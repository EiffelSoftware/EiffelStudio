note
	description: "Summary description for {EIFFEL_DOWNLOAD_MODULE_ADMINISTRATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DOWNLOAD_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [EIFFEL_DOWNLOAD_MODULE]
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_BLOCK

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_BLOCK_HELPER

	SHARED_LOGGER

create
	make

feature -- Access

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("upload download")
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
		do
			a_router.handle ("/update_download/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_update_download_admin (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/process_update/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_process_update_admin (a_api, ?, ?)), a_router.methods_post)
		end

feature -- Handle

	handle_update_download_admin (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			write_debug_log (generator + ".handle_update_download_admin")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
			r.values.force ("download_area_update", "download_area_update")
			r.execute
		end

	handle_process_update_admin (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_tmp: WSF_UPLOADED_FILE
			vars: STRING_TABLE [READABLE_STRING_8]
			l_dir: DIRECTORY
			l_file: FILE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
			create vars.make_caseless (5)
			vars.put (safe_html_encoded (a_api.setup.site_url), "siteurl")
			vars.put (safe_html_encoded (a_api.setup.site_name), "sitename")

			if req.has_uploaded_file then
				across req.uploaded_files as c loop
					l_tmp := c.item
				end
			end
			if attached l_tmp then
				if attached process_uploaded_file (l_tmp) as l_uploaded then
						-- save the file
						-- send a valid response
						-- TODO extract code to save_file with retry a few times in case we can save it.
					create l_dir.make_with_path (a_api.module_location_by_name ("eiffel_download"))
					if l_dir.exists then
						create {RAW_FILE} l_file.make_open_write (l_dir.path.extended ("downloads_configuration_" + l_uploaded.number + ".json").name.out)
						l_file.put_string (l_uploaded.to_json_representation)
						l_file.close
					end
					write_debug_log (generator + ".handle_process_update_admin:  Success")
					r.values.force (False, "has_error")
					vars.put ("False", "has_error")
					r.set_status_code ({HTTP_CONSTANTS}.ok)
					if attached smarty_template_block_with_values (module, "post_update_download", a_api, vars) as l_tpl_block then
					across
						r.values as tb
					loop
						l_tpl_block.set_value (tb.item, tb.key)
					end
						r.set_main_content (l_tpl_block.to_html (r.theme))
					end
					r.execute
				else
						-- send bad input file
					write_error_log (generator + ".handle_process_update_admin:  Bad upload file")
					r.values.force (True, "has_error")
					vars.put ("True", "has_error")
					r.set_status_code ({HTTP_CONSTANTS}.bad_request)
					if attached smarty_template_block_with_values (module, "post_update_download", a_api, vars) as l_tpl_block then
					across
						r.values as tb
					loop
						l_tpl_block.set_value (tb.item, tb.key)
					end
						r.set_main_content (l_tpl_block.to_html (r.theme))
					end
					r.execute
				end
			else
					-- No file.
					-- send Internal Server Error response.
				write_error_log (generator + ".handle_process_update_admin:  Internal Server Error")
				r.values.force (True, "has_error")
				vars.put ("True", "has_error")
				r.set_status_code ({HTTP_CONSTANTS}.internal_server_error)
				if attached smarty_template_block_with_values (module, "post_update_download", a_api, vars) as l_tpl_block then
				across
					r.values as tb
				loop
					l_tpl_block.set_value (tb.item, tb.key)
				end
					r.set_main_content (l_tpl_block.to_html (r.theme))
				end
				r.execute
			end

		end

feature -- Hook

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_block_hook (Current)
		end


	response_alter (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_response.add_style (a_response.module_resource_url (module, "/files/css/download.css", Void), Void)
			module.response_alter (a_response)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			if a_response.is_authenticated then
				if a_response.has_permission ("upload download") then
					a_menu_system.management_menu.extend_into (a_response.api.administration_link ("Update Download", "update_download/"), "Admin", "admin")
				end
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
				-- <Precursor>
		local
			l_string: STRING
		do
			Result := <<"?download_area_update">>
			create l_string.make_empty
			across Result as ic loop
				l_string.append (ic.item)
				l_string.append_character (' ')
			end
			write_debug_log (generator + ".block_list:" + l_string )
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
				-- <Precursor>
		do
			write_debug_log (generator + ".get_block_view with block_id:`" + a_block_id + "'")
			if
				a_block_id.is_case_insensitive_equal_general ("download_area_update") and then
				a_response.request.path_info.same_string ("/admin/update_download/")
			then
				get_block_view_update_download (a_block_id, a_response)
			end
		end

	get_block_view_update_download (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
				--  Get block view update object identified by `a_block_id' and associate with `a_response'.
		local
			l_tpl_block: detachable CMS_SMARTY_TEMPLATE_BLOCK
			res: PATH
			p: detachable PATH
		do
			create res.make_from_string ("templates")
				-- Note: template name harcoded.
			res := res.extended ("block_update_download").appended_with_extension ("tpl")
			p := a_response.api.module_theme_resource_location (module, res)

			if p /= Void then
				write_debug_log (generator + ".get_block_view with template_path:" + p.out)
				if attached p.entry as e then
					create l_tpl_block.make_raw (a_block_id, Void, p.parent, e)
				else
					create l_tpl_block.make_raw (a_block_id, Void, p.parent, p)
				end
				if l_tpl_block /= Void then
					write_debug_log (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					write_debug_log (generator + ".get_block_view with template_block: Void")
				end
				a_response.add_block (l_tpl_block, "content")

			else
				a_response.add_warning_message ("Error with block [" + a_block_id + "]")
				write_warning_log ("Error with block [" + a_block_id + "]")
			end
		end

feature {NONE} -- Implementation

	process_uploaded_file (a_uploaded_file: WSF_UPLOADED_FILE): detachable EIFFEL_UPLOAD_CONFIGURATION
			-- process the uploaded file.
		do
			if attached a_uploaded_file.tmp_path as l_path then
				Result := (create {EIFFEL_UPLOAD_JSON_CONFIGURATION}).upload_json_configuration (l_path)
				delete_uploaded_file (l_path)
			end

		end

	delete_uploaded_file (p: PATH)
			-- Remove uploaded temporal file at path `p'.
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if retried then
				write_error_log (generator + {STRING_32} "Can not delete file %"" + p.name + "%"")
			else
				create f.make_with_path (p)
				if f.exists then
					f.delete
				else
						-- Not considered as failure.
				end
			end
		rescue
			retried := True
			retry
		end
end

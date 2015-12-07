note
	description: "Summary description for {EIFFEL_DOWNLOAD_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DOWNLOAD_MODULE

inherit
	CMS_MODULE
		redefine
			setup_hooks
		end

	CMS_HOOK_VALUE_TABLE_ALTER

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_BLOCK

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Eiffel GPL Download"
			package := "eiffel"
		end

feature -- Access

	name: STRING = "eiffel_download"

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
			a_router.handle ("/download", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_download (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/downloads", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_download_options (a_api, ?, ?)), a_router.methods_head_get)
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_value_table_alter_hook (Current)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Access: config

	download_configuration: detachable DOWNLOAD_CONFIGURATION
			-- Configuration for eiffel download.

	get_download_configuration (api: CMS_API)
			-- Get `download_configuration' value.
		do
			write_debug_log (generator + ".get_download_configuration")
			if download_configuration = Void then
				download_configuration := (create {DOWNLOAD_JSON_CONFIGURATION}).new_download_configuration (api.module_resource_location (Current, create {PATH}.make_from_string ("downloads_configuration.json")))
			end
		end

	retrieve_mirror_gpl (cfg: DOWNLOAD_CONFIGURATION): detachable READABLE_STRING_32
			-- Get mirror.
		do
			if attached cfg.mirror as l_mirror then
				Result := l_mirror
			end
		end

	retrieve_product_gpl (cfg: DOWNLOAD_CONFIGURATION): detachable DOWNLOAD_PRODUCT
			-- Get product.
		do
			if attached cfg.products as l_products then
				Result := l_products.at (1)
			end
		end

	retrieve_products (cfg: DOWNLOAD_CONFIGURATION): detachable LIST[DOWNLOAD_PRODUCT]
		do
			if attached cfg.products as l_products then
				Result := l_products
			end
		end


feature -- Hooks

	value_table_alter (a_value: CMS_VALUE_TABLE; a_response: CMS_RESPONSE)
		local
			l_ua: CMS_USER_AGENT
		do
			get_download_configuration (a_response.api)
			if attached download_configuration as cfg then
				if
					attached retrieve_product_gpl (cfg) as l_product and then
					attached l_product.name as l_name and then
					attached l_product.version  as l_version and then
					attached retrieve_mirror_gpl (cfg) as l_mirror
				then
					a_value.force (l_name +" " + l_version, "last_release")
					a_value.force (l_mirror, "mirror")
					a_value.force ((create {CMS_LOCAL_LINK}.make ("download link", "download")), "link")
				end


				create l_ua.make_from_string (a_response.request.http_user_agent)
				a_value.force (get_platform (l_ua), "platform")

				if attached retrieve_product_gpl (cfg) as l_product then
					if attached selected_platform (l_product.downloads, get_platform (l_ua)) as l_selected then
						a_value.force (l_selected.filename, "filename")
					end
				end
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
				-- <Precursor>
		local
			l_string: STRING
		do
			Result := <<"?download_area", "?download_options">>
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
				-- Download header
			if a_block_id.is_case_insensitive_equal_general ("download_area") then
				if a_response.is_front then
					get_block_view_download_area (a_block_id, a_response)
				end
			elseif
				a_block_id.is_case_insensitive_equal_general ("download_options") and then
				a_response.request.path_info.same_string ("/downloads")
			then
				get_block_view_download_options (a_block_id, a_response)
			end
		end

feature {NONE} -- Block view implementation

	get_block_view_download_area (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
				--  Get block download area object identified by `a_block_id' and associate with `a_response'.
		local
			l_tpl_block: detachable CMS_SMARTY_TEMPLATE_BLOCK
			vals: CMS_VALUE_TABLE
			res: PATH
			p: detachable PATH
		do
			create res.make_from_string ("templates")
				-- Note: template name harcoded.
			res := res.extended ("block_download_area").appended_with_extension ("tpl")
			p := a_response.api.module_theme_resource_location (Current, res)
			if p /= Void then
				write_debug_log (generator + ".get_block_view with template_path:" + p.out)

				if attached p.entry as e then
					create l_tpl_block.make (a_block_id, Void, p.parent, e)
				else
					create l_tpl_block.make (a_block_id, Void, p.parent, p)
				end

				create vals.make (5)
				value_table_alter (vals, a_response)
				across
					vals as ic
				loop
					l_tpl_block.set_value (ic.item, ic.key)
				end

				if l_tpl_block /= Void then
					write_debug_log (generator + ".get_block_view with template_block:" + l_tpl_block.out)
				else
					write_debug_log (generator + ".get_block_view with template_block: Void")
				end
				a_response.add_block (l_tpl_block, "header")

			else
				a_response.add_warning_message ("Error with block [" + a_block_id + "]")
				write_warning_log ("Error with block [" + a_block_id + "]")
			end
		end


	get_block_view_download_options (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
				--  Get block download options object identified by `a_block_id' and associate with `a_response'.
		local
			l_tpl_block: detachable CMS_SMARTY_TEMPLATE_BLOCK
			vals: CMS_VALUE_TABLE
			res: PATH
			p: detachable PATH
		do
			create res.make_from_string ("templates")
				-- Note: template name harcoded.
			res := res.extended ("block_download_options").appended_with_extension ("tpl")
			p := a_response.api.module_theme_resource_location (Current, res)

			if p /= Void then
				write_debug_log (generator + ".get_block_view with template_path:" + p.out)
				if attached p.entry as e then
					create l_tpl_block.make_raw (a_block_id, Void, p.parent, e)
				else
					create l_tpl_block.make_raw (a_block_id, Void, p.parent, p)
				end

				create vals.make (8)
				value_table_alter (vals, a_response)
				across
					vals as ic
				loop
					l_tpl_block.set_value (ic.item, ic.key)
				end

				get_download_configuration (a_response.api)

				if attached download_configuration as cfg then
					vals.force (retrieve_product_gpl (cfg), "product")
					vals.force (retrieve_products (cfg), "products")
					vals.force (retrieve_mirror_gpl (cfg), "mirror")

					across
						vals as ic
					loop
						l_tpl_block.set_value (ic.item, ic.key)
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
		end

feature -- Handler	

	handle_download_options (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			write_debug_log (generator + ".handle_download_options")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.values.force ("download_options", "download_options")
			r.execute
		end

	handle_download (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_link: STRING
			l_ua: CMS_USER_AGENT
			err: INTERNAL_SERVER_ERROR_CMS_RESPONSE
			done: BOOLEAN
		do
			write_debug_log (generator + ".handle_download")
			get_download_configuration (api)
			if attached download_configuration as cfg then
				create l_ua.make_from_string (req.http_user_agent)
				write_debug_log (generator + ".handle_download [ User_agent: " + l_ua.user_agent  + " ]")

				if attached retrieve_product_gpl (cfg) as l_product and then
				   attached l_product.build as l_build and then
				   attached l_product.name as l_name and then
				   attached l_product.number as l_number and then
				   attached retrieve_mirror_gpl (cfg) as l_mirror
				then
				    l_link := l_mirror
				    l_link.append (l_name)
				    l_link.append (" ")
				    l_link.append (l_number)
				    l_link.append_character ('/')
				    l_link.append (l_build)
				    l_link.append_character ('/')
				    write_debug_log (generator + ".handle_download [ Link: " + l_link  + " ]")
					if attached selected_platform (l_product.downloads, get_platform (l_ua)) as l_selected then
						if attached l_selected.filename as l_filename then
							write_debug_log (generator + ".handle_download [ Filename: " + l_filename  + " ]")
							l_link.append (l_filename)
							file_download (req, res, l_link)
							done := True
						end
					end
				end
			end
			if not done then
					-- If not answer was done, return internal server error.
				create err.make (req, res, api)
				err.execute
			end
		end

	file_download  (req: WSF_REQUEST; res: WSF_RESPONSE; a_link: READABLE_STRING_32)
			-- Simple response to download content
			-- Harcoded for testing.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_disposition ("attachment; filename", a_link)
			h.put_current_date
			h.put_header_key_value ("Content-type", "application/octet-stream")
			h.put_location (a_link)
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end

feature {NONE}  -- Helper

	selected_platform (a_downloads: detachable LIST[DOWNLOAD_PRODUCT_OPTIONS]; a_platform: READABLE_STRING_32): detachable DOWNLOAD_PRODUCT_OPTIONS
		local
			l_found: BOOLEAN
		do
			if
				attached a_downloads
			then
				from
					a_downloads.start
				until
					a_downloads.after or l_found
				loop
					if a_downloads.item.platform ~ a_platform then
						Result := a_downloads.item
					end
					a_downloads.forth
				end
			end
		end

	get_platform (a_user_agent: CMS_USER_AGENT)	: READABLE_STRING_32
				-- Set by default win64
				--	<option value="freebsd-x86">FreeBSD x86 32-bit</option>
				--	<option value="freebsd-x86-64">FreeBSD x86 64-bit</option>
				--	<option value="linux-x86">Linux x86 32-bit</option>
				--	<option value="linux-x86-64">Linux x86 64-bit</option>
				--	<option value="macosx-x86-64">Mac OS X</option>
				--  <option value="openbsd-x86">OpenBSD x86 32-bit</option>
				--	<option value="openbsd-x86-64">OpenBSD x86 64-bit</option>
				--	<option value="solaris-x86">Solaris x86 32-bit</option>
				--	<option value="solaris-x86-64">Solaris x64 64-bit</option>
				--	<option value="solaris-sparc">Solaris Sparc 32-bit</option>
				--	<option value="solaris-sparc-64">Solaris Sparc 64-bit</option>
				--	<option value="win64" selected="">Windows 64-bit</option>
				--	<option value="windows">Windows 32-bit</option>		
		do
			write_debug_log (generator + ".get_platform [ from " + a_user_agent.user_agent  + " ]")
			Result := "win64"
			if a_user_agent.is_windows_os then
				if a_user_agent.is_64bits then
					Result := "win64"
				else
					Result := "windows"
				end
			elseif a_user_agent.is_linux_os then
				if a_user_agent.is_64bits then
					Result := "linux-x86-64"
				else
					Result := "linux-x86"
				end
			elseif a_user_agent.is_mac_os then
				Result := "macosx-x86-64"
			end
			write_debug_log (generator + ".get_platform [ platform inferred "+  Result  + " ]")
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

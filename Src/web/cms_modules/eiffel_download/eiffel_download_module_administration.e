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

	EIFFEL_DOWNLOAD_HANDLER_UTILITIES

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	SHARED_LOGGER

create
	make

feature -- Access

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (perm_manage_download)
			Result.force (perm_upload_download)
		end

	perm_manage_download: STRING = "manage download"

	perm_upload_download: STRING = "upload download"

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
		local
			h_up: WSF_URI_TEMPLATE_AGENT_HANDLER
		do
			a_router.handle ("/eiffel_download/channel/{channel}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_list_admin (a_api, ?, ?)), a_router.methods_get)
			a_router.handle ("/eiffel_download/channel/{channel}/{filename}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_edit_admin (a_api, ?, ?)), a_router.methods_get_put_delete + a_router.methods_post)
			create h_up.make (agent handle_update_download_admin (a_api, ?, ?))
			a_router.handle ("/eiffel_download/update/channel/{channel}", h_up, a_router.methods_head_get_post)
			a_router.handle ("/eiffel_download/create/channel/{channel}", h_up, a_router.methods_head_get_post)
		end

feature -- Handle

	new_response (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE): CMS_RESPONSE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} Result.make (req, res, a_api)
			Result.add_to_primary_tabs (a_api.administration_link ("Stable", "eiffel_download/channel/stable"))
			Result.add_to_primary_tabs (a_api.administration_link ("Beta", "eiffel_download/channel/beta"))
		end

	handle_list_admin (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			ch: READABLE_STRING_8
			r: CMS_RESPONSE
			s: STRING
			l_can_edit: BOOLEAN
		do
			r := new_response (a_api, req, res)

			if attached channel_from_url (req.percent_encoded_path_info) as l_channel then
				ch := l_channel
			else
				ch := "stable"
			end
			create s.make (1024)
			if a_api.has_permissions (<<perm_manage_download, perm_upload_download>>) then
				s.append ("<h2>Management</h2>%N")
				s.append ("<li><a href=%""+ r.api.administration_path ("eiffel_download/update/channel/" + a_api.url_encoded (ch)) +"%">Update channel "+ a_api.html_encoded (ch) +"</a></li>%N")
				s.append ("<li><a href=%""+ r.api.administration_path ("eiffel_download/create/channel/" + a_api.url_encoded (ch)) +"%">Create new entry for channel "+ a_api.html_encoded (ch) +"</a></li>%N")
			end
			if attached module.eiffel_download_api as l_download_api then
				s.append ("<h2>Configurations</h2>%N")
				l_can_edit := a_api.has_permission (perm_manage_download)
				across
					l_download_api.configuration_files (ch) as ic
				loop
					if attached ic.item.entry as e then
						s.append ("<li>")
						if attached {DOWNLOAD_CONFIGURATION} l_download_api.download_configuration_at (ch, e) as e_cfg then
							if e_cfg.hidden then
								s.append ("HIDDEN ")
							end
							if not e_cfg.published then
								s.append ("NOT-PUBLISHED ")
							end
							if e_cfg.products = Void then
								s.append ("INVALID ")
							end
						end

						s.append (a_api.html_encoded (e.name))
						if l_can_edit then
							s.append (" -- <a href=%""+ req.percent_encoded_path_info + "/" + a_api.url_encoded (e.name) +"%">Edit</a>")
						end

						s.append ("</li>%N")
					end
				end
				s.append ("<h2>Products</h2>%N")
				if l_download_api.is_channel_available (ch) then
					if attached l_download_api.download_channel_configuration (ch) as cfg then
						if attached cfg.products as l_products then
							s.append ("<p>" + l_products.count.out + " products:</p><ul class=%"products%">")
							across
								l_products as p_ic
							loop
								if p_ic.item.public then
									s.append ("<li class=%"public%">")
								else
									s.append ("<li class=%"private%">PRIVATE: ")
								end
								s.append (html_encoded (p_ic.item.full_versioned_name))
								s.append (" <span class=%"details%"> (" + p_ic.item.downloads_count.out + " download options)</span>")
								s.append ("</li>")
							end
							s.append ("</ul>")
						else
							s.append ("<p class=%"error%">No product!</p>")
						end
					else
						s.append ("<p class=%"error%">Invalid!</p>")
					end
				else
					s.append ("<p class=%"error%">Not available!</p>")
				end
			end
			r.set_title ("Eiffel Downloads: channel " + a_api.html_encoded (ch))
			r.set_main_content (s)
			r.execute
		end

	handle_edit_admin (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			ch: READABLE_STRING_8
			r: CMS_RESPONSE
			s: STRING
			p: PATH
			f: PLAIN_TEXT_FILE
			txt: STRING
			wf: CMS_FORM
		do
			r := new_response (a_api, req, res)
			if attached channel_from_url (req.percent_encoded_path_info) as l_channel then
				ch := l_channel
			else
				ch := "stable"
			end
			r.set_title ("Eiffel Downloads: edit ...")
			create s.make (1024)
			if
				attached module.eiffel_download_api as l_download_api and then
				a_api.has_permissions (<<perm_manage_download>>) and then
				attached {WSF_STRING} req.path_parameter ("filename") as p_filename
			then
				p := l_download_api.channel_file_location (ch).extended (p_filename.value)

				if req.is_put_post_request_method then
					wf := new_edit_form (req, p_filename.value)
					wf.process_cms_response (r)
					if attached wf.last_data as fd then
						if fd.is_valid then
							if attached fd.string_item ("op") as l_op then
								if l_op.same_string_general ("Save") then
									if attached fd.string_item ("content") as l_content then
										create f.make_with_path (p)
										f.open_write
										f.put_string (utf_8_encoded (l_content))
										f.close
										r.add_notice_message ("Data saved!")
										-- FIXME: check the validity, valid JSON, valid configuration !!!
									end
								elseif l_op.same_string_general ("Delete") then
									create f.make_with_path (p)
									f.delete
									r.add_notice_message ("Data deleted!")
								end
							end
						end
					end
				elseif req.is_delete_request_method then
					create f.make_with_path (p)
					f.delete
					r.add_notice_message ("Data deleted!")
				end
				create f.make_with_path (p)
				if f.exists and then f.is_access_readable then
					wf := new_edit_form (req, p_filename.value)
					create txt.make (f.count)
					f.open_read
					from
					until
						f.exhausted or f.end_of_file
					loop
						f.read_stream (1024)
						txt.append (f.last_string)
					end
					f.close
					if
						attached wf.fields_by_name ("content") as tf_lst and then
						tf_lst.count = 1 and then
						attached {WSF_FORM_TEXTAREA} tf_lst.first as tf
					then
						tf.set_text_value (txt)
					end
					wf.append_to_html (r.wsf_theme, s)
				else
					s.append ("Data not found!")
				end
				r.set_title ("Eiffel Downloads: editing " + a_api.html_encoded (p_filename.value))
			end
			r.set_main_content (s)
			r.execute
		end

	new_edit_form (req: WSF_REQUEST; fn: READABLE_STRING_GENERAL): CMS_FORM
		local
			wf: CMS_FORM
			txtf: CMS_FORM_TEXTAREA
			hf: WSF_FORM_HIDDEN_INPUT

			subf: WSF_FORM_SUBMIT_INPUT
		do
			create wf.make (req.percent_encoded_path_info, Void)
			wf.set_method_post

			create hf.make_with_text ("filename", fn)
			wf.extend (hf)

			create txtf.make ("content")
			txtf.set_label ("Content:")
			txtf.set_is_required (True)
			txtf.set_cols (80)
			txtf.set_rows (25)
			wf.extend (txtf)

			create subf.make_with_text ("op", "Save")
			wf.extend (subf)
			create subf.make_with_text ("op", "Delete")
			wf.extend (subf)

			Result := wf
		end

	handle_update_download_admin (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			wf: CMS_FORM
			wfile: WSF_FORM_FILE_INPUT
			wtext: WSF_FORM_TEXTAREA
			wdiv: WSF_FORM_DIV
			wsubmit: WSF_FORM_SUBMIT_INPUT
			s: STRING
			m: STRING
			vars: STRING_TABLE [READABLE_STRING_GENERAL]
			ch: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} req.path_parameter ("channel") as p_channel then
				ch := p_channel.value
			else
				ch := "stable"
			end
			create vars.make_caseless (5)
			vars.put (safe_html_encoded (a_api.setup.site_url), "siteurl")
			vars.put (safe_html_encoded (a_api.setup.site_name), "sitename")
			if attached {WSF_STRING} req.path_parameter ("channel") as p_channel then
				vars.put (p_channel.value, "channel")
			end

			write_debug_log (generator + ".handle_update_download_admin")
			r := new_response (a_api, req, res)
			if req.percent_encoded_path_info.has_substring ("/update/") then
				create wf.make (a_api.administration_path ("eiffel_download/update/channel/" + url_encoded (ch)), "download-form-update")
			else
				create wf.make (a_api.administration_path ("eiffel_download/create/channel/" + url_encoded (ch)), "download-form-create")
			end
			wf.set_method_post
			create wdiv.make
			wdiv.add_css_classes (<<"download-box">>)
			wf.extend (wdiv)
			wdiv.extend_html_text ("<h1>Update " + r.html_encoded (ch) + " channel</h1>")

			if req.percent_encoded_path_info.has_substring ("/update/") then
				create wfile.make ("file")
				wfile.set_accepted_types (".json")
				wfile.set_label ("File: select the file")
				wfile.set_is_required (True)
				wfile.set_description ("You can only upload a JSON file.")
				wdiv.extend (wfile)
				create wsubmit.make_with_text ("op", "Upload")
				wdiv.extend (wsubmit)
			else
				create wtext.make ("content")
				wtext.set_label ("Content: enter json configuration content")
				wtext.set_is_required (True)
				wtext.set_description ("You can only use a JSON content.")
				wtext.set_cols (70)
				wtext.set_rows (25)
				wdiv.extend (wtext)
				create wsubmit.make_with_text ("op", "Create")
				wdiv.extend (wsubmit)
			end
			create s.make_empty
			if
				req.is_post_request_method and then
				attached module.eiffel_download_api as l_download_api
			then
				wf.process_cms_response (r)
				if attached wf.last_data as fd then
					if fd.is_valid then
						if attached {WSF_STRING} fd.item ("content") as l_content then
									-- Check success
							if attached configuration_from_content (l_content.value) as cfg then
									-- save the content
								l_download_api.save_configuration (ch, cfg)
									-- Check success
								if l_download_api.configuration_exists (ch, cfg) then
									r.add_notice_message ("Content saved!")
								else
									fd.report_invalid_field ("content", "could not save the content!")
								end
							end
						elseif attached {WSF_UPLOADED_FILE} fd.item ("file") as l_file then
							if attached configuration_from_file (l_file) as cfg then
									-- save the content
								l_download_api.save_configuration (ch, cfg)
									-- Check success
								if l_download_api.configuration_exists (ch, cfg) then
									r.add_notice_message ("File saved!")
								else
									fd.report_invalid_field ("file", "could not save the file!")
								end
							end
						else
							fd.report_error ("Invalid input")
						end
					else
						fd.report_error ("Invalid input")
					end
					if fd.has_error then
						if attached fd.errors as fd_errors then
							across
								fd_errors as ic
							loop
								create m.make_empty
								if attached ic.item.field as l_field then
									m.append (l_field.name + ": ")
								end
								if attached ic.item.message as msg then
									m.append (msg)
								end
								if not m.is_whitespace then
									r.add_error_message (m)
								end
							end
						end
						fd.apply_to_associated_form
						wf.append_to_html (r.wsf_theme, s)

						r.values.force (True, "has_error")
						vars.put ("True", "has_error")
					else
						s.append ("Data successfully saved!")
						r.values.force (False, "has_error")
						vars.put ("False", "has_error")
					end
				else
					r.add_error_message ("Invalid input!")
					wf.append_to_html (r.wsf_theme, s)
				end
			else
				wf.append_to_html (r.wsf_theme, s)
			end
			r.set_main_content (s)

			r.execute
		end

feature -- Hook

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_response.add_style (a_response.module_resource_url (module, "/files/css/download-admin.css", Void), Void)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			if
				a_response.is_authenticated and then
				a_response.has_permission ("upload download")
			then
				a_menu_system.management_menu.extend_into (a_response.api.administration_link ("Stable channel", "eiffel_download/channel/stable"), "Eiffel Download", "admin")
				a_menu_system.management_menu.extend_into (a_response.api.administration_link ("Beta channel", "eiffel_download/channel/beta"), "Eiffel Download", "admin")
			end
		end

	channel_from_url (a_url: READABLE_STRING_8): detachable READABLE_STRING_8
		local
			i,j: INTEGER
		do
			if a_url.has_substring ("/channel/") then
				i := a_url.substring_index ("/channel/", 1)
				i := a_url.index_of ('/', i + 1)
				j := a_url.index_of ('/', i + 1)
				if j = 0 then
					j := a_url.count + 1
				end
				Result := a_url.substring (i + 1, j - 1)
			end
		end

end

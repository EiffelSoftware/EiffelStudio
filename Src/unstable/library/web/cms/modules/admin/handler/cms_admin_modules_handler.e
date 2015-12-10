note
	description: "[
			Administrate modules.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_MODULES_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get, do_post
		end

	REFACTORING_HELPER

	CMS_SETUP_ACCESS

	CMS_ACCESS

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
			l_denied: BOOLEAN
		do
			if
				attached {WSF_STRING} req.query_parameter ("op") as l_op and then l_op.same_string ("uninstall") and then
				attached {WSF_TABLE} req.query_parameter ("module_uninstallation") as tb
			then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				if attached api.setup.string_8_item ("admin.installation_access") as l_access then
					if l_access.is_case_insensitive_equal ("none") then
						l_denied := True
					elseif l_access.is_case_insensitive_equal ("permission") then
						l_denied := not r.has_permission ("install modules")
					end
				else
					l_denied := True
				end
				if l_denied then
					create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.set_main_content ("You do not have permission to access CMS module uninstallation procedure!")
				else
					create s.make_empty
					across
						tb as ic
					loop
						if attached api.setup.modules.item_by_name (ic.item.string_representation) as l_module then
							if api.is_module_installed (l_module) then
								api.uninstall_module (l_module)
								if api.is_module_installed (l_module) then
									s.append ("<p>ERROR: Module " + l_module.name + " failed to be uninstalled!</p>")
								else
									s.append ("<p>Module " + l_module.name + " was successfully uninstalled.</p>")
								end
							else
								s.append ("<p>Module " + l_module.name + " is not installed.</p>")
							end
						end
					end
					s.append (r.link ("Back to modules management", r.location, Void))
					r.set_main_content (s)
				end
				r.execute
			else
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				f := modules_collection_web_form (r)
				create s.make_empty
				f.append_to_html (r.wsf_theme, s)
				r.set_page_title ("Modules")
				r.set_main_content (s)
				r.execute
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			s: STRING
			f: CMS_FORM
			l_denied: BOOLEAN
		do
			if attached {WSF_STRING} req.item ("op") as l_op then
				if l_op.same_string ("Install modules") then
					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)

					if attached api.setup.string_8_item ("admin.installation_access") as l_access then
						if l_access.is_case_insensitive_equal ("none") then
							l_denied := True
						elseif l_access.is_case_insensitive_equal ("permission") then
							l_denied := not r.has_permission ("install modules")
						end
					else
						l_denied := True
					end
					if l_denied then
						create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
						r.set_main_content ("You do not have permission to access CMS module installation procedure!")
					else
						f := modules_collection_web_form (r)
						if l_op.same_string ("Install modules") then
							f.submit_actions.extend (agent on_installation_submit)
							f.process (r)
						elseif l_op.same_string ("uninstall") then
							f.submit_actions.extend (agent on_uninstallation_submit)
							f.process (r)
						end
						if
							not attached f.last_data as l_data or else
							not l_data.is_valid
						then
							r.add_error_message ("Error occurred.")
							create s.make_empty
							f.append_to_html (r.wsf_theme, s)
							r.set_page_title ("Modules")
							r.set_main_content (s)
						else
							r.add_notice_message ("Operation on module(s) succeeded.")
							r.set_redirection (r.location)
						end
					end
					r.execute
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.execute
				end
			else
				do_get (req, res)
			end
		end

	modules_collection_web_form (a_response: CMS_RESPONSE): CMS_FORM
		local
			mod: CMS_MODULE
			f_cb: WSF_FORM_CHECKBOX_INPUT
			w_tb: WSF_WIDGET_TABLE
			w_row: WSF_WIDGET_TABLE_ROW
			w_item: WSF_WIDGET_TABLE_ITEM
			w_submit: WSF_FORM_SUBMIT_INPUT
			w_set: WSF_FORM_FIELD_SET

			l_mods_to_install: ARRAYED_LIST [CMS_MODULE]
		do
			create Result.make (a_response.url (a_response.location, Void), "modules_collection")
			create w_tb.make
			w_tb.add_css_class ("modules_table")
			create w_row.make (5)
			create w_item.make_with_text ("Enabled ")
			w_row.add_item (w_item)
			create w_item.make_with_text ("Module")
			w_row.add_item (w_item)
			create w_item.make_with_text ("Version")
			w_row.add_item (w_item)
			create w_item.make_with_text ("Description")
			w_row.add_item (w_item)
			w_tb.add_head_row (w_row)

			create l_mods_to_install.make (0)
			across
				a_response.api.setup.modules as ic
			loop
				mod := ic.item
				if not a_response.api.is_module_installed (mod) then
					l_mods_to_install.extend (mod)
				else
					create w_row.make (5)
					create f_cb.make ("module_" + mod.name)
					f_cb.set_text_value (mod.name)
					f_cb.set_checked (mod.is_enabled)
					f_cb.set_is_readonly (True)
					create w_item.make_with_content (f_cb)
					w_row.add_item (w_item)

					create w_item.make_with_text (mod.name)
					w_row.add_item (w_item)

					create w_item.make_with_text (mod.version)
					w_row.add_item (w_item)

					if attached mod.description as l_desc then
						create w_item.make_with_text (l_desc)
						w_row.add_item (w_item)
					else
						create w_item.make_with_text ("")
						w_row.add_item (w_item)
					end
					create w_item.make_with_text (a_response.link ("Uninstall", a_response.location + "?op=uninstall&module_uninstallation[]=" + mod.name, Void))
					w_row.add_item (w_item)

					w_tb.add_row (w_row)
				end
			end
			create w_set.make
			w_set.set_legend ("Installed modules")
			w_set.extend (w_tb)
--			create w_submit.make ("op")
--			w_submit.set_text_value ("Save")
--			w_set.extend (w_submit)
			Result.extend (w_set)

			Result.extend_html_text ("<br/>")

			if not l_mods_to_install.is_empty then
				create w_tb.make
				w_tb.add_css_class ("modules_table")
				create w_row.make (3)
				create w_item.make_with_text ("Install ")
				w_row.add_item (w_item)
				create w_item.make_with_text ("Module")
				w_row.add_item (w_item)
				create w_item.make_with_text ("Description")
				w_row.add_item (w_item)
				w_tb.add_head_row (w_row)
				across
					l_mods_to_install as ic
				loop
					mod := ic.item
					create w_row.make (3)
					create f_cb.make ("module_installation[" + mod.name + "]")
					f_cb.set_text_value (mod.name)
					create w_item.make_with_content (f_cb)
					w_row.add_item (w_item)

					create w_item.make_with_text (mod.name)
					w_row.add_item (w_item)

					if attached mod.description as l_desc then
						create w_item.make_with_text (l_desc)
						w_row.add_item (w_item)
					else
						create w_item.make_with_text ("")
						w_row.add_item (w_item)
					end
					w_tb.add_row (w_row)
				end
				create w_set.make
				w_set.set_legend ("Available modules for installation")
				w_set.extend (w_tb)
				create w_submit.make ("op")
				w_submit.set_text_value ("Install modules")
				w_set.extend (w_submit)
				Result.extend (w_set)
			end
		end

	on_installation_submit (fd: WSF_FORM_DATA)
		local
			l_mods: CMS_MODULE_COLLECTION
		do
			if attached {WSF_TABLE} fd.table_item ("module_installation") as tb and then not tb.is_empty then
				l_mods := api.setup.modules
				across
					tb as ic
				loop
					if
						attached {WSF_STRING} ic.item as l_mod_name and then
						attached l_mods.item_by_name (l_mod_name.value) as m
					then
						api.install_module (m)
						if not api.is_module_installed (m) then
							fd.report_error ("Installation failed for module " + m.name)
						end
					else
						fd.report_error ("Can not find associated module" + ic.item.as_string.url_encoded_value)
					end
				end
			else
				fd.report_error ("No module to install!")
			end
		end

	on_uninstallation_submit (fd: WSF_FORM_DATA)
		local
			l_mods: CMS_MODULE_COLLECTION
		do
			if attached {WSF_TABLE} fd.table_item ("module_uninstallation") as tb and then not tb.is_empty then
				l_mods := api.setup.modules
				across
					tb as ic
				loop
					if
						attached {WSF_STRING} ic.item as l_mod_name and then
						attached l_mods.item_by_name (l_mod_name.value) as m
					then
						api.uninstall_module (m)
						if api.is_module_installed (m) then
							fd.report_error ("Un-Installation failed for module " + m.name)
						end
					else
						fd.report_error ("Can not find associated module" + ic.item.as_string.url_encoded_value)
					end
				end
			else
				fd.report_error ("No module to uninstall!")
			end
		end

end

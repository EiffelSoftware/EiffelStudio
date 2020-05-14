note
	description: "Handler to process CMS installation process."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_INSTALL_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	CMS_ACCESS

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			r: CMS_RESPONSE
			l_module: CMS_MODULE
			s: STRING
			lst: ARRAYED_LIST [CMS_MODULE]
			l_access: detachable READABLE_STRING_8
			l_denied: BOOLEAN
			l_is_fresh_installation: BOOLEAN
		do
			l_is_fresh_installation := api.enabled_modules.count <= 1 --| Should have at least the required Core module!

				--| FIXME: improve the installer.
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			l_access := api.setup.string_8_item ("admin.installation_access")
			if l_access = Void then
				l_access := api.setup.string_8_item ("administration.installation_access")
			end
			if l_access /= Void then
				if l_access.is_case_insensitive_equal ("none") then
					l_denied := True
				elseif l_access.is_case_insensitive_equal ("permission") then
					l_denied := not r.has_permission ("install modules")
				end
			else
				l_denied := True
			end
			if l_denied then
				send_custom_access_denied ("You do not have permission to access CMS installation procedure!", Void, req, res)
			else
				create s.make_empty
				s.append ("<h2>Informations</h2>")
				s.append ("<ul>")
				across
					api.setup.system_info as ic
				loop
					s.append ("<li><strong>"+ html_encoded (ic.key) +":</strong> ")
					s.append (html_encoded (ic.item))
					s.append ("</li>")
				end
				s.append ("<li><strong>Storage:</strong> ")
				s.append (" -&gt; ")
				s.append (api.storage.generator)
				if attached api.storage.error_handler.as_single_error as err then
					s.append ("(error: ")
					s.append (html_encoded (err.string_representation))
					s.append (")")
				end
				s.append ("</li>")
				s.append ("</ul>")

				s.append ("<h2>Modules</h2><ul>")
				create lst.make (1)
				across
					api.setup.modules as ic
				loop
					l_module := ic.item
					if api.is_module_installed (l_module) then
						s.append ("<li>")
						s.append (l_module.name)
						if l_module.is_enabled then
							s.append (" </strong>[enabled]</strong>")
						end
						s.append (" is already installed.")
						s.append ("</li>%N")
					else
						lst.force (l_module)
					end
				end
				api.install_all_modules
				if api.has_error and then attached api.string_representation_of_errors as errs then
					r.add_error_message (html_encoded (errs))
				end

				across
					lst as ic
				loop
					l_module := ic.item
					s.append ("<li>")
					s.append (l_module.name)
					if l_module.is_enabled then
						s.append (" </strong>[enabled]</strong>")
					end

					if api.is_module_installed (l_module) then
						s.append (" was successfully installed.")
					elseif l_module.is_enabled then
						s.append (" could not be installed!")
						s.append (" <span class=%"error%">[ERROR]</span>")
					else
						s.append (" is not enabled!")
					end
					s.append ("</li>%N")
				end
				s.append ("</ul>")
				s.append ("<div>Back to the " + r.link ("Administration", api.administration_path (Void), Void) + " ...</div>")
				r.set_main_content (s)

				if l_is_fresh_installation then
					r.set_title (r.translation ("New installation ...", Void))
				else
					r.set_title (r.translation ("Update installation ...", Void))
				end
				r.execute
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

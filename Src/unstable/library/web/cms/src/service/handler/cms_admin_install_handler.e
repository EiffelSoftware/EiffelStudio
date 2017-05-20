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
		do
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
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.set_main_content ("You do not have permission to access CMS installation procedure!")
			else
				create s.make_from_string ("<h1>Modules</h1><ul>")
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
			end
			r.set_title (r.translation ("CMS Installation ...", Void))
			r.execute
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

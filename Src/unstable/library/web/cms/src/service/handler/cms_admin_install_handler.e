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
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_title (r.translation ("CMS Installation ...", Void))
			create s.make_from_string ("<h1>Modules</h1><ul>")
			create lst.make (1)
			across
				api.setup.modules as ic
			loop
				l_module := ic.item
				if api.is_module_installed (l_module) then
					s.append ("<li>" + l_module.name + " is already installed.</li>%N")
				else
					lst.force (l_module)
				end
			end
			api.install
			across
				lst as ic
			loop
				l_module := ic.item
				if api.is_module_installed (l_module) then
					s.append ("<li>" + l_module.name + " was successfully installed.</li>%N")
				else
					s.append ("<li>" + l_module.name + " could not be installed!</li>%N")
				end
			end
			s.append ("</ul>")
			r.set_main_content (s)
			r.execute
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

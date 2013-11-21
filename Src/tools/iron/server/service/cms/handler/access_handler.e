note
	description: "Summary description for {ACCESS_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ACCESS_HANDLER

inherit
	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		select
			new_mapping
		end

	IRON_NODE_HANDLER
		rename
			set_iron as make
		end

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				handle_access_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_access_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			s: STRING
		do
			if req.is_content_type_accepted ("text/html") then
				m := new_response_message (req)
				if has_iron_version (req) then
					create s.make_empty
					s.append ("<ul>")
					s.append ("<li><a href=%"" + req.script_url (iron.package_version_list_web_page (iron_version (req))) + "%">Package list</a></li>")
					s.append ("<li><a href=%"" + req.script_url (iron.package_version_create_web_page (iron_version (req))) + "%">New package</a></li>")
					s.append ("</ul>")
				elseif attached iron.database.versions as l_versions then
					create s.make_empty
					s.append ("<h2>Versions</h2>")
					s.append ("<ul>")
					across
						l_versions as c
					loop
						s.append ("<li><a href=%"" + req.script_url (iron.page (c.item, "/")) + "%">Version "+ c.item.value +"</a></li>")

					end
					s.append ("</ul>")
				else
					s := "..."
				end

				if attached {WSF_STRING} req.item ("redirection") as l_redir then
					m.set_location (l_redir.value)
				end

				m.set_title ("Information")
				m.set_body (s)
				res.send (m)
			else
				res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("GET: Access the repositories information.")
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

note
	date: "$Date$"
	revision: "$Revision$"

class
	HOME_HANDLER

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
				handle_home_package (req, res)
			elseif req.is_post_request_method then
				handle_new_version_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_home_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			s: STRING
			f: like new_version_form
		do
			if req.is_content_type_accepted ("text/html") then
				m := new_response_message (req)
				m.set_is_front (True)
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
					l_versions.reverse_sort
					across
						l_versions as c
					loop
						s.append ("<li><a href=%"" + req.script_url (iron.page (c, "/")) + "%">Version "+ c.value +"</a></li>")

					end
					s.append ("</ul>")
				else
					s := "..."
				end

				if
					has_permission_to_administrate_versions (req)
				then
					if
						attached req.query_parameter ("manage") as p and then p.same_string ("versions")
					then
						f := new_version_form (req)
						f.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (req), s)
					else
						s.append ("<div><a href=%"" + req.script_url (iron.version_create_page) + "?manage=versions%">New version?</a></div>")
					end
				end

				if attached {WSF_STRING} req.item ("redirection") as l_redir then
					m.set_location (l_redir.value)
				end

				m.set_title (Void)
				m.set_body (s)
				res.send (m)
			else
				res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
			end
		end

	handle_new_version_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			f: like new_version_form
			v: detachable IRON_NODE_VERSION
		do
			m := new_response_message (req)
			if attached req.form_parameter ("op") as p_op and then p_op.same_string (op_create_new_version) then
				if has_permission_to_administrate_versions (req) then
					f := new_version_form (req)
					f.process (req, Void, Void)
					if
						attached f.last_data as l_data and then
						not l_data.has_error and then
						attached l_data.string_item ("new_version") as l_new_version and then
						not l_new_version.is_whitespace
					then
						create v.make (l_new_version)
						iron.database.save_version (v)
						m.add_normal_message ("New version created.")
					end
					m.set_location (iron.page_redirection (v))
					if v /= Void then
						m.set_body ("<a href=%"" + iron.page_redirection (v) + "%">New version created.</a>")
					else
						m.set_body ("<a href=%"" + iron.page_redirection (Void) + "%">Back to home.</a>")
					end
					res.send (m)
				else
					res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
				end
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	new_version_form (req: WSF_REQUEST): WSF_FORM
		local
			ti: WSF_FORM_TEXT_INPUT
			sub: WSF_FORM_SUBMIT_INPUT
		do
			create Result.make (req.percent_encoded_path_info, "new-iron-version")
			create ti.make ("new_version")
			Result.extend (ti)
			create sub.make_with_text ("op", op_create_new_version)
			Result.extend (sub)
		end

	op_create_new_version: STRING_32 = "Create new version"

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("GET: Access the repositories information.")
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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

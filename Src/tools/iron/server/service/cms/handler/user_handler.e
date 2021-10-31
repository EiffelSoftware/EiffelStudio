note
	date: "$Date$"
	revision: "$Revision$"

class
	USER_HANDLER

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

	SHARED_HTML_ENCODER

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				handle_account (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_account (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: like new_response_message
			s: STRING
			u: like current_user
			l_user: detachable IRON_NODE_USER
		do
			if req.is_content_type_accepted ("text/html") then
				m := new_response_message (req)
				create s.make_empty
				u := current_user (req)

				if attached {WSF_STRING} req.path_parameter ("uid") as s_uid then
					l_user := iron.database.user (s_uid.value)
				else
					l_user := u
				end

				if l_user /= Void then
					s.append ("<h2>")
					s.append ("Account ")
					s.append (m.html_encoded_string (l_user.name))
					s.append ("</h2>")

					if
						u /= Void and then
						(u.is_administrator or u.same_user (l_user))
					then
						if attached l_user.email as l_user_email then
							s.append ("<div>email: ")
							s.append (l_user_email)
							s.append ("</div>")
						end
						if attached l_user.roles as l_roles then
							s.append ("<div>")
							s.append ("<span>Roles:")
							across
								l_roles as c
							loop
								s.append (" ")
								s.append (m.html_encoded_string (c.name))
							end
							s.append ("</span>")
							s.append ("</div>")
						end

						if attached {READABLE_STRING_GENERAL} l_user.data_item ("profile.note") as l_note then
							s.append ("<div>note: ")
							s.append (html_encoder.general_encoded_string (l_note))
							s.append ("</div>")
						end
					end
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
			Result.add_description ("Account page (authentication required).")
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

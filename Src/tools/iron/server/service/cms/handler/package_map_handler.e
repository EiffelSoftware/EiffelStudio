note
	date: "$Date$"
	revision: "$Revision$"

class
	PACKAGE_MAP_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_NODE_HANDLER
		rename
			set_iron as make
		end

create
	make

feature -- Execution	

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if is_method_post (req) then
				handle_create_package_map (req, res)
			elseif is_method_delete (req) then
					-- Must be before GET processing, since it uses GET + ?method as hack
				handle_delete_package_map (req, res)
			elseif is_method_get (req) then
				handle_view_package_map (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_view_package_map (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_response_message
			s: STRING_8
			v: READABLE_STRING_8
			l_parent: detachable READABLE_STRING_8
			i: INTEGER
			f: WSF_FORM
			fi: WSF_FORM_TEXT_INPUT
		do
			if attached package_version_from_id_path_parameter (req, "id") as l_package	then
				if has_permission_to_modify_package_version (req, l_package) then
					r := new_response_message (req)
					r.set_iron_version_package (l_package)
					r.add_menu ("View", iron.package_version_view_web_page (l_package))
					create s.make_empty
					s.append ("<strong>[")
					s.append (r.html_encoded_string (l_package.human_identifier))
					s.append ("] maps:</strong>")
					if attached iron.database.path_associated_with_package (l_package) as lst then
						s.append ("<ul>%N")
						v := iron_version (req).value
						across
							lst as c
						loop
							s.append ("<li>")
							i := c.last_index_of ('/', c.count)
							s.append ("<a href=%"" + "/" + v + "%">/" + v + "</a> ")
							if i > 0 then
								l_parent := c.substring (1, i)
								s.append ("<a href=%"" + "/" + v + l_parent + "%">" + l_parent + "</a>")
								s.append ("<a href=%"" + "/" + v + c + "%">" + c.substring ( i+1, c.count) + "</a>")
							else
								s.append ("<a href=%"" + "/" + v + c + "%"> " + c + " </a>")
							end
							s.append (" <a style=%"color: red;%" href=%"" + iron.package_version_map_web_page (l_package, c) + "?" + Method_query_parameter + "=DELETE%">DEL</a>")
							s.append ("</li>%N")
						end
						s.append ("</ul>")
					end
					create f.make (iron.package_version_map_web_page (l_package, Void), "new_map")
					create fi.make ("map")
					fi.set_label ("Path association")
					fi.set_description ("Associate the path with current package.")
					f.extend (fi)
					f.extend (create {WSF_FORM_SUBMIT_INPUT}.make_with_text ("op", "ADD"))

					f.append_to_html (create {WSF_REQUEST_THEME}.make_with_request (req), s)
					r.set_body (s)
					res.send (r)
				else
					res.send (new_not_permitted_response_message (l_package, req))
				end
			else
				res.send (new_not_found_response_message (req))
			end
		end

	handle_create_package_map (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_path: detachable STRING_32
			m: like new_response_message
			s: STRING
			l_repo_url: STRING
			err: BOOLEAN
		do
			if attached package_version_from_id_path_parameter (req, "id") as l_package	then
				if has_permission_to_modify_package_version (req, l_package) then
					m := new_response_message (req)
					m.set_iron_version_package (l_package)
					create s.make_empty

					m.add_menu ("View", iron.package_version_view_web_page (l_package))

					if attached req.string_item ("map") as s_path then
						l_path := s_path
					end
					if l_path = Void then
						if
							attached {WSF_TABLE} req.item ("map") as p_map
						then
							create l_path.make_empty
							across
								p_map as c
							loop
								if not l_path.is_empty then
									l_path.append_character ('/')
								end
								l_path.append (c.string_representation)
							end
						end
					end
					if l_path /= Void then
						l_repo_url := req.absolute_script_url ("/" + iron_version (req).value)
						if l_path.starts_with (l_repo_url) then
							l_path.remove_head (l_repo_url.count)
						end
						if l_path.has (':') or l_path.has_substring ("..") then
							-- invalid path
							err := True
							s.append ("Invalid map parameter (should not contain ':' or '..' )")
						else
							if l_path.starts_with ("/") then
								l_path.remove_head (1)
							end
							if attached iron.database.package_by_path (iron_version (req), l_path) as p_curr then
								s.append ("Already associated to " + m.html_encoded_string (p_curr.human_identifier))
								err := True
							else
								iron.database.associate_package_with_path (l_package, l_path)
								if iron.database.package_by_path (iron_version (req), l_path) ~ l_package then
									-- succeed
									s.append ("association created.")
								else
									-- failure
									s.append ("association creation failed.")
									err := True
								end
							end
						end
					else
						s.append ("Missing map parameter.")
					end
					s.append ("<div>")
					s.append ("<a href=%"" + iron.package_version_map_web_page (l_package, Void) + "%">"+ m.html_encoded_string (l_package.human_identifier) +"</a>")
					s.append ("</div>")
					m.set_body (s)

					res.send (m)
				else
					res.send (new_not_permitted_response_message (l_package, req))
				end
			else
				res.send (new_not_found_response_message (req))
			end
		end

	handle_delete_package_map (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_path: STRING_32
			m: IRON_NODE_HTML_RESPONSE
			s: STRING
		do
			if attached package_version_from_id_path_parameter (req, "id") as l_package then
				if has_permission_to_modify_package_version (req, l_package) then
					m := new_response_message (req)
					m.set_iron_version_package (l_package)
					create s.make_empty
					m.add_menu ("View", iron.package_version_view_web_page (l_package))
					if
						attached {WSF_TABLE} req.path_parameter ("map") as p_map
					then
						create l_path.make_empty
						across
							p_map as c
						loop
							if not l_path.is_empty then
								l_path.append_character ('/')
							end
							l_path.append (c.string_representation)
						end
						if iron.database.package_by_path (iron_version (req), l_path) ~ l_package then
							iron.database.unassociate_package_with_path (l_package, l_path)
							if iron.database.package_by_path (iron_version (req), l_path) = Void then
								-- succeed
								s.append ("association removed.")
							else
								-- failure
								s.append ("association removal failed.")
							end
						else
							s.append ("Not associated.")
						end
					else
						s.append ("Missing map parameter.")
					end
					s.append ("<div>")
					s.append ("<a href=%"" + iron.package_version_map_web_page (l_package, Void) + "%">"+ m.html_encoded_string (l_package.human_identifier) +"</a>")
					s.append ("</div>")
					m.set_body (s)

					res.send (m)
				else
					res.send (new_not_permitted_response_message (l_package, req))
				end
			else
				res.send (new_not_found_response_message (req))
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("GET: get package map information.")
			Result.add_description ("POST: create package map (auth required).")
			Result.add_description ("DELETE: delete package map (auth required).")
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

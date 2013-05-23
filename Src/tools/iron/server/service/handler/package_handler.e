note
	description: "Summary description for {SEARCH_PACKAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PACKAGE_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_REPO_HANDLER
		rename
			set_iron as make
		end

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if is_method_post (req) or is_method_put (req) then
				handle_update_package (req, res)
			elseif is_method_delete (req) then
				handle_delete_package (req, res)
			elseif is_method_get (req) then
				handle_view_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_view_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: IRON_REPO_HTML_RESPONSE
			it: HTML_IRON_REPO_ITERATOR
			s: STRING_8
			v: READABLE_STRING_8
			i: INTEGER
			l_path: READABLE_STRING_8
		do
			if
				attached {WSF_STRING} req.path_parameter ("id") as p_id and then
			 	attached iron.database.package (iron_version (req), p_id.value) as l_package
			then
				create s.make (1024)
				s.append ("<ul>")
				create it.make (s, req, iron, iron_version (req))
				it.set_user (current_user (req))
				it.visit_package (l_package)
				if attached iron.database.path_associated_with_package (iron_version (req), l_package) as lst then
					s.append ("<ul><strong><a href=%""+ iron.package_map_web_page (iron_version (req), l_package, Void) +"%">Associated URIs</a></strong>%N")
					v := iron_version (req).value
					across
						lst as c
					loop
						s.append ("<li>")
						l_path := c.item
						i := l_path.last_index_of ('/', l_path.count)
						if i > 0 then
							s.append ("<a href=%"" + "/" + v + l_path.substring (1, i) + "%">/" + v + l_path.substring (1, i) + "</a> ")
							s.append ("<a href=%"" + "/" + v + l_path + "%">" + l_path.substring (i+1, l_path.count) + "</a>")
						else
							s.append ("<a href=%"" + "/" + v + l_path + "%">/" + v + l_path + "</a>")
						end
						s.append ("</li>%N")
					end
					s.append ("</ul>")
				end

				if is_authenticated (req) then
					s.append ("<div><a href=%""+ req.script_url (iron.package_edit_web_page (iron_version (req), l_package)) +"%"Edit this package</a></div>")
				end
				r := new_response_message (req)
				r.add_menu ("Edit", iron.package_edit_web_page (iron_version (req), l_package))
				r.add_menu ("Map", iron.package_map_web_page (iron_version (req), l_package, Void))
				r.set_title ("Package " + iron.html_encoder.encoded_string (l_package.human_identifier))
				r.set_body (s)
				res.send (r)
			else
				res.send (create {WSF_NOT_IMPLEMENTED_RESPONSE}.make (req))
			end
		end

	handle_update_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
--			l_theme: WSF_THEME
			f: detachable like new_package_edit_form
--			r: IRON_HTML_RESPONSE
		do
			if attached package_from_id_path_parameter (req, "id") as l_package then
				f := new_package_edit_form (l_package, req, True)
			else
				f := new_package_edit_form (Void, req, True)
			end
			if f /= Void then
				f.process (req, Void, agent on_package_edit_form_processed (?, req, res))
			else
				res.send (create {IRON_REPO_HTML_RESPONSE}.make_not_found (req, iron))
			end
		end

	handle_delete_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached package_from_id_path_parameter (req, "id") as l_package then
				if has_permission_to_modify_package (req, l_package) then
					iron.database.delete_package (iron_version (req), l_package)
					res.redirect_now (iron.package_list_web_page (iron_version (req)))
				else
					res.send (create {IRON_REPO_HTML_RESPONSE}.make_not_permitted (req, iron))
				end
			else
				res.send (create {IRON_REPO_HTML_RESPONSE}.make_not_found (req, iron))
			end
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			Result.add_description ("GET: get information related to package {id} (auth required).")
			Result.add_description ("DELETE: delete package {id} (auth required).")
			Result.add_description ("PUT: update package {id} (auth required).")
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

note
	description: "Summary description for {SEARCH_PACKAGE_API_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PACKAGE_API_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

	IRON_NODE_API_HANDLER
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
				handle_get_package (req, res)
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_get_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: IRON_NODE_API_RESPONSE
			it: JSON_V1_IRON_NODE_ITERATOR
			s: STRING_8
			l_package: detachable IRON_NODE_VERSION_PACKAGE
		do
			l_package := package_version_from_id_path_parameter (req, "id")
			if l_package /= Void then
				create s.make (1024)
				create it.make (req, iron, iron_version (req))
				it.set_is_long_version (True)
				it.set_user (current_user (req))
--				it.visit_package_version (l_package)
				s.append (it.package_version_to_json (l_package))
				s.append ("</ul>")
				r := new_response_message (req)
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
			if attached package_version_from_id_path_parameter (req, "id") as l_package then
				f := new_package_edit_form (l_package, req, True)
			else
				f := new_package_edit_form (Void, req, True)
			end
			if f /= Void then
				f.process (req, Void, agent on_package_edit_form_processed (?, req, res))
			else
				res.send (new_not_found_response_message (req))
			end
		end

	handle_delete_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached package_version_from_id_path_parameter (req, "id") as l_package then
				if has_permission_to_modify_package (req, l_package.package) then
					iron.database.delete_version_package (l_package)
--					res.redirect_now (iron.package_version_list_web_page (iron_version (req)))
				else
					res.send (new_not_permitted_response_message (req))
				end
			else
				res.send (new_not_found_response_message (req))
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

note
	description: "Summary description for {EDIT_PACKAGE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDIT_PACKAGE_HANDLER

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
			if is_authenticated (req) then
				if req.is_get_request_method then
					handle_form_edit_package (req, res)
				else
					res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
				end
			else
				res.send (create {WSF_METHOD_NOT_ALLOWED_RESPONSE}.make (req))
			end
		end

	handle_form_edit_package (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_theme: WSF_REQUEST_THEME
			f: like new_package_edit_form
			r: IRON_NODE_HTML_RESPONSE
		do
			r := new_response_message (req)
			if attached package_version_from_id_path_parameter (req, "id") as l_package then
				r.set_iron_version_package (l_package)
				r.add_menu ("View", iron.package_version_view_web_page (l_package))
				f := new_package_edit_form (l_package, req, False)
				create l_theme.make_with_request (req)
				r.set_title ("Edit package %"" + iron.html_encoder.general_encoded_string (l_package.human_identifier) + "%"")
				r.set_body (f.to_html (l_theme))
			else
				r.set_body ("Missing parameter {id}")
			end
			res.send (r)
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- Documentation associated with Current handler, in the context of the mapping `m' and methods `a_request_methods'.
			--| `m' and `a_request_methods' are useful to produce specific documentation when the handler is used for multiple mapping.
		do
			create Result.make (m)
			Result.add_description ("[GET] web form to edit a new package entry (authentication required).")
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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

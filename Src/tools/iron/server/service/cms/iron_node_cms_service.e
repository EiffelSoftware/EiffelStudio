note
	description: "Summary description for {IRON_NODE_CMS_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_CMS_SERVICE

inherit
	IRON_NODE_SERVICE_I

create
	make

feature -- Initialization

	setup_router
			-- Setup `router'
		local
			h_access: HOME_HANDLER
			h_account: ACCOUNT_HANDLER
			h_user: USER_HANDLER
			h_search: SEARCH_PACKAGE_HANDLER
			h_create: CREATE_PACKAGE_HANDLER
			h_edit: EDIT_PACKAGE_HANDLER
			h_package: PACKAGE_HANDLER
			h_package_map: PACKAGE_MAP_HANDLER
			h_archive_package: ARCHIVE_PACKAGE_HANDLER
			h_package_fetcher: FETCH_PACKAGE_HANDLER
			l_layout: IRON_NODE_LAYOUT
			l_iron: like iron
			h_doc: WSF_FILE_SYSTEM_HANDLER
		do
				--| Optional
			router.handle ("/debug/", create {WSF_DEBUG_HANDLER}.make_hidden, Void)

			l_iron := iron
			l_layout := l_iron.layout

			debug ("iron")
				router.handle (l_iron.cms_page ("/db/"), create {WSF_FILE_SYSTEM_HANDLER}.make_hidden (l_layout.repo_path.name), router.methods_get)
			end
			router.handle (l_iron.cms_page ("/html/"), create {WSF_FILE_SYSTEM_HANDLER}.make_hidden (l_layout.www_path.name), router.methods_get)
			if l_iron.is_documentation_available then
				create h_doc.make_hidden (l_layout.documentation_path.name)
				h_doc.set_directory_index (<<"index.html">>)
				h_doc.enable_index
				router.handle (l_iron.cms_page ("/doc/"), h_doc, router.methods_get)
			end

				--| User
			create h_user.make (l_iron)
			map_uri (l_iron.cms_page ("/user"), new_auth_uri_handler (h_user), router.methods_get) -- User::home
			map_uri (l_iron.cms_page ("/user/"), new_auth_uri_handler (h_user), router.methods_get) -- User::home
			map_uri_template (l_iron.cms_page ("/user/{uid}"), new_auth_uri_template_handler (h_user), router.methods_get) -- User::home

				--| Account
			create h_account.make (l_iron)
			map_uri (l_iron.cms_page ("/account/"), h_account, router.methods_get_post) -- Account::home
			map_uri_template (l_iron.cms_page ("/account/{uid}/"), h_account, router.methods_get_post) -- Activate ...

				--| Access
			create h_access.make (l_iron)
			map_uri (l_iron.cms_page ("/"), h_access, router.methods_get_post) -- Admin::home
			map_uri_template (l_iron.cms_page ("/{version}/"), h_access, router.methods_get) -- Admin::home

			create h_create.make (l_iron)
			create h_archive_package.make (l_iron)
			create h_search.make (l_iron)
			create h_package.make (l_iron)
			create h_edit.make (l_iron)
			create h_package_map.make (l_iron)

				-- Pure website/html pages
			map_uri_template (l_iron.cms_page ("/{version}/package/create/"), new_auth_uri_template_handler (h_create), router.methods_get) -- Create
			map_uri_template (l_iron.cms_page ("/{version}/package/{id}/edit/"), new_auth_uri_template_handler (h_edit), router.methods_get) -- Edit

				-- Cms
			map_uri_template (l_iron.cms_page ("/{version}/package/"), new_auth_uri_template_handler (h_package), router.methods_post) -- Create
			map_uri_template (l_iron.cms_page ("/{version}/package/{id}"), h_package, router.methods_get) --  Get package data
			map_uri_template (l_iron.cms_page ("/{version}/package/{id}"), new_auth_uri_template_handler (h_package), router.methods_put_post + router.methods_delete) --  Update package
			map_uri_template (l_iron.cms_page ("/{version}/package/{id}/archive"), h_archive_package, router.methods_get) --  Get archive package data
			map_uri_template (l_iron.cms_page ("/{version}/package/{id}/archive"), new_auth_uri_template_handler (h_archive_package), router.methods_post + router.methods_put + router.methods_delete) --  Get archive package data

			map_uri_template (l_iron.cms_page ("/{version}/package/{id}/map"), h_package_map, router.methods_get) --  Get map
			map_uri_template (l_iron.cms_page ("/{version}/package/{id}/map{/map}"), h_package_map, router.methods_get) --  Get map and allow ?method= .. hack
			map_uri_template (l_iron.cms_page ("/{version}/package/{id}/map"), h_package_map, router.methods_post) --  Create new map
			map_uri_template (l_iron.cms_page ("/{version}/package/{id}/map{/map}"), new_auth_uri_template_handler (h_package_map), router.methods_delete + router.methods_post) -- Create/Delete mapping
			map_uri_template (l_iron.cms_page ("/{version}/package/"), h_search, router.methods_get) -- Search

			router.handle (l_iron.cms_page (""), create {WSF_STARTS_WITH_AGENT_HANDLER}.make (agent redirect_to_home), router.methods_get)

				--| Misc access
			router.handle ("/favicon.ico", create {WSF_SELF_DOCUMENTED_URI_AGENT_HANDLER}.make_hidden (agent handle_favicon), router.methods_get)
			router.handle ("/", create {WSF_SELF_DOCUMENTED_URI_AGENT_HANDLER}.make (agent handle_home("/", ?, ?), agent  (ia_m: WSF_ROUTER_MAPPING; ia_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
				do
					create Result.make (ia_m)
					Result.add_description ("Home page")
				end), router.methods_get)

				--| Package access
			create h_package_fetcher.make (l_iron)
			map_uri_template ("/{version}{/vars}", h_package_fetcher, router.methods_get) --  Get package info
			map_uri_template ("/{version}", h_package_fetcher, router.methods_get) --  Get package info

				--| Misc/default
			router.handle ("/", create {WSF_SELF_DOCUMENTED_STARTS_WITH_AGENT_HANDLER}.make_with_descriptions (agent handle_home, <<"Redirect to home page">>), router.methods_get)
			debug ("iron")
				router.pre_execution_actions.extend (agent  (ia_map: WSF_ROUTER_MAPPING)
					do
						io.error.put_string (">> ")
						io.error.put_string (ia_map.associated_resource)
						io.error.put_string (" ")
						io.error.put_string (ia_map.handler.generator)
						io.error.put_string (" ")
						io.error.put_string (ia_map.debug_output.as_string_8) -- eventual truncated information, but ok for debugging
						io.error.put_new_line
					end)
			end
		end

feature -- handler

	redirect_to_home (a_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: WSF_REDIRECTION_RESPONSE
		do
			create r.make (req.absolute_script_url (iron.cms_page ("/")))
			r.set_content ("Test redirection content", Void)
			res.send (r)
		end

	handle_favicon (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
		end

	handle_home (a_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: IRON_NODE_HTML_RESPONSE
			s: STRING
			l_iron: like iron
		do
			l_iron := iron
			create r.make (req, l_iron)
			create s.make_empty
			s.append ("<div id=%"enter-box%">")
			s.append ("<a href=%"" + req.script_url (l_iron.cms_page ("")) + "%">ENTER the IRON repository</a>")
			s.append ("</div>")
			r.set_location (iron.cms_page (""))
			r.set_body (s)
			res.send (r)
		end

feature -- Factory

	new_auth_uri_handler (h: WSF_URI_HANDLER): IRON_NODE_AUTH_URI_FILTER_HANDLER
		do
			create Result.make_with_next (iron, h)
		end

	new_auth_uri_template_handler (h: WSF_URI_TEMPLATE_HANDLER): IRON_NODE_AUTH_URI_TEMPLATE_FILTER_HANDLER
		do
			create Result.make_with_next (iron, h)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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


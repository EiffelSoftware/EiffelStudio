note
	description: "Summary description for {IRON_NODE_API_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_API_SERVICE

inherit
	IRON_NODE_SERVICE_I

create
	make

feature -- Initialization

	setup_router
			-- Setup `router'
		local
			h_access: ACCESS_API_HANDLER
			h_search: SEARCH_PACKAGE_API_HANDLER
			h_package: PACKAGE_API_HANDLER
			h_package_map: PACKAGE_MAP_API_HANDLER
			h_archive_package: ARCHIVE_PACKAGE_API_HANDLER
			h_package_fetcher: FETCH_PACKAGE_API_HANDLER
			l_layout: IRON_NODE_LAYOUT
			l_iron: like iron
		do
			l_iron := iron
			l_layout := l_iron.layout

				--| Documentation
			router.handle (l_iron.api_resource ("/api/"), create {WSF_ROUTER_SELF_DOCUMENTATION_HANDLER}.make_hidden (router), router.methods_get)

				--| Access
			create h_access.make (l_iron)
			map_uri (l_iron.api_resource ("/"), h_access, router.methods_get) -- Admin::home
			map_uri_template (l_iron.api_resource ("/{version}/"), h_access, router.methods_get) -- Admin::home

			create h_archive_package.make (l_iron)
			create h_search.make (l_iron)
			create h_package.make (l_iron)
			create h_package_map.make (l_iron)

				-- REST: access
			map_uri_template (l_iron.api_resource ("/package/{id}"), h_package, router.methods_get) --  Get package data for `id'

				-- REST: access by version
			map_uri_template (l_iron.api_resource ("/{version}/package/{id}"), h_package, router.methods_get) --  Get package data for `id'
			map_uri_template (l_iron.api_resource ("/{version}/package/{id}/archive"), h_archive_package, router.methods_get) --  Get archive package data i.e download archive...

				-- REST: manager
			map_uri_template (l_iron.api_resource ("/{version}/package/"), new_auth_uri_template_handler (h_package), router.methods_post) -- Create new package version
			map_uri_template (l_iron.api_resource ("/{version}/package/{id}"), new_auth_uri_template_handler (h_package), router.methods_put_post + router.methods_delete) --  Update package version
			map_uri_template (l_iron.api_resource ("/{version}/package/{id}/archive"), new_auth_uri_template_handler (h_archive_package), router.methods_post + router.methods_put + router.methods_delete) --  Update archive package data

				-- REST: access map
			map_uri_template (l_iron.api_resource ("/{version}/package/{id}/map"), h_package_map, router.methods_get) --  Get maps
			map_uri_template (l_iron.api_resource ("/{version}/package/{id}/map{/map}"), h_package_map, router.methods_get) -- Get specific maps
				-- FIXME: Get map and allow ?method= .. hack for website. Will be removed soon.

				-- REST: manage map
			map_uri_template (l_iron.api_resource ("/{version}/package/{id}/map"), new_auth_uri_template_handler (h_package_map), router.methods_post) --  Create new map
			map_uri_template (l_iron.api_resource ("/{version}/package/{id}/map{/map}"), new_auth_uri_template_handler (h_package_map), router.methods_delete + router.methods_post) -- Create/Delete mapping

				-- REST: search ...
			map_uri_template (l_iron.api_resource ("/{version}/package/"), h_search, router.methods_get) -- Search

--				--| Misc access
--			router.handle ("/", create {WSF_SELF_DOCUMENTED_URI_AGENT_HANDLER}.make (agent handle_home("/", ?, ?), agent  (ia_m: WSF_ROUTER_MAPPING; ia_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
--				do
--					create Result.make (ia_m)
--					Result.add_description ("Home page")
--				end))

				--| Package access
			create h_package_fetcher.make (l_iron)
			map_uri_template ("/{version}{/vars}", h_package_fetcher, router.methods_get) --  Get package info
			map_uri_template ("/{version}", h_package_fetcher, router.methods_get) --  Get package info


				--| Misc/default
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

feature -- Factory

	new_auth_uri_handler (h: WSF_URI_HANDLER): IRON_NODE_AUTH_URI_FILTER_API_HANDLER
		do
			create Result.make_with_next (iron, h)
		end

	new_auth_uri_template_handler (h: WSF_URI_TEMPLATE_HANDLER): IRON_NODE_AUTH_URI_TEMPLATE_FILTER_API_HANDLER
		do
			create Result.make_with_next (iron, h)
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


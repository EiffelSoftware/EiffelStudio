note
	description: "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_SERVER

inherit

	IRON_REPO_CONSTANTS

	WSF_LAUNCHABLE_SERVICE
		rename
			make_and_launch as make_and_launch_service
		redefine
			initialize
		end

	WSF_URI_HELPER_FOR_ROUTED_SERVICE

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_SERVICE

		--	WSF_ROUTED_SERVICE

	WSF_ROUTED_SKELETON_SERVICE
		rename
			execute as execute_router
		undefine
			requires_proxy
		end

	WSF_NO_PROXY_POLICY

	WSF_FILTERED_SERVICE

	WSF_FILTER
		rename
			execute as execute_router
		end

	SHARED_EXECUTION_ENVIRONMENT

create
	make_and_launch,
	make_and_launch_cgi,
	make_and_launch_libfcgi

feature {NONE} -- Initialization

	make_and_launch (a_iron: like iron)
		do
			iron := a_iron
			make_and_launch_service
		end

	make_and_launch_cgi (a_iron: like iron)
		do
			is_cgi := True
			make_and_launch (a_iron)
		end

	make_and_launch_libfcgi (a_iron: like iron)
		do
			is_libfcgi := True
			make_and_launch (a_iron)
		end

	initialize
		do
			initialize_router
			initialize_filter
			Precursor
			service_options := create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("iron.ini")
				--			set_service_option ("force_single_threaded", True)
		end

feature {NONE} -- Launcher

	is_standalone: BOOLEAN
		do
			Result := not (is_cgi or is_libfcgi)
		end

	is_cgi: BOOLEAN

	is_libfcgi: BOOLEAN

	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_SERVICE_LAUNCHER
		do
			if is_cgi then
				create {WSF_CGI_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts)
			elseif is_libfcgi then
				create {WSF_LIBFCGI_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts)
			else
				create {WSF_DEFAULT_SERVICE_LAUNCHER} launcher.make_and_launch (a_service, opts)
			end
		end

feature -- Iron

	iron: IRON_REPO

feature -- Router and Filter

	create_filter
			-- Create `filter'
		local
			f, l_filter: detachable WSF_FILTER
			fh: WSF_CUSTOM_HEADER_FILTER
			cfg: IRON_CONFIGURATION_FILTER
		do
			l_filter := Void
			create cfg
			cfg.uploaded_file_path := iron.basedir.extended ("tmp")
			cfg.set_next (l_filter)
			l_filter := cfg

				-- Header
			create fh.make (1)
			fh.set_next (l_filter)
			fh.custom_header.put_header ("X-IronServer: " + version)
			l_filter := fh

				-- Maintenance
			create {WSF_MAINTENANCE_FILTER} f
			f.set_next (l_filter)
			l_filter := f
			debug ("iron")
					-- Debug
				create {WSF_DEBUG_FILTER} f
				f.set_next (l_filter)
				l_filter := f
			end
			if not (is_libfcgi or is_cgi) then
					-- Logging for nino
				create {WSF_LOGGING_FILTER} f
				f.set_next (l_filter)
				l_filter := f
			end

				--			if attached iron.basedir as p_basedir then
				--				create {WSF_FILE_SYSTEM_FILTER} f.make_with_path (p_basedir.extended ("html"))
				--				f.set_next (l_filter)
				--				l_filter := f
				--			end

			filter := l_filter
		end

	setup_filter
			-- Setup `filter'
		local
			f: WSF_FILTER
		do
			from
				f := filter
			until
				not attached f.next as l_next
			loop
				f := l_next
			end
			f.set_next (Current)
		end

	setup_router
			-- Setup `router'
		local
			h_access: ACCESS_HANDLER
			h_account: ACCOUNT_HANDLER
			h_user: USER_HANDLER
			h_search: SEARCH_PACKAGE_HANDLER
			h_create: CREATE_PACKAGE_HANDLER
			h_edit: EDIT_PACKAGE_HANDLER
			h_package: PACKAGE_HANDLER
			h_package_map: PACKAGE_MAP_HANDLER
			h_archive_package: ARCHIVE_PACKAGE_HANDLER
			h_package_fetcher: FETCH_PACKAGE_HANDLER
			--			h_fs: WSF_FILE_SYSTEM_HANDLER
		do
				--|  Servername: http://iron.eiffel.com/

				--| Optional
			debug ("iron")
				map_uri_template ("/debug/{name}", create {WSF_SELF_DOCUMENTED_URI_TEMPLATE_AGENT_HANDLER}.make_hidden (agent handle_debug))
			end
			if attached iron.basedir as p_basedir then
				debug ("iron")
					router.handle ("/access/db/", create {WSF_FILE_SYSTEM_HANDLER}.make_hidden (p_basedir.extended ("repo").name))
				end
				router.handle ("/access/html/", create {WSF_FILE_SYSTEM_HANDLER}.make_hidden (p_basedir.extended ("html").name))
			end
			if iron.is_documentation_available then
				router.handle ("/access/doc/", create {WSF_FILE_SYSTEM_HANDLER}.make_hidden (iron.documentation_path.name))
			end
			map_uri_with_request_methods ("/_shutdown_/", new_auth_uri_handler (create {SHUTDOWN_HANDLER}.make (iron)), router.methods_get) --  Shutdown server

				--| Documentation
			router.handle ("/access/api/", create {WSF_ROUTER_SELF_DOCUMENTATION_HANDLER}.make_hidden (router))

				--| User
			create h_user.make (iron)
			map_uri_with_request_methods ("/access/user", new_auth_uri_handler (h_user), router.methods_get) -- User::home
			map_uri_with_request_methods ("/access/user/", new_auth_uri_handler (h_user), router.methods_get) -- User::home
			map_uri_template_with_request_methods ("/access/user/{uid}", new_auth_uri_template_handler (h_user), router.methods_get) -- User::home

				--| Account
			create h_account.make (iron)
			map_uri_with_request_methods ("/access/account/", h_account, router.methods_get + router.methods_post) -- Account::home
			map_uri_template_with_request_methods ("/access/account/{uid}/", h_account, router.methods_get  + router.methods_post) -- Activate ...

				--| Access
			create h_access.make (iron)
			map_uri_with_request_methods ("/access/", h_access, router.methods_get) -- Admin::home
			map_uri_template_with_request_methods ("/access/{version}/", h_access, router.methods_get) -- Admin::home

			create h_create.make (iron)
			create h_archive_package.make (iron)
			create h_search.make (iron)
			create h_package.make (iron)
			create h_edit.make (iron)
			create h_package_map.make (iron)

				-- Pure website/html pages
			map_uri_template_with_request_methods ("/access/{version}/package/create/", new_auth_uri_template_handler (h_create), router.methods_get) -- Create
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/edit/", new_auth_uri_template_handler (h_edit), router.methods_get) -- Edit

				-- REST or web
			map_uri_template_with_request_methods ("/access/{version}/package/", new_auth_uri_template_handler (h_package), router.methods_post) -- Create
			map_uri_template_with_request_methods ("/access/{version}/package/{id}", h_package, router.methods_get) --  Get package data
			map_uri_template_with_request_methods ("/access/{version}/package/{id}", new_auth_uri_template_handler (h_package), router.methods_put_post + router.methods_delete) --  Update package
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/archive", h_archive_package, router.methods_get) --  Get archive package data
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/archive", new_auth_uri_template_handler (h_archive_package), router.methods_post + router.methods_put + router.methods_delete) --  Get archive package data

			map_uri_template_with_request_methods ("/access/{version}/package/{id}/map", h_package_map, router.methods_get) --  Get map
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/map{/map}", h_package_map, router.methods_get) --  Get map and allow ?method= .. hack
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/map", h_package_map, router.methods_post) --  Create new map
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/map{/map}", new_auth_uri_template_handler (h_package_map), router.methods_delete + router.methods_post) -- Create/Delete mapping
			map_uri_template_with_request_methods ("/access/{version}/package/", h_search, router.methods_get) -- Search

			router.handle ("/access", create {WSF_STARTS_WITH_AGENT_HANDLER}.make (agent redirect_to_home))

				--| Misc access
			map_uri_template ("/debug/{name}", create {WSF_SELF_DOCUMENTED_URI_TEMPLATE_AGENT_HANDLER}.make_hidden (agent handle_debug))
			router.handle ("/favicon.ico", create {WSF_SELF_DOCUMENTED_URI_AGENT_HANDLER}.make_hidden (agent handle_favicon))
			router.handle ("/", create {WSF_SELF_DOCUMENTED_URI_AGENT_HANDLER}.make (agent handle_home("/", ?, ?), agent  (ia_m: WSF_ROUTER_MAPPING; ia_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
				do
					create Result.make (ia_m)
					Result.add_description ("Home page")
				end))

				--| Package access
			create h_package_fetcher.make (iron)
			map_uri_template_with_request_methods ("/{version}{/vars}", h_package_fetcher, router.methods_get) --  Get package info
			map_uri_template_with_request_methods ("/{version}", h_package_fetcher, router.methods_get) --  Get package info

				--| Misc/default
			router.handle ("/", create {WSF_SELF_DOCUMENTED_STARTS_WITH_AGENT_HANDLER}.make_with_descriptions (agent handle_home, <<"Redirect to home page">>))
			debug ("iron")
				router.pre_execution_actions.extend (agent  (ia_map: WSF_ROUTER_MAPPING)
					do
						io.error.put_string (">> ")
						io.error.put_string (ia_map.associated_resource)
						io.error.put_string (" ")
						io.error.put_string (ia_map.handler.generator)
						io.error.put_string (" ")
						io.error.put_string (ia_map.debug_output)
						io.error.put_new_line
					end)
			end
		end

feature -- Access

	handle_debug (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			s: STRING_8
			h: HTTP_HEADER
		do
			if req.is_get_request_method then
				s := "debug"
				create h.make_with_count (1)
				h.put_content_type_text_html
				h.put_content_length (s.count)
				res.put_header_lines (h)
				res.put_string (s)
			else
				create s.make (30_000)
				across
					req.form_parameters as c
				loop
					s.append (c.item.url_encoded_name)
					s.append ("=")
					s.append (c.item.string_representation)
					s.append ("<br/>")
				end
				if s.is_empty then
					req.read_input_data_into (s)
				end
				create h.make_with_count (1)
				h.put_content_type_text_html
				h.put_content_length (s.count)
				res.put_header_lines (h)
				res.put_string (s)
			end
		end

feature -- Change

feature -- Factory

	new_auth_uri_handler (h: WSF_URI_HANDLER): IRON_REPO_AUTH_URI_FILTER_HANDLER
		do
			create Result.make_with_next (iron, h)
		end

	new_auth_uri_template_handler (h: WSF_URI_TEMPLATE_HANDLER): IRON_REPO_AUTH_URI_TEMPLATE_FILTER_HANDLER
		do
			create Result.make_with_next (iron, h)
		end

feature -- Handler

	redirect_to_home (a_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: WSF_REDIRECTION_RESPONSE
		do
			create r.make (req.absolute_script_url ("/access/"))
			r.set_content ("Test redirection content", Void)
			res.send (r)
		end

	not_yet_implemented_uri_template_handler (msg: READABLE_STRING_8): WSF_URI_TEMPLATE_HANDLER
		do
			create {WSF_URI_TEMPLATE_AGENT_HANDLER} Result.make (agent not_yet_implemented(?, ?, msg))
		end

	not_yet_implemented (req: WSF_REQUEST; res: WSF_RESPONSE; msg: detachable READABLE_STRING_8)
		local
			m: WSF_NOT_IMPLEMENTED_RESPONSE
		do
			create m.make (req)
			if msg /= Void then
				m.set_body (msg)
			end
			res.send (m)
		end

	handle_favicon (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			res.send (create {WSF_NOT_FOUND_RESPONSE}.make (req))
		end

	handle_home (a_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: IRON_REPO_HTML_RESPONSE
			s: STRING
		do
			create r.make (req, iron)
			create s.make_empty
			s.append ("<ul>")
			s.append ("<li><a href=%"" + req.script_url ("/access") + "%">Home</a></li>")
			across
				iron.database.versions as c_version
			loop
				s.append ("<li><a href=%"" + req.script_url (iron.package_list_web_page (c_version.item)) + "%">Version " + c_version.item.value + "</a></li>")
			end
			s.append ("</ul>")
			r.set_body (s)
			res.send (r)
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

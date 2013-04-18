note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

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
			f,l_filter: detachable WSF_FILTER
			fh: WSF_CUSTOM_HEADER_FILTER
		do
			l_filter := Void

			create fh.make (1)
			fh.set_next (l_filter)
			fh.custom_header.put_header ("X-IronServer: " + version)
			l_filter := fh

			create {WSF_MAINTENANCE_FILTER} f
			f.set_next (l_filter)
			l_filter := f

			create {WSF_DEBUG_FILTER} f
			f.set_next (l_filter)
			l_filter := f

--			create {WSF_100_CONTINUE_FILTER} f
--			f.set_next (l_filter)
--			l_filter := f


			if not (is_libfcgi or is_cgi) then
				create {WSF_LOGGING_FILTER} f
				f.set_next (l_filter)
				l_filter := f
			end

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
			h_admin: ACCESS_HANDLER
			h_search: SEARCH_PACKAGE_HANDLER
			h_create: CREATE_PACKAGE_HANDLER
			h_edit: EDIT_PACKAGE_HANDLER
			h_package: PACKAGE_HANDLER
			h_package_map: PACKAGE_MAP_HANDLER
			h_zip_package: DOWNLOAD_PACKAGE_HANDLER
			h_package_fetcher: FETCH_PACKAGE_HANDLER
			h_fs: WSF_FILE_SYSTEM_HANDLER
		do
			--|  Servername: http://iron.eiffel.com/
			--|  /admin/package/  POST
			--|  /admin/package/{pid}  GET PUT DELETE

			map_uri_template_agent ("/debug/{name}", agent handle_debug)

			create h_admin.make (iron)
			map_uri_with_request_methods ("/access/", new_auth_uri_handler (h_admin), router.methods_get) -- Admin::home
			map_uri_template_with_request_methods ("/access/{version}/", new_auth_uri_template_handler (h_admin), router.methods_get) -- Admin::home

			create h_create.make (iron)
			create h_zip_package.make (iron)
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
			map_uri_template_with_request_methods ("/access/{version}/package/{id}", new_auth_uri_template_handler (h_package), router.methods_put_post) --  Update package			
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/archive", h_zip_package, router.methods_get) --  Get archive package data			

			map_uri_template_with_request_methods ("/access/{version}/package/{id}/map", h_package_map, router.methods_get) --  Get map
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/map{/map}", h_package_map, router.methods_get) --  Get map and allow ?method= .. hack
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/map", h_package_map, router.methods_post) --  Create new map
			map_uri_template_with_request_methods ("/access/{version}/package/{id}/map{/map}", new_auth_uri_template_handler (h_package_map), router.methods_delete + router.methods_post) -- Create/Delete mapping
			map_uri_template_with_request_methods ("/access/{version}/package/", h_search, router.methods_get) -- Search

--			map_uri_template_with_request_methods ("/access/{version}/package/{id}/archive", not_yet_implemented_uri_template_handler ("POST archive"), router.methods_post) --  Upload package archive
--			map_uri_template_with_request_methods ("/access/{version}/package/{id}/archive", not_yet_implemented_uri_template_handler ("PUT archive"), router.methods_put) --  Update package archive			
--			map_uri_template_with_request_methods ("/access/{version}/package/{id}/archive", not_yet_implemented_uri_template_handler ("GET archive"), router.methods_get) --  Download package archive						
--			map_uri_template_with_request_methods ("/access/{version}/package/{id}/archive", not_yet_implemented_uri_template_handler ("DELETE archive"), router.methods_delete) --  Delete package archive									


			map_uri_with_request_methods ("/_shutdown_/", new_auth_uri_handler (create {SHUTDOWN_HANDLER}.make (iron)), router.methods_get) --  Shutdown server

			create h_fs.make_hidden ("db")
			router.handle ("/access/db/", h_fs)

			router.handle ("/access/api/", create {WSF_ROUTER_SELF_DOCUMENTATION_HANDLER}.make (router))

			router.handle ("/access", create {WSF_STARTS_WITH_AGENT_HANDLER}.make (agent redirect_to_home))

			create h_package_fetcher.make (iron)
			map_uri_template_with_request_methods ("/{version}/{domain}{/vars}", h_package_fetcher, router.methods_get) --  Get package info

			router.handle ("/favicon.ico", create {WSF_URI_AGENT_HANDLER}.make (agent handle_favicon))

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

	new_auth_uri_handler (h: WSF_URI_HANDLER): WSF_URI_HANDLER
		do
			create {IRON_REPO_AUTH_URI_FILTER_HANDLER} Result.make_with_next (iron, h)
		end

	new_auth_uri_template_handler (h: WSF_URI_TEMPLATE_HANDLER): WSF_URI_TEMPLATE_HANDLER
		do
			create {IRON_REPO_AUTH_URI_TEMPLATE_FILTER_HANDLER} Result.make_with_next (iron, h)
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
			create {WSF_URI_TEMPLATE_AGENT_HANDLER} Result.make (agent not_yet_implemented (?, ?, msg))
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

end

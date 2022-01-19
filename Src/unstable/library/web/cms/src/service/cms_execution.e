note
	description: "[
				This class implements the CMS service

				It could be used to implement the main EWF service, or
				even for a specific handler.
			]"

deferred class
	CMS_EXECUTION

inherit
	WSF_FILTERED_ROUTED_SKELETON_EXECUTION
		undefine
			requires_proxy
		redefine
			execute,
			create_router, router,
			execute_default,
			filter_execute,
			initialize,
			initialize_filter,
			initialize_router
		end

	WSF_NO_PROXY_POLICY

	WSF_ROUTED_URI_HELPER

	WSF_ROUTED_URI_TEMPLATE_HELPER

	WSF_REQUEST_EXPORTER

	REFACTORING_HELPER

	SHARED_LOGGER

--create
--	make

feature {NONE} -- Initialization

	initialize
			-- Build a CMS service with `a_api'
		local
			l_setup: CMS_SETUP
		do
			l_setup := initial_cms_setup
			setup_storage (l_setup)
			setup_modules (l_setup)
			create api.make (l_setup, request, response)
			if api.has_error then
				response.put_error ("ROC: Error during API initialization!")
				response.put_error (api.utf_8_encoded (api.string_representation_of_errors))
			elseif attached api.storage.error_handler.as_single_error as err then
				response.put_error ("ROC: Error during Storage initialization!")
				response.put_error (api.utf_8_encoded (err.string_representation))
			end
			modules := api.enabled_modules

			initialize_cms
			Precursor
		end

	initialize_cms
		do
				-- CMS Initialization
				-- for void-safety concern.
			create {WSF_MAINTENANCE_FILTER} filter
		end

	initialize_filter
			-- Initialize `filter`.
		do
			create_filter
			-- setup_filter: delayed to `initialize_execution`.
		end

	initialize_router
			-- Initialize `router`.
		do
			create_router
			-- setup_router: delayed to `initialize_execution`.
		end

	initialize_modules
			-- Intialize modules and keep only enabled modules.
		do
			modules := api.enabled_modules
		ensure
			only_enabled_modules: across modules as ic all ic.item.is_enabled end
		end

feature -- Factory

	initial_cms_setup: CMS_SETUP
			-- Default setup object that Current interface can customize.
		deferred
		end

feature -- Access

	api: CMS_API
			-- API service.

	setup: CMS_SETUP
			-- CMS Setup.
		do
			Result := api.setup
		end

	modules: CMS_MODULE_COLLECTION
			-- Declared modules.

feature -- CMS setup

	setup_modules (a_setup: CMS_SETUP)
			-- Setup additional modules.
		deferred
		end

	setup_storage (a_setup: CMS_SETUP)
		deferred
		end

feature -- Settings: router

	router: CMS_ROUTER
			-- <Precursor>

	create_router
			-- Create `router'.
		do
			create router.make (api, 30)
		end

	setup_router
			-- <Precursor>
		local
			l_api: like api
			l_router: like router
			l_module: CMS_MODULE
		do
			l_api := api
			l_router := router

			l_router.set_base_url (l_api.base_url)

				-- Configure root of api handler.
			configure_api_root (l_router)

				-- Include routes from modules.
			across
				modules as ic
			loop
				l_module := ic.item
				if l_module.is_initialized then
					l_module.setup_router (l_router, l_api)
				end
			end
				-- Configure files handler.
			configure_api_file_handler (l_router)
		end

	setup_router_and_filter_for_webapi
		local
			l_api: like api
			l_router: like router
			l_module: CMS_MODULE
			f, l_filter, l_last_filter: WSF_FILTER
		do
			l_api := api
			l_router := router

				-- Configure root of api handler.
			l_router.set_base_url (l_api.webapi_path (Void))

				-- Find insertion location for new filter
				-- i.e just before the CMS_EXECUTION filter.
			from
				l_filter := filter
			until
				l_last_filter /= Void or not attached l_filter.next as l_next_filter
			loop
				if l_next_filter.next = Void then
					l_last_filter := l_next_filter
				else
					l_filter := l_next_filter
				end
			end

				-- Include routes from modules.
			across
				modules as ic
			loop
				l_module := ic.item
				if
					l_module.is_initialized and then
					attached {CMS_WITH_WEBAPI} l_module as l_webapi and then
					attached l_webapi.module_webapi as wapi
				then
					wapi.setup_router (l_router, l_api)
					if attached wapi.filters (l_api) as l_filters then
						across
							l_filters as f_ic
						loop
							f := f_ic.item
							l_filter.set_next (f)
							f.set_next (l_last_filter)
							l_filter := f
						end
					end
				end
			end
		end

	setup_router_and_filter_for_administration
			-- <Precursor>
		local
			l_api: like api
			l_router: like router
			l_module: CMS_MODULE
			f, l_filter, l_last_filter: WSF_FILTER
		do
			l_api := api
			l_router := router

				-- Configure root of api handler.
			l_router.set_base_url (l_api.administration_path (Void))

				-- Apply normal filters
			setup_filter

				-- Find insertion location for new filter
				-- i.e just before the CMS_EXECUTION filter.
			from
				l_filter := filter
			until
				l_last_filter /= Void or not attached l_filter.next as l_next_filter
			loop
				if l_next_filter.next = Void then
					l_last_filter := l_next_filter
				else
					l_filter := l_next_filter
				end
			end

				-- Include routes from modules.
			across
				modules as ic
			loop
				l_module := ic.item
				if
					l_module.is_initialized
				then
					if
						attached {CMS_WITH_MODULE_ADMINISTRATION} l_module as l_administration and then
						attached l_administration.module_administration as adm
					then
						adm.setup_router (l_router, l_api)
						if attached adm.filters (l_api) as l_filters then
							across
								l_filters as f_ic
							loop
								f := f_ic.item
								l_filter.set_next (f)
								f.set_next (l_last_filter)
								l_filter := f
							end
						end
--					elseif
--						attached {CMS_WITH_WEBAPI} l_module as l_wapi and then
--						attached l_wapi.module_webapi as wapi
--					then
--						wapi.setup_router (l_router, l_api)
					end
				end
			end
			map_uri ("/install", create {CMS_ADMIN_INSTALL_HANDLER}.make (api), l_router.methods_head_get)
		end

	configure_api_root (a_router: WSF_ROUTER)
		local
			l_root_handler: CMS_ROOT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_root_handler.make (api)
			create l_methods
			l_methods.enable_get
			a_router.handle ("/", l_root_handler, l_methods)
			a_router.handle ("", l_root_handler, l_methods)
			map_uri_agent ("/favicon.ico", agent handle_favicon, a_router.methods_head_get)
		end

	configure_api_file_handler (a_router: WSF_ROUTER)
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
			themehdl: CMS_THEME_FILE_SYSTEM_HANDLER
			l_not_found_handler_agent: PROCEDURE [READABLE_STRING_8, WSF_REQUEST, WSF_RESPONSE]
		do
			l_not_found_handler_agent := agent (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE)
				do
					execute_default (ia_req, ia_res)
				end

			create themehdl.make (api)
			themehdl.set_not_found_handler (l_not_found_handler_agent)
				-- See CMS_API.api.theme_path_for (...) for the hardcoded "/theme/" path.
			a_router.handle ("/theme/{theme_id}{/vars}", themehdl, router.methods_GET)

				-- "/files/.."
			create fhdl.make_hidden_with_path (api.files_location)
			fhdl.disable_index
			fhdl.set_not_found_handler (l_not_found_handler_agent)
			a_router.handle (api.files_path, fhdl, router.methods_GET)

				-- files folder from specific module.
			a_router.handle ("/module/{modname}/files{/vars}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_module_files), a_router.methods_get)

				-- www folder. Should we keep this??
			create fhdl.make_hidden_with_path (setup.environment.www_path)
			fhdl.disable_index
			fhdl.set_not_found_handler (l_not_found_handler_agent)
			a_router.handle ("/", fhdl, router.methods_GET)
		end

feature -- Request execution

	initialize_execution
			-- Initialize CMS execution.
		do
			request.set_uploaded_file_path (api.temp_location)
			if api.is_administration_request (request) then
				initialize_administration_execution
			elseif api.is_webapi_request (request) then
				initialize_webapi_execution
			else
				initialize_site_execution
			end
		end

	initialize_site_execution
			-- Initialize for site execution.
		do
			api.switch_to_site_mode
			api.initialize_execution
			setup_filter
			setup_router
		end

	initialize_webapi_execution
			-- Initialize for site execution.
		do
			api.switch_to_webapi_mode
			api.initialize_execution
			setup_router_and_filter_for_webapi
		end

	initialize_administration_execution
			-- Initialize for administration execution.
		do
			api.switch_to_administration_mode
			api.initialize_execution
			setup_router_and_filter_for_administration
		end

	execute
			-- <Precursor>.
		do
			initialize_execution
			Precursor
				-- Clean execution...
			if
				attached api.storage as l_storage and then
				not l_storage.is_reuseable
			then
				l_storage.close
			end
		end

	filter_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do
			res.put_header_line ("Date: " + (create {HTTP_DATE}.make_now_utc).string)
			res.put_header_line ("X-EWF-Server: CMS_v1.0")

			Precursor (req, res)
		end

feature -- Filters

	create_filter
			-- Create `filter'.
		local
			f, l_filter: detachable WSF_FILTER
			l_api: like api
			fut: FILE_UTILITIES
		do
			l_api := api
			l_filter := Void

				-- Maintenance
			create {CMS_MAINTENANCE_FILTER} f.make (Void, l_api)
			f.set_next (l_filter)
			l_filter := f

			if fut.file_exists (".debug") then
				create {WSF_DEBUG_FILTER} f
				f.set_next (l_filter)
				l_filter := f
			end

--			 	-- Error Filter
--			create {CMS_ERROR_FILTER} f.make (api)
--			f.set_next (l_filter)
--			l_filter := f

			filter := l_filter
		end

	setup_filter
			-- Setup `filter'.
		local
			f, l_filter, l_last_filter: detachable WSF_FILTER
			l_module: CMS_MODULE
			l_api: like api
		do
			l_api := api

				-- Find insertion location for new filter
				-- i.e just before the CMS_EXECUTION filter.
			from
				l_filter := filter
			until
				l_last_filter /= Void or not attached l_filter.next as l_next_filter
			loop
				if l_next_filter.next = Void then
					l_last_filter := l_next_filter
				else
					l_filter := l_next_filter
				end
			end

				-- Include filters from modules
			across
				modules as ic
			loop
				l_module := ic.item
				if
					l_module.is_enabled and then
					attached l_module.filters (l_api) as l_m_filters
				then
					across l_m_filters as f_ic loop
						f := f_ic.item
						l_filter.set_next (f)
						f.set_next (l_last_filter)
--						f.set_next (l_filter)
						l_filter := f
					end
				end
			end
--			filter := l_filter
		end

feature -- Execution

	handle_favicon (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			ut: FILE_UTILITIES
			p: PATH
			f: WSF_FILE_RESPONSE
		do
			p := api.theme_assets_location.extended ("favicon.ico")
			if ut.file_path_exists (p) then
				create f.make_with_path (p)
				f.set_expires_in_seconds (86_400) -- 24h = 60 sec * 60 min * 24 = 86 400 minutes
				res.send (f)
			else
				api.response_api.send_not_found (Void, req, res)
			end
		end

	handle_module_files (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle files per modules.
			-- i.e: "/module/{modname}/files{/vars}"
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do
			if attached {WSF_STRING} req.path_parameter ("modname") as l_mod_name then
				create fhdl.make_with_path (api.module_location_by_name (l_mod_name.url_encoded_value).extended ("files"))
				fhdl.disable_index
				fhdl.set_not_found_handler (agent (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE)
					do
						execute_default (ia_req, ia_res)
					end)
				fhdl.execute_starts_with ("/module/" + l_mod_name.url_encoded_value + "/files/", req, res)
			else
				api.response_api.send_not_found (Void, req, res)
			end
		end

	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Default request handler if no other are relevant
		do
			to_implement ("Default response for CMS_SERVICE")
			api.response_api.send_not_found (Void, req, res)
		end

note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

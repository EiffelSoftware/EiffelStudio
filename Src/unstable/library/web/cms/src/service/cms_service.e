note
	description: "[
				This class implements the CMS service

				It could be used to implement the main EWF service, or
				even for a specific handler.
			]"

class
	CMS_SERVICE

inherit
	WSF_ROUTED_SKELETON_SERVICE
		rename
			execute as execute_service
		undefine
			requires_proxy
		redefine
			execute_default
		end

	WSF_FILTERED_SERVICE

	WSF_FILTER
		rename
			execute as execute_filter
		end

	WSF_NO_PROXY_POLICY

	WSF_URI_HELPER_FOR_ROUTED_SERVICE

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_SERVICE

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API)
			-- Build a CMS service with `a_api'
		do
			api := a_api
			initialize
		ensure
			api_set: api = a_api
		end

	initialize
			-- Initialize various parts of the CMS service.
		do
			initialize_modules
			initialize_users
			initialize_auth_engine
			initialize_mailer
				-- initialize_router
				-- initialize_filter: expanded here, for void-safety concern.
			create_filter
			initialize_router
			setup_filter
		end

	initialize_modules
			-- Intialize modules and keep only enabled modules.
		do
			modules := setup.enabled_modules
		ensure
			only_enabled_modules: across modules as ic all ic.item.is_enabled end
		end

	initialize_users
			-- Initialize users.
		do
		end

	initialize_mailer
			-- Initialize mailer engine.
		do
			to_implement ("To Implement mailer")
		end

	initialize_auth_engine
		do
			to_implement ("To Implement authentication engine")
		end

feature -- Settings: router

	setup_router
			-- <Precursor>
		local
			l_module: CMS_MODULE
			l_api: like api
			l_router: like router
		do
			api.logger.put_debug (generator + ".setup_router", Void)
				-- Configure root of api handler.

			l_router := router
			configure_api_root (l_router)

				-- Include routes from modules.
			l_api := api
			across
				modules as ic
			loop
				l_module := ic.item
				l_router.import (l_module.router (l_api))
			end
				-- Configure files handler.
			configure_api_file_handler (l_router)
		end

	configure_api_root (a_router: WSF_ROUTER)
		local
			l_root_handler: CMS_ROOT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			api.logger.put_debug (generator + ".configure_api_root", Void)
			create l_root_handler.make (api)
			create l_methods
			l_methods.enable_get
			a_router.handle_with_request_methods ("/", l_root_handler, l_methods)
			a_router.handle_with_request_methods ("", l_root_handler, l_methods)
			map_uri_agent_with_request_methods ("/favicon.ico", agent handle_favicon, a_router.methods_head_get)
		end

	configure_api_file_handler (a_router: WSF_ROUTER)
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do
			api.logger.put_information (generator + ".configure_api_file_handler", Void)

			create fhdl.make_hidden_with_path (setup.theme_assets_location)
			fhdl.disable_index
			fhdl.set_not_found_handler (agent  (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE)
				do
					execute_default (ia_req, ia_res)
				end)
			a_router.handle_with_request_methods ("/theme/", fhdl, router.methods_GET)


			create fhdl.make_hidden_with_path (setup.layout.www_path)
			fhdl.disable_index
			fhdl.set_not_found_handler (agent  (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE)
				do
					execute_default (ia_req, ia_res)
				end)
			a_router.handle_with_request_methods ("/", fhdl, router.methods_GET)
		end

feature -- Execute Filter

	execute_filter (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do
			res.put_header_line ("Date: " + (create {HTTP_DATE}.make_now_utc).string)
			res.put_header_line ("X-EWF-Server: CMS_v1.0")
			execute_service (req, res)
		end

feature -- Filters

	create_filter
			-- Create `filter'.
		local
			f, l_filter: detachable WSF_FILTER
			l_module: CMS_MODULE
			l_api: like api
		do
			api.logger.put_debug (generator + ".create_filter", Void)
			l_filter := Void

				-- Maintenance
			create {WSF_MAINTENANCE_FILTER} f
			f.set_next (l_filter)
			l_filter := f

			 	-- Error Filter
			create {CMS_ERROR_FILTER} f.make (api)
			f.set_next (l_filter)
			l_filter := f

				-- Include filters from modules
			l_api := api
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
						f.set_next (l_filter)
						l_filter := f
					end
				end
			end

			filter := l_filter
		end

	setup_filter
			-- Setup `filter'.
		local
			f: WSF_FILTER
		do
			api.logger.put_debug (generator + ".setup_filter", Void)

			from
				f := filter
			until
				not attached f.next as l_next
			loop
				f := l_next
			end
			f.set_next (Current)
		end

feature -- Access	

	api: CMS_API
			-- API service.

	setup:  CMS_SETUP
			-- CMS setup.
		do
			Result := api.setup
		end

	modules: CMS_MODULE_COLLECTION
			-- Configurator of possible modules.

feature -- Execution

	handle_favicon (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			ut: FILE_UTILITIES
			p: PATH
			r: NOT_FOUND_ERROR_CMS_RESPONSE
			f: WSF_FILE_RESPONSE
		do
			p := api.setup.theme_assets_location.extended ("favicon.ico")
			if ut.file_path_exists (p) then
				create f.make_with_path (p)
				res.send (f)
			else
				create r.make (req, res, api)
				r.execute
			end
		end

	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Default request handler if no other are relevant
		local
			r: NOT_FOUND_ERROR_CMS_RESPONSE
		do
			to_implement ("Default response for CMS_SERVICE")
			create r.make (req, res, api)
			r.execute
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

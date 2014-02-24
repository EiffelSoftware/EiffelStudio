note
	description: "[
		application service
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_ESA_API

inherit

	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	WSF_ROUTED_SERVICE
		rename
			execute as execute_router
		redefine
			execute_default
		end

	WSF_FILTERED_SERVICE

	WSF_URI_HELPER_FOR_ROUTED_SERVICE

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_SERVICE

	WSF_HANDLER_HELPER

	WSF_FILTER
		rename
			execute as execute_router
		end

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	APPLICATION_LAUNCHER

	SHARED_API_SERVICE

	SHARED_CONNEG_HELPER

	REFACTORING_HELPER

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
			initialize_filter
			initialize_router
			set_service_option ("port", 9990)
		end

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do

			to_implement ("Extract Setup to a new Class")

			configure_api_root

			configure_api_report

			configure_api_report_detail

			configure_api_report_interaction

			configure_api_login

			configure_api_logoff

			router.handle_with_request_methods ("/doc", create {WSF_ROUTER_SELF_DOCUMENTATION_HANDLER}.make (router), router.methods_GET)
			create fhdl.make_hidden ("www")
			fhdl.set_directory_index (<<"index.html">>)
			fhdl.set_not_found_handler (agent (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE) do execute_default (ia_req, ia_res) end)
			router.handle_with_request_methods ("/", fhdl, router.methods_GET)

		end

feature -- Configure Resources Routes


	configure_api_root
		local
			l_root_handler: ROOT_HANDLER
			l_methods: WSF_REQUEST_METHODS
			l_filter: AUTHENTICATION_FILTER
		do
			create l_filter
			create l_root_handler
			l_filter.set_next (l_root_handler)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent l_filter.execute), l_methods)
		end

	configure_api_report
		local
			l_report_handler: REPORT_HANDLER
			l_methods: WSF_REQUEST_METHODS
			l_filter: AUTHENTICATION_FILTER
		do
			create l_filter
			create l_report_handler
			l_filter.set_next (l_report_handler)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/reports", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent l_filter.execute), l_methods)
		end



	configure_api_report_detail
		local
			l_report_detail_handler: REPORT_DETAIL_HANDLER
			l_methods: WSF_REQUEST_METHODS
			l_filter: AUTHENTICATION_FILTER
		do
			create l_filter
			create l_report_detail_handler
			l_filter.set_next (l_report_detail_handler)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/report_detail/{id}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent l_filter.execute), l_methods)
		end


	configure_api_report_interaction
		local
			l_report_interaction_handler: REPORT_INTERACTION_HANDLER
			l_methods: WSF_REQUEST_METHODS
		    l_filter: AUTHENTICATION_FILTER
		do
			create l_filter
			create l_report_interaction_handler
			l_filter.set_next (l_report_interaction_handler)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/report_interaction/{id}/{name}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent l_filter.execute), l_methods)
		end



	configure_api_login
		local
			l_options_filter: WSF_CORS_OPTIONS_FILTER
			l_authentication_filter: AUTHENTICATION_FILTER
			l_login_handler: LOGIN_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_options_filter.make (router)
			create l_authentication_filter
			create l_login_handler

			l_options_filter.set_next (l_authentication_filter)
			l_authentication_filter.set_next (l_login_handler)

			create l_methods
			l_methods.enable_options
			l_methods.enable_get
			l_methods.enable_post

			router.handle_with_request_methods ("/login", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent l_options_filter.execute), l_methods)
		end


	configure_api_logoff
		local
			l_logoff_handler: LOGOFF_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_logoff_handler
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/logoff", l_logoff_handler, l_methods)
		end


feature -- Default Execution

	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Dispatch requests without a matching handler.
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: REPRESENTATION_HANDLER_FACTORY
		do
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached media_variants.media_type as l_type then
					create l_rhf
					l_rhf.new_representation_handler (l_type,media_variants).not_found_page (req, res)
				end
			else
				create l_rhf
				l_rhf.new_representation_handler ("",media_variants).not_found_page (req, res)
			end
		end


feature -- Filters


	setup_filter
			-- Setup `filter'
		do
			filter.set_next (Current)
		end

	create_filter
			-- Create `filter'
		do
			create {WSF_CORS_FILTER} filter
		end


end

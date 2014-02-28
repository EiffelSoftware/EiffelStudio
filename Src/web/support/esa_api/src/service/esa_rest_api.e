note
	description: "Summary description for {ESA_REST_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REST_API

inherit

	ESA_ABSTRACT_API

create
	make

feature -- Initialization

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do
			configure_api_root
			configure_api_report
			configure_api_reports_user
			configure_api_report_detail
			configure_api_report_interaction
			configure_api_login
			configure_api_logoff
			router.handle_with_request_methods ("/doc", create {WSF_ROUTER_SELF_DOCUMENTATION_HANDLER}.make (router), router.methods_GET)
			create fhdl.make_hidden ("www")
			fhdl.set_directory_index (<<"index.html">>)
			fhdl.set_not_found_handler (agent  (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE)
				do
					execute_default (ia_req, ia_res)
				end)
			router.handle_with_request_methods ("/", fhdl, router.methods_GET)
		end

feature -- Configure Resources Routes

	configure_api_root
		local
			l_root_handler: ESA_ROOT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_root_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("", l_root_handler, l_methods) -- IE workaround
			router.handle_with_request_methods ("/", l_root_handler, l_methods)
		end

	configure_api_report
		local
			l_report_handler: ESA_REPORT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/reports", l_report_handler, l_methods)
			router.handle_with_request_methods ("/reports/", l_report_handler, l_methods) --IE workaround

			router.handle_with_request_methods ("/reports/{id}", l_report_handler, l_methods)
			router.handle_with_request_methods ("/reports/{id}/", l_report_handler, l_methods) -- IE Workaround


		end

	configure_api_reports_user
		local
			l_user_report_handler: ESA_USER_REPORT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_user_report_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/user_reports/{user}", l_user_report_handler, l_methods)
			router.handle_with_request_methods ("/user_reports/{user}/{id}", l_user_report_handler, l_methods)
		end

	configure_api_report_detail
		local
			l_report_detail_handler: ESA_REPORT_DETAIL_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_detail_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/report_detail/{id}", l_report_detail_handler, l_methods)
		end

	configure_api_report_interaction
		local
			l_report_interaction_handler: ESA_REPORT_INTERACTION_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_interaction_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/report_interaction/{id}/{name}", l_report_interaction_handler, l_methods)
		end

	configure_api_login
		local
			l_login_handler: ESA_LOGIN_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_login_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/login", l_login_handler, l_methods)
			router.handle_with_request_methods ("/login/", l_login_handler, l_methods) -- IE Workaround
		end

	configure_api_logoff
		local
			l_logoff_handler: ESA_LOGOFF_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_logoff_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle_with_request_methods ("/logoff", l_logoff_handler, l_methods)
			router.handle_with_request_methods ("/logoff/", l_logoff_handler, l_methods) -- IE workaround
		end


end

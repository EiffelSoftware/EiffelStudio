note
	description: "[
		REST API configuration
		We manage URI and Uri templates using Routers. They are used to delegate calls (to the corresponing handlers) based on a URI template. 
		We define a Rooter and attach handlers to it.
	]"
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
			-- Setup `router'.
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do
			configure_api_root
			configure_api_report
			configure_api_reports_user
			configure_api_interaction_report
			configure_api_interaction_confirm
			configure_api_report_detail
			configure_api_closed_report
			configure_api_report_interaction
			configure_api_report_form
			configure_api_report_confirm
			configure_api_register
			configure_api_login
			configure_api_logoff
			configure_api_activation
			configure_api_status
			configure_api_severity
			configure_api_category
			configure_api_priority
			configure_api_responsible
			configure_api_reminder
			configure_api_password_reset
			configure_api_logger
			configure_api_user_account
			configure_api_user_password
			configure_api_user_email
			configure_api_user_confirm_email
			configure_api_subscribe_to_category
			configure_api_login_session
			configure_api_logoff_session

			create fhdl.make_hidden_with_path (layout.www_path)
			fhdl.disable_index
			fhdl.set_not_found_handler (agent  (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE)
				do
					execute_default (ia_req, ia_res)
				end)
			router.handle ("/", fhdl, router.methods_GET)
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
			router.handle ("", l_root_handler, l_methods)
			router.handle ("/", l_root_handler, l_methods)
		end

	configure_api_report
		local
			l_report_handler: ESA_REPORT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/reports", l_report_handler, l_methods)

			create l_methods
			l_methods.enable_get
			l_methods.enable_post

			router.handle ("/reports/{id}", l_report_handler, l_methods)
		end

	configure_api_closed_report
		local
			l_report_handler: ESA_CLOSED_REPORT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/closed_reports", l_report_handler, l_methods)
		end

	configure_api_reports_user
		local
			l_user_report_handler: ESA_USER_REPORT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_user_report_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/user_reports/{user}", l_user_report_handler, l_methods)
			router.handle ("/user_reports/{user}/{id}", l_user_report_handler, l_methods)
		end

	configure_api_report_detail
		local
			l_report_detail_handler: ESA_REPORT_DETAIL_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_detail_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/report_detail/{id}", l_report_detail_handler, l_methods)
			router.handle ("/report_detail/{?search}", l_report_detail_handler, l_methods)
		end

	configure_api_report_interaction
		local
			l_report_interaction_handler: ESA_REPORT_INTERACTION_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_interaction_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/report_interaction/{id}/{name}", l_report_interaction_handler, l_methods)
			router.handle ("/report_interaction/{id}", l_report_interaction_handler, l_methods)

		end

	configure_api_login
		local
			l_login_handler: ESA_LOGIN_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_login_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/login", l_login_handler, l_methods)
		end

	configure_api_logoff
		local
			l_logoff_handler: ESA_LOGOFF_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_logoff_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/logoff", l_logoff_handler, l_methods)
		end

	configure_api_login_session
		local
			l_logoff_handler: ESA_LOGIN_SESSION_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_logoff_handler.make (esa_config)
			create l_methods
			l_methods.enable_post
			router.handle ("/login_session", l_logoff_handler, l_methods)
		end

	configure_api_logoff_session
		local
			l_logoff_handler: ESA_LOGOFF_SESSION_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_logoff_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/logoff_session", l_logoff_handler, l_methods)
		end

	configure_api_report_form
		local
			l_form_handler: ESA_REPORT_FORM_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_form_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/report_form", l_form_handler, l_methods)
			router.handle ("/report_form/{id}", l_form_handler, l_methods)
		end

	configure_api_report_confirm
		local
			l_confirm_handler: ESA_REPORT_CONFIRM_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_confirm_handler.make (esa_config)
			create l_methods
			l_methods.enable_post
			router.handle ("/report_confirm", l_confirm_handler, l_methods)

			create l_methods
			l_methods.enable_get
			router.handle ("/report_confirm/{id}", l_confirm_handler, l_methods)
		end

	configure_api_register
		local
			l_register_handler: ESA_REGISTER_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_register_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/register", l_register_handler, l_methods)
		end

	configure_api_activation
		local
			l_activation_handler: ESA_ACTIVATION_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_activation_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/activation", l_activation_handler, l_methods)
		end

	configure_api_status
		local
			l_status_handler: ESA_STATUS_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_status_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/status", l_status_handler, l_methods)
		end

	configure_api_severity
		local
			l_severity_handler: ESA_SEVERITY_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_severity_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/severity", l_severity_handler, l_methods)
		end

	configure_api_category
		local
			l_category_handler: ESA_CATEGORY_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_category_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/category", l_category_handler, l_methods)
		end

	configure_api_priority
		local
			l_priority_handler: ESA_PRIORITY_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_priority_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/priority", l_priority_handler, l_methods)
		end

	configure_api_responsible
		local
			l_responsible_handler: ESA_RESPONSIBLE_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_responsible_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/responsible", l_responsible_handler, l_methods)
		end

	configure_api_interaction_report
		local
			l_interaction_handler: ESA_INTERACTION_FORM_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_interaction_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_put
			l_methods.enable_post
			router.handle ("/report_detail/{report_id}/interaction_form", l_interaction_handler, l_methods)
			router.handle ("/report_detail/{report_id}/interaction_form/{id}", l_interaction_handler, l_methods)
		end

	configure_api_interaction_confirm
		local
			l_interaction_handler: ESA_INTERACTION_CONFIRM_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_interaction_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			router.handle ("/report_detail/{report_id}/interaction_confirm/{id}", l_interaction_handler, l_methods)

			create l_methods
			l_methods.enable_post
			router.handle ("/report_detail/{report_id}/interaction_confirm", l_interaction_handler, l_methods)
		end

	configure_api_reminder
		local
			l_reminder_handler: ESA_PASSWORD_REMINDER_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_reminder_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/reminder", l_reminder_handler, l_methods)
		end

	configure_api_logger
		local
			l_logger_handler: ESA_LOGGER_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_logger_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/logger", l_logger_handler, l_methods)
		end

	configure_api_user_account
		local
			l_account_handler: ESA_USER_ACCOUNT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_account_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/account", l_account_handler, l_methods)
		end

	configure_api_user_password
		local
			l_password_handler: ESA_PASSWORD_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_password_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/password", l_password_handler, l_methods)
		end

	configure_api_user_email
		local
			l_email_handler: ESA_EMAIL_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_email_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/email", l_email_handler, l_methods)
		end

	configure_api_user_confirm_email
		local
			l_confirm_email_handler: ESA_EMAIL_CONFIRM_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_confirm_email_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/confirm_email", l_confirm_email_handler, l_methods)
		end

	configure_api_password_reset
		local
			l_password_reset_handler: ESA_PASSWORD_RESET_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_password_reset_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/password-reset", l_password_reset_handler, l_methods)
		end

	configure_api_subscribe_to_category
		local
			l_register_subscriber_handler: ESA_REGISTER_SUBSCRIBER_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_register_subscriber_handler.make (esa_config)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			router.handle ("/subscribe_to_category", l_register_subscriber_handler, l_methods)
		end

end

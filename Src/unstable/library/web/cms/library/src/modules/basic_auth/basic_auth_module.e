note
	description: "This module allows the use of HTTP Basic Authentication to restrict access by looking up users in the given providers."
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_AUTH_MODULE

inherit

	CMS_MODULE
		redefine
			filters
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "basic auth"
			version := "1.0"
			description := "Service to manage basic authentication"
			package := "core"
		end

feature -- Access: router

	router (a_api: CMS_API): WSF_ROUTER
			-- Node router.
		do
			create Result.make (2)
			configure_api_login (a_api, Result)
			configure_api_logoff (a_api, Result)
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			create {ARRAYED_LIST [WSF_FILTER]} Result.make (2)
			Result.extend (create {CORS_FILTER})
			Result.extend (create {BASIC_AUTH_FILTER}.make (a_api))
		end

feature {NONE} -- Implementation: routes

	configure_api_login (api: CMS_API; a_router: WSF_ROUTER)
		local
			l_bal_handler: BASIC_AUTH_LOGIN_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_bal_handler.make (api)
			create l_methods
			l_methods.enable_get
			a_router.handle_with_request_methods ("/basic_auth_login", l_bal_handler, l_methods)
		end

	configure_api_logoff (api: CMS_API; a_router: WSF_ROUTER)
		local
			l_bal_handler: BASIC_AUTH_LOGOFF_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_bal_handler.make (api)
			create l_methods
			l_methods.enable_get
			a_router.handle_with_request_methods ("/basic_auth_logoff", l_bal_handler, l_methods)
		end

end

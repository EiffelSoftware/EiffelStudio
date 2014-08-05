note
	description: "Summary description for {WDOCS_APP_EMBEDDED_WEB_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_APP_EMBEDDED_WEB_SERVICE

inherit
	EMBEDDED_WEB_SERVICE
		rename
			make as make_service
		redefine
			initialize_options
		end

	WSF_ROUTED_SERVICE
		undefine
			execute_default
		end

	WDOCS_SERVICE
		redefine
			setup_router
		end

create
	make

feature {NONE} -- Initialization

	make (a_root_dir: PATH)
		do
			root_dir := a_root_dir
			make_service
			initialize_router
			create request_exit_operation_actions
			local_connection_restriction_enabled := True

			if not {PLATFORM}.is_thread_capable then
				print ("Impossible to launch the embedded web service%N")
				(create {EXCEPTIONS}).die (-1)
			end
		end

	initialize_options (opts: WSF_SERVICE_LAUNCHER_OPTIONS)
		do
			Precursor (opts)
			opts.set_option ("force_single_threaded", True)
		end

feature -- Access

	root_dir: PATH

feature -- Factory

	manager: WDOCS_MANAGER
		do
			create Result.make (root_dir)
		end

feature -- Access

	request_exit_operation_actions: ACTION_SEQUENCE [TUPLE]

feature	-- Initialization

	setup_router
		do
			Precursor
			router.handle ("/exit", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_exit))
		end

feature -- Execution

	handle_exit (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_HTML_PAGE_RESPONSE
			b: STRING
		do
			create m.make
			create b.make_from_string ("<h1>Wiki Docs is about to shutdown</h1>")
			append_navigation_to (req, b)
			m.set_body (b)
			res.send (m)
			if attached {WGI_NINO_CONNECTOR} req.wgi_connector as nino then
				nino.server.shutdown_server
			end
			request_exit_operation_actions.call (Void)
		end

end

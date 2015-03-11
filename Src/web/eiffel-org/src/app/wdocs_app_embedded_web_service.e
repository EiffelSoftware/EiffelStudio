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

	EIFFEL_COMMUNITY_SITE_SERVICE
		redefine
			initialize_cms,
			layout
		select
			execute
		end

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
		do
			make_service
			initialize_application
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

	configuration: WDOCS_CONFIG
		local
			cfg: detachable WDOCS_CONFIG
			p: PATH
			ut: FILE_UTILITIES
		do
			create p.make_from_string ("wdocs.ini")
			if ut.file_path_exists (p) then
				create {WDOCS_INI_CONFIG} cfg.make (p)
			elseif attached execution_environment.item ("WDOCS_CONFIG") as s then
				create p.make_from_string (s)
				if ut.file_path_exists (p) then
					create {WDOCS_INI_CONFIG} cfg.make (p)
				end
			end
			if cfg = Void then
				create {WDOCS_DEFAULT_CONFIG} cfg.make_default
			end
			Result := cfg
		end

feature -- Access

	request_exit_operation_actions: ACTION_SEQUENCE [TUPLE]

	layout: APP_CMS_LAYOUT

feature	-- Initialization

	initialize_cms (a_setup: CMS_SETUP)
		do
			Precursor (a_setup)
			cms_service.map_uri_template_agent_with_request_methods ("/exit", agent handle_exit, cms_service.router.methods_get)
		end

feature -- Execution

	handle_exit (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_HTML_PAGE_RESPONSE
			b: STRING
		do
			create m.make
			create b.make_from_string ("<h1>Eiffel Lang is about to shutdown</h1>")
			m.set_body (b)
			res.send (m)
			if attached {WGI_NINO_CONNECTOR} req.wgi_connector as nino then
				nino.server.shutdown_server
			end
			request_exit_operation_actions.call (Void)
		end

end

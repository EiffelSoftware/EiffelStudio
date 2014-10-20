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

	EIFFEL_LANG_SERVICE
		redefine
			initialize_cms
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
			initialize_wdocs
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
			create p.make_from_string ("eiffel-lang.ini")
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

feature	-- Initialization

	initialize_cms (a_root_dir: PATH)
		do
			Precursor (a_root_dir)
			cms_service.map_uri_template ("/exit", agent handle_exit)
		end

feature -- Execution

	handle_exit (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_HTML_PAGE_RESPONSE
			b: STRING
		do
			create m.make
			create b.make_from_string ("<h1>Wiki Docs is about to shutdown</h1>")
			m.set_body (b)
			res.send (m)
			if attached {WGI_NINO_CONNECTOR} req.wgi_connector as nino then
				nino.server.shutdown_server
			end
			request_exit_operation_actions.call (Void)
		end

end

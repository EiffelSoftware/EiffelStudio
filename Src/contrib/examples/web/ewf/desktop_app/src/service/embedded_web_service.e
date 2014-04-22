note
	description: "Summary description for {EMBEDDED_WEB_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMBEDDED_WEB_SERVICE

inherit
	THREAD
		rename
			make as make_thread,
			execute as execute_thread
		end

	WSF_SERVICE
		rename
			execute as execute_embedded
		end

	SHARED_EMBEDED_WEB_SERVICE_INFORMATION

feature -- Initialization

	make
		do
			make_thread
			create on_launched_actions
		end

feature {NONE} -- Execution

	execute_embedded (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the request
			-- See `req.input' for input stream
    		--     `req.meta_variables' for the CGI meta variable
			-- and `res' for output buffer
		local
			filter: WSF_AGENT_FILTER
			m: WSF_PAGE_RESPONSE
		do
			if local_connection_restriction_enabled then
				if
					attached req.remote_addr as l_remote_addr and then
					l_remote_addr.is_case_insensitive_equal_general ("127.0.0.1")
				then
					execute (req, res)
				else
					create m.make_with_body ("Only local connection is allowed")
					m.set_status_code (403) -- Forbidden
					res.send (m)
				end
			else
				execute (req, res)
			end
		end

	execute_thread
		local
			nino: WSF_NINO_SERVICE_LAUNCHER
			opts: WSF_SERVICE_LAUNCHER_OPTIONS
		do
			create opts.default_create
			opts.set_verbose (True)
			opts.set_option ("port", port_number)
			create nino.make (Current, opts)
			nino.on_launched_actions.force (agent on_launched)
			nino.launch
		end

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the request
			-- See `req.input' for input stream
    		--     `req.meta_variables' for the CGI meta variable
			-- and `res' for output buffer
		deferred
		end

	on_launched (conn: WGI_CONNECTOR)
		do
			if attached {WGI_NINO_CONNECTOR} conn as nino then
				set_port_number (nino.port)
			end
			on_launched_actions.call (Void)
		end

feature -- Control

	wait
			-- Wait for server to be terminated.
		do
			join
		end

feature -- Access

	on_launched_actions: ACTION_SEQUENCE [TUPLE]

feature -- Status report

	local_connection_restriction_enabled: BOOLEAN
			-- Accept only local connection?
			--| based on 127.0.0.1 IP
			--| TO IMPROVE

feature -- Change

	set_local_connection_restriction_enabled (b: BOOLEAN)
		do
			local_connection_restriction_enabled := b
		end

end

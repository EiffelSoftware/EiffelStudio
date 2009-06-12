note
	description: "[
		API for commands that weppaps can send to a server.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XSC_SERVER_INTERFACE


feature -- Basic operations

	shutdown_webapps
			-- Shutdown all webapps.
		deferred
		end

	shutdown_http_server
			-- Shutdown the http server.
		deferred
		end

	launch_http_server
		-- (re) launches the http server.
		deferred
		end

	display_response
			-- Display a response. (Send it to the mod_xebra).
		deferred
		end

	load_config
			-- (re) load the file config.
		deferred
		end

	stop_server
			-- Stop the server.
		deferred
		end

	handle_errors
			-- Handle errors in the shared error manager.
		deferred
		end

end


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

	shutdown_https
			-- Shutdown the http server.
		deferred
		end

	launch_https
		-- (re) launches the http server.
		deferred
		end

	load_config
			-- (re) load the file config.
		deferred
		end

	shutdown_server
			-- Shutdown the server.
		deferred
		end

	handle_errors
			-- Handles errors that occured in the current command
		deferred
		end
end


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

	get_modules: XS_COMMAND_RESPONSE
			-- Gets the available modules.
		deferred
		ensure
			result_attached: Result /= Void
		end


	shutdown_webapps: XS_COMMAND_RESPONSE
			-- Shutdown all webapps.
		deferred
		ensure
			result_attached: Result /= Void
		end

	shutdown_module (a_name: STRING): XS_COMMAND_RESPONSE
			-- Shutdown the http server.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	relaunch_module (a_name: STRING): XS_COMMAND_RESPONSE
		-- (re) launches a module
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	load_config: XS_COMMAND_RESPONSE
			-- (re) load the file config.
		deferred
		ensure
			result_attached: Result /= Void
		end

	shutdown_server: XS_COMMAND_RESPONSE
			-- Shutdown the server.
		deferred
		ensure
			result_attached: Result /= Void
		end

	handle_errors
			-- Handles errors that occured in the current command
		deferred
		end
end


note
	description: "[
		API for commands that can be executed on a server.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_SERVER_INTERFACE

feature -- Webapps

	force_translate (a_name: STRING): XC_COMMAND_RESPONSE
			-- Forces (re)-translattion and compilation of webapp.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end


	get_sessions (a_name: STRING): XC_COMMAND_RESPONSE
			-- Retrieves the number of sessions of all running webapps.
			-- `a_name': Use this to exclude a webapp from this request
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	fire_off_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- Sends shutdown signal even if the webapp process is not owned by the server.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	dev_mode_on_global: XC_COMMAND_RESPONSE
			-- Sets dev_mod to on on all webapps.
		deferred
		ensure
			result_attached: Result /= Void
		end

	dev_mode_off_global: XC_COMMAND_RESPONSE
			-- Sets dev_mod to off on all webapps.
		deferred
		ensure
			result_attached: Result /= Void
		end

	dev_mode_on_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- Sets developing mode of a webapp to on.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	dev_mode_off_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- Sets developing mode of a webapp to off.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	get_webapps: XC_COMMAND_RESPONSE
			-- Retrieves the available webapps.
		deferred
		ensure
			result_attached: Result /= Void
		end

	enable_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- Enables a webapp.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	disable_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- Disables a webapp.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	launch_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- (Re)-translates, compiles and launches a webapp.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	shutdown_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- Shuts down a webapp.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	shutdown_webapps: XC_COMMAND_RESPONSE
			-- Shutdown all webapps.
		deferred
		ensure
			result_attached: Result /= Void
		end

	clean_webapp (a_name: STRING): XC_COMMAND_RESPONSE
			-- Cleans, re-translates and compiles a webapp.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Modules

	get_modules: XC_COMMAND_RESPONSE
			-- Gets the available modules.
		deferred
		ensure
			result_attached: Result /= Void
		end

	shutdown_module (a_name: STRING): XC_COMMAND_RESPONSE
			-- Shutdown the http server.
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	relaunch_module (a_name: STRING): XC_COMMAND_RESPONSE
		-- (re) launches a module
		require
			a_name_attached: a_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Server

	load_config: XC_COMMAND_RESPONSE
			-- (re) load the file config.
		deferred
		ensure
			result_attached: Result /= Void
		end

	shutdown_server: XC_COMMAND_RESPONSE
			-- Shutdown the server.
		deferred
		ensure
			result_attached: Result /= Void
		end

--feature -- Other

--	handle_errors
--			-- Handles errors that occured in the current command
--		deferred
--		end
end


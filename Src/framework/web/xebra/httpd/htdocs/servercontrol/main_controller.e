note
	description: "[
		Provides features for the servlets
	]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_CONTROLLER

inherit
	XWA_CONTROLLER redefine	make end

create
	make

feature {NONE} -- Initialization	

	make
			-- Initializes Current
		do
			Precursor
		end

feature -- Access

	modules: LIST [TUPLE[ name: STRING; launched: BOOLEAN; running: BOOLEAN]]

feature -- Server Control


	get_modules
			-- Retreive modules from server
		do
			if attached {XCCR_GET_MODULES} server_control.send (create {XCC_GET_MODULES}.make) as l_modules then
				modules := l_modules.twin
			end
		end

	reload_config: STRING
			--
		do
			if attached  {XCCR_OK} server_control.send (create {XCC_LOAD_CONFIG}.make) then
				Result := "OK"
			else
				Result := "Error"
			end
		end

	shutdown_server (a: ANY)
			--
		do

		end

	shutdown_https (a: ANY)
			--
		do

		end

	launch_https (a: ANY)
			--
		do

		end

	shutdown_webapps (a: ANY)
			--
		do
		end


end

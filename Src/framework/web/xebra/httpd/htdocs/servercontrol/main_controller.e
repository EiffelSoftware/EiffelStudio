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

feature -- Server Control

--	reload_config (a: ANY)
--			--
--		do
--			server_control.load_config
--		end

--	shutdown_server (a: ANY)
--			--
--		do
--			server_control.shutdown_server
--		end

--	shutdown_https (a: ANY)
--			--
--		do
--			server_control.shutdown_https
--		end

--	launch_https (a: ANY)
--			--
--		do
--			server_control.launch_https
--		end

--	shutdown_webapps (a: ANY)
--			--
--		do
--			server_control.shutdown_webapps
--		end


end

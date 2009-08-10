note
	description: "[
		Provides features for the servlets.
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
			create {ARRAYED_LIST [XC_SERVER_MODULE_BEAN]}modules.make (1)
			create {ARRAYED_LIST [XC_WEBAPP_BEAN]}webapps.make (1)
		end

feature -- Access

	modules: LIST [XC_SERVER_MODULE_BEAN]
	webapps: LIST [XC_WEBAPP_BEAN]

feature -- Modules Control

	get_modules: STRING
			-- Retreive modules from server
		do
			if attached {XCCR_GET_MODULES} server_control.send (create {XCC_GET_MODULES}.make) as l_response then
				from
					modules.wipe_out
					l_response.modules.start
				until
					l_response.modules.after
				loop
					modules.force (l_response.modules.item_for_iteration)
					l_response.modules.forth
				end
			end
			Result := ""
		end

	shutdown_mod (a_mod: ANY)
			-- Sends a shutdown_mod command to the server.
		local
			l_cmd: XCC_SHUTDOWN_MOD
		do
			create l_cmd.make
			if attached {STRING} a_mod as l_mod then
				l_cmd.set_parameter (l_mod)
				server_control.send (l_cmd).do_nothing
			end
		end

	relaunch_mod (a_mod: ANY)
			-- Sends a relaunch_mod command to the server.
		local
			l_cmd: XCC_RELAUNCH_MOD
		do
			create l_cmd.make
			if attached {STRING} a_mod as l_mod then
				l_cmd.set_parameter (l_mod)
				server_control.send (l_cmd).do_nothing
			end
		end

feature -- Webapp Control

	force_translate (a_mod: ANY)
			-- Forces translation of a webapp
		local
			l_cmd: XCC_TRANSLATE_WEBAPP
		do
			create l_cmd.make
			if attached {STRING} a_mod as l_mod then
				l_cmd.set_parameter (l_mod)
				server_control.send ( l_cmd ).do_nothing
			end
		end

	get_webapps: STRING
			-- Retreive webapps from server
		local
			l_c: XCC_GET_SESSIONS
		do
			create l_c.make
			l_c.set_parameter ("servercontrol")

			if attached server_control.send (l_c) then
				if attached {XCCR_GET_WEBAPPS} server_control.send (create {XCC_GET_WEBAPPS}.make) as l_response then
					from
						webapps.wipe_out
						l_response.webapps.start
					until
						l_response.webapps.after
					loop
						webapps.force (l_response.webapps.item_for_iteration)
						l_response.webapps.forth
					end
				end
			end
			Result := ""
		end


	dev_mode_on_webapp (a_webapp: ANY)
			-- Sends a dev_mode_on_webapp command to the server.
		local
			l_cmd: XCC_DEV_ON_WEBAPP
		do
			create l_cmd.make
			if attached {STRING} a_webapp as l_webapp then
				l_cmd.set_parameter (l_webapp)
				server_control.send ( l_cmd ).do_nothing
			end
		end

	dev_mode_off_webapp (a_webapp: ANY)
			-- Sends a dev_mode_off_webapp command to the server.
		local
			l_cmd: XCC_DEV_OFF_WEBAPP
		do
			create l_cmd.make
			if attached {STRING} a_webapp as l_webapp then
				l_cmd.set_parameter (l_webapp)
				server_control.send ( l_cmd ).do_nothing
			end
		end


	shutdown_webapp (a_webapp: ANY)
			-- Sends a shutdown_webapp command to the server.
		local
			l_cmd: XCC_SHUTDOWN_WEBAPP
		do
			create l_cmd.make
			if attached {STRING} a_webapp as l_webapp then
				l_cmd.set_parameter (l_webapp)
				server_control.send ( l_cmd ).do_nothing
			end
		end

	relaunch_webapp (a_webapp: ANY)
			-- Sends a relaunch_webapp command to the server.
		local
			l_cmd: XCC_LAUNCH_WEBAPP
		do
			create l_cmd.make
			if attached {STRING} a_webapp as l_webapp then
				l_cmd.set_parameter (l_webapp)
				server_control.send (l_cmd).do_nothing
			end
		end

	clean_webapp (a_webapp: ANY)
			-- Sends a clean_webapp command to the server.
		local
			l_cmd: XCC_CLEAN_WEBAPP
		do
			create l_cmd.make
			if attached {STRING} a_webapp as l_webapp then
				l_cmd.set_parameter (l_webapp)
				server_control.send (l_cmd).do_nothing
			end
		end

	enable_webapp (a_webapp: ANY)
			-- Sends a clean_webapp command to the server.
		local
			l_cmd: XCC_ENABLE_WEBAPP
		do
			create l_cmd.make
			if attached {STRING} a_webapp as l_webapp then
				l_cmd.set_parameter (l_webapp)
				server_control.send (l_cmd).do_nothing
			end
		end

	disable_webapp (a_webapp: ANY)
			-- Sends a clean_webapp command to the server.
		local
			l_cmd: XCC_DISABLE_WEBAPP
		do
			create l_cmd.make
			if attached {STRING} a_webapp as l_webapp then
				l_cmd.set_parameter (l_webapp)
				server_control.send (l_cmd).do_nothing
			end
		end

feature -- Server Control

	reload_config (e: ANY)
			-- Sends a reload_config command to the server.
		do
			if attached  {XCCR_OK} server_control.send (create {XCC_LOAD_CONFIG}.make) then
--				Result := "OK"
			else
--				Result := "Error"
			end
		end

	shutdown_server (e: ANY)
			-- Sends a shutdown_server command to the server
		do
			if attached  {XCCR_OK} server_control.send (create {XCC_SHUTDOWN_SERVER}.make) then
--				Result := "OK"
			else
--				Result := "Error"
			end
		end



end

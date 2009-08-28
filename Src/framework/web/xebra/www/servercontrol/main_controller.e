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
	XWA_CONTROLLER redefine	default_create end

create
	default_create

feature {NONE} -- Initialization	

	default_create
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

	shutdown_mod (a_mod: detachable ANY)
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

	relaunch_mod (a_mod: detachable ANY)
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

	force_translate (a_mod: detachable ANY)
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

	dev_mode_on_webapp (a_webapp: detachable ANY)
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

	dev_mode_off_webapp (a_webapp: detachable ANY)
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


	shutdown_webapp (a_webapp: detachable ANY)
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

	relaunch_webapp (a_webapp: detachable ANY)
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

	clean_webapp (a_webapp: detachable ANY)
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

	enable_webapp (a_webapp: detachable ANY)
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

	disable_webapp (a_webapp: detachable ANY)
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

	reload_config
			-- Sends a reload_config command to the server.
		do
			if attached  {XCCR_OK} server_control.send (create {XCC_LOAD_CONFIG}.make) then
			end
		end

	shutdown_server
			-- Sends a shutdown_server command to the server
		do
			if attached  {XCCR_OK} server_control.send (create {XCC_SHUTDOWN_SERVER}.make) then
			end
		end



note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

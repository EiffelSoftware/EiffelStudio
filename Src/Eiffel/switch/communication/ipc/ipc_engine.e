indexing
	description	: "Controller of the Eiffel debugger's daemon"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	IPC_ENGINE

inherit

	PLATFORM

	ISED_X_SLAVE
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES

	IPC_REQUEST

	THREAD_CONTROL

create
	make

feature {NONE} -- Initialization

	make is
		local
			p: BOOLEAN_PREFERENCE
		do
			p := Preferences.debugger_data.close_classic_dbg_daemon_on_end_of_debugging_preference
			set_close_ecdbgd_on_end_of_debugging_by_pref (p)
			p.change_actions.extend (agent set_close_ecdbgd_on_end_of_debugging_by_pref)
		end

feature -- Launching

	launch_ec_dbg is
		require
			ecdbgd_launched_only_if_not_closed: ec_dbg_launched implies not close_ecdbgd_on_end_of_debugging
		local
			cmd: STRING
			cs_pname, cs_cmd: C_STRING
			r: INTEGER
		do
			if ec_dbg_launched and then not is_ecdbgd_alive then
				clean_connection
				ec_dbg_launched := False
			end
			if not ec_dbg_launched then
				get_environment
				if ise_eiffel = Void or else ise_platform = Void then
					--| Error
				else
					if valid_ise_ecdbgd_executable then
						create cmd.make_from_string (ise_ecdbgd_path)
						if cmd.has (' ') then
							cmd.prepend_character ('"')
							cmd.append_character ('"')
						end

						create cs_cmd.make (cmd)
						create cs_pname.make ("ecdbgd")

						debug ("ipc")
							io.put_string ("Launching ecDBDd : " + cmd + " (timeout=" + ise_timeout.out + ") %N")
						end

						r := c_launch_ecdbgd (cs_pname.item, cs_cmd.item, ise_timeout)
						ec_dbg_launched := (r = 1)
					else
						ec_dbg_launched := False
					end
					if ec_dbg_launched then
						init_connection (False)
						if connection_failed then
							ec_dbg_launched := False
						else
							check
								ecdbgd_alive: is_ecdbgd_alive
							end
							send_rqst_2 (Rqst_set_ipc_param, ipc_current_process_id, ise_timeout)

							start_ecdbgd_alive_checking
						end
					end
				end
			end
		end

	get_environment is
			-- Get environment needed to start the debugger
		local
			s: STRING_8
		do
			ise_eiffel := Void
			ise_platform := Void

			ise_eiffel := Execution_environment.get (Ise_eiffel_varname)
			ise_platform := Execution_environment.get (Ise_platform_varname)

			ise_timeout := Preferences.debugger_data.classic_debugger_timeout
			if ise_timeout <= 0 then
				s := Execution_environment.get (Ise_timeout_varname)
				if s /= Void and then s.is_integer then
					ise_timeout := s.to_integer
				else
					ise_timeout := 30
				end
			end

			s := Preferences.debugger_data.classic_debugger_location
			if s = Void or else s.is_empty then
				s := Execution_environment.get (Ise_ecdbgd_varname)
			end
			if s /= Void then
				create ise_ecdbgd_path.make_from_string (s)
			else
				if ise_eiffel /= Void and ise_platform /= Void then
					create ise_ecdbgd_path.make_from_string (ise_eiffel)
					ise_ecdbgd_path.extend_from_array (<<"studio", "spec", ise_platform, "bin" >>)
					ise_ecdbgd_path.set_file_name (Ise_ecdbgd_default_name)
					if is_windows then
						ise_ecdbgd_path.add_extension ("exe")
					end
				end
			end
		end

	end_of_debugging is
			-- Notify the end of debugging
		do
			if close_ecdbgd_on_end_of_debugging then
				close_ecdbgd
			end
		end

	close_ecdbgd is
			-- Close the Eiffel debugger's daemon
		local
			n: INTEGER
		do
			stop_ecdbgd_alive_checking
			if is_ecdbgd_alive then
				Close_debugger_request.send

				from
					n := 0
				until
					not is_ecdbgd_alive or n > 100 --| timeout: 100ms
				loop
					sleep (1_000_000) -- i.e: 1 ms
					n := n + 1
				end
				check not is_ecdbgd_alive end
				--| it is not that critical to be sure ecdbgd is closed
				--| but it should be very quick .. so let's check
			end
				--| It is better to do that even if it is not alive.
			clean_connection
			ec_dbg_launched := False
		ensure
			ecdbgd_dead: not is_ecdbgd_alive
		end

feature -- Status

	is_ecdbgd_alive: BOOLEAN is
			-- Is the Eiffel debugger's daemon still alive ?
		do
			Result := (c_is_ecdbgd_alive = 1)
		end

	ise_eiffel, ise_platform: STRING
	ise_ecdbgd_path: FILE_NAME
	ise_timeout: INTEGER

	valid_ise_ecdbgd_executable: BOOLEAN is
		do
			Result := ise_ecdbgd_path /= Void and then valid_executable (ise_ecdbgd_path)
		end

feature -- Property

	ec_dbg_launched: BOOLEAN
			-- Is Eiffel debugger's daemon launched ?

	close_ecdbgd_on_end_of_debugging: BOOLEAN
			-- Do we close the Eiffel debugger's daemon
			-- when the debugging session is terminated ?

feature {NONE} -- ecdbgd status

	set_close_ecdbgd_on_end_of_debugging_by_pref (p: BOOLEAN_PREFERENCE) is
		do
			close_ecdbgd_on_end_of_debugging := p.value
		end

	ecdbgd_alive_checking_timer: EV_TIMEOUT

	start_ecdbgd_alive_checking is
		do
			if ecdbgd_alive_checking_timer = Void then
				create ecdbgd_alive_checking_timer
				ecdbgd_alive_checking_timer.actions.extend (agent check_ecdbgd_alive)
			end
			ecdbgd_alive_checking_timer.set_interval (1000)
		end

	stop_ecdbgd_alive_checking is
		do
			if ecdbgd_alive_checking_timer /= Void then
				ecdbgd_alive_checking_timer.set_interval (0)
			end
		end

	check_ecdbgd_alive is
		local
			retried: BOOLEAN
			old_delay: INTEGER
			dlg: EV_WARNING_DIALOG
		do
			if not retried then
				if ecdbgd_alive_checking_timer /= Void then
					old_delay := ecdbgd_alive_checking_timer.interval
					ecdbgd_alive_checking_timer.set_interval (0)
				end
				if not is_ecdbgd_alive then
					debug ("ipc")
						print ("ecdbgd is not alive anymore !!! %N")
					end
					create dlg.make_with_text ("The Eiffel debugger daemon is dead,%N" +
						"If you were debugging, the session is about to be terminated")
					dlg.show
					dead_handler.execute
				elseif ecdbgd_alive_checking_timer /= Void then
					ecdbgd_alive_checking_timer.set_interval (old_delay)
				end
			else
				debug ("ipc")
					print ("ERROR while checking if ecdbgd is still alive !!! %N")
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	close_debugger_request: EWB_REQUEST is
		once
			create Result.make ({IPC_SHARED}.Rqst_close_debugger)
		end

	Process_factory: PROCESS_FACTORY is
		once
			create Result
		end

	create_handler is
		do
			-- Keep this for compatibility with old EiffelStudio
		end

	valid_executable (fn: FILE_NAME): BOOLEAN is
			-- Does `fn' represents a valid executable ?
		local
			f: RAW_FILE
		do
			create f.make (fn)
			Result := f.exists and then (is_windows or else f.is_access_executable)
		end

feature {ANY} -- Constants

	Ise_eiffel_varname: STRING is "ISE_EIFFEL"
	Ise_platform_varname: STRING is "ISE_PLATFORM"
	Ise_timeout_varname: STRING is "ISE_TIMEOUT"
	Ise_ecdbgd_varname: STRING is "ISE_ECDBGD"
	Ise_ecdbgd_default_name: STRING is "ecdbgd"

feature {NONE} -- Externals

	c_launch_ecdbgd (pprogn: POINTER; pcmd: POINTER; timeout: INTEGER): INTEGER is
			-- launch classic Eiffel debugger component
		external
			"C signature (char* , char* , int ): int"
		alias
			"launch_ecdbgd"
		end

	ipc_current_process_id: INTEGER is
		external
			"C"
		alias
			"ewb_current_process_id"
		end

	c_is_ecdbgd_alive: INTEGER is
			-- Ask if the Eiffel debugger's daemon is still alive ?
		external
			"C signature (): int"
		alias
			"is_ecdbgd_alive"
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

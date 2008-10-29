indexing
	description	: "Controller of the Eiffel debugger's daemon"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	IPC_ENGINE

inherit

	ISED_X_SLAVE
		export
			{NONE} all
		end

	IPC_REQUEST

	EXECUTION_ENVIRONMENT

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_EXEC_ENVIRONMENT

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SAFE_PATH_BUILDER
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (dbg: like debugger_manager) is
		require
			dbg_not_void: dbg /= Void
		do
			change_debugger_manager (dbg)
		end

feature {APPLICATION_EXECUTION_CLASSIC} -- Change

	change_debugger_manager (dbg: like debugger_manager) is
		require
			dbg_not_void: dbg /= Void
		do
			debugger_manager := dbg
		end

	debugger_manager: DEBUGGER_MANAGER

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

			prepare_ec_dbg_launching

				--| Launch Eiffel Debugger
			if not ec_dbg_launched then
				get_environment
				if valid_ise_ecdbgd_executable then
					cmd := safe_path (ise_ecdbgd_path)
					create cs_cmd.make (cmd)
					create cs_pname.make ("ecdbgd")

					debug ("ipc")
						io.put_string ("Launching ecdbgd : " + cmd + " (timeout=" + ise_timeout.out + ") %N")
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

	prepare_ec_dbg_launching is
			-- Prepare ec before starting Eiffel debugger daemon
			--| Mainly optimization
		do
				--| Optimisation to reduce the file descriptor number of pipes
				--| used by the IPC protocol on unices
			Eiffel_system.System.server_controler.wipe_out
		end

	get_environment is
			-- Get environment needed to start the debugger
		local
			s: STRING_8
		do
			ise_timeout := Debugger_manager.classic_debugger_timeout
			if ise_timeout <= 0 then
				s := Execution_environment.get (Ise_timeout_varname)
				if s /= Void and then s.is_integer then
					ise_timeout := s.to_integer
				else
					ise_timeout := 30
				end
			end

			s := Debugger_manager.classic_debugger_location
			if s = Void or else s.is_empty then
				s := Execution_environment.get (Ise_ecdbgd_varname)
			end
			if s /= Void then
				create ise_ecdbgd_path.make_from_string (s)
			else
				ise_ecdbgd_path := eiffel_layout.Ecdbgd_command_name.twin
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
			r, n: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				stop_ecdbgd_alive_checking
				if is_ecdbgd_alive then
					r := c_close_ecdbgd (0)

					from
						n := 0
					until
						not is_ecdbgd_alive or n > 100 --| timeout: 100ms
					loop
						sleep (1_000_000) -- i.e: 1 ms
						n := n + 1
					end
					check
						not_is_ecdbgd_alive: not is_ecdbgd_alive
					end
					--| it is not that critical to be sure ecdbgd is closed
					--| but it should be very quick .. so let's check
				end
					--| It is better to do that even if it is not alive.
				clean_connection
				ec_dbg_launched := False
			else
				clean_connection
				ec_dbg_launched := False
			end
		ensure
			ecdbgd_dead: not is_ecdbgd_alive
		rescue
			retried := True
			retry
		end

feature -- Status

	is_ecdbgd_alive: BOOLEAN is
			-- Is the Eiffel debugger's daemon still alive ?
		do
			Result := (c_is_ecdbgd_alive = 1)
		end

	ise_ecdbgd_path: FILE_NAME
	ise_timeout: INTEGER

	valid_ise_ecdbgd_executable: BOOLEAN is
		do
			Result := ise_ecdbgd_path /= Void and then valid_executable (ise_ecdbgd_path)
		end

	close_ecdbgd_on_end_of_debugging: BOOLEAN is
			-- Do we close the Eiffel debugger's daemon
			-- when the debugging session is terminated ?
		do
			Result := Debugger_manager.classic_close_dbg_daemon_on_end_of_debugging
		end

feature -- Property

	ec_dbg_launched: BOOLEAN
			-- Is Eiffel debugger's daemon launched ?

feature {NONE} -- ecdbgd status

	ecdbgd_alive_checking_timer: DEBUGGER_TIMER

	start_ecdbgd_alive_checking is
		do
			if ecdbgd_alive_checking_timer = Void then
				ecdbgd_alive_checking_timer := debugger_manager.new_timer
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
					debugger_manager.debugger_error_message (
							"The Eiffel debugger daemon is dead,%N" +
							"If you were debugging, the session is about to be terminated"
						)
					if dead_handler /= Void then
							--| It occurs on linux, dead_handler is Void
							--| it seems even if the debugger is stopped
							--| the timeout still occurs ...
						dead_handler.execute
					end
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

	Ise_timeout_varname: STRING is "ISE_TIMEOUT"
	Ise_ecdbgd_varname: STRING is "ISE_ECDBGD"

feature {NONE} -- Externals

	c_launch_ecdbgd (pprogn: POINTER; pcmd: POINTER; timeout: INTEGER): INTEGER is
			-- launch classic Eiffel debugger component
		external
			"C signature (char* , char* , int ): int"
		alias
			"launch_ecdbgd"
		end

	c_close_ecdbgd (timeout: INTEGER): INTEGER is
			-- close classic Eiffel debugger component
		external
			"C signature (int ): int"
		alias
			"close_ecdbgd"
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

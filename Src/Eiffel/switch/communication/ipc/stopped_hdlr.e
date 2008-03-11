indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class STOPPED_HDLR

inherit

	RQST_HANDLER_WITH_DATA

	SHARED_DEBUGGER_MANAGER

	OBJECT_ADDR

	RECV_VALUE

	APPLICATION_STATUS_EXPORTER

	REFACTORING_HELPER

	APPLICATION_STATUS_CONSTANTS

create

	make

feature {NONE} -- Initialization

	make is
			-- Create Current and pass addresses to C
		do
			request_type := Rep_stopped
			pass_addresses
		end

feature -- Execution

	execute is
			-- Register that the application is stopped
			-- and parse the string passed from C.
			-- The format of the passed string is:
			--    feature name
			--    object address
			--    origin of feature
			--    type of object
			--    offset in byte code
			--    reason for stopping
			--    did exception occurred ?
			--    assertion tag (undefined if irrelevant)
			--
			-- Check:
			--		* C\ipc\app\app_proto.c:stop_rqst (..)
			--		* C\ipc\ewb\eif_in.c:request_dispatch (..) --> case STOPPED: ..
			--		* C\ipc\shared\rqst_idrs.c:idr_Stop (..)
		local
			feature_name: STRING
			origine_type_id: INTEGER
			dynamic_type_id: INTEGER
			offset: INTEGER
			address: STRING
			stopping_reason: INTEGER
			exception_occurred: BOOLEAN
			thr_id: INTEGER

			l_app: APPLICATION_EXECUTION
			l_status: APPLICATION_STATUS_CLASSIC
			retry_clause: BOOLEAN
		do
			check
				application_is_executing: debugger_manager.application_is_executing
			end

			if not retry_clause then
				l_app := Debugger_manager.application
				l_app.on_application_before_paused
				debug ("DEBUGGER_TRACE","DEBUGGER_IPC")
					io.error.put_string (generator + ": Application is stopped%N")
				end

					--| Physical address of objects held in object tools
					--| may have been change...
				debug ("DEBUGGER_IPC")
					io.error.put_string (generator + ": update kept objects addresses %N")
				end
				update_kept_objects_addresses

					--|--------------------------------|--
					--| Retrieve data sent by debuggee |--
					--|--------------------------------|--

				debug ("DEBUGGER_TRACE","DEBUGGER_IPC")
					io.error.put_string (generator + ": reading information from application%N")
				end

					--| Reset pipe reader parsing
				reset_parsing
				debug ("DEBUGGER_TRACE","DEBUGGER_IPC")
					print (generator + ".details=" + detail + "%N")
				end

					--| Read feature name.
				read_string
				feature_name := last_string

					--| Read object address and convert it to hector address.
				read_string
				address := keep_object_as_hector_address (last_string)

					--| Read origin of feature
				read_integer
				origine_type_id := last_integer + 1;

					--| Read type of current object.
					--| Note: the type id on the C side must be
					--| incremented by one.
				read_integer
				dynamic_type_id := last_integer + 1;

					--| Read offset in byte code.
				read_integer
				offset := last_integer

					--| Read thread id
				read_integer
				thr_id := last_integer

					--| Read reason for stopping.
				read_integer
				stopping_reason := last_integer

					--| Read exception.
				read_integer
				exception_occurred := last_integer = 1

					--|----------------------------|--
					--| Data retrieved             |--
					--| Now process stopped state  |--
					--|----------------------------|--

				debug ("DEBUGGER_TRACE","DEBUGGER_IPC")
					io.error.put_string ("STOPPED_HDLR: Application is stopped - finished reading%N")
					io.error.put_string ("              Setting app status for routine: ")
					io.error.put_string (feature_name)
					io.error.put_new_line
				end

				l_status ?= l_app.status;
				check
					application_launched: l_status /= Void
				end
				if thr_id = 0 then
						--| Since our version of HASH_TABLE does not allow to have default value as key
						--| and thr_id may be zero only in non MT system
						--| thus we can hack this with '1' as thread id.
					thr_id := 1
				end
				l_status.set_is_stopped (True)
				if not l_status.has_thread_id (thr_id) then
					l_status.add_thread_id (thr_id)
				end
				l_status.set_active_thread_id (thr_id)
				l_status.set_current_thread_id (thr_id)

				l_status.set (feature_name, address, origine_type_id, dynamic_type_id, offset, stopping_reason)
				l_status.set_exception_occurred (exception_occurred)
				if exception_occurred then
					if {e: !EXCEPTION_DEBUG_VALUE} l_app.remote_current_exception_value then
						e.update_data
						l_status.set_exception (e)
					else
						check should_not_occur: False end
						l_status.set_exception (create {EXCEPTION_DEBUG_VALUE}.make_without_any_value)
						l_status.exception.set_user_meaning ("Exception occurred (no data available!)")
					end
				end

				debug ("DEBUGGER_TRACE","DEBUGGER_IPC")
					io.error.put_string ("STOPPED_HDLR: Finished setting status (Now calling after cmd)%N")
				end

					--|----------------------------|--
					--| Status set , now process   |--
					--| stopped state operations   |--
					--|----------------------------|--

				process_paused_state (stopping_reason, l_app)

			else -- retry_clause
				if l_app.is_running then
					l_app.process_termination;
				end
			end
			debug ("DEBUGGER_TRACE")
				io.error.put_string ("STOPPED_HDLR: finished%N")
			end
--		rescue
-- FIXME ARNAUD
-- toTo: write a beautiful message box instead of this crappy message
--			io.put_string("Error while getting Application status. Application will be terminated%N")
-- END FIXME
--			retry_clause := True
--			retry
		end

	process_paused_state (a_pause_reason: INTEGER; a_app: APPLICATION_EXECUTION) is
			-- Process paused state
		local
			need_to: TUPLE [stop: BOOLEAN; update_bp: BOOLEAN]
			l_status: APPLICATION_STATUS
		do
			l_status := a_app.status

			inspect
				a_pause_reason
			when Pg_update_breakpoint then
					--| If the reason is Pg_update_breakpoint, the application sends the
					--| new breakpoints status and then automatically resume its execution.
				debug ("DEBUGGER_TRACE")
					io.error.put_string ("STOPPED_HDLR: New breakpoint added, do nothing%N")
				end

				-- application has stopped to take into account the
				-- breakpoints changes. So let's send the breakpoints
				-- to the application and resume it.
				need_to := [False, True] -- Continue, but resend bp
			when pg_overflow then
				--Do nothing specific
			when pg_catcall then
				need_to := [execution_stopped_on_catcall_event (a_app), False]
			else
					--| The debuggee is on a real stopped state
				need_to := [True, True]

				a_app.on_application_paused

				inspect
					a_pause_reason
				when
					{APPLICATION_STATUS_CONSTANTS}.Pg_raise,
					{APPLICATION_STATUS_CONSTANTS}.Pg_viol then
					need_to.stop := execution_stopped_on_exception_event (a_app)
					need_to.update_bp := False
				when {APPLICATION_STATUS_CONSTANTS}.Pg_break then
						--| debuggee stopped on a Breakpoint
					need_to := execution_stopped_on_breakpoint_event (a_app)
					need_to.update_bp := need_to.stop or else breakpoints_manager.breakpoints_changed
				when {APPLICATION_STATUS_CONSTANTS}.Pg_step then
					if l_status.has_breakpoint_enabled then
							--| Process breakpoints
						need_to := execution_stopped_on_breakpoint (a_app)
						need_to.update_bp := breakpoints_manager.breakpoints_changed
					end
					need_to.stop := True
				else
					--| Nothing
				end
			end

			if need_to /= Void and then need_to.stop then
					--| Now that we know the debuggee will be really stopped
					--| Let get the effective call stack (not the dummy)
				l_status.reload_current_call_stack
				a_app.set_current_execution_stack_number (a_app.number_of_stack_elements)

					-- Inspect the application's current state.
				a_app.on_application_just_stopped

				debug ("DEBUGGER_TRACE")
					io.error.put_string ("STOPPED_HDLR: Finished calling after_cmd%N")
				end
			else
					--| We don't stop on this breakpoint,
					--| Relaunch the application.
				if need_to /= Void and then need_to.update_bp then
						--| if we stopped on cond bp
						--| in case we don't really stop
						--| we won't send again the breakpoints
						--| since they didn't changed, and a "go to this point" may be enabled
					a_app.continue
				else
						-- Shortcut breakpoint sending
					a_app.release_all_but_kept_object
					l_status.set_is_stopped (False)
					Cont_request.send_rqst_3_integer (Rqst_resume, Resume_cont, debugger_manager.interrupt_number, debugger_manager.critical_stack_depth)
				end
			end
		end

feature {NONE} -- Implementation

	execution_stopped_on_catcall_event (app: APPLICATION_EXECUTION): BOOLEAN is
			-- Do we stop execution on this catcall warning event ?
		require
			catcall_occurred: app.status.reason_is_catcall
		local
			i, nb: INTEGER
			l_integer: INTEGER
			t: TUPLE [pos: INTEGER; expected: INTEGER; actual: INTEGER]
		do
			if app.debugger_manager.exceptions_handler.catcall_warning_ignored then
				Result := False
			else
				Result := True

					--| Request information
				Cont_request.send_rqst_0 (Rqst_last_rtcc_info)
				nb := to_integer_32 (c_tread)
				if nb > 0 then
					from
						i := 1
						create t
					until
						i > nb
					loop
						l_integer := to_integer_32 (c_tread)
						inspect i
						when 1 then
							t.pos := l_integer
						when 2 then
							--| +1 : because in the runtime the id starts at 0
							t.expected := l_integer + 1
						when 3 then
							--| +1 : because in the runtime the id starts at 0
							t.actual := l_integer + 1
						else
							--| unexpected value!
						end
						i := i + 1
					end
				end
				app.status.set_catcall_data (t)
			end
		end

	execution_stopped_on_exception_event (app: APPLICATION_EXECUTION): BOOLEAN is
			-- Do we stop execution on this exception event ?
		require
			exception_occurred: app.status.exception_occurred
		do
			Result := app.debugger_manager.process_exception
			debug ("debugger_trace")
				if Result then
					io.put_string ("Catch exception")
				else
					io.put_string ("Ignore exception")
				end
				if {s: !STRING} (app.status.exception_type_name) then
					io.put_string (": " + s)
				end
				io.new_line
			end
		end

	execution_stopped_on_breakpoint_event (app: APPLICATION_EXECUTION): TUPLE [stop: BOOLEAN; update_bp: BOOLEAN] is
			-- Do we stop execution and resend breakpoints on this breakpoint event ?
		require
			appstat: app.status.reason = {APPLICATION_STATUS_CONSTANTS}.Pg_break
		do
			Result := execution_stopped_on_breakpoint (app)
		end

	execution_stopped_on_breakpoint (app: APPLICATION_EXECUTION): TUPLE [stop: BOOLEAN; update_bp: BOOLEAN] is
			-- Do we stop execution and resend breakpoints on this breakpoint event ?
		local
			bps: LIST [BREAKPOINT]
			loc: BREAKPOINT_LOCATION
			bpm: BREAKPOINTS_MANAGER
			dbm: DEBUGGER_MANAGER
			b: BOOLEAN

			l_status: APPLICATION_STATUS_CLASSIC
			cse: CALL_STACK_ELEMENT_CLASSIC
		do
			l_status ?= app.status
			Result := [False, False]

				--| debuggee stopped on a Breakpoint

				--| Initialize the stack with a dummy first call stack element
				--| to be able to operation on the current feature
--			if app. then
--				
--			end
			cse := l_status.dummy_call_stack_element
			l_status.current_call_stack.extend (cse)
			app.set_current_execution_stack_number (1)

			if
				cse = Void
				or else cse.is_not_valid
				or else cse.routine = Void
			then
				Result.stop := True
			else
				dbm := app.debugger_manager
				bpm := dbm.breakpoints_manager
				loc := bpm.breakpoint_location (cse.routine, cse.break_index, False)
				bps := bpm.breakpoints_at (loc)
				if bps /= Void then
					from
						b := False
						bps.start
					until
						bps.after
					loop
						b := b or dbm.process_breakpoint (bps.item)
						bps.forth
					end
					Result.stop := b
				else
						-- We are stopped, but there is no "set" breakpoints ...
						-- might be a trouble, then resend bps
					Result.stop := False
					Result.update_bp := True
				end
			end
		end

	cont_request: EWB_REQUEST is
			-- Request to relaunch the application when needed.
		once
			create Result.make (Rqst_cont)
		end

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

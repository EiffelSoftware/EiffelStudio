indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class STOPPED_HDLR

inherit

	RQST_HANDLER_WITH_DATA

	SHARED_DEBUG

	OBJECT_ADDR

	APPLICATION_STATUS_EXPORTER

	REFACTORING_HELPER

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
			--    exception code (undefined if irrelevant)
			--    assertion tag (undefined if irrelevant)
		local
			feature_name: STRING
			origine_type: INTEGER
			dynamic_type: INTEGER
			offset: INTEGER
			address: STRING
			stopping_reason: INTEGER
			exception_code: INTEGER
			exception_tag: STRING
			thr_id: INTEGER

			l_status: APPLICATION_STATUS_CLASSIC
			retry_clause: BOOLEAN
			cse: CALL_STACK_ELEMENT_CLASSIC
			expr: EB_EXPRESSION
			need_to_stop: BOOLEAN
			need_to_resend_bp: BOOLEAN
			evaluator: DBG_EXPRESSION_EVALUATOR
		do
			if not retry_clause then
				Application.on_application_before_stopped
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

					--| Read feature name.
				read_string
				feature_name := last_string

					--| Read object address and convert it to hector address.
				read_string
				address := keep_object_as_hector_address (last_string)

					--| Read origin of feature
				read_integer
				origine_type := last_integer + 1;

					--| Read type of current object.
					--| Note: the type id on the C side must be
					--| incremented by one.
				read_integer
				dynamic_type := last_integer + 1;

					--| Read offset in byte code.
				read_integer
				offset := last_integer

					--| Read thread id
				read_integer
				thr_id := last_integer

					--| Read reason for stopping.
				read_integer
				stopping_reason := last_integer

					--| Read exception code.
				read_integer
				exception_code := last_integer

					--| Read assertion tag.
				read_string;
				exception_tag := last_string


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

				l_status ?= Application.status;
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
				l_status.set_current_thread_id (thr_id)
				l_status.set (feature_name, address, origine_type, dynamic_type, offset, stopping_reason)
				l_status.set_exception (exception_code, exception_tag)

				debug ("DEBUGGER_TRACE","DEBUGGER_IPC")
					io.error.put_string ("STOPPED_HDLR: Finished setting status (Now calling after cmd)%N")
				end

					--|----------------------------|--
					--| Status set , now process   |--
					--| stopped state operations   |--
					--|----------------------------|--

				if stopping_reason /= Pg_new_breakpoint then
						--| The debuggee is on a real stopped state

					need_to_resend_bp := True
					need_to_stop := True

					inspect
						stopping_reason
					when Pg_raise, Pg_viol then
						need_to_stop := execution_stopped_on_exception (exception_code)
						need_to_resend_bp := False
					when Pg_break then
							--| debuggee stopped on a Breakpoint

							--| Initialize the stack with a dummy first call stack element
							--| to be able to operation on the current feature
						l_status.current_call_stack.extend (create {CALL_STACK_ELEMENT_CLASSIC}.dummy_make (feature_name, 1, True, offset, address, dynamic_type - 1, origine_type - 1))
						Application.set_current_execution_stack_number (1)

							--| Check if this is a Conditional Breakpoint
						cse := l_status.current_call_stack.i_th (1)
						if application.is_breakpoint_set (cse.routine, cse.break_index) then
							expr := Application.condition (cse.routine, cse.break_index)
							if expr /= Void then
									--| if the breakpoint is conditional, tests the condition.
								expr.evaluate
								evaluator := expr.expression_evaluator
								need_to_stop := evaluator.error_occurred or else evaluator.final_result_is_true_boolean_value
								need_to_resend_bp := need_to_stop
							end
						end
					else
					end
					if need_to_stop then
							--| Now that we know the debuggee will be really stopped
							--| Let get the effective call stack (not the dummy)
						l_status.reload_current_call_stack
						Application.set_current_execution_stack_number (Application.number_of_stack_elements)

							-- Inspect the application's current state.
						Application.on_application_just_stopped

						debug ("DEBUGGER_TRACE")
							io.error.put_string ("STOPPED_HDLR: Finished calling after_cmd%N")
						end
					else
							--| We don't stop on this breakpoint,
							--| Relaunch the application.
						Application.release_all_but_kept_object
						if need_to_resend_bp then
								--| if we stopped on cond bp
								--| in case we don't really stop
								--| we won't send again the breakpoints
								--| since they didn't changed, and a "go to this point" may be enabled
							Cont_request.send_breakpoints
						end
						l_status.set_is_stopped (False)
						Cont_request.send_rqst_3_integer (Rqst_resume, Resume_cont, Application.interrupt_number, application.critical_stack_depth)
					end
				else --| stopping_reason = Pg_new_breakpoint |--
						--| If the reason is Pg_new_breakpoint, the application sends the
						--| new breakpoints and then automatically resume its execution.
					debug ("DEBUGGER_TRACE")
						io.error.put_string ("STOPPED_HDLR: New breakpoint added, do nothing%N")
					end
				end
			else -- retry_clause
				if Application.is_running then
					Application.process_termination;
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

feature {NONE} -- Implementation

	execution_stopped_on_exception (excep_code: INTEGER): BOOLEAN is
		do
			Result := Application.exceptions_handler.exception_catched_by_code (excep_code)
			debug ("debugger_trace")
				if Result then
					print ("Catch exception: " + excep_code.out + "%N")
				else
					print ("Ignore exception: " + excep_code.out + "%N")
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

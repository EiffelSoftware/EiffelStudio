class STOPPED_HDLR

inherit

	RQST_HANDLER

	SHARED_DEBUG

	OBJECT_ADDR

	APPLICATION_STATUS_EXPORTER

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

				debug ("DEBUGGER_TRACE")
					io.error.put_string ("STOPPED_HDLR: Application is stopped - reading information from application%N")
				end

				update_threads_info

					--| Physical address of objects held in object tools
					--| may have been change...
				update_kept_objects_addresses

					--|--------------------------------|--
					--| Retrieve data sent by debuggee |--
					--|--------------------------------|--

					--| Reset pipe reader parsing
				reset_parsing

					--| Read feature name.
				read_string;
				feature_name := last_string;

					--| Read object address and convert it to hector address.
				read_string;
				address := keep_object_as_hector_address (last_string);

					--| Read origin of feature
				read_int;
				origine_type := last_int + 1;

					--| Read type of current object.
					--| Note: the type id on the C side must be
					--| incremented by one.
				read_int;
				dynamic_type := last_int + 1;

					--| Read offset in byte code.
				read_int;
				offset := last_int;

					--| Read reason for stopping.
				read_int;
				stopping_reason := last_int;

					--| Read exception code.
				read_int;
				exception_code := last_int

					--| Read assertion tag.
				read_string;
				exception_tag := last_string


					--|----------------------------|--
					--| Data retrieved             |--
					--| Now process stopped state  |--
					--|----------------------------|--

				debug ("DEBUGGER_TRACE")
					io.error.put_string ("STOPPED_HDLR: Application is stopped - finished reading%N")
					io.error.put_string ("              Setting app status for routine: ")
					io.error.put_string (feature_name)
					io.error.put_new_line
				end

				l_status ?= Application.status;
				check
					application_launched: l_status /= Void
				end
				l_status.set_is_stopped (True)
				l_status.set (feature_name, address, origine_type, dynamic_type, offset, stopping_reason)
				l_status.set_exception (exception_code, exception_tag)

				debug ("DEBUGGER_TRACE")
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

					if stopping_reason = Pg_break then
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
							--| We don't stop on thie breakpoint,
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

	update_threads_info is
			-- Update current threads information
		local
			s: APPLICATION_STATUS
		do
			s := application.status
			if s /= Void and then s.current_thread_id = 0 then
				s.set_current_thread_id (1) -- FIXME jfiat: fake Thread ID ... for now
			end
		end

	cont_request: EWB_REQUEST is
			-- Request to relaunch the application when needed.
		once
			create Result.make (Rqst_cont)
		end

feature {NONE} -- parsing features

	position: INTEGER;
			-- Position in parsed string

	reset_parsing is
		do
			position := 1
		end

	last_string: STRING;
			-- Last parsed string token

	last_int: INTEGER;
			-- Last parsed integer token

	read_string is
			-- Parse string token.
		require
			-- position < detail.count and
			-- detail.substring (position, count).has ('%U')	
		local
			i: INTEGER;
		do
			i := index_of ('%U', position);
			if i = 0 then i := detail.count + 1 end;
			if i <= position then
				last_string := ""
			else
				last_string := detail.substring (position, i - 1);
			end;
			position := i + 1;
		end;

	index_of (c: CHARACTER; pos: INTEGER): INTEGER is
			-- position of first occurrence of c
			-- after pos (included). 0 if none
			--| should be in string
		local
			i: INTEGER
		do
			from
				i := pos
			until
				i > detail.count or Result > 0
			loop
				if detail.item (i) = c then
					Result := i
				else
					i := i + 1
				end
			end
		end;

	read_int is
			-- Parse integer token.
		do
			read_string;
			last_int := last_string.to_integer;
		end;

end

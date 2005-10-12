indexing
	description : "[
			General request from workbench to ised.
		]"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class EWB_REQUEST 

inherit

	DEBUG_EXT
	IPC_SHARED
	SHARED_DEBUG
	EXEC_MODES

create

	make 

feature -- Initialization

	make (code: INTEGER) is
			-- create a new request of type `code'
		do
			request_code := code
		end

feature -- Update

	send_breakpoints is
			-- send new breakpoints to the application
		local
			bpts: BREAK_LIST
			status: APPLICATION_STATUS
			curr_callstack_depth: INTEGER
			bp: BREAKPOINT
		do
			debug("debugger_trace_breakpoint")
				io.put_string("sending new breakpoint to the application%N")
			end
			bpts := debug_info.breakpoints
			status := Application.status

				-- remove breakpoint that are now useless.
			debug_info.update

			inspect Application.execution_mode
			when No_stop_points then
					-- remove all breakpoints set by the application.
					-- without changing their status under bench
				from
					bpts.start
				until
					bpts.after
				loop
					bp := bpts.item_for_iteration

					if bp.is_set_for_application then
						send_breakpoint(bp, bp.breakpoint_to_remove)
					end
					bpts.forth
				end

			when User_stop_points then
					-- Execution with no stop points set.
				update_breakpoints(bpts)

			when step_into then
					-- Execution with all breakable points set
					-- the flag 'step_into' is set, so that application
					-- know it must stop to the next breakable statement
					-- send a request for a "step-into" breakpoint
				update_breakpoints(bpts)
				send_rqst_3_integer (Rqst_break, 0, Break_set_stepinto,	0) -- as far as they are useless, body_id & offset are set to zero

			when step_by_step then
					-- Execution will stop to next breakable point where the callstack depth is
					-- the same than the current one
				update_breakpoints(bpts)
				if status /= Void then
					if status.current_call_stack /= Void then
						curr_callstack_depth := status.current_call_stack.stack_depth

						-- set a stack breakpoint, set on the current stack depth plus one
						-- (in run-time, the break is 'exec_stack < stack_bp', so we have to add 1 for step by step)
						send_rqst_3_integer (Rqst_break, 0, Break_set_stack_depth, +1) -- body_id is useless, so it's set to zero
					else
						-- the user has pushed on the step-by-step button to launch the application. let's stop at the begginning
						send_rqst_3_integer (Rqst_break, 0, Break_set_stepinto,	0) -- as far as they are useless, body_id & offset are set to zero
					end
				end

			when Out_of_routine then
					-- Execution will stop to next breakable point where the callstack depth is
					-- equal to the current one - 1
				update_breakpoints(bpts)
				if status /= Void then
					if status.current_call_stack /= Void then
						curr_callstack_depth := status.current_call_stack.stack_depth

						-- set a stack breakpoint, set on the current stack depth
						-- (in run-time, the break is 'exec_stack < stack_bp', so we dont have to substract 1 for step out)
						send_rqst_3_integer (Rqst_break, 0, Break_set_stack_depth, 0 ) -- body_id is useless, so it's set to zero
					else
						-- the user has pushed on the step-out button to launch the application. let's stop at the begginning
						send_rqst_3_integer (Rqst_break, 0, Break_set_stepinto,	0) -- as far as they are useless, body_id & offset are set to zero
					end
				end

			else
					-- Unknown execution mode. Do nothing.
			end
		end

	send is
			-- Send Current request to ised, which may 
			-- relay it to the application.
		do
			send_rqst_0 (request_code)
		end

	request_code: INTEGER
		-- type of request

feature {NONE} -- Implementation

	send_breakpoint (bp: BREAKPOINT; bp_mode: INTEGER) is
			-- send a breakpoint to the application, and update the
			-- status of the sent breakpoint
		do
			if (bp_mode = bp.breakpoint_to_remove) then
				debug("debugger_trace_breakpoint")
					io.put_string("removing the breakpoint : %N")
					io.put_string (bp.debug_output)
					io.put_new_line
				end
				send_rqst_3_integer (Rqst_break, bp.real_body_id - 1, Break_remove, bp.breakable_line_number)
				bp.set_application_not_set
			elseif (bp_mode = bp.breakpoint_to_add) then
				debug("debugger_trace_breakpoint")
					io.put_string("adding the breakpoint : ")
					io.put_string (bp.debug_output)
					io.put_new_line
				end
				send_rqst_3_integer (Rqst_break, bp.real_body_id - 1, Break_set, bp.breakable_line_number)
				bp.set_application_set
			end
		end

	update_breakpoints (bpts: BREAK_LIST) is
			-- Synchronize breakpoints status between application and $EiffelGraphicalCompiler$.
		local
			bp: BREAKPOINT
			to_do: INTEGER
		do
			from
				bpts.start
			until
				bpts.after
			loop
				bp := bpts.item_for_iteration
				to_do := bp.update_status
				send_breakpoint(bp, to_do)
				bpts.forth
			end
		end

end

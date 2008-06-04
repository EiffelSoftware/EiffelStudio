indexing
	description : "[
			General request from workbench to ised.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class EWB_REQUEST

inherit
	SHARED_DEBUGGER_MANAGER

	IPC_REQUEST

	RECV_VALUE

create
	make

feature -- Initialization

	make (code: INTEGER) is
			-- create a new request of type `code'
		do
			request_code := code
		end

feature -- Update		

	send is
			-- Send Current request to ised, which may
			-- relay it to the application.
		do
			send_rqst_0 (request_code)
		end

	send_integer (v: INTEGER) is
			-- Send Current request to ised, which may
			-- relay it to the application.
		do
			send_rqst_1 (request_code, v)
		end

	request_code: INTEGER
		-- type of request

feature {APPLICATION_EXECUTION} -- Breakpoints update

	send_breakpoints_for_stepping (app: APPLICATION_EXECUTION; a_execution_mode: INTEGER) is
			-- Send breakpoints for step operation
			-- called by `{APPLICATION_EXECUTION_CLASSIC}.send_breakpoints'
			-- DO NOT CALL DIRECTLY
			--
			-- be sure `{APPLICATION_EXECUTION_CLASSIC}.update_breakpoints' has already been called
		do
				--| Execution with all breakable points set
				--|
				--| Execution will stop to next breakable point where the callstack depth is
				--| the same than the current one for step_by_step
				--| and equal to current on minus 1 for Out_of_routine

			if app.is_running and then app.status.current_call_stack /= Void then
				debug("debugger_trace_breakpoint")
					print ("curr_callstack_depth=" + app.status.current_call_stack.stack_depth.out + "%N")
				end
				inspect a_execution_mode
				when {EXEC_MODES}.Step_next then
						-- set a stack breakpoint, set on the current stack depth plus one
						-- (in run-time, the break is 'exec_stack < stack_bp', so we have to add 1 for step by step)
					send_rqst_3_integer (Rqst_break, 0, Break_set_stack_depth, +1) -- useless body_id set to zero
				when {EXEC_MODES}.step_out then
					 -- Out_of_routine
						-- set a stack breakpoint, set on the current stack depth
						-- (in run-time, the break is 'exec_stack < stack_bp', so we dont have to substract 1 for step out)
					send_rqst_3_integer (Rqst_break, 0, Break_set_stack_depth, 0 ) -- useless body_id set to zero
				else -- {EXEC_MODES}.step_into
					send_rqst_3_integer (Rqst_break, 0, Break_set_stepinto,	0) -- useless body_id, and offset set to zero
				end
			else
				-- the user has pushed on the step-xyz button to launch the application.
				-- let's stop at the beginning (even for step-out .. which is disabled anyway)
				send_rqst_3_integer (Rqst_break, 0, Break_set_stepinto,	0) -- useless body_id, and offset set to zero
			end
		end

	set_classic_breakpoint (loc: BREAKPOINT_LOCATION; a_state: BOOLEAN) is
			-- set breakpoint at `loc' if `a_state' is `True'
			-- otherwise unset it
		require
			loc_valid: loc.is_valid
		local
			l_body_ids: LIST [INTEGER]
			l_real_body_id: INTEGER
			l_break_op: INTEGER
			l_break_line: INTEGER
		do
			if a_state then
				l_break_op := Break_set
			else
				l_break_op := Break_remove
			end
			l_body_ids := loc.real_body_ids_list
			if l_body_ids /= Void then
				l_break_line := loc.breakable_line_number
				from
					l_body_ids.start
				until
					l_body_ids.after
				loop
					l_real_body_id := l_body_ids.item
					send_rqst_3_integer (Rqst_break, l_real_body_id - 1, l_break_op, l_break_line)
					l_body_ids.forth
				end
				inspect
					l_break_op
				when Break_set then
					loc.set_application_set
				when Break_remove then
					loc.set_application_not_set
				end
			else
					--| Error when getting real body ids ...
				loc.set_application_not_set
			end
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

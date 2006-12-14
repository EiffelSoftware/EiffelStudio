indexing
	description: "Shared object that manages all debugging actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TTY_DEBUGGER_MANAGER

inherit
	DEBUGGER_MANAGER
		redefine
			on_application_launched,
			on_application_just_stopped,
			make,
			debugger_output_message,
			display_system_info,
			display_application_status,
			display_debugger_info,
			controller,
			implementation
		end

	OUTPUT_ROUTINES

create
	make

feature {NONE} -- Initialization

	make is
			-- Create current
		do
			Precursor
			create {DEBUGGER_TEXT_FORMATTER_OUTPUT} text_formatter_visitor.make
			create {TERM_WINDOW} tty_output
		end

feature -- Output helpers

	debugger_output_message (msg: STRING) is
		do
			tty_output.add_string (msg)
			tty_output.add_new_line
		end

	display_application_status is
		do
			text_formatter_visitor.append_status (application_status, tty_output)
		end

	display_system_info	is
		do
			append_system_info (tty_output)
		end

	display_debugger_info is
		do
			text_formatter_visitor.append_debugger_information (Current, tty_output)
		end

feature -- output

	display_callstack is
		require
			application_is_executing
		do
			text_formatter_visitor.append_stack (application_status.current_call_stack, tty_output)
		end

	display_exception is
		require
			application_is_executing
		do
			text_formatter_visitor.append_exception (application_status, tty_output)
		end

	display_locals is
		require
			application_is_executing
		do
			text_formatter_visitor.append_locals (application_status.current_call_stack_element, tty_output)
		end

	display_arguments is
		require
			application_is_executing
		do
			text_formatter_visitor.append_arguments (application_status.current_call_stack_element, tty_output)
		end

feature -- Access

	on_application_launched is
		do
			Precursor
			implementation.tty_wait_until_application_is_dead
		end

	on_application_just_stopped is
		do
			Precursor
			debugger_message (debugger_names.t_paused)
			raise_dbg_running_menu (False)
		end

feature -- Interaction

	inside_debugger_menu: BOOLEAN

	dbg_running_menu: TTY_MENU is
		local
			ag_is_stopped: FUNCTION [ANY, TUPLE, BOOLEAN]
		once
			ag_is_stopped := agent safe_application_is_stopped
			create Result.make ("--< Debugger execution menu >--")
			Result.enter_actions.extend (agent do inside_debugger_menu := True end)
			Result.quit_actions.extend (agent do inside_debugger_menu := False end)

			Result.add_conditional_entry ("N", "Step next", 
						agent tty_controller_do_if_stopped ({EXEC_MODES}.step_by_step, Result),
						ag_is_stopped)

			Result.add_conditional_entry ("I", "Step into", 
						agent tty_controller_do_if_stopped ({EXEC_MODES}.step_into, Result),
						ag_is_stopped)

			Result.add_conditional_entry ("O", "Step out", 
						agent tty_controller_do_if_stopped ({EXEC_MODES}.out_of_routine, Result),
						ag_is_stopped)

			Result.add_conditional_entry ("C", "Run to next stop point",
						agent tty_controller_do_if_stopped ({EXEC_MODES}.user_stop_points, Result),
						ag_is_stopped)

			Result.add_conditional_entry ("G", "Run without stop point", 
						agent tty_controller_do_if_stopped ({EXEC_MODES}.no_stop_points, Result),
						ag_is_stopped)

			Result.add_entry ("K", "Kill application", agent controller.debug_kill)
			Result.add_entry ("P", "Pause application", agent controller.debug_interrupt)
			Result.add_separator (" --- ")
			Result.add_conditional_entry ("D", "Display information", agent raise_debugger_menu_display,
						ag_is_stopped)

			Result.add_conditional_entry ("Q", "Quit", agent Result.quit, agent :BOOLEAN do Result := not application_is_executing end)
			Result.add_entry ("H", "Help", agent Result.execute)
		end

	tty_controller_do_if_stopped (a_exec_mode: INTEGER; a_menu: TTY_MENU) is
		do
			if safe_application_is_stopped then
				application.set_execution_mode (a_exec_mode)
				controller.resume_workbench_application
				a_menu.quit
			end
		end

	raise_dbg_running_menu (sm: BOOLEAN) is
		do
			dbg_running_menu.execute (sm)
		end

	dbg_display_menu: TTY_MENU is
		do
			create Result.make ("--< Debugger menu :: Display >--")
			Result.enter_actions.extend (agent do inside_debugger_menu := True end)
			Result.quit_actions.extend (agent do inside_debugger_menu := False end)

			Result.add_entry ("L", "locals", agent display_locals)
			Result.add_entry ("A", "arguments", agent display_arguments)
			Result.add_entry ("C", "callstack", agent display_callstack)
			Result.add_entry ("S", "status", agent display_application_status)
			if safe_application_is_stopped and then application_status.exception_occurred then
				Result.add_entry ("X", "exception", agent display_exception)
			end
			Result.add_entry ("E", "Expression evaluation", agent
					local
						x: EB_EXPRESSION
					do
						io.put_string (" --> Expression: ")
						io.read_line
						create x.make_for_context (io.last_string.twin)
						x.evaluate
						if x.error_occurred then
							io.put_string (x.expression_evaluator.short_text_from_error_messages)
						else
							tty_output.add_string (x.expression + " => " + x.expression_evaluator.final_result_value.output_for_debugger + "%N")
						end
						x := Void
					end
				)
			Result.add_entry (Void, Void, Void)
			Result.add_entry ("H", "Help", agent Result.execute)
			Result.add_quit_entry ("Q", "Quit")
		end

	raise_debugger_menu_display is
		do
			dbg_display_menu.execute (True)
		end

	string_started_by (s: STRING; pref: STRING): BOOLEAN is
		require
			s /= Void
			pref /= Void
		local
			i,j: INTEGER
		do
			if s.count >= pref.count then
				from
					i := 1
					j := 1
					Result := True
				until
					not Result or j > pref.count
				loop

					if s.item (i) /= ' ' then
						Result := s.item (i).as_lower = pref.item (j).as_lower
						j := j + 1
					end
					i := i + 1
				end
			end
		end

feature -- Properties

	tty_output: TEXT_FORMATTER

	controller: TTY_DEBUGGER_CONTROLLER

feature -- Output visitor

	text_formatter_visitor: DEBUGGER_TEXT_FORMATTER_VISITOR

feature {NONE} -- Implementation

	implementation: TTY_DEBUGGER_MANAGER_IMP;

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

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

	THREAD_CONTROL

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

	display_breakpoints (on_select_proc: PROCEDURE [ANY, TUPLE [BREAKPOINT]]; a_proc_message: STRING) is
			-- Display on breakpoints
		local
			bl: BREAK_LIST
			b: BREAKPOINT
			i: INTEGER
			s: STRING
			arr: ARRAY [BREAKPOINT]
		do
			bl := debug_info.breakpoints
			from
				i := 1
				if on_select_proc /= Void then
					create arr.make (1, bl.count)
				end
				io.put_string ("*** " + bl.count.out + " Breakpoints *** %N")
				bl.start
			until
				bl.after
			loop

				b := bl.item_for_iteration
				if arr /= Void then
					io.put_string (" [" + i.out + "] ")
					arr[i] := b
				else
					io.put_string (" - ")
				end
				io.put_string (b.string_representation (True) + "%N")
				bl.forth
				i := i + 1
			end
			if on_select_proc /= Void then
				from
					io.put_string (" [0] Cancel %N")
					if a_proc_message /= Void then
						io.put_string (" -> " + a_proc_message + ": ")
					end
					i := 1
					b := Void
				until
					b /= Void or i = 0
				loop
					io.read_line
					s := io.last_string
					s.left_adjust
					s.right_adjust
					if s.is_integer then
						i:= s.to_integer
						if arr.lower <= i and i <= arr.upper then
							b := arr[i]
						end
					end
				end
				if b /= Void then
					on_select_proc.call ([b])
				end
			end
		end

feature -- Access

	on_application_launched is
		do
			Precursor
			wait_until_application_is_dead
		end

	on_application_just_stopped is
		do
			Precursor
			debugger_message (debugger_names.t_paused)
			raise_dbg_running_menu (False)
		end

	wait_until_application_is_dead is
			-- Wait until application is dead
		local
			stop_process_loop_on_events: BOOLEAN
		do
			from
				stop_process_loop_on_events := False
			until
				stop_process_loop_on_events
			loop
				if not inside_debugger_menu then
					implementation.process_underlying_toolkit_event_queue
				end
				if application_initialized then
					sleep (10 * 1000)
				else
					stop_process_loop_on_events := True
				end
			end
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
			Result.add_conditional_entry ("B", "Breakpoints control", agent raise_debugger_menu_breakpoints,
						ag_is_stopped)
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

	raise_debugger_menu_display is
		do
			dbg_display_menu.execute (True)
		end

	raise_debugger_menu_breakpoints	is
		do
			dbg_breakpoints_menu.execute (True)
		end

	dbg_display_menu: TTY_MENU is
		do
			create Result.make ("--< Debugger menu :: Display >--")
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
			Result.add_quit_entry ("..", "Back to parent menu")
		end

	dbg_breakpoints_menu: TTY_MENU is
		do
			create Result.make ("--< Debugger menu :: Breakpoints >--")

			Result.add_entry ("A", "Add breakpoint", agent add_breakpoint)
			Result.add_entry ("M", "Modify existing breakpoint", agent display_breakpoints (agent modify_breakpoint, "Modify breakpoint"))
			Result.add_entry ("L", "list breakpoints", agent display_breakpoints (Void, Void))
			Result.add_entry (Void, Void, Void)
			Result.add_entry ("H", "Help", agent Result.execute)
			Result.add_quit_entry ("..", "Back to parent menu")
		end

feature -- Breakpoints management

	add_breakpoint is
		local
			s: STRING
			i: INTEGER
			curr_bi: INTEGER
			ci_lst: LIST [CLASS_I]
			curr_cc, cc: CLASS_C
			curr_fe, fe: E_FEATURE
			l_added: BOOLEAN
		do
			io.put_string (" -> class name: ")
			curr_cc := current_debugging_class_c
			if curr_cc /= Void then
				io.put_string ("[" + curr_cc.name_in_upper + "] ")
			end
			io.read_line
			s := io.last_string
			s.left_adjust
			s.right_adjust
			if s.is_empty then
				if curr_cc /= Void then
					cc := curr_cc
				else
					s := Void
				end
			else
				i := s.index_of ('[', 1)
				if i > 0 then
					s := s.substring (1, i - 1)
				end
				s.prune_all (' ')
				if s /= Void and then not s.is_case_insensitive_equal (curr_cc.name) then
					ci_lst := Eiffel_universe.classes_with_name (s)
					if ci_lst /= Void and then not ci_lst.is_empty then
						cc := ci_lst.first.compiled_class
					else
						io.put_string (" => Could not find class {" + s + "}. %N")
					end
				else
					cc := curr_cc
				end
			end

			if cc /= Void then
				io.put_string (" -> feature name: (*=all feature)")
				if cc = curr_cc then
					curr_fe := current_debugging_feature
					if curr_fe /= Void then
						io.put_string ("[" + curr_fe.name + "] ")
					end
				end
				io.read_line
				s := io.last_string
				s.left_adjust
				s.right_adjust
				if s.is_empty then
					if curr_fe /= Void then
						fe := curr_fe
					end
				else
					if s.item (1) = '*' then
						debug_info.enable_breakpoints_in_class (cc)
						l_added := True
						io.put_string (" => Added breakpoints in class {" + cc.name_in_upper + "}. %N")
					else
						fe := cc.feature_with_name (s)
						if fe = Void then
							io.put_string (" => Could not find feature {" + cc.name_in_upper + "}." + s + " %N")
						end
					end
				end
				if fe /= Void then
					io.put_string (" -> break index: ")
					if fe = curr_fe then
						curr_bi := current_debugging_breakable_index
						if curr_bi > 0 then
							io.put_string ("[" + curr_bi.out + "] ")
						end
					end
					io.read_line
					s := io.last_string
					if s.is_empty then
						if curr_bi > 0 then
							i := curr_bi
						end
					else
						if s.is_integer then
							i := s.to_integer
						else
							i := 0
						end
					end
					if i > 0 then
						debug_info.enable_breakpoint (fe, i)
						l_added := True
						io.put_string (" => Added breakpoint {" + cc.name_in_upper + "}." + fe.name + "@" + i.out +" %N")
					end
				end
			end
			if not l_added then
				io.put_string (" => No breakpoint addition%N")
			end
		end

	modify_breakpoint (bp: BREAKPOINT) is
		local
			m: TTY_MENU
			s: STRING
		do
			create m.make ("*** Modify breakpoint " + bp.string_representation (False) + " ***")
			if not bp.is_enabled then
				m.add_entry ("E", "Enable breakpoint", agent bp.enable)
			end
			if not bp.is_disabled then
				m.add_entry ("D", "Disable breakpoint", agent bp.disable)
			end
			m.add_entry ("R", "Remove breakpoint", agent bp.discard)
			if bp.has_condition then
				s := bp.condition.expression.as_string_8
				if s.count > 22 then
					s.keep_head (20)
					s.append ("..")
				end
				m.add_separator ("--( condition: %"" + s + "%")--")
				m.add_entry ("I", "Edit condition", agent edit_breakpoint_condition (bp))
				m.add_entry ("R", "Remove condition", agent bp.remove_condition)
			else
				m.add_entry ("C", "Add condition", agent edit_breakpoint_condition (bp))
			end
			m.add_separator (Void)
			m.add_quit_entry ("..", "Back to previous menu")
			m.execute (True)
		end

	edit_breakpoint_condition (bp: BREAKPOINT) is
		local
			s: STRING
			exp: EB_EXPRESSION
			fe: E_FEATURE
		do
			if bp.has_condition then
				s := bp.condition.expression.as_string_8
				io.put_string (" -> Current condition: %"" + s + "%" %N")
			end
			io.put_string (" -> Enter new condition (empty to cancel) :")
			io.read_line
			s := io.last_string.twin
			s.left_adjust
			s.right_adjust
			if not s.is_empty then
				fe := bp.routine
				create exp.make_for_context (s)
				if (fe /= Void and then not exp.is_condition (fe)) or else exp.error_occurred then
					io.put_string (" => This is not a valid condition. %N")
				else
					bp.set_condition (exp)
					io.put_string (" => New condition applied. %N")
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

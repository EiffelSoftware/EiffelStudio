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
			add_idle_action, remove_idle_action, new_timer,
			windows_handle,
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
			create idle_actions
		end

feature -- Output helpers

	debugger_output_message (msg: STRING_GENERAL) is
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
			bl := debugger_data.breakpoints
			from
				i := 1
				if on_select_proc /= Void then
					create arr.make (1, bl.count)
				end
				localized_print (debugger_names.m_n_breakpoints (bl.count.out))
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
				localized_print (b.string_representation (True) + "%N")
				bl.forth
				i := i + 1
			end
			if on_select_proc /= Void then
				from
					localized_print (debugger_names.m_zero_cancel)
					if a_proc_message /= Void then
						localized_print (" -> " + a_proc_message + ": ")
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

				--| Activate user interaction
			raise_dbg_running_menu (False)
		end

feature -- Interaction

	inside_debugger_menu: BOOLEAN

	dbg_running_menu: TTY_MENU is
		local
			ag_is_stopped: FUNCTION [ANY, TUPLE, BOOLEAN]
			ag_is_executing: FUNCTION [ANY, TUPLE, BOOLEAN]
		once
			ag_is_stopped := agent safe_application_is_stopped
			ag_is_executing := agent application_is_executing

			create Result.make (debugger_names.t_debugger_excetion_menu)
			Result.enter_actions.extend (agent do inside_debugger_menu := True end)
			Result.quit_actions.extend (agent do inside_debugger_menu := False end)

			Result.add_conditional_entry ("N", debugger_names.c_step_next,
						agent tty_controller_do_if_stopped ({EXEC_MODES}.step_by_step, Result),
						ag_is_stopped)

			Result.add_conditional_entry ("I", debugger_names.c_step_into,
						agent tty_controller_do_if_stopped ({EXEC_MODES}.step_into, Result),
						ag_is_stopped)

			Result.add_conditional_entry ("O", debugger_names.c_step_out,
						agent tty_controller_do_if_stopped ({EXEC_MODES}.out_of_routine, Result),
						ag_is_stopped)

			Result.add_conditional_entry ("C", debugger_names.c_run_to_next_stop_point,
						agent tty_controller_do_if_stopped ({EXEC_MODES}.user_stop_points, Result),
						ag_is_stopped)

			Result.add_conditional_entry ("G", debugger_names.c_run_without_stop_point,
						agent tty_controller_do_if_stopped ({EXEC_MODES}.no_stop_points, Result),
						ag_is_stopped)

			Result.add_conditional_entry ("K", debugger_names.c_kill_application, agent controller.debug_kill,
						ag_is_executing)
			Result.add_conditional_entry ("P", debugger_names.c_pause_application, agent controller.debug_interrupt,
						ag_is_executing)
			Result.add_separator (" --- ")
			Result.add_conditional_entry ("B", debugger_names.c_breakpoints_controls, agent raise_debugger_menu_breakpoints,
						ag_is_stopped)
			Result.add_conditional_entry ("D", debugger_names.c_display_information, agent raise_debugger_menu_display,
						ag_is_stopped)

			Result.add_conditional_entry ("Q", debugger_names.e_quit, agent Result.quit, agent :BOOLEAN do Result := not application_is_executing end)
			Result.add_entry ("H", debugger_names.e_help, agent Result.request_menu_display)
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
			create Result.make (debugger_names.t_debugger_menu_display)
			Result.add_entry ("L", debugger_names.e_locales, agent display_locals)
			Result.add_entry ("A", debugger_names.e_arguments, agent display_arguments)
			Result.add_entry ("C", debugger_names.e_callstack, agent display_callstack)
			Result.add_entry ("S", debugger_names.e_status, agent display_application_status)
			if safe_application_is_stopped and then application_status.exception_occurred then
				Result.add_entry ("X", debugger_names.e_exception, agent display_exception)
			end
			Result.add_entry ("E", debugger_names.e_expression_evaluation, agent
					local
						x: EB_EXPRESSION
					do
						localized_print (debugger_names.m_expression)
						io.read_line
						create x.make_for_context (io.last_string.twin)
						x.evaluate
						if x.error_occurred then
							if x.expression_evaluator.short_text_from_error_messages /= Void then
								localized_print (x.expression_evaluator.short_text_from_error_messages)
							else
								localized_print (debugger_names.m_error_occurred)
							end
						else
							tty_output.add_string (x.expression + " => " + x.expression_evaluator.final_result_value.output_for_debugger + "%N")
						end
						x := Void
					end
				)
			Result.add_entry (Void, Void, Void)
			Result.add_entry ("H", debugger_names.e_help, agent Result.request_menu_display)
			Result.add_quit_entry ("..", debugger_names.e_back_to_parent_menu)
		end

	dbg_breakpoints_menu: TTY_MENU is
		do
			create Result.make (debugger_names.t_debugger_menu_breakpoints)

			Result.add_entry ("A", debugger_names.e_add_breakpoint, agent add_breakpoint)
			Result.add_entry ("M", debugger_names.e_modify_exsiting_breakpoint, agent display_breakpoints (agent modify_breakpoint, "Modify breakpoint"))
			Result.add_entry ("L", debugger_names.e_list_breakpoints, agent display_breakpoints (Void, Void))
			Result.add_entry (Void, Void, Void)
			Result.add_entry ("H", debugger_names.e_help, agent Result.request_menu_display)
			Result.add_quit_entry ("..", debugger_names.e_back_to_parent_menu)
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
			localized_print (debugger_names.m_class_name)
			curr_cc := current_debugging_class_c
			if curr_cc /= Void then
				localized_print ("[" + curr_cc.name_in_upper + "] ")
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
						localized_print (debugger_names.m_could_not_find_class (s))
					end
				else
					cc := curr_cc
				end
			end

			if cc /= Void then
				localized_print (debugger_names.m_feature_name)
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
						debugger_data.enable_breakpoints_in_class (cc)
						l_added := True
						localized_print (debugger_names.m_added_breakpoints_in_class (cc.name_in_upper))
					else
						fe := cc.feature_with_name (s)
						if fe = Void then
							localized_print (debugger_names.m_could_not_find_feature (cc.name_in_upper, s))
						end
					end
				end
				if fe /= Void then
					localized_print (debugger_names.m_break_index)
					if fe = curr_fe then
						curr_bi := current_debugging_breakable_index
						if curr_bi > 0 then
							localized_print ("[" + curr_bi.out + "] ")
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
						debugger_data.enable_breakpoint (fe, i)
						l_added := True
						localized_print (debugger_names.m_added_breakpoint_detailed (cc.name_in_upper, fe.name, i.out))
					end
				end
			end
			if not l_added then
				localized_print (debugger_names.m_no_breakpoint_addition)
			end
		end

	modify_breakpoint (bp: BREAKPOINT) is
		local
			m: TTY_MENU
			s: STRING_32
		do
			create m.make (debugger_names.m_modify_breakpoint (bp.string_representation (False)))
			if not bp.is_enabled then
				m.add_entry ("E", debugger_names.e_enable_breakpoint, agent bp.enable)
			end
			if not bp.is_disabled then
				m.add_entry ("D", debugger_names.e_disable_breakpoint, agent bp.disable)
			end
			m.add_entry ("R", debugger_names.e_remove_breakpoint, agent bp.discard)
			if bp.has_condition then
				s := bp.condition.expression
				if s.count > 22 then
					s.keep_head (20)
					s.append ("..")
				end
				m.add_separator (debugger_names.m_condition_sep (s))
				m.add_entry ("I", debugger_names.e_edit_condition, agent edit_breakpoint_condition (bp))
				m.add_entry ("R", debugger_names.e_remove_condition, agent bp.remove_condition)
			else
				m.add_entry ("C", debugger_names.e_add_condition, agent edit_breakpoint_condition (bp))
			end
			m.add_separator (Void)
			m.add_quit_entry ("..", debugger_names.e_back_to_previous_menu)
			m.execute (True)
		end

	edit_breakpoint_condition (bp: BREAKPOINT) is
		local
			s: STRING
			exp: EB_EXPRESSION
			fe: E_FEATURE
		do
			if bp.has_condition then
				s := bp.condition.expression
				localized_print (debugger_names.m_current_condition (s))
			end
			localized_print (debugger_names.m_edit_new_condition)
			io.read_line
			s := io.last_string.twin
			s.left_adjust
			s.right_adjust
			if not s.is_empty then
				fe := bp.routine
				create exp.make_for_context (s)
				if (fe /= Void and then not exp.is_boolean_expression (fe)) or else exp.error_occurred then
					localized_print (debugger_names.m_not_a_valid_boolean_condition)
				else
					bp.set_condition (exp)
					localized_print (debugger_names.m_new_condition_applied)
				end
			end
		end

feature -- Access

	windows_handle: POINTER is
		do
			Result := implementation.timer_win32_handle
		end

feature -- Events

	new_timer: TTY_DEBUGGER_TIMER is
		do
			create Result.make (implementation)
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
					idle_actions.call (Void)
				end
				if application_initialized then
					sleep (10 * 1000)
				else
					stop_process_loop_on_events := True
				end
			end
		end

	idle_actions: ACTION_SEQUENCE [TUPLE]
			-- Internal idle actions.

	add_idle_action (v: PROCEDURE [ANY, TUPLE]) is
			-- Extend `idle_actions' with `v'.
		do
			if not idle_actions.has (v) then
				idle_actions.extend (v)
			end
		end

	remove_idle_action (v: PROCEDURE [ANY, TUPLE]) is
			-- Remove `v' from `idle_actions'
		local
			l_cursor: CURSOR
			l_idle_actions: like idle_actions
		do
			l_idle_actions := idle_actions
			l_cursor := l_idle_actions.cursor
			l_idle_actions.prune_all (v)
			if l_idle_actions.valid_cursor (l_cursor) then
				l_idle_actions.go_to (l_cursor)
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

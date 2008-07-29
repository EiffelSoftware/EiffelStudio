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
	ES_DEBUGGER_MANAGER
		redefine
			make,
			on_application_launched,
			on_debugging_terminated,
			on_application_just_stopped,
			debugger_output_message,
			display_system_info,
			display_application_status,
			display_debugger_info,
			controller
		end

	EIFFEL_SYNTAX_CHECKER

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

	display_debugger_info (param: DEBUGGER_EXECUTION_PARAMETERS) is
		do
			text_formatter_visitor.append_debugger_information (Current, param, tty_output)
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
			bl := breakpoints_manager.breakpoints
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
					io.put_string ("  [" + i.out + "] ")
					arr[i] := b
				else
					io.put_string ("  - ")
				end
				localized_print (b.string_representation (True) + "%N")
				bl.forth
				i := i + 1
			end
			if on_select_proc /= Void then
				from
					localized_print (debugger_names.m_zero_cancel)
					if a_proc_message /= Void then
						localized_print ("  -> " + a_proc_message + ": ")
					end
					i := 1
					b := Void
				until
					b /= Void or i = 0
				loop
					s := adjusted_answer
					if s.is_integer then
						i:= s.to_integer
						if arr.lower <= i and i <= arr.upper then
							b := arr[i]
						end
					end
					if b = Void and then i /= 0 then
						localized_print (debugger_names.m_error_invalid_value ("0-" + arr.upper.out))
						io.put_new_line
						io.put_string (" -> ")
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
			enter_events_handling
		end

	on_application_just_stopped is
		do
			Precursor
			debugger_message (debugger_names.t_paused)

				--| Activate user interaction
			raise_dbg_running_menu (False)
		end

	on_debugging_terminated (was_executing: BOOLEAN) is
			--
		do
			leave_events_handling
			Precursor (was_executing)
		end

feature -- Interaction

	inside_debugger_menu: BOOLEAN

	dbg_running_menu: EWB_TTY_MENU is
		local
			ag_is_stopped: FUNCTION [ANY, TUPLE, BOOLEAN]
			ag_is_executing: FUNCTION [ANY, TUPLE, BOOLEAN]
		do
			Result := internal_dbg_running_menu
			if Result = Void then
				ag_is_stopped := agent safe_application_is_stopped
				ag_is_executing := agent application_is_executing

				create Result.make (debugger_names.t_debugger_excetion_menu)
				Result.enter_actions.extend (agent do inside_debugger_menu := True end)
				Result.quit_actions.extend (agent do inside_debugger_menu := False end)

				Result.add_conditional_entry ("N", debugger_names.c_step_next,
							agent tty_controller_do_if_stopped ({EXEC_MODES}.Step_next, Result),
							ag_is_stopped)

				Result.add_conditional_entry ("I", debugger_names.c_step_into,
							agent tty_controller_do_if_stopped ({EXEC_MODES}.step_into, Result),
							ag_is_stopped)

				Result.add_conditional_entry ("O", debugger_names.c_step_out,
							agent tty_controller_do_if_stopped ({EXEC_MODES}.step_out, Result),
							ag_is_stopped)

				Result.add_conditional_entry ("C", debugger_names.c_run_to_next_stop_point,
							agent tty_controller_do_if_stopped ({EXEC_MODES}.Run, Result),
							ag_is_stopped)

				Result.add_conditional_entry ("G", debugger_names.c_run_without_stop_point,
							agent tty_controller_do_if_stopped ({EXEC_MODES}.Run, Result),
							ag_is_stopped)

				Result.add_conditional_entry ("T", debugger_names.c_toggle_ignore_breakpoint,
							agent do set_execution_ignoring_breakpoints (not execution_ignoring_breakpoints) end,
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
				internal_dbg_running_menu := Result
			end
		end

	tty_controller_do_if_stopped (a_exec_mode: INTEGER; a_menu: TTY_MENU) is
		do
			if safe_application_is_stopped then
				controller.debug_operate (a_exec_mode)
				a_menu.quit
			end
		end

	raise_dbg_running_menu (sm: BOOLEAN) is
		do
			io.put_new_line
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

	dbg_display_menu: EWB_TTY_MENU is
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
						exp_txt: STRING
						x: DBG_EXPRESSION
						v: DBG_EXPRESSION_EVALUATION
						s: STRING_GENERAL
					do
						localized_print (debugger_names.m_expression)
						io.read_line
						exp_txt := io.last_string.twin
						create x.make_with_context (exp_txt)
						if not x.error_occurred then
							create v.make (x)
							v.evaluate
						end
						if v = Void or else v.error_occurred then
							if v /= Void then
								s := v.short_text_from_error_messages
							end
							if s /= Void then
								localized_print (s)
							else
								localized_print (debugger_names.m_error_occurred)
							end
						elseif v.value /= Void then
							tty_output.add_string (exp_txt + " => " + v.value.output_for_debugger + "%N")
						else
							tty_output.add_string (exp_txt + " => Returned ...%N")
						end
						x := Void
						v := Void
						io.put_new_line
					end
				)
			Result.add_entry (Void, Void, Void)
			Result.add_entry ("H", debugger_names.e_help, agent Result.request_menu_display)
			Result.add_quit_entry ("..", debugger_names.e_back_to_parent_menu)
		end

	dbg_breakpoints_menu: EWB_TTY_MENU is
		do
			create Result.make (debugger_names.t_debugger_menu_breakpoints)

			Result.add_entry ("A", debugger_names.e_add_breakpoint, agent add_breakpoint)
			Result.add_entry ("M", debugger_names.e_modify_exsiting_breakpoint, agent display_breakpoints (agent modify_breakpoint, "Modify breakpoint"))
			Result.add_entry ("L", debugger_names.e_list_breakpoints, agent display_breakpoints (Void, Void))
			Result.add_entry (Void, Void, Void)
			Result.add_entry ("H", debugger_names.e_help, agent Result.request_menu_display)
			Result.add_quit_entry ("..", debugger_names.e_back_to_parent_menu)
		end

feature {NONE} -- Menu caching

	internal_dbg_running_menu: like dbg_running_menu
			-- Cached `dbg_running_menu'.

feature -- Breakpoints management

	add_breakpoint is
		local
			s: STRING
			i: INTEGER
			curr_bi: INTEGER
			ci_lst: LIST [CLASS_I]
			ci: CLASS_I
			curr_cc, cc: CLASS_C
			curr_fe, fe: E_FEATURE
			l_added: BOOLEAN
		do
			localized_print (debugger_names.m_class_name)
			curr_cc := current_debugging_class_c
			if curr_cc /= Void then
				localized_print ("[" + curr_cc.name_in_upper + "] ")
			end
			s := adjusted_answer
			s.to_upper
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
					if is_valid_class_name (s) then
						if curr_cc /= Void then
							ci := eiffel_universe.class_named (s, curr_cc.group)
						else
							ci_lst := Eiffel_universe.classes_with_name (s)
							if ci_lst /= Void and then not ci_lst.is_empty then
								ci := ci_lst.first
							end
						end
					end
					if ci = Void then
						localized_print (debugger_names.m_could_not_find_class (s))
					else
						cc := ci.compiled_class
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
				s := adjusted_answer
				s.to_lower
				if s.is_empty then
					if curr_fe /= Void then
						fe := curr_fe
					end
				else
					if s.item (1) = '*' then
						breakpoints_manager.enable_first_user_breakpoints_in_class (cc)
						l_added := True
						localized_print (debugger_names.m_added_breakpoints_in_class (cc.name_in_upper))
					else
						if is_valid_feature_name (s) then
							fe := cc.feature_with_name (s)
						end
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
					s := adjusted_answer
					if s.is_empty then
						if curr_bi > 0 then
							i := curr_bi
						end
					else
						if s.is_integer then
							i := s.to_integer
						else
							i := 0
							s := Void
						end
					end
					if s /= Void then --| i.e `i' is a number
						if i <= 0 then
							i := 1
						elseif i > fe.number_of_breakpoint_slots then
							i := fe.number_of_breakpoint_slots
						end
						breakpoints_manager.enable_user_breakpoint (fe, i)
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
			m: EWB_TTY_MENU
			s: STRING_32
		do
			create m.make (debugger_names.m_modify_breakpoint (bp.string_representation (False)))
			if bp.hits_count > 0 then
				s := "Hits count = "
				s.append_integer (bp.hits_count)
				m.add_separator (s)
			end
			if bp.has_condition then
				s := "Condition = "
				s.append_string_general (bp.condition.text)
				m.add_separator (s)
			end
			if bp.has_when_hits_action_for ({BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE}) then
				if {x: BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE} bp.when_hits_actions_for ({BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE}).first then
					s := "Message = "
					s.append_string_general (x.message)
					m.add_separator (s)
				end
			end
			m.add_separator ("----")
			if not bp.is_enabled then
				m.add_entry ("E", debugger_names.e_enable_breakpoint, agent bp.enable)
			end
			if not bp.is_disabled then
				m.add_entry ("D", debugger_names.e_disable_breakpoint, agent bp.disable)
			end
			m.add_entry ("R", debugger_names.e_remove_breakpoint, agent bp.discard)

			m.add_conditional_entry ("Z", debugger_names.e_reset_bp_hits_count (bp.hits_count), agent bp.reset_hits_count,
						agent (a_bp: BREAKPOINT): BOOLEAN do Result := a_bp.hits_count > 0 end(bp))

			m.add_conditional_entry ("I", debugger_names.e_edit_condition, agent edit_breakpoint_condition (bp),
						agent bp.has_condition)
			m.add_conditional_entry ("R", debugger_names.e_remove_condition, agent bp.remove_condition,
						agent bp.has_condition)
			m.add_conditional_entry ("C", debugger_names.e_add_condition, agent edit_breakpoint_condition (bp),
						agent (a_bp: BREAKPOINT): BOOLEAN do Result := not a_bp.has_condition end (bp))
			m.add_entry ("W", debugger_names.e_bp_when_hits, agent edit_breakpoint_when_hits (bp))

			m.add_separator (Void)
			m.add_quit_entry ("..", debugger_names.e_back_to_previous_menu)
			m.execute (True)
		end

	edit_breakpoint_condition (bp: BREAKPOINT) is
		local
			s: STRING
			exp: DBG_EXPRESSION
			fe: E_FEATURE
			d: STRING
		do
			if bp.has_condition then
				s := bp.condition.text
				localized_print (debugger_names.m_current_condition (s))
			end
			localized_print (debugger_names.m_edit_new_condition)
			s := adjusted_answer
			if not s.is_empty then
				fe := bp.routine
				create exp.make_with_context (s)
				if bp.continue_on_condition_failure then
					d := "y"
				else
					d := "n"
				end
				s := confirmation_answer (debugger_names.m_continue_on_condition_failure_question, <<"y", "n">>, d, True)
				bp.set_continue_on_condition_failure (s.is_equal ("y"))

				if bp.condition_as_is_true then
					d := "1"
				else
					d := "2"
				end
				s := confirmation_answer (debugger_names.m_condition_is_true_or_has_changed_question ("1", "2"), <<"1", "2">>, d, True)
				if s.is_equal ("1") then
					bp.set_condition_as_is_true
				else
					bp.set_condition_as_has_changed
				end

				if exp.error_occurred then
					localized_print (debugger_names.m_not_a_valid_condition)
				elseif
					bp.condition_as_is_true and then (fe /= Void and then not exp.is_boolean_expression (fe))
				then
					localized_print (debugger_names.m_not_a_valid_boolean_condition)
				else
					bp.set_condition (exp)
					localized_print (debugger_names.m_new_condition_applied)
				end
			end
		end

	edit_breakpoint_when_hits (bp: BREAKPOINT) is
		local
			s: STRING
			d: STRING
			wha: BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE
		do
			if bp.has_when_hits_action_for ({BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE}) then
				wha ?= bp.when_hits_actions_for ({BREAKPOINT_WHEN_HITS_ACTION_PRINT_MESSAGE}).first
				s := wha.message
				localized_print (debugger_names.m_current_bp_message(s))
				d := "y"
			else
				d := "n"
			end
			s := confirmation_answer (debugger_names.m_print_message_when_bp_hit_question, <<"y", "n">>, d, True)
			if s.is_equal ("y") then
				localized_print (debugger_names.e_enter_print_message)
				s := adjusted_answer
				if s.is_empty and wha /= Void then
					if confirmation_answer (debugger_names.m_remove_or_use_current_bp_message_question ("1", "2"), << "1", "2">>, "2", True).is_equal ("1") then
						bp.remove_when_hits_action (wha)
						wha := Void
					else
						--| Do nothing
					end
					-- do you want to keep existing message
				else
					if wha = Void then
						create wha.make (s)
						bp.add_when_hits_action (wha)
						bp.set_continue_execution (True)
					else
						wha.set_message (s)
					end
				end
			end
			if bp.continue_execution then
				d := "y"
			else
				d := "n"
			end
			s := confirmation_answer (debugger_names.m_continue_when_bp_hit_question, <<"y", "n">>, d, True)
			bp.set_continue_execution (s.is_equal ("y"))
		end

feature -- Events

	enter_events_handling is
		require
			events_handler /= Void
		do
			events_handler.start_events_handling
		end

	leave_events_handling is
		do
			events_handler.stop_events_handling
		end

feature -- Properties

	tty_output: TEXT_FORMATTER

	controller: TTY_DEBUGGER_CONTROLLER

feature -- Output visitor

	text_formatter_visitor: DEBUGGER_TEXT_FORMATTER_VISITOR;

feature {NONE} -- Implementation

	truncated_text (s: STRING; a_size: INTEGER): STRING is
		require
			a_size > 3
		do
			Result := s.twin
			if Result.count > a_size and Result.count > 2 then
				Result.keep_head (a_size - 2)
				Result.append ("..")
			end
		end

	adjusted_answer: STRING is
			-- Return input answer.
		do
			io.read_line
			Result := io.last_string.twin
			Result.left_adjust
			Result.right_adjust
		end

	confirmation_answer (m: STRING_GENERAL; lst: ARRAY [STRING]; a_default: STRING; a_caseless: BOOLEAN): STRING is
			-- Confirmation answer
		require
			a_default_in_lst: (a_default /= Void and lst /= Void)
						implies lst.there_exists (agent (s:STRING; d:STRING): BOOLEAN do Result := s.is_equal (d) end(?,a_default))
		local
			i: INTEGER
			l_is_valid: BOOLEAN
		do
			from
--				lst.there_exists (test: FUNCTION [ANY, TUPLE [G], BOOLEAN])
			until
				Result /= Void
			loop
				localized_print (m)
				if lst /= Void and then lst.count > 1 then
					io.put_string (" (")
					from
						i := lst.lower
					until
						i > lst.upper
					loop
						if (i > lst.lower) then
							io.put_character ('/')
						end
						io.put_string (lst[i])
						i := i + 1
					end
					io.put_string (") ")
					if a_default /= Void then
						io.put_character ('[')
						localized_print (a_default)
						io.put_string ("] ")
					end
				end
				Result := adjusted_answer
				if a_default /= Void and then Result.is_empty then
					Result := a_default
				elseif lst /= Void and then lst.count > 1 then
					from
						l_is_valid := False
						i := lst.lower
					until
						i > lst.upper or l_is_valid
					loop
						if a_caseless then
							l_is_valid := Result.is_case_insensitive_equal (lst[i])
						else
							l_is_valid := Result.is_equal (lst[i])
						end
						if l_is_valid then
							Result := lst[i]
						end
						i := i + 1
					end
					if not l_is_valid then
						Result := Void
					end
				end
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

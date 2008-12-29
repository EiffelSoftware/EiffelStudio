note
	description: "Object that manages freezing and finalizing c compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROCESS_MANAGER

inherit
	EB_SHARED_PREFERENCES

	EB_CONSTANTS

create
	make

feature{NONE} -- Initialization

	make (a_freezor, a_finalizor: EB_C_COMPILER_LAUNCHER; a_external: EB_EXTERNAL_LAUNCHER)
			-- Initialize using freezing launcher `freezor',
			-- finalizing launcher `finalizor' and external command launcher `a_external'.
		require
			a_freezor_not_void: a_freezor /= Void
			a_finalizor_not_void: a_finalizor /= Void
			a_external_not_void: a_external /= Void
		do
			freezor := a_freezor
			finalizor := a_finalizor
			externalor := a_external
		ensure
			freezor_set: freezor = a_freezor
			finalizor_set: finalizor = a_finalizor
			externalor_set: externalor = a_external
		end

feature -- Status reporting

	is_c_compilation_running: BOOLEAN
			-- Is either `freezor' or `finalizor' running, or both?
		do
			Result := freezor.is_running or finalizor.is_running
		end

	is_external_command_running: BOOLEAN
			-- Is external command running?
		do
			Result := externalor.is_running
		end

	is_process_running: BOOLEAN
			-- Is either `freezor', `finalizor' or `externalor' running, or all?
		do
			Result := is_c_compilation_running or is_external_command_running
		end

	is_freezing_running: BOOLEAN
			-- Is freezor running?
		do
			Result := freezor.is_running
		end

	is_finalizing_running: BOOLEAN
			-- Is finalizor running?
		do
			Result := finalizor.is_running
		end

feature -- Execution

	terminate_c_compilation
			-- Terminate running freezing or fianlizing.
		do
			if is_freezing_running then
				freezor.terminate
			end
			if is_finalizing_running then
				finalizor.terminate
			end
		ensure
			freezor_not_running: not is_freezing_running
			finalizor_not_running: not is_finalizing_running
		end

	terminate_finalizing
			-- Terminate running finalizing if any.
		do
			if is_finalizing_running then
				finalizor.terminate
			end
		ensure
			freezing_not_running: not is_freezing_running
		end

	terminate_freezing
			-- Terminate running freezing is any.
		do
			if is_freezing_running then
				freezor.terminate
			end
		ensure
			finalizing_not_running: not is_finalizing_running
		end

	terminate_external_command
			-- Terminate running external command if any.
		do
			if is_external_command_running then
				externalor.terminate
			end
		ensure
			external_command_not_running: not is_external_command_running
		end

	terminate_process
			-- Terminate running freezing, finalizing and external command if any.
		do
			terminate_c_compilation
			terminate_external_command
		end

	confirm_process_termination (ok_agent, no_agent: PROCEDURE [ANY, TUPLE]; a_window: EV_WINDOW)
			-- Confirm if user want to terminate running c compilation.
		require
			a_window_not_void: a_window /= Void
		local
			l_question: ES_DISCARDABLE_WARNING_PROMPT
		do
			if is_c_compilation_running then
				if is_freezing_running then
					create l_question.make_standard_with_cancel (warning_messages.w_freezing_running, interface_names.l_discard_terminate_freezing, preferences.dialog_data.confirm_on_terminate_freezing_string)
				elseif is_finalizing_running then
					create l_question.make_standard_with_cancel (warning_messages.w_finalizing_running, interface_names.l_discard_terminate_finalizing, preferences.dialog_data.confirm_on_terminate_finalizing_string)
				end
				if l_question /= Void then
					l_question.set_button_action (l_question.dialog_buttons.ok_button, ok_agent)
					l_question.show (a_window)
				end
			end
		end

	confirm_process_termination_for_quiting (ok_agent, no_agent: PROCEDURE [ANY, TUPLE]; a_window: EV_WINDOW)
			-- Confirm if user want to exit EiffelStudio when c compilation or external command is running.
		require
			a_window_not_void: a_window /= Void
		local
			l_question: ES_DISCARDABLE_WARNING_PROMPT
			l_output, l_discard_msg: STRING_GENERAL
		do
			if is_process_running then
				if is_c_compilation_running and is_external_command_running then
					l_output := interface_names.l_c_compilation_and_external_command_running
					l_discard_msg := interface_names.l_discard_cancel_c_compilation_and_external_command
				elseif is_c_compilation_running then
					l_output := interface_names.l_c_compilation_running
					l_discard_msg := interface_names.l_discard_cancel_c_compilation
				elseif is_external_command_running then
					l_output := interface_names.l_external_command_running
					l_discard_msg := interface_names.l_discard_terminate_external_command_when_exit
				end
				create l_question.make_standard_with_cancel (l_output, l_discard_msg, preferences.dialog_data.confirm_on_terminate_process_string)
				l_question.set_button_action (l_question.dialog_buttons.ok_button, ok_agent)
				l_question.show (a_window)
			end
		end

	confirm_external_command_termination (ok_agent, no_agent: PROCEDURE [ANY, TUPLE]; a_window: EV_WINDOW)
			-- Confirm running external command termination before destroy a development window.
		require
			a_window_not_void: a_window /= Void
		local
			l_question: ES_DISCARDABLE_QUESTION_PROMPT
		do
			if is_external_command_running then
				create l_question.make_standard (warning_messages.w_external_command_running_in_development_window, interface_names.l_discard_terminate_external_command, preferences.dialog_data.confirm_on_terminate_external_command_string)
				l_question.set_button_action (l_question.dialog_buttons.yes_button, ok_agent)
				l_question.show (a_window)
			end
		end

feature{NONE} -- Implementation

	freezor: EB_C_COMPILER_LAUNCHER
			-- Freezing launcher

	finalizor: EB_C_COMPILER_LAUNCHER
			-- Finalizing launcher

	externalor: EB_EXTERNAL_LAUNCHER

invariant

	freezor_not_void: freezor /= Void
	finalizor_not_void: finalizor /= Void
	externalor_not_void: externalor /= Void

note
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

indexing
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

	make (a_freezor, a_finalizor: EB_C_COMPILER_LAUNCHER; a_external: EB_EXTERNAL_LAUNCHER) is
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

	is_c_compilation_running: BOOLEAN is
			-- Is either `freezor' or `finalizor' running, or both?
		do
			Result := freezor.is_running or finalizor.is_running
		end

	is_external_command_running: BOOLEAN is
			-- Is external command running?
		do
			Result := externalor.is_running
		end

	is_process_running: BOOLEAN is
			-- Is either `freezor', `finalizor' or `externalor' running, or all?
		do
			Result := is_c_compilation_running or is_external_command_running
		end

	is_freezing_running: BOOLEAN is
			-- Is freezor running?
		do
			Result := freezor.is_running
		end

	is_finalizing_running: BOOLEAN is
			-- Is finalizor running?
		do
			Result := finalizor.is_running
		end

feature -- Execution

	terminate_c_compilation is
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

	terminate_finalizing is
			-- Terminate running finalizing if any.
		do
			if is_finalizing_running then
				finalizor.terminate
			end
		ensure
			freezing_not_running: not is_freezing_running
		end

	terminate_freezing is
			-- Terminate running freezing is any.
		do
			if is_freezing_running then
				freezor.terminate
			end
		ensure
			finalizing_not_running: not is_finalizing_running
		end

	terminate_external_command is
			-- Terminate running external command if any.
		do
			if is_external_command_running then
				externalor.terminate
			end
		ensure
			externalor_terminated: not is_external_command_running
		end


	terminate_process is
			-- Terminate running freezing, finalizing and external command if any.
		do
			terminate_c_compilation
			terminate_external_command
		end

	confirm_process_termination (ok_agent, no_agent: PROCEDURE [ANY, TUPLE]; a_window: EV_WINDOW) is
			-- Confirm if user want to terminate running c compilation.
		require
			a_window_not_void: a_window /= Void
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if is_c_compilation_running then
				if is_freezing_running then
					create cd.make_initialized (
						2, preferences.dialog_data.confirm_on_terminate_freezing_string,
						Warning_messages.w_Freezing_running, Interface_names.l_Discard_terminate_freezing,
						preferences.preferences)
				elseif is_finalizing_running then
					create cd.make_initialized (
						2, preferences.dialog_data.confirm_on_terminate_finalizing_string,
						Warning_messages.w_Finalizing_running, Interface_names.l_Discard_terminate_finalizing,
						preferences.preferences)
				end
				if cd /= Void then
					cd.set_ok_action (ok_agent)
					cd.show_modal_to_window (a_window)
				end
			end
		end

	confirm_process_termination_for_quiting (ok_agent, no_agent: PROCEDURE [ANY, TUPLE]; a_window: EV_WINDOW) is
			-- Confirm if user want to exit EiffelStudio when c compilation or external command is running.
		require
			a_window_not_void: a_window /= Void
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			l_output: STRING
			l_output2: STRING
			l_discard_msg: STRING
			l_cnt: INTEGER
			l_and_str: STRING
			l_link_verb: STRING
			l_sub_str: STRING
			l_comma_str: STRING

		do
			if is_process_running then
				l_cnt := 0
				if is_c_compilation_running then
					l_cnt := l_cnt + 1
				end
				if is_external_command_running then
					l_cnt := l_cnt + 1
				end
				if l_cnt = 2 then
					l_and_str := once "and "
					l_link_verb := once "are "
					l_sub_str := once "They need "
					l_comma_str := once ", "
				else
					l_and_str := ""
					l_link_verb := once "is "
					l_sub_str := once "It needs "
					l_comma_str := once ""
				end

				create l_output.make (100)
				if is_c_compilation_running then
					l_output.append (once "a C complication ")
				end
				l_output.append (l_and_str)
				if is_external_command_running then
					l_output.append (once "an external command ")
				end
				l_output.append (l_link_verb)
				l_output.append (once "currently running.%N")
				l_output.append (l_sub_str)
				l_output.append (once "to be terminated before EiffelStudio can exit.%N%N")

				create l_output2.make (100)
				if is_c_compilation_running then
					l_output2.append ("cancel C compilation")
				end
				l_output2.append (l_comma_str)
				if is_external_command_running then
					l_output2.append ("Terminate external command")
				end
				l_output2.append (once " and exit?%N")

				create l_discard_msg.make (100)
				l_discard_msg.append (once "Do not ask again, and always ")
				if is_c_compilation_running then
					l_discard_msg.append (once "cancel C compilation")
				end
				l_discard_msg.append (l_comma_str)

				if is_external_command_running then
					l_discard_msg.append (once "terminate external command")
				end
				l_discard_msg.append (" when exiting.")

				if l_output.item (1).is_lower then
					l_output.put (l_output.item (1).as_upper, 1)
				end
				if l_output2.item (1).is_lower then
					l_output2.put (l_output2.item (1).as_upper, 1)
				end
				l_output.append (l_output2)

				create cd.make_initialized (
					2, preferences.dialog_data.confirm_on_terminate_process_string,
					l_output, l_discard_msg,
					preferences.preferences)
				cd.set_ok_action (ok_agent)
				cd.show_modal_to_window (a_window)

			end
		end

	confirm_external_command_termination (ok_agent, no_agent: PROCEDURE [ANY, TUPLE]; a_window: EV_WINDOW) is
			-- Confirm running external command termination before destroy a development window.
		require
			a_window_not_void: a_window /= Void
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if is_external_command_running then
				create cd.make_initialized (
					2, preferences.dialog_data.confirm_on_terminate_external_command_string,
					Warning_messages.w_external_command_running_in_development_window,
					Interface_names.l_Discard_terminate_external_command,
					preferences.preferences)
					cd.set_ok_action (ok_agent)
					cd.show_modal_to_window (a_window)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

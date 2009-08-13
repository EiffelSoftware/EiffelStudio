note
	description: "[
		Evaluator controller which launches the evaluator as an external process.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_EVALUATOR_PROCESS_CONTROLLER

inherit
	ETEST_EVALUATOR_CONTROLLER

create
	make

feature {NONE} -- Access

	process: PROCESS
			-- Evaluator process
		require
			evaluator_launched: is_evaluator_launched
		local
			l_process: like internal_process
		do
			l_process := internal_process
			check l_process /= Void end
			Result := l_process
		end

	internal_process: detachable like PROCESS
			-- Storage for `process'

feature {NONE} -- Status report

	is_evaluator_launched: BOOLEAN
			-- <Precursor>
		do
			Result := internal_process /= Void
		ensure then
			result_implies_process_attached: Result implies internal_process /= Void
		end

	is_evaluator_running: BOOLEAN
			-- <Precursor>
		do
			Result := process.is_running
		end

feature {NONE} -- Status setting

	start_evaluator (a_argument: STRING)
			-- <Precursor>
		local
			l_project: E_PROJECT
			l_factory: PROCESS_FACTORY
			l_process: like process
			l_cmd: STRING
		do
			create l_factory
			create l_cmd.make (100)
			l_project := test_suite.project_access.project
			l_cmd.append_string (l_project.system.application_name (True))
			l_cmd.append_character (' ')
			l_cmd.append_string (a_argument)
			l_process := l_factory.process_launcher_with_command_line (l_cmd, l_project.lace.directory_name)

			l_process.enable_launch_in_new_process_group
			l_process.set_separate_console (False)
			l_process.set_hidden (True)

				--| Note: we do not really need input redirection, however on windows with a non console
				--|       application this is needed or the process will crash.
			l_process.redirect_input_to_stream
			l_process.redirect_output_to_agent (agent {STRING}.do_nothing)
			l_process.redirect_error_to_same_as_output

			l_process.launch
			internal_process := l_process
		end

	stop_evaluator
			-- <Precursor>
		local
			l_process: like process
		do
			l_process := process
			if l_process.launched and not l_process.force_terminated then
				l_process.terminate
				l_process.wait_for_exit
			end
			internal_process := Void
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

note
	description: "[
		Controller for evaluators running in separate process.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_BACKGROUND_EVALUATOR_CONTROLLER

inherit
	TEST_EVALUATOR_CONTROLLER
		rename
			make as make_controller
		end

	PLATFORM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_assigner: like assigner; a_executable: like executable)
			-- Initizialize `Current'
			--
			-- `a_assigner': Assigner for retrieving test to be executed.
		require
			a_executable_not_empty: not a_executable.is_empty
		do
			make_controller (a_assigner)
			executable := a_executable
		ensure
			executable_set: executable = a_executable
		end

feature {NONE} -- Access

	executable: attached STRING
			-- Name of executable for `process'

	process: detachable PROCESS
			-- Process

feature {NONE} -- Status report

	is_evaluator_running: BOOLEAN
			-- <Precursor>
		do
			Result := process.is_running
		end

feature -- Status setting

	terminate_evaluator
			-- <Precursor>
		do
			if process.launched and not process.force_terminated then
				process.terminate
				process.wait_for_exit
			end
		end

	launch_evaluator (a_args: attached LIST [attached STRING])
			-- <Precursor>
		do
			process := process_factory.process_launcher (executable, a_args, Void)

			process.enable_launch_in_new_process_group
			process.set_separate_console (False)
			process.set_hidden (True)

				--| Note: we do not really need input redirection, however on windows with a non console
				--|       application this is needed or the process will crash.
			process.redirect_input_to_stream
			process.redirect_output_to_agent (
				agent (a_string: STRING)
					do

					end)
			process.redirect_error_to_same_as_output

			process.launch
		end

feature {NONE} -- Implementation

	process_factory: PROCESS_FACTORY
			-- Factory for creating processes.
		once
			create Result
		end

invariant
	running_implies_process_attached: is_running implies
		(process /= Void and then process.launched)

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

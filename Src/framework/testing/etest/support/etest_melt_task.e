note
	description: "[
		Task witch tries to melt project.
		
		Task can be started even if compilation is already running. A second compilation is launched if
		a freeze occurred during the last compilation.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_MELT_TASK

inherit
	ROTA_TIMED_TASK_I

	DISPOSABLE_SAFE

create
	make

feature {NONE} -- Initialization

	make (a_etest_suite: like test_suite)
			-- Initialize `Current'.
		require
			a_etest_suite_attached: a_etest_suite /= Void
		do
			test_suite := a_etest_suite
		ensure
			test_suite_set: test_suite = a_etest_suite
		end

feature -- Access

	test_suite: ETEST_SUITE
			-- Test suite providing access to Eiffel project

	frozen project: E_PROJECT
			-- Project which is compiled by `Current'
		do
			Result := test_suite.project_access.project
		end

	sleep_time: NATURAL = 500
			-- <Precursor>

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>

	is_successful: BOOLEAN
			-- Was project successfully melted?

feature {NONE} -- Status report

	force_recompilation: BOOLEAN
			-- Should a compilation be launched by `Current'?

	compilation_requested: BOOLEAN
			-- Are we waiting for a compilation to start?

	launched_current_compilation: BOOLEAN
			-- Is current compilation launched by `Current'?

feature -- Status setting

	start (a_force: like force_recompilation)
			-- Start `Current'.
			--
			-- `a_force': If True, a compilation should be launched, even if one is currently running.
			--
			-- Note: if project is already compiling, `Current' will simply wait for it to finish and check
			--       if the result is valid.
		require
			not_running: not has_next_step
		do
			is_successful := False
			force_recompilation := a_force
			has_next_step := True
			compilation_requested := False
			launched_current_compilation := False

			launch_compilation
		end

	step
			-- <Precursor>
		local
			l_project: like project
		do
			if force_recompilation then
				launch_compilation
			elseif not compilation_requested then
				l_project := project
				if not l_project.is_compiling then
					has_next_step := False
					is_successful := l_project.successful
				end
			end
		end

	cancel
			-- <Precursor>
		do
			if launched_current_compilation then
				test_suite.project_helper.cancel_compilation
			end
			has_next_step := False
		end

feature {NONE} -- Implementation

	launch_compilation
			-- Try to launch a compilation.
		require
			running: has_next_step
			forcing: force_recompilation
		local
			l_helper: TEST_PROJECT_HELPER_I
		do
			l_helper := test_suite.project_helper
			if l_helper.can_compile then
				force_recompilation := False
				compilation_requested := True
				launched_current_compilation := True
				project.manager.compile_start_agents.extend_kamikaze (
					agent
						do
							compilation_requested := False
						end)
				l_helper.compile
			end
		end

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit and has_next_step then
				cancel
			end
		end

invariant
	successful_implies_not_running: is_successful implies not has_next_step
	not_force_and_requested: not (force_recompilation and compilation_requested)

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

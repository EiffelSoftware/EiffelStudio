indexing
	description: "[
		Executor running tests in separate processes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_BACKGROUND_EXECUTOR

inherit
	TEST_EXECUTOR
		redefine
			compile_project,
			evaluator_count,
			relaunch_evaluators
		end

	TEST_BACKGROUND_EXECUTOR_I
		undefine
			is_ready
		end

create
	make

feature -- Access

	evaluator_count: NATURAL = 4
			-- <Precursor>

feature {NONE} -- Status report

	relaunch_evaluators: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Status setting

	compile_project
			-- <Precursor>
		do
			Precursor
				-- TODO: copy wkbench executable to separate directory
		end

feature {NONE} -- Factory

	create_evaluator: !TEST_EVALUATOR_CONTROLLER
			-- <Precursor>
		local
			l_exec: !STRING
		do
				-- TODO: use temporary executable
			create l_exec.make_from_string (test_suite.eiffel_project.system.application_name (True))
			if {l_assigner: !like assigner} assigner then
				create {TEST_BACKGROUND_EVALUATOR_CONTROLLER} Result.make (l_assigner, l_exec)
			end
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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

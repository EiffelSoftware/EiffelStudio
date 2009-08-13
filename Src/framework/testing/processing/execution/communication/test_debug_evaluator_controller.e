note
	description: "[
		Controller for evaluators running in the debugger.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_DEBUG_EVALUATOR_CONTROLLER

inherit
	TEST_EVALUATOR_CONTROLLER
		rename
			make as make_controller
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_assigner: like assigner; a_project_helper: like project_helper)
			-- Initialize `Current'.
			--
			-- `a_assigner': Assigner for retrieving test to be executed.
			-- `a_project_helper': Helper object for launching debugger
		do
			make_controller (a_assigner)
			project_helper := a_project_helper
		end

feature {NONE} -- Access

	project_helper: TEST_PROJECT_HELPER_I
			-- Project containing tests to be debugged.

feature -- Status report

	is_evaluator_running: BOOLEAN
			-- <Precursor>
		do
			Result := debugger_manager.application_initialized and then
				debugger_manager.application.is_running
		end

feature -- Status setting

	terminate_evaluator
			-- <Precursor>
		do
			if is_evaluator_running then
				debugger_manager.application.kill
			end
		end

	launch_evaluator (a_args: LIST [STRING])
			-- <Precursor>
		local
			l_param: DEBUGGER_EXECUTION_PARAMETERS
			l_args: STRING
		do
			create l_param
			create l_args.make (50)
			from
				a_args.start
			until
				a_args.after
			loop
				l_args.append (a_args.item_for_iteration)
				l_args.append_character (' ')
				a_args.forth
			end
			l_param.set_arguments (l_args)

			project_helper.run (Void, l_args, Void)
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

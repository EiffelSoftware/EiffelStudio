note

	description:

		"Testing strategy for manually written unit tests"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_MANUAL_STRATEGY

inherit

	AUT_STRATEGY
		rename
			make as make_strategy
		redefine
			start
		end

create

	make

feature {NONE} -- Initialization

	make (a_test_cases: like test_cases; a_system: like system;
			an_interpreter: like interpreter; an_error_handler: like error_handler)
			-- Create new strategy.
		require
			a_test_cases_not_void: a_test_cases /= Void
			no_test_case_void: not a_test_cases.has (Void)
			a_system_not_void: a_system /= Void
			a_interpreter_not_void: an_interpreter /= Void
			an_error_handler_not_void: an_error_handler /= Void
		do
			test_cases := a_test_cases
			test_case_cursor := test_cases.new_cursor
			make_strategy (an_interpreter, a_system, an_error_handler)
		ensure
			test_cases_set: test_cases = a_test_cases
			system_set: system = a_system
			interpreter_set: interpreter = an_interpreter
			error_handler_set: error_handler = an_error_handler
		end

feature -- Status

	has_next_step: BOOLEAN
		do
			Result := not test_case_cursor.off
		end

feature -- Access

	test_cases: DS_LINEAR [CLASS_C]
			-- Test cases to execute

	selected_test_case: CLASS_C
			-- Currently selected test case;
			-- `Void' if none is selected.

feature -- Execution

	start
		do
			Precursor
			test_case_cursor.start
		end

	step
		local
			caller: AUT_MANUAL_TEST_CASE_CALLER
		do
			if sub_task = Void then
				selected_test_case := test_case_cursor.item
				create caller.make (selected_test_case, system, interpreter, error_handler)
				sub_task := caller
				sub_task.start
			else
				if sub_task.has_next_step and interpreter.is_running and interpreter.is_ready then
					sub_task.step
				else
					if interpreter.is_running and not interpreter.is_ready then
						interpreter.stop
					end
					if not interpreter.is_running then
						interpreter.start
					end
					sub_task := Void
					test_case_cursor.forth
				end
			end
		end

feature {NONE} -- Implementation

	sub_task: AUT_TASK
			-- Current sub task

	test_case_cursor: DS_LINEAR_CURSOR [CLASS_C]
			-- Cursor over selected test case

invariant

	test_cases_not_void: test_cases /= Void
	no_test_case_void: not test_cases.has (Void)
	test_case_cursor_not_void: test_case_cursor /= Void
	valid_test_case_cursor: test_case_cursor.container = test_cases
	error_handler_not_void: error_handler /= Void

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

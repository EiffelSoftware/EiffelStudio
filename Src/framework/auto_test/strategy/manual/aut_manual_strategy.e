indexing

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

	make (a_test_cases: like test_cases; a_universe: like universe;
			an_interpreter: like interpreter; an_error_handler: like error_handler) is
			-- Create new strategy.
		require
			a_test_cases_not_void: a_test_cases /= Void
			no_test_case_void: not a_test_cases.has (Void)
			a_universe_not_void: a_universe /= Void
			a_interpreter_not_void: an_interpreter /= Void
			an_error_handler_not_void: an_error_handler /= Void
		do
			test_cases := a_test_cases
			test_case_cursor := test_cases.new_cursor
			make_strategy (a_universe, an_interpreter)
			error_handler := an_error_handler
		ensure
			test_cases_set: test_cases = a_test_cases
			universe_set: universe = a_universe
			interpreter_set: interpreter = an_interpreter
			error_handler_set: error_handler = an_error_handler
		end

feature -- Status

	has_next_step: BOOLEAN is
		do
			Result := not test_case_cursor.off
		end

feature -- Access

	test_cases: DS_LINEAR [CLASS_C]
			-- Test cases to execute

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	selected_test_case: CLASS_C
			-- Currently selected test case;
			-- `Void' if none is selected.

feature -- Execution

	start is
		do
			Precursor
			test_case_cursor.start
		end

	step is
		local
			caller: AUT_MANUAL_TEST_CASE_CALLER
		do
			if sub_task = Void then
				selected_test_case := test_case_cursor.item
				create caller.make (selected_test_case, universe, interpreter, error_handler)
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

end

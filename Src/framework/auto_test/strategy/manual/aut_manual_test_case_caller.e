indexing

	description:

		"Objects that instruct interpreter to call features of a given manual unit test case"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_MANUAL_TEST_CASE_CALLER

inherit

	AUT_TASK

	AUT_SHARED_RANDOM
		export {NONE} all end

	ERL_G_TYPE_ROUTINES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_test_case: CLASS_C; a_universe: like universe; an_interpreter: like interpreter;
			an_error_handler: like error_handler) is
			-- Create new test case caller.
		require
			a_test_case_not_void: a_test_case /= Void
			a_test_case_has_set_up: a_test_case.feature_named (set_up_procedure_name) /= Void
			a_universe_not_void: a_universe /= Void
			a_interpreter_not_void: an_interpreter /= Void
			an_error_handler_not_void: an_error_handler /= Void
		do
			test_case := a_test_case
			set_up_procedure := a_test_case.feature_named (set_up_procedure_name)
			tear_down_procedure := a_test_case.feature_named (tear_down_procedure_name)
			universe := a_universe
			interpreter := an_interpreter
			procedure_index := 1
			error_handler := an_error_handler
			create test_case_locator.make (a_universe)
		ensure
			test_case_set: test_case = a_test_case
			universe_set: universe = a_universe
			interpreter_set: interpreter = an_interpreter
			error_handler_set: error_handler = an_error_handler
		end

feature -- Status

	has_next_step: BOOLEAN is
			-- Is there a next step to execute?
		do
			Result := interpreter.is_running and interpreter.is_ready and not steps_completed
		end

feature -- Access

	test_case: CLASS_C
			-- Test case to exercise

	universe: SYSTEM_I
			-- System

	interpreter: AUT_INTERPRETER_PROXY
			-- Proxy to the interpreter used to execute call

	error_handler: AUT_ERROR_HANDLER
			-- Error handler

	set_up_procedure_name: STRING is "set_up"
			-- Name for procedure `set_up'

	tear_down_procedure_name: STRING is "tear_down"
			-- Name for procedure `set_up'

feature -- Execution

	start is
		do
			procedure_index := 1
			steps_completed := False
			test_case_variable := Void
			skip_non_test_routines
			test_case_variable := Void
		ensure then
			test_case_variable_void: test_case_variable = Void
		end

	step is
		do
			if procedure_index > test_case.feature_table.count then
				steps_completed := True
			elseif test_case_variable = Void then
				create_test_case
			else
				invoke_test_procedure
				procedure_index := procedure_index + 1
				skip_non_test_routines
			end
		end

	cancel is
		do
			steps_completed := True
		end

feature {NONE} -- Implementation

	steps_completed: BOOLEAN
			-- Should there be no more steps for reasons other than a bad interpeter?

	procedure_index: INTEGER
			-- Index of current procedure from `test_case'

	procedure: FEATURE_I is
			-- Procedure indexed by `procedure_index'
		require
			procedure_index <= test_case.feature_table.count
		local
			l_feat_table: FEATURE_TABLE
			i: INTEGER
		do
			l_feat_table := test_case.feature_table
			from
				l_feat_table.start
				i := 1
			until
				i = procedure_index
			loop
				i := i + 1
				l_feat_table.forth
			end
			Result := l_feat_table.item_for_iteration
		end

	set_up_procedure: FEATURE_I
			-- Setup procedure of test case

	tear_down_procedure: FEATURE_I
			-- Tear down procedure of test case

	test_case_variable: ITP_VARIABLE
			-- Variable in interpreter referencing the test case object;
			-- Void if not yet created.

feature {NONE} -- Steps

	create_test_case is
			-- Create an object of type `test_case' and make it available via variable
			-- `test_case_variable'. If creation should fail, abort task.
		require
			interpreter_is_ready: interpreter.is_ready
		do
			test_case_variable := interpreter.new_variable
			interpreter.create_object_default (test_case_variable, test_case.actual_type)
			if not interpreter.is_variable_defined (test_case_variable) then
				test_case_variable := Void
				steps_completed := True
			end
		ensure
			canceled_or_created: steps_completed xor test_case_variable /= Void
		end

	invoke_test_procedure is
			-- Invoke `set_up', `procedure' and `tear_down'.
		require
			test_case_variable_not_void: test_case_variable /= Void
			interpreter_is_ready: interpreter.is_ready
		local
			arguments: DS_LINKED_LIST [ITP_EXPRESSION]
		do
			error_handler.report_feature_selection (test_case.actual_type, procedure)
			create arguments.make
			interpreter.invoke_feature (set_up_procedure, test_case_variable, arguments)
			if interpreter.is_ready then
				interpreter.invoke_feature (procedure, test_case_variable, arguments)
				if interpreter.is_ready then
					interpreter.invoke_feature (tear_down_procedure, test_case_variable, arguments)
				end
			end
		end

feature {NONE} -- Implementation

	skip_non_test_routines is
			-- Increment `procedure_index' until it indexes a test procedure.
			-- (See `test_case_locator.is_test_procedure' for a defintion of what constitutes a
			-- test procedure.)
		local
			l_feat_table: FEATURE_TABLE
			i: INTEGER
			l_feat_count: INTEGER
		do
			l_feat_table := test_case.feature_table
			l_feat_count := l_feat_table.count
			from
				i := 1
				l_feat_table.start
			until
				i = procedure_index
			loop
				l_feat_table.forth
				i := i + 1
			end

			from
			until
				procedure_index > l_feat_count or else test_case_locator.is_test_procedure (procedure)
			loop
				procedure_index := procedure_index + 1
			end
		end

	test_case_locator: AUT_MANUAL_TEST_CASE_LOCATOR
			-- Locator for manual unit test cases

invariant

	test_case_not_void: test_case /= Void
	set_up_procedure_not_void: set_up_procedure /= Void
	tear_down_procedure_not_void: tear_down_procedure /= Void
	universe_not_void: universe /= Void
	interpreter_not_void: interpreter /= Void
	procedure_index_large_enough: procedure_index >= 1
	procedure_index_small_enough_1: procedure_index <= test_case.feature_table.count + 1
	error_handler_not_void: error_handler /= Void
	test_case_locator_not_void: test_case_locator /= Void

end

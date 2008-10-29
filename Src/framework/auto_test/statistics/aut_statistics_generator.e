indexing

	description:

		"Abstract base class for statistics generators"

	copyright: "Copyright (c) 2007, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


deferred class AUT_STATISTICS_GENERATOR

feature {NONE} -- Initialization

	make (an_output_dirname: like output_dirname; a_system: like system; a_classes_under_test: like classes_under_test) is
			-- Create new html generator.
		require
			an_output_dirname_not_void: an_output_dirname /= Void
			a_system_not_void: a_system /= Void
			a_classes_under_test: a_classes_under_test /= Void
		local
			comparator: AUT_TEST_CASE_RESULT_PART_COMPARATOR
		do
--			create manual_test_case_locator.make (a_system)
			output_dirname := an_output_dirname
			system := a_system
			classes_under_test := a_classes_under_test
			create comparator.make
			create test_case_result_sorter.make (comparator)
		ensure
			output_dirname_set: output_dirname = an_output_dirname
			system_set: system = a_system
			classes_under_test_set: classes_under_test = a_classes_under_test
		end

feature -- Status report

	has_fatal_error: BOOLEAN
			-- Has a fatal error occured during generation?

feature -- Access

	output_dirname: STRING
			-- Directory where output is to be generated to

	system: SYSTEM_I
			-- System

	absolute_index_filename: STRING is
			-- Absolute filename of main entry page
		deferred
		ensure
			filename_not_void: Result /= Void
		end

feature -- Generation

	generate (a_repository: AUT_TEST_CASE_RESULT_REPOSITORY) is
			-- Generate HTML pages describing the results from `a_repository'.
		require
			a_repository_not_void: a_repository /= Void
		deferred
		end

feature {NONE} -- Test Scope

	is_class_in_test_scope (a_class: CLASS_C): BOOLEAN is
			-- Is class `a_class' in the test scope?
		require
			a_class_not_void: a_class /= Void
		do
			Result := classes_under_test.has (a_class)
		end

	is_manual_test_class (a_class: CLASS_C): BOOLEAN is
			-- Is class `a_class' a manual test class?
		require
			a_class_not_void: a_class /= Void
		do
--			Result := manual_test_case_locator.is_test_case_class (a_class)
		end

--	is_manual_test_procedure (a_procedure: FEATURE_I): BOOLEAN is
--			-- Is procedure `a_procedure' a manual test procedure?
--		require
--			a_procedure_not_void: a_procedure /= Void
--		do
--			Result := manual_test_case_locator.is_test_procedure (a_procedure)
--		end

	classes_under_test: DS_LINEAR [CLASS_C]
			-- List of classes under test

	manual_test_case_locator: AUT_MANUAL_TEST_CASE_LOCATOR
			-- Manual test case locator

feature {NONE} -- Implementation

	test_case_result_sorter: DS_HEAP_SORTER [AUT_TEST_CASE_RESULT]
			-- Sorter for test case results

invariant

	output_dirname_not_void: output_dirname /= Void
	system_not_void: system /= Void
	classes_under_test_not_void: classes_under_test /= Void
--	manual_test_case_locator_not_void: manual_test_case_locator /= Void
	test_case_result_sorter_not_void: test_case_result_sorter /= Void

end

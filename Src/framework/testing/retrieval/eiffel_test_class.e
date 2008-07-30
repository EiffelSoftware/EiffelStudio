indexing
	description: "[
		Objects representing classes containing tests associated with the corresponding eiffel class.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_CLASS

inherit
	KL_SHARED_STRING_EQUALITY_TESTER
		export
			{NONE} all
		end

create {EIFFEL_TEST_MANAGER_I}
	make

feature {NONE} -- Initialization

	make (a_class: like eiffel_class) is
			-- Initialize `Current'.
		do
			eiffel_class := a_class
			create internal_names.make_default
			internal_names.set_equality_tester ({!KL_EQUALITY_TESTER [!STRING]} #? string_equality_tester)
		end

feature -- Access

	eiffel_class: !EIFFEL_CLASS_I
			-- Class in system carrying tests

	frozen test_routine_names: !DS_LINEAR [!STRING]
			-- Names of test routines defined in `eiffel_class'.
		do
			Result := internal_names
		ensure
			results_not_empty: not Result.there_exists (agent {!STRING}.is_empty)
			correct_equality_tester: Result.equality_tester = string_equality_tester
		end

feature {EIFFEL_TEST_MANAGER_I} -- Access

	internal_names: !DS_HASH_SET [!STRING]
			-- Internal storage for `test_routine_names'

end

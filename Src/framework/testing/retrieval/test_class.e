indexing
	description: "[
		Objects representing classes containing tests associated with the corresponding eiffel class.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CLASS

inherit
	ANY

create {TEST_PROJECT_I}
	make

feature {NONE} -- Initialization

	make (a_class: like eiffel_class) is
			-- Initialize `Current'.
		local
			l_classname, l_filename: !STRING
		do
			eiffel_class := a_class
			create l_classname.make_from_string (eiffel_class.name)
			create l_filename.make_from_string (eiffel_class.file_name)
			create identifier.make (l_classname.count + l_filename.count)
			identifier.append (l_classname)
			identifier.append (l_filename)
			create internal_names.make_default
			internal_names.set_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [!STRING]})
		end

feature -- Access

	eiffel_class: !EIFFEL_CLASS_I
			-- Class in system carrying tests

	identifier: !STRING
			-- Unique identifier for `eiffel_class'

	frozen test_routine_names: !DS_LINEAR [!STRING]
			-- Names of test routines defined in `eiffel_class'.
		do
			Result := internal_names
		ensure
			results_not_empty: not Result.there_exists (agent {!STRING}.is_empty)
			correct_equality_tester: {l_tester: KL_STRING_EQUALITY_TESTER_A [!STRING]} Result.equality_tester /= Void
		end

feature {TEST_PROJECT_I} -- Access

	internal_names: !DS_HASH_SET [!STRING]
			-- Internal storage for `test_routine_names'

end

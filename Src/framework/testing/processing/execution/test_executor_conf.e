indexing
	description: "[
		Simple implementation of {TEST_EXECUTOR_CONF_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXECUTOR_CONF

inherit
	TEST_EXECUTOR_CONF_I

create
	make, make_with_tests

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			internal_tests := Void
			create sorter_prefix.make_empty
		end

	make_with_tests (a_list: like tests)
			-- Initialize `Current' with specific tests.
		do
			create internal_tests.make_from_linear (a_list)
			create sorter_prefix.make_empty
		end

feature -- Access

	tests: !DS_LINEAR [!TEST_I]
			-- <Precursor>
		local
			l_tests: like internal_tests
		do
			l_tests := internal_tests
			check l_tests /= Void end
			Result := l_tests
		end

	sorter_prefix: !STRING
			-- <Precursor>

feature {NONE} -- Access

	internal_tests: ?DS_ARRAYED_LIST [!TEST_I]
			-- Internal storage for `tests'

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_specific: BOOLEAN
			-- <Precursor>
		do
			Result := internal_tests /= Void
		end

feature -- Status setting

	set_sorter_prefix (a_prefix: like sorter_prefix)
			--  Set `sorter_prefix' to `a_prefix'.
		require
			a_prefix_valid: (create {TAG_UTILITIES}).is_valid_tag (a_prefix)
		do
			create sorter_prefix.make_from_string (a_prefix)
		end

end

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
		end

	make_with_tests (a_list: !DS_LINEAR [!TEST_I])
			-- Initialize `Current' with specific tests.
		do
			create internal_tests.make_from_linear (a_list)
		end

feature -- Access

	tests: !DS_LINEAR [!TEST_I]
			-- <Precursor>
		do
			Result := internal_tests.as_attached
		end

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

end

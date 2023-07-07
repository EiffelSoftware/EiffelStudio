note
	description: "Summary description for {TEST_REMAP_TABLES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_REMAP_TABLES

feature -- Tests

	test_build_tables
		local
			l_mock: MD_TABLE_MOCK
			l_typedef: MD_TABLE
			l_field: MD_TABLE
		do
			create l_mock
			l_typedef := l_mock.build_typedef_fields_unsorted_case1
			l_field := l_mock.build_field_list_type_def_case1

			l_mock.print_type_def_table (l_typedef)
			l_mock.print_field_def_table (l_field)
		end

end


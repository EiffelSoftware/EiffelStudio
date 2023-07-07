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
			io.put_new_line
			l_mock.print_field_def_table (l_field)
			io.put_new_line
		end

	test_remap_case1
		local
			l_mock: MD_TABLE_MOCK
			l_typedef: MD_TABLE
			l_field: MD_TABLE
			md: MD_EMIT
			mdu: MD_TABLE_UTILITIES
		do
			create l_mock
			l_typedef := l_mock.build_typedef_fields_unsorted_case1
			l_field := l_mock.build_field_list_type_def_case1
			create md.make
			md.tables.put (l_typedef, {PE_TABLES}.ttypedef.to_integer_32)
			md.tables.put (l_field,   {PE_TABLES}.tfield.to_integer_32)

			create mdu.make (md)
			mdu.ensure_field_list_column_is_ordered

			l_mock.print_type_def_table (md.md_table ({PE_TABLES}.ttypedef))
			io.put_new_line
			l_mock.print_field_def_table (md.md_table ({PE_TABLES}.tfield))
			io.put_new_line
		end


	test_remap_case2
		local
			l_mock: MD_TABLE_MOCK
			l_typedef: MD_TABLE
			l_field: MD_TABLE
			md: MD_EMIT
			mdu: MD_TABLE_UTILITIES
		do
			create l_mock
			l_typedef := l_mock.build_typedef_fields_unsorted_case2
			l_field := l_mock.build_field_list_type_def_case2
			create md.make
			md.tables.put (l_typedef, {PE_TABLES}.ttypedef.to_integer_32)
			md.tables.put (l_field,   {PE_TABLES}.tfield.to_integer_32)

			create mdu.make (md)
			mdu.ensure_field_list_column_is_ordered

			l_mock.print_type_def_table (md.md_table ({PE_TABLES}.ttypedef))
			io.put_new_line
			l_mock.print_field_def_table (md.md_table ({PE_TABLES}.tfield))
			io.put_new_line
		end

	test_remap_case3
		local
			l_mock: MD_TABLE_MOCK
			l_typedef: MD_TABLE
			l_field: MD_TABLE
			md: MD_EMIT
			mdu: MD_TABLE_UTILITIES
		do
			create l_mock
			l_typedef := l_mock.build_typedef_fields_unsorted_case3
			l_field := l_mock.build_field_list_type_def_case3
			create md.make
			md.tables.put (l_typedef, {PE_TABLES}.ttypedef.to_integer_32)
			md.tables.put (l_field,   {PE_TABLES}.tfield.to_integer_32)

			create mdu.make (md)
			mdu.ensure_field_list_column_is_ordered

			l_mock.print_type_def_table (md.md_table ({PE_TABLES}.ttypedef))
			io.put_new_line
			l_mock.print_field_def_table (md.md_table ({PE_TABLES}.tfield))
			io.put_new_line
		end

	test_remap_case4
		local
			l_mock: MD_TABLE_MOCK
			l_typedef: MD_TABLE
			l_field: MD_TABLE
			md: MD_EMIT
			mdu: MD_TABLE_UTILITIES
		do
			create l_mock
			l_typedef := l_mock.build_typedef_fields_unsorted_case4
			l_field := l_mock.build_field_list_type_def_case4
			create md.make
			md.tables.put (l_typedef, {PE_TABLES}.ttypedef.to_integer_32)
			md.tables.put (l_field,   {PE_TABLES}.tfield.to_integer_32)

			create mdu.make (md)
			mdu.ensure_field_list_column_is_ordered

			l_mock.print_type_def_table (md.md_table ({PE_TABLES}.ttypedef))
			io.put_new_line
			l_mock.print_field_def_table (md.md_table ({PE_TABLES}.tfield))
			io.put_new_line
		end


end

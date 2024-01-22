note
	description: "Summary description for {TEST_REMAP_TABLES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_REMAP_TABLES

inherit
	TEST_I

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
			l_expected_typedef: MD_TABLE
			l_expected_field: MD_TABLE
		do
			create l_mock
			l_typedef := l_mock.build_typedef_fields_unsorted_case1
			l_field := l_mock.build_field_list_type_def_case1
			md := new_emitter
			md.tables.put (l_typedef, {PE_TABLES}.ttypedef.to_integer_32)
			md.tables.put (l_field,   {PE_TABLES}.tfield.to_integer_32)

			create mdu.make (md, Void)
			mdu.ensure_field_list_column_is_ordered (False)
			mdu.update_index_list_in_tables


			l_mock.print_type_def_table (md.md_table ({PE_TABLES}.ttypedef))
			io.put_new_line
			l_mock.print_field_def_table (md.md_table ({PE_TABLES}.tfield))
			io.put_new_line

			l_expected_typedef := l_mock.build_expected_field_list_type_def_case1
			l_expected_field   := l_mock.build_expected_field_table_case1

			check expected_type_def_same_items: assert_type_def_same_items (l_typedef, l_expected_typedef, agent (e: PE_TYPE_DEF_TABLE_ENTRY): PE_LIST do Result := e.fields end) = True end
			check expected_field_same_items: assert_field_same_items (l_field, l_expected_field, agent (e: PE_FIELD_TABLE_ENTRY): TUPLE[flags: INTEGER_32; name_index: NATURAL_32] do create Result; Result.flags := e.flags; Result.name_index := e.name_index.index end) = True end

		end


	test_remap_case2
		local
			l_mock: MD_TABLE_MOCK
			l_typedef: MD_TABLE
			l_field: MD_TABLE
			md: MD_EMIT
			mdu: MD_TABLE_UTILITIES
			l_expected_typedef: MD_TABLE
			l_expected_field: MD_TABLE
		do
			create l_mock
			l_typedef := l_mock.build_typedef_fields_unsorted_case2
			l_field := l_mock.build_field_list_type_def_case2
			md := new_emitter
			md.tables.put (l_typedef, {PE_TABLES}.ttypedef.to_integer_32)
			md.tables.put (l_field,   {PE_TABLES}.tfield.to_integer_32)

			create mdu.make (md, Void)
			mdu.ensure_field_list_column_is_ordered (False)
			mdu.update_index_list_in_tables

			l_mock.print_type_def_table (md.md_table ({PE_TABLES}.ttypedef))
			io.put_new_line
			l_mock.print_field_def_table (md.md_table ({PE_TABLES}.tfield))
			io.put_new_line

			l_expected_typedef := l_mock.build_expected_typedef_fields_case2
			l_expected_field   := l_mock.build_expected_field_list_case2

			check expected_type_def_same_items: assert_type_def_same_items (l_typedef, l_expected_typedef, agent (e: PE_TYPE_DEF_TABLE_ENTRY): PE_LIST do Result := e.fields end) = True end
			check expected_field_same_items: assert_field_same_items (l_field, l_expected_field, agent (e: PE_FIELD_TABLE_ENTRY): TUPLE[flags: INTEGER_32; name_index: NATURAL_32] do create Result; Result.flags := e.flags; Result.name_index := e.name_index.index end) = True end

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
			md := new_emitter
			md.tables.put (l_typedef, {PE_TABLES}.ttypedef.to_integer_32)
			md.tables.put (l_field,   {PE_TABLES}.tfield.to_integer_32)

			-- l_mock.print_type_def_table (md.md_table ({PE_TABLES}.ttypedef))
			-- io.put_new_line
			-- l_mock.print_field_def_table (md.md_table ({PE_TABLES}.tfield))
			-- io.put_new_line


			create mdu.make (md, Void)
			mdu.ensure_field_list_column_is_ordered (False)
			mdu.update_index_list_in_tables

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
			md := new_emitter
			md.tables.put (l_typedef, {PE_TABLES}.ttypedef.to_integer_32)
			md.tables.put (l_field,   {PE_TABLES}.tfield.to_integer_32)

			create mdu.make (md, Void)
			mdu.ensure_field_list_column_is_ordered (False)
			mdu.update_index_list_in_tables

			l_mock.print_type_def_table (md.md_table ({PE_TABLES}.ttypedef))
			io.put_new_line
			l_mock.print_field_def_table (md.md_table ({PE_TABLES}.tfield))
			io.put_new_line
		end


	test_remap_case5
		local
			l_mock: MD_TABLE_MOCK
			l_typedef: MD_TABLE
			l_field: MD_TABLE
			md: MD_EMIT
			mdu: MD_TABLE_UTILITIES
		do
			create l_mock
			l_typedef := l_mock.build_typedef_fields_unsorted_case5
			l_field := l_mock.build_field_list_type_def_case5
			md := new_emitter
			md.tables.put (l_typedef, {PE_TABLES}.ttypedef.to_integer_32)
			md.tables.put (l_field,   {PE_TABLES}.tfield.to_integer_32)

			create mdu.make (md, Void)
			mdu.ensure_field_list_column_is_ordered (False)
			mdu.update_index_list_in_tables

			l_mock.print_type_def_table (md.md_table ({PE_TABLES}.ttypedef))
			io.put_new_line
			l_mock.print_field_def_table (md.md_table ({PE_TABLES}.tfield))
			io.put_new_line
		end

	assert_type_def_same_items (table_order: MD_TABLE; expected: MD_TABLE; a_value_for: FUNCTION [PE_TYPE_DEF_TABLE_ENTRY, PE_LIST]): BOOLEAN
		local
			i: NATURAL_32
		do
			if table_order.size /= expected.size then
			 	Result := False
			else
				from
					i := 1
					Result := True
				until
					i > table_order.size or else not Result
				loop
					if attached {PE_TYPE_DEF_TABLE_ENTRY} table_order[i] as l_result_entry  and then
					   attached {PE_TYPE_DEF_TABLE_ENTRY} expected[i] as l_exptected_entry  and then
					   attached {PE_LIST} a_value_for (l_result_entry) as l_res_index and then
					   attached {PE_LIST} a_value_for (l_exptected_entry) as l_exp_index and then
					   l_res_index.index = l_exp_index.index
					then
						-- Same values
					else
						Result := False
					end
					i := i + 1
				end
			end
		end


	assert_field_same_items (table_order: MD_TABLE; expected: MD_TABLE; a_value_for: FUNCTION [PE_FIELD_TABLE_ENTRY, TUPLE[flags: INTEGER_32; name_index: NATURAL_32]]): BOOLEAN
		local
			i: NATURAL_32
		do
			if table_order.size /= expected.size then
			 	Result := False
			else
				from
					i := 1
					Result := True
				until
					i > table_order.size or else not Result
				loop
					if attached {PE_FIELD_TABLE_ENTRY} table_order[i] as l_result_entry  and then
					   attached {PE_FIELD_TABLE_ENTRY} expected[i] as l_exptected_entry  and then
					   attached {TUPLE[flags: INTEGER_32; name_index: NATURAL_32]} a_value_for (l_result_entry) as l_res_index and then
					   attached {TUPLE[flags: INTEGER_32; name_index: NATURAL_32]} a_value_for (l_exptected_entry) as l_exp_index and then
					   l_res_index.flags = l_exp_index.flags and then
					   l_res_index.name_index = l_exp_index.name_index

					then
						-- Same values
					else
						Result := False
					end
					i := i + 1
				end
			end
		end
end

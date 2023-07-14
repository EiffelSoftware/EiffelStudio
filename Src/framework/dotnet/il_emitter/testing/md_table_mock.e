note
	description: "Summary description for {MD_TABLE_MOCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TABLE_MOCK

feature -- Table Helpers Case1

	build_typedef_fields_unsorted_case1: MD_TABLE
			-- #  |Flags|Name|Namespace|Extends|FieldList|MethodList
			--  1 |  -  | -  | -       |   -   |    1    |     -
			--  2 |  -  | -  | -       |   -   |    1    |     -
			--  3 |  -  | -  | -       |   -   |    1    |     -
			--  4 |  -  | -  | -       |   -   |    1    |     -
			--  5 |  -  | -  | -       |   -   |    8(1) |     -
			--  6 |  -  | -  | -       |   -   |    2(6) |     -
			--  7 |  -  | -  | -       |   -   |    9    |     -
			--  8 |  -  | -  | -       |   -   |    9    |     -
		do
			create Result.make ({PE_TABLES}.ttypedef)
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (8))
			Result.force (type_def_table_factory (2))
			Result.force (type_def_table_factory (9))
			Result.force (type_def_table_factory (9))
		end

	build_field_list_type_def_case1: MD_TABLE
			--	 #  |Flags  |Name   |Signature
			-- 	 1  | 4 	|10     |-
			-- 	 2  | 16    |11 	|-
			--   3  | 16    |12 	|-
			--	 4  | 16    |13 	|-
			--	 5  | 16    |14  	|-
			--	 6  | 16    |15     |-
			--	 7  | 16    |16     |-
			--	 8  | 4     |10     |-
		do
			create Result.make ({PE_TABLES}.tfield)
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (16, 11))
			Result.force (file_table_factory (16, 12))
			Result.force (file_table_factory (16, 13))
			Result.force (file_table_factory (16, 14))
			Result.force (file_table_factory (16, 15))
			Result.force (file_table_factory (16, 16))
			Result.force (file_table_factory (4, 10))
		end


	build_expected_field_list_type_def_case1: MD_TABLE
			-- #  |Flags|Name|Namespace|Extends|FieldList|MethodList
			--  1 |  -  | -  | -       |   -   |    1    |     -
			--  2 |  -  | -  | -       |   -   |    1    |     -
			--  3 |  -  | -  | -       |   -   |    1    |     -
			--  4 |  -  | -  | -       |   -   |    1    |     -
			--  5 |  -  | -  | -       |   -   |    2    |     -
			--  6 |  -  | -  | -       |   -   |    8    |     -
			--  7 |  -  | -  | -       |   -   |    9    |     -
			--  8 |  -  | -  | -       |   -   |    9    |     -
		do
			create Result.make ({PE_TABLES}.ttypedef)
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (2))
			Result.force (type_def_table_factory (3))
			Result.force (type_def_table_factory (9))
			Result.force (type_def_table_factory (9))
		end

	build_expected_field_table_case1: MD_TABLE
			--	 #  |Flags  |Name   |Signature
			-- 	 1  | 4 	|10     |-
			-- 	 2  | 16    |11 	|-
			--   3  | 16    |12 	|-
			--	 4  | 16    |13 	|-
			--	 5  | 16    |14  	|-
			--	 6  | 16    |15     |-
			--	 7  | 16    |16     |-
			--	 8  | 4     |10     |-
		do
			create Result.make ({PE_TABLES}.tfield)
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (16, 11))
			Result.force (file_table_factory (16, 12))
			Result.force (file_table_factory (16, 13))
			Result.force (file_table_factory (16, 14))
			Result.force (file_table_factory (16, 15))
			Result.force (file_table_factory (16, 16))

		end



feature -- Table Helpers Case2

	build_typedef_fields_unsorted_case2: MD_TABLE
			--	     |Flags|Name|Namespace|Extends|FieldList|MethodList
			--	1    | -   | -  | -       | -     | 3       | -
			--	2    | -   | -  | -       | -     | 1       | -
			--	3    | -   | -  | -       | -     | 2       | -
			--	4    | -   | -  | -       | -     | 4       | -
			--	5    | -   | -  | -       | -     | 4       | -		
		do
			create Result.make ({PE_TABLES}.ttypedef)
			Result.force (type_def_table_factory (3))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (2))
			Result.force (type_def_table_factory (4))
			Result.force (type_def_table_factory (4))
		end

	build_field_list_type_def_case2: MD_TABLE
		  -- #| Flags| Name| Signature
		  -- 1|  4   | 10  |-
	  	  -- 2| 16   | 11  |-
	      -- 3| 16   | 12  |-
	      -- 4|  4   | 10  |-
		do
			create Result.make ({PE_TABLES}.tfield)
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (16, 11))
			Result.force (file_table_factory (16, 12))
			Result.force (file_table_factory (4, 10))
		end


	build_expected_typedef_fields_case2: MD_TABLE
			--	     |Flags|Name|Namespace|Extends|FieldList|MethodList
			--	1    | -   | -  | -       | -     | 1       | -
			--	2    | -   | -  | -       | -     | 2       | -
			--	3    | -   | -  | -       | -     | 3       | -
			--	4    | -   | -  | -       | -     | 4       | -
			--	5    | -   | -  | -       | -     | 4       | -		
		do
			create Result.make ({PE_TABLES}.ttypedef)
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (2))
			Result.force (type_def_table_factory (3))
			Result.force (type_def_table_factory (4))
			Result.force (type_def_table_factory (4))
		end

	build_expected_field_list_case2: MD_TABLE
		  -- #| Flags| Name| Signature
		  -- 1| 16   | 12  |-
		  -- 2|  4   | 10  |-
	  	  -- 3| 16   | 11  |-
	      -- 4|  4   | 10  |-
		do
			create Result.make ({PE_TABLES}.tfield)
			Result.force (file_table_factory (16, 12))
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (16, 11))
			Result.force (file_table_factory (4, 10))
		end


feature -- Test Helper Case 3

	build_typedef_fields_unsorted_case3: MD_TABLE
			-- #  |Flags|Name|Namespace|Extends|FieldList|MethodList
			--  1 |  -  | -  | -       |   -   |    1    |     -
			--  2 |  -  | -  | -       |   -   |    1    |     -
			--  3 |  -  | -  | -       |   -   |    1    |     -
			--  4 |  -  | -  | -       |   -   |    1    |     -
			--  5 |  -  | -  | -       |   -   |    5 (3)|     -
			--  6 |  -  | -  | -       |   -   |    8 (1)|     -
			--  7 |  -  | -  | -       |   -   |    2 (3)|     -
			--  8 |  -  | -  | -       |   -   |    9    |     -
			--  9 |  -  | -  | -       |   -   |    9    |     -
		do
			create Result.make ({PE_TABLES}.ttypedef)
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (5))
			Result.force (type_def_table_factory (8))
			Result.force (type_def_table_factory (2))
			Result.force (type_def_table_factory (9))
			Result.force (type_def_table_factory (9))
		end




	build_field_list_type_def_case3: MD_TABLE
			--	 #  |Flags  |Name   |Signature
			-- 	 1  | 4 	|10     |-
			-- 	 2  | 16    |11 	|-
			--   3  | 16    |12 	|-
			--	 4  | 16    |13 	|-
			--	 5  | 16    |14  	|-
			--	 6  | 16    |15     |-
			--	 7  | 16    |16     |-
			--	 8  | 16    |17     |-
			--	 9  | 4     |10     |-
		do
			create Result.make ({PE_TABLES}.tfield)
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (16, 11))
			Result.force (file_table_factory (16, 12))
			Result.force (file_table_factory (16, 13))
			Result.force (file_table_factory (16, 14))
			Result.force (file_table_factory (16, 15))
			Result.force (file_table_factory (16, 16))
			Result.force (file_table_factory (16, 17))
			Result.force (file_table_factory (4, 10))
		end


feature -- Test Helper Case 4

	build_typedef_fields_unsorted_case4: MD_TABLE
			-- #  |Flags|Name|Namespace|Extends|FieldList|MethodList
			--  1 |  -  | -  | -       |   -   |    1    |     -
			--  2 |  -  | -  | -       |   -   |    1    |     -
			--  3 |  -  | -  | -       |   -   |    4 (2)|     -
			--  4 |  -  | -  | -       |   -   |    2 (1)|     -
			--  5 |  -  | -  | -       |   -   |    8 (2)|     -
			--  6 |  -  | -  | -       |   -   |    6 (2)|     -
			--  7 |  -  | -  | -       |   -   |    3 (1)|     -
			--  8 |  -  | -  | -       |   -   |    10   |     -
			--  9 |  -  | -  | -       |   -   |    10   |     -
		do
			create Result.make ({PE_TABLES}.ttypedef)
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (4))
			Result.force (type_def_table_factory (2))
			Result.force (type_def_table_factory (8))
			Result.force (type_def_table_factory (6))
			Result.force (type_def_table_factory (3))
			Result.force (type_def_table_factory (9))
			Result.force (type_def_table_factory (9))
		end


	build_field_list_type_def_case4: MD_TABLE
			--	 #  |Flags  |Name   |Signature
			-- 	 1  | 4 	|10     |-
			-- 	 2  | 16    |11 	|-
			--   3  | 16    |12 	|-
			--	 4  | 16    |13 	|-
			--	 5  | 16    |14  	|-
			--	 6  | 16    |15     |-
			--	 7  | 16    |16     |-
			--	 8  | 16    |17     |-
			--	 9  | 4     |10     |-
		do
			create Result.make ({PE_TABLES}.tfield)
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (16, 11))
			Result.force (file_table_factory (16, 12))
			Result.force (file_table_factory (16, 13))
			Result.force (file_table_factory (16, 14))
			Result.force (file_table_factory (16, 15))
			Result.force (file_table_factory (16, 16))
			Result.force (file_table_factory (16, 17))
			Result.force (file_table_factory (4, 10))
		end



feature -- Test Helper Case 5

	build_typedef_fields_unsorted_case5: MD_TABLE
			-- #  |Flags|Name|Namespace|Extends|FieldList|MethodList
			--  1 |  -  | -  | -       |   -   |    1    |     -
			--  2 |  -  | -  | -       |   -   |    1    |     -
			--  3 |  -  | -  | -       |   -   |    4 (1)|     -
			--  4 |  -  | -  | -       |   -   |    4 (1)|     -
			--  2 |  -  | -  | -       |   -   |    1 (3)|     -
			--  3 |  -  | -  | -       |   -   |    4 (0)|     -
			--  4 |  -  | -  | -       |   -   |    4 (0)|     -
			--  5 |  -  | -  | -       |   -   |    8 (2)|     -
			--  6 |  -  | -  | -       |   -   |    4 (0)|     -
			--  7 |  -  | -  | -       |   -   |    4 (0)|     -
			--  8 |  -  | -  | -       |   -   |    5 (3)|     -
			--  9 |  -  | -  | -       |   -   |    10   |     -
			-- 10 |  -  | -  | -       |   -   |    10   |     -
		do
			create Result.make ({PE_TABLES}.ttypedef)
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (0))
			Result.force (type_def_table_factory (0))
			Result.force (type_def_table_factory (8))
			Result.force (type_def_table_factory (0))
			Result.force (type_def_table_factory (0))
			Result.force (type_def_table_factory (5))
			Result.force (type_def_table_factory (10))
			Result.force (type_def_table_factory (10))
		end

	build_field_list_type_def_case5: MD_TABLE
			--	 #  |Flags  |Name   |Signature
			-- 	 1  | 4 	|10     |-
			-- 	 2  | 16    |11 	|-
			--   3  | 16    |12 	|-
			--	 4  | 16    |13 	|-
			--	 5  | 16    |14  	|-
			--	 6  | 16    |15     |-
			--	 7  | 16    |16     |-
			--	 8  | 16    |17     |-
			--	 9  | 16    |18     |-
			--	10  | 4     |10     |-
		do
			create Result.make ({PE_TABLES}.tfield)
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (16, 11))
			Result.force (file_table_factory (16, 12))
			Result.force (file_table_factory (16, 13))
			Result.force (file_table_factory (16, 14))
			Result.force (file_table_factory (16, 15))
			Result.force (file_table_factory (16, 16))
			Result.force (file_table_factory (16, 17))
			Result.force (file_table_factory (16, 18))
			Result.force (file_table_factory (4, 10))
		end

	build_expected_typedef_fields_case5: MD_TABLE
			-- #  |Flags|Name|Namespace|Extends|FieldList|MethodList
			--  1 |  -  | -  | -       |   -   |    1    |     -
			--  2 |  -  | -  | -       |   -   |    1    |     -
			--  3 |  -  | -  | -       |   -   |    0    |     -
			--  4 |  -  | -  | -       |   -   |    0    |     -
			--  5 |  -  | -  | -       |   -   |    5    |     -
			--  6 |  -  | -  | -       |   -   |    0    |     -
			--  7 |  -  | -  | -       |   -   |    0    |     -
			--  8 |  -  | -  | -       |   -   |    7    |     -
			--  9 |  -  | -  | -       |   -   |    10   |     -
			-- 10 |  -  | -  | -       |   -   |    10   |     -
		do
			create Result.make ({PE_TABLES}.ttypedef)
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (0))
			Result.force (type_def_table_factory (0))
			Result.force (type_def_table_factory (5))
			Result.force (type_def_table_factory (0))
			Result.force (type_def_table_factory (0))
			Result.force (type_def_table_factory (7))
			Result.force (type_def_table_factory (10))
			Result.force (type_def_table_factory (10))
		end

	build_expected_field_list_case5: MD_TABLE
			-- #  |  Flags |  Name  |Signature
			--  1 |    4   |   10   | -
			--  2 |   16   |   11   | -
			--  3 |   16   |   12   | -
			--  4 |   16   |   13   | -
			--  5 |   16   |   17   | -
			--  6 |   16   |   18   | -
			--  7 |   16   |   14   | -
			--  8 |   16   |   15   | -
			--  9 |   16   |   16   | -
			-- 10 |    4   |   10   | -
		do
			create Result.make ({PE_TABLES}.tfield)
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (16, 11))
			Result.force (file_table_factory (16, 12))
			Result.force (file_table_factory (16, 13))
			Result.force (file_table_factory (16, 17))
			Result.force (file_table_factory (16, 18))
			Result.force (file_table_factory (16, 14))
			Result.force (file_table_factory (16, 15))
			Result.force (file_table_factory (16, 16))
			Result.force (file_table_factory (4, 10))
		end

feature -- Test Helper Case 6

	build_typedef_fields_unsorted_case6: MD_TABLE
			-- #  |Flags|Name|Namespace|Extends|FieldList|MethodList
			--  1 |  -  | -  | -       |   -   |    1    |     -
			--  2 |  -  | -  | -       |   -   |    1    |     -
			--  3 |  -  | -  | -       |   -   |    1    |     -
			--  4 |  -  | -  | -       |   -   |    1    |     -
			--  5 |  -  | -  | -       |   -   |    5 (3)|     -
			--  6 |  -  | -  | -       |   -   |    8 (1)|     -
			--  7 |  -  | -  | -       |   -   |    9    |     -
			--  8 |  -  | -  | -       |   -   |    9    |     -
			--  9 |  -  | -  | -       |   -   |    2 (2)|     -
		do
			create Result.make ({PE_TABLES}.ttypedef)
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (1))
			Result.force (type_def_table_factory (5))
			Result.force (type_def_table_factory (8))
			Result.force (type_def_table_factory (9))
			Result.force (type_def_table_factory (9))
			Result.force (type_def_table_factory (2))
		end


	build_field_list_type_def_case6: MD_TABLE
			--	 #  |Flags  |Name   |Signature
			-- 	 1  | 4 	|10     |-
			-- 	 2  | 16    |11 	|-
			--   3  | 16    |12 	|-
			--	 4  | 16    |13 	|-
			--	 5  | 16    |14  	|-
			--	 6  | 16    |15     |-
			--	 7  | 16    |16     |-
			--	 8  | 16    |17     |-
			--	 9  | 4     |10     |-
		do
			create Result.make ({PE_TABLES}.tfield)
			Result.force (file_table_factory (4, 10))
			Result.force (file_table_factory (16, 11))
			Result.force (file_table_factory (16, 12))
			Result.force (file_table_factory (16, 13))
			Result.force (file_table_factory (16, 14))
			Result.force (file_table_factory (16, 15))
			Result.force (file_table_factory (16, 16))
			Result.force (file_table_factory (16, 17))
			Result.force (file_table_factory (4, 10))
		end


feature -- Print Helper

	print_type_def_table (a_table: MD_TABLE)
		local
			i: NATURAL
			format_field: FORMAT_INTEGER
			format_index: FORMAT_INTEGER
		do
			create format_field.make (9)
			format_field.center_justify

			create format_index.make (4)
			format_index.center_justify
			from
				i := 1
				io.put_string ("%N%NTable: TypeDef")
				io.put_string ("%N #  |Flags|Name|Namespace|Extends|FieldList|MethodList")

			until
				i > a_table.size
			loop
				if attached {PE_TYPE_DEF_TABLE_ENTRY} a_table.item (i) as entry then
					io.put_string ("%N" + format_index.formatted (i.to_integer_32) + "|  -  | -  | -       |   -   |" + format_field.formatted (entry.fields.index.to_integer_32) + "|     -     ")
				end
				i := i + 1
			end
		end

	print_field_def_table (a_table: MD_TABLE)
		local
			i: NATURAL
			format_field: FORMAT_INTEGER
			format_index: FORMAT_INTEGER
		do
			create format_field.make (8)
			format_field.center_justify

			create format_index.make (4)
			format_index.center_justify
			from
				i := 1
				io.put_string ("%N%NTable: Field")
				io.put_string ("%N #  |  Flags |  Name  |Signature")

			until
				i > a_table.size
			loop
				if attached {PE_FIELD_TABLE_ENTRY} a_table.item (i) as entry then
					io.put_string ("%N" + format_index.formatted (i.to_integer_32) + "|")
					io.put_string (format_field.formatted (entry.flags) + "|")
					io.put_string (format_field.formatted (entry.name_index.index.to_integer_32) + "|")
					io.put_string ( " - ")
				end
				i := i + 1
			end
		end

feature {NONE} -- Factory

	type_def_table_factory (a_field_index: NATURAL): PE_TYPE_DEF_TABLE_ENTRY
		do
			create Result.make_with_data (0, 0, 0, Void, a_field_index, 0)
		end

	file_table_factory (a_flags: INTEGER_32; a_name_index: NATURAL_32): PE_FIELD_TABLE_ENTRY
		do
			create Result.make_with_data (a_flags, a_name_index, 0)
		end

end




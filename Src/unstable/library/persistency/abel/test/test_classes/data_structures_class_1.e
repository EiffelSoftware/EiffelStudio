note
	description: "[
		Test objects for serialization, filled in with attributes of the following types:
		ARRAY [FLAT_CLASS_1], ARRAY2 [FLAT_CLASS_1], SPECIAL [FLAT_CLASS_1],
		ARRAYED_LIST [FLAT_CLASS_1], LINKED_LIST [FLAT_CLASS_1], 
		HASH_TABLE [FLAT_CLASS_1, STRING], TUPLE [FLAT_CLASS_1, INTEGER, STRING].
	]"
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_STRUCTURES_CLASS_1

inherit

	ANY
		redefine
			out
		end

create
	make

feature -- Initialization

	make
			-- Initialization for `Current'.
		local
			i: NATURAL
		do
			create array_1.make_filled (create {FLAT_CLASS_1}.make, 1, 10)
			create array_2.make_filled (create {FLAT_CLASS_1}.make, 5, 5)
			create array_3.make_filled (create {FLAT_CLASS_1}.make, 10)
			create arrayed_list_1.make_from_array (array_1)
			create linked_list_1.make
			from
				i := 1
			until
				i > 10
			loop
				linked_list_1.extend (create {FLAT_CLASS_1}.make)
				linked_list_1.forth
				i := i + 1
			end
--			create hash_table_1.make (10)
--			from
--				i := 1
--			until
--				i > 10
--			loop
--				create s.make_from_string ("key")
--				s.append_natural_32 (i)
--				hash_table_1.put (create {FLAT_CLASS_1}.make, s)
--				i := i + 1
--			end
--			create tuple_1.default_create
--			tuple_1.put (create {FLAT_CLASS_1}.make, 1)
--			tuple_1.put (2, 2)
--			tuple_1.put ("third", 3)
		ensure
			array_1_size_correct: array_1.count = 10
			array_2_size_correct: array_2.count = 25
			array_3.count = 10
			arrayed_list_1_size_correct: arrayed_list_1.count = 10
			linked_list_1_size_correct: linked_list_1.count = 10
--			hash_table_1_size_correct: hash_table_1.count = 10
--			tuple_1_size_correct: tuple_1.count = 3
		end

feature -- Access

	array_1: ARRAY [FLAT_CLASS_1]

	array_2: ARRAY2 [FLAT_CLASS_1]

	array_3: SPECIAL [FLAT_CLASS_1]

	arrayed_list_1: ARRAYED_LIST [FLAT_CLASS_1]

	linked_list_1: LINKED_LIST [FLAT_CLASS_1]

--	hash_table_1: HASH_TABLE [FLAT_CLASS_1, STRING]

--	tuple_1: TUPLE [FLAT_CLASS_1, INTEGER, STRING]

feature -- Status Report

	out: STRING
			-- Convenient STRING representation of Current.
		do
			Result := "Object of class " + Current.generating_type.name + " string representation:%N"
			Result.append ("array_1:%N " + array_1.out)
			Result.append ("array_2:%N " + array_2.out)
			Result.append ("arrayed_list_1:%N " + arrayed_list_1.out)
--			Result.append ("hash_table_1:%N " + hash_table_1.out)
--			Result.append ("tuple_1:%N " + tuple_1.out)
		end

end

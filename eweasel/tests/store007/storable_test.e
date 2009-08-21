indexing
	description: "Test object for storable"
	date: "$Date$"
	revision: "$Revision$"

class
	STORABLE_TEST

create
	make

feature {NONE} -- Initialization

	make is
		do
			create_basic_types
			create_tuples
			create_specials
			create_lists
		end

feature -- Basic types

	a: ANY

	i8: INTEGER_8
	i16: INTEGER_16
	i32: INTEGER
	i64: INTEGER_64

	n8: NATURAL_8
	n16: NATURAL_16
	n32: NATURAL_32
	n64: NATURAL_64

	p: POINTER

	r32: REAL
	r64: DOUBLE

	c: CHARACTER
	s: STRING

	create_basic_types is
		do
			i8 := -9
			i16 := -1245
			i32 := 65538
			i64 := 0x0000FFFF0000FFFF

			n8 := 1
			n16 := 0xFFFF
			n32 := 0xFFFFFFFF
			n64 := 0xFFFF0000FFFF0000

			p := default_pointer + 65

			r32 := {REAL_32} 4.5
			r64 := 6.5

			c := 'a'
			s := "I'm a nice string!!"
		end

feature -- Tuples

	t1: TUPLE
	t2: TUPLE [INTEGER]
	t3: TUPLE [INTEGER, CHARACTER, BOOLEAN]
	t4: TUPLE [REAL, DOUBLE]
	t5: TUPLE [STRING, NATURAL_8, NATURAL_16]
	t6: TUPLE [INTEGER_8, INTEGER_16, INTEGER, INTEGER_64, NATURAL_8, NATURAL_16, NATURAL_32, NATURAL_64]

	create_tuples is
		do
			t1 := []
			t2 := [5]
			t3 := [5, 's', True]
			t4 := [{REAL} 4.6, 6.5]
			t5 := ["TEST", {NATURAL_8} 9, {NATURAL_16} 16]
			t6 := [{INTEGER_8} 1, {INTEGER_16} 2, 3, {INTEGER_64} 4, {NATURAL_8} 5, {NATURAL_16} 6, {NATURAL_32} 7, {NATURAL_64} 8]
		end

feature -- Specials

	spec_i8: SPECIAL [INTEGER_8]
	spec_i16: SPECIAL [INTEGER_16]
	spec_i32: SPECIAL [INTEGER]
	spec_i64: SPECIAL [INTEGER_64]

	spec_n8: SPECIAL [NATURAL_8]
	spec_n16: SPECIAL [NATURAL_16]
	spec_n32: SPECIAL [NATURAL_32]
	spec_n64: SPECIAL [NATURAL_64]

	spec_p: SPECIAL [POINTER]

	spec_r32: SPECIAL [REAL]
	spec_r64: SPECIAL [DOUBLE]

	spec_c: SPECIAL [CHARACTER]
	spec_s: SPECIAL [STRING]
	spec_t: SPECIAL [TUPLE]

	create_specials is
		do
			create spec_i8.make_filled (0, 100)
			create spec_i16.make_filled (0, 100)
			create spec_i32.make_filled (0, 100)
			create spec_i64.make_filled (0, 100)
			create spec_n8.make_filled (0, 100)
			create spec_n16.make_filled (0, 100)
			create spec_n32.make_filled (0, 100)
			create spec_n64.make_filled (0, 100)
			create spec_r32.make_filled ({REAL_32} 0.0, 100)
			create spec_r64.make_filled (0.0, 100)
			create spec_p.make_filled (default_pointer, 100)
			create spec_c.make_filled ('%/000/', 100)

			create spec_s.make_filled (Void, 100)
			spec_s.put ("FDS", 10)
			create spec_t.make_filled (Void, 100)
			spec_t.put ([12, 23, 45, "Fds"], 90)
		end

feature -- Lists

	list_i8: LINKED_LIST [INTEGER_8]
	list_i16: LINKED_LIST [INTEGER_16]
	list_i32: LINKED_LIST [INTEGER]
	list_i64: LINKED_LIST [INTEGER_64]

	list_n8: LINKED_LIST [NATURAL_8]
	list_n16: LINKED_LIST [NATURAL_16]
	list_n32: LINKED_LIST [NATURAL_32]
	list_n64: LINKED_LIST [NATURAL_64]

	list_p: LINKED_LIST [POINTER]

	list_r32: LINKED_LIST [REAL]
	list_r64: LINKED_LIST [DOUBLE]

	list_c: LINKED_LIST [CHARACTER]
	list_s: LINKED_LIST [STRING]

	list_cell: LINKED_LIST [CELL [INTEGER]]

	lists: ARRAYED_LIST [like list_cell]

	create_lists is
		local
			i: INTEGER
		do
			create list_i8.make
			create list_i16.make
			create list_i32.make
			create list_i64.make
			create list_n8.make
			create list_n16.make
			create list_n32.make
			create list_n64.make
			create list_p.make
			create list_r32.make
			create list_r64.make
			create list_c.make
			create list_s.make
			list_s.extend ("FDs")
			list_s.extend ("FDs")

			list_cell := list

			from
				i := 1
				create lists.make (20)
			until
				i = 20
			loop
				lists.extend (list)
				i := i + 1
			end
		end

	list: LINKED_LIST [CELL [INTEGER]] is
			-- New big list of data
		local
			i: INTEGER
		do
			create Result.make
			from
				i := 1
			until
				i = 300
			loop
				Result.extend (create {CELL [INTEGER]}.put (i))
				Result.finish
				i := i + 1
			end
		end

end

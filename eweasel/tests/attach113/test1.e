class
	TEST1 [G -> HASHABLE]
inherit
	ANY
		redefine
			is_equal
		end

create
	make_empty,
	make_from_array

convert
	make_from_array ({ARRAY [TUPLE [G, INTEGER]]})

feature

	make_empty
			-- Initialize an empty integer array.
		do
			create table.make_equal(10)
		end

	make_from_array (a: ARRAY [TUPLE[x: G; y: INTEGER]])
			-- Initialize the integer array from the input 'a'.
		do
			create table.make_equal(10)
			across
				a as it
			loop
				extend (it.item.x, it.item.y)
			end
		end

	extend (x: G; y: INTEGER)
			-- Extend the integer array with input 'i'.
		do
			table.extend (x, y)
		end

	is_equal (other: like Current): BOOLEAN
			-- Two foo's are equal if their integer arrays are equal.
		do
			Result := table ~ other.table
		end

feature
	table : HASH_TABLE [G, INTEGER]

end

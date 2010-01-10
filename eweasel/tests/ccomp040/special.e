indexing

	description: "[
		Special objects: homogeneous sequences of values, 
		used to represent arrays and strings
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	SPECIAL [T]

create
	make,
	make_filled,
	make_empty

feature

	make_empty (i: INTEGER) is
		do
		end

	make (i: INTEGER) is
		do
		end

	make_filled (v: T; i: INTEGER) is
		do
		end

	put (v:T; i: INTEGER) is
		do
		end

	item (i: INTEGER): T is
		do
		end

	to_array: ARRAY [T] is
		do
		end

end -- class SPECIAL



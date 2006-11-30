indexing

	description: "[
		Sequences of characters, accessible through integer indices 
		in a contiguous range.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class STRING_8

inherit
	TO_SPECIAL [CHARACTER]

create
	make

feature

	make (i: INTEGER) is
		do
		end

	set_count (n: INTEGER) is
		do
		end
	
	count, internal_hash_code: INTEGER
end

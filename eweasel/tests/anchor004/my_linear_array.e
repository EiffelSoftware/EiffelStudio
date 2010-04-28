deferred class
	MY_LINEAR_ARRAY [G]

inherit
	MY_LINEAR_PROXY[G]
		rename
			linear_ as array_,
			item as current_item
		redefine
			array_
		end

feature -- Access

	valid_cursor (a_cursor : like cursor) : BOOLEAN is
		do
		end

	item, infix "@" (i: INTEGER): G is
		do
		end

feature {NONE} -- Implementation

	array_: MY_LINEAR_2[G]

	index_: INTEGER

	lower_: INTEGER

end

class
	TEST1 [G, H]

inherit
	TEST3 [H]

feature

	set_internal_cursor (c: like internal_cursor) is
		do
		end

	internal_cursor: like new_cursor

	new_cursor: TEST4 [G, H] is
		do
		end

end

class
	LINE

inherit
	LINKED_LIST [POINT]

creation
	make

feature -- Access

	width: INTEGER
			-- Width of the line

feature -- Element change

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'.
		require
			positive_width: a_width >= 0
		do
			width := a_width
		ensure
			width_set: width = a_width
		end

	add (x, y: INTEGER) is
			-- Add a point specified by `x' and `y'.
		local
			p: POINT
		do
			create p.make (x, y)
			extend (p)
		end

invariant
	positive_width: width >= 0

end -- class LINE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


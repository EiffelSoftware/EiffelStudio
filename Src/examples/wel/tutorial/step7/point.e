class
	POINT

creation
	make

feature -- Initialization

	make (a_x, a_y: INTEGER) is
			-- Make a point with `a_x' and `a_y'.
		do
			x := a_x
			y := a_y
		ensure
			x_set: x = a_x
			y_set: y = a_y
		end

feature -- Access

	x: INTEGER
			-- x position

	y: INTEGER
			-- y position

end -- class POINT

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

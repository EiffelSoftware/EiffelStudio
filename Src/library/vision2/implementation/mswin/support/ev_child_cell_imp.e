--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision child cell. Used only for windows%
		% implementation. This cell represant the space given%
		% to a child by the parent. Then, depending of its%
		% options, the child move or is resized in this cell."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHILD_CELL_IMP

feature -- Access

	x: INTEGER
		-- x coordinate of the top-left corner of the cell in
		-- the parent window.

	y: INTEGER
		-- y coordinate of the top-left corent of the cell in
		-- the parent window.

	width: INTEGER
		-- width of the current cell

	height: INTEGER
		-- height of the current cell

feature -- Status report

feature -- Element change

	set_x (value: INTEGER) is
			-- Make `value' the new x coordinate of the cell.
		do
			x := value
		end

	set_y (value: INTEGER) is
			-- Make `value' the new y coordinate of the cell.
		do
			x := value
		end

	move (a_x, a_y: INTEGER) is
			-- Change the x and the y coordinates of the cell.
		do
			x := a_x
			y := a_y
		end

	set_width (value: INTEGER) is
			-- Make `value' the new width of the cell.
		do
			width := value
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height of the cell.
		do
			height := value
		end

	resize (a_width, a_height: INTEGER) is
			-- Change the size of the cell.
		do
			width := a_width
			height := a_height
		end

end -- class EV_CHILD_CELL_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.8.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.4  2000/03/14 03:02:54  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.3.2.1  2000/03/09 19:15:55  brendel
--| Unreleased. We can use EV_RECTANGLE for this.
--|
--| Revision 1.3  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.2  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.2  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

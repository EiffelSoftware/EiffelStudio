indexing
	description:
		"Apearance of a screen pointer cursor, typically moved by a mouse."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR

inherit
	EV_PIXMAP
		redefine
			copy
		end

create
	default_create,
	make_with_size,
	make_for_test,
	make_with_pixmap

feature {NONE} -- Initialization

	make_with_pixmap (a_pixmap: EV_PIXMAP; a_x_hotspot, 
	a_y_hotspot: INTEGER) is
			-- Create a cursor initialized with `a_pixmap' as
			-- pixmap and `a_x_hotspot' & `a_y_hotspot' as 
			-- hotspot coordinates
		do
			default_create
			implementation.copy_pixmap (a_pixmap)
			set_x_hotspot (a_x_hotspot)
			set_y_hotspot (a_y_hotspot)
		end

feature -- Access

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot. 

	Y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot. 

feature -- Status setting

	set_x_hotspot (a_x_hotspot: INTEGER) is
			-- Set `x_hotspot' to `a_x_hotspot'.
		require
			valid_x_hotspot: a_x_hotspot >= 0 and a_x_hotspot < width
		do
			x_hotspot := a_x_hotspot
		ensure
			x_hotspot_set: x_hotspot = a_x_hotspot
		end

	set_y_hotspot (a_y_hotspot: INTEGER) is
			-- Set `y_hotspot' to `a_y_hotspot'.
		require
			valid_y_hotspot: a_y_hotspot >= 0 and a_y_hotspot < height
		do
			y_hotspot := a_y_hotspot
		ensure
			y_hotspot_set: y_hotspot = a_y_hotspot
		end

feature -- Duplication

	copy (other: EV_PIXMAP) is 
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_cursor: EV_CURSOR
		do
				-- Copy the "pixmap part"
			implementation.copy_pixmap(other)

				-- Copy the "cursor part"
			other_cursor ?= other
			if other_cursor /= Void then
					-- Retrieve the hotspot coordinates of `other'
				set_x_hotspot (other_cursor.x_hotspot)
				set_y_hotspot (other_cursor.y_hotspot)
			else
					-- Reset the hotspot coordinates to (0,0)
				set_x_hotspot (0)
				set_y_hotspot (0)
			end
		end

end -- class EV_CURSOR

--!-----------------------------------------------------------------------------
--! EiffelVision Library: Example for the ISE EiffelVision library.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/06/07 17:28:06  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.4.4.3  2000/05/05 22:26:15  pichery
--| Redefined `copy' feature to take into
--| account the hotspot.
--|
--| Revision 1.4.4.2  2000/05/04 04:17:07  pichery
--| Brand new EV_CURSOR class. It now a
--| simple pixmap with 2 attributes `x_hotspot'
--| and `y_hotspot'.
--|
--| Revision 1.4.4.1  2000/05/03 19:10:00  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/03/16 01:13:15  oconnor
--| comments
--|
--| Revision 1.7  2000/03/15 22:47:20  king
--| Implemented a make_with_pixmap creation procedure
--|
--| Revision 1.6  2000/02/22 18:39:48  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.12  2000/02/03 23:19:19  brendel
--| Added feature `set_code' and `code'.
--|
--| Revision 1.4.6.11  2000/02/03 22:51:15  rogers
--| Removed invariant, as it is possible for the pixmap to be Void.
--|
--| Revision 1.4.6.10  2000/01/29 01:22:42  brendel
--| Added make_with_code.
--|
--| Revision 1.4.6.9  2000/01/28 23:20:37  brendel
--| Revised. Now only has `pixmap' and `set_pixmap'.
--| Might be added later: set_code.
--|
--| Revision 1.4.6.8  2000/01/28 22:24:21  oconnor
--| released
--|
--| Revision 1.4.6.7  2000/01/27 19:30:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.6  2000/01/15 02:18:53  oconnor
--| formatting
--|
--| Revision 1.4.6.5  1999/12/09 19:03:00  oconnor
--| TEMPORARY: commented out make_with_filename
--|
--| Revision 1.4.6.4  1999/12/02 20:15:57  brendel
--| Commented out implementation.pixmap.
--|
--| Revision 1.4.6.3  1999/12/02 20:03:36  brendel
--| Added : BOOLEAN to `is_equal'.
--|
--| Revision 1.4.6.2  1999/12/02 19:20:08  oconnor
--| new access feature pixmap and is_equal
--|
--| Revision 1.4.6.1  1999/11/24 17:30:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.4  1999/11/04 23:10:53  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.4.2.3  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

indexing
	description: 
		"Displays two widgets side by side, seperated by an adjustable divider."
	apearance:
		"------------------------------%N%
		%|             ||             |%N%
		%|   `first'   ||   `second'  |%N%
		%|             ||             |%N%
		%------------------------------"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_HORIZONTAL_SPLIT_AREA

inherit
	EV_SPLIT_AREA
		redefine
			initialize
		end

create
	default_create,
	make_for_test

feature -- Initialization

	initialize is
			-- Create main box and separator.
		do
			create {EV_HORIZONTAL_BOX} split_box
			create {EV_VERTICAL_SEPARATOR} sep
			sep.set_pointer_style (Default_pixmaps.Sizewe_cursor)
			Precursor
		end

feature {NONE} -- Implementation

	select_from (a_hor, a_vert: INTEGER): INTEGER is
			-- Return `a_hor'.
			-- See `{EV_SPLIT_AREA}.select_from'.
		do
			Result := a_hor
		end

	set_first_cell_dimension (a_size: INTEGER) is
			-- Set width of first_cell.
		do
			first_cell.set_minimum_width (a_size)
		end

	set_second_cell_dimension (a_size: INTEGER) is
			-- Set width of second_cell.
		do
			second_cell.set_minimum_width (a_size)
		end
	
end -- class EV_HORIZONTAL_SPLIT_AREA

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--| Revision 1.20  2000/06/07 17:28:12  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.19  2000/05/03 21:44:10  brendel
--| Reverted to old version not using EV_FIXED.
--|
--| Revision 1.4.4.3  2000/05/05 23:39:39  brendel
--| Normal separator again.
--|
--| Revision 1.4.4.2  2000/05/05 22:16:52  brendel
--| Uses split mouse cursor.
--|
--| Revision 1.4.4.1  2000/05/03 19:10:08  oconnor
--| mergred from HEAD
--|
--| Revision 1.18  2000/05/02 22:01:21  brendel
--| Removed redundent features.
--|
--| Revision 1.17  2000/03/18 00:52:23  oconnor
--| formatting, layout and comment tweaks
--|
--| Revision 1.16  2000/03/17 23:50:03  oconnor
--| comments
--|
--| Revision 1.15  2000/03/06 19:51:52  brendel
--| Considerably reduced amount of implementation. Most of it could be moved
--| upwards into EV_SPLIT_AREA.
--| Implemented: select_from, set_first_cell_dimension,
--| set_second_cell_dimension.
--|
--| Revision 1.14  2000/03/04 03:13:22  brendel
--| witdth -> width
--|
--| Revision 1.13  2000/03/04 03:12:16  brendel
--| Implemented moving of separator, but cannot be made smaller after that, so
--| we need to find a solution.
--|
--| Revision 1.12  2000/03/04 00:17:33  brendel
--| Simplified implementation.
--|
--| Revision 1.11  2000/03/03 23:13:21  brendel
--| Fixed bug in moving of separator.
--|
--| Revision 1.9  2000/03/03 20:32:24  brendel
--| Fixed bug in initialize. Before, Precursor was not called.
--| Formatted for 80 columns.
--|
--| Revision 1.8  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.7  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/21 20:11:17  rogers
--| There is no longer an EV_HORIZONTAL_SPLIT_AREA_I, so moved the appropriate
--| implementation into this class.
--|
--| Revision 1.5  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.6  2000/01/28 20:00:13  oconnor
--| released
--|
--| Revision 1.4.6.5  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.4  2000/01/20 18:59:47  oconnor
--| formatting, comments
--|
--| Revision 1.4.6.3  2000/01/20 18:49:09  oconnor
--| reimplemented in line with new EV_SPLIT_AREA
--|
--| Revision 1.4.6.2  2000/01/19 22:16:12  king
--| First foundation of platform independent split area
--|
--| Revision 1.4.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

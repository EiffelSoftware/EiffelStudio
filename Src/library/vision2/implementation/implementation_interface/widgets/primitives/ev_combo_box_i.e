indexing 
	description: "EiffelVision Combo-box. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COMBO_BOX_I

inherit
	EV_TEXT_FIELD_I
		redefine
			interface
		end

	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end

feature -- Status report

	pixmaps_width: INTEGER
			-- Width of displayed pixmaps in `Current'.

	pixmaps_height: INTEGER
			-- Height of displayed pixmaps in `Current'.

feature -- Status setting

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of displayed pixmaps in the Multicolumn list
			-- `a_width' by `a_height'.
		do
			if pixmaps_width /= a_width or pixmaps_height /= a_height then
				pixmaps_width := a_width
				pixmaps_height := a_height
				pixmaps_size_changed
			end
		end

feature {NONE} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			-- Do nothing by default
		end

	initialize_pixmaps is
			-- Assign default sizes to pixmaps.
		do
			pixmaps_width := default_pixmaps_width
			pixmaps_height := default_pixmaps_height
		end

	default_pixmaps_width: INTEGER is 16
		-- Default width for pixmaps.

	default_pixmaps_height: INTEGER is 16
		-- Default height for pixmaps.

feature {EV_COMBO_BOX_I} -- Implementation

	interface: EV_COMBO_BOX

end -- class EV_COMBO_BOX_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.29  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.28  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.22.4.8  2000/10/27 02:28:21  manus
--| Removed declaration or undefinition of `set_default_colors'. Now it is defined
--| in a platform dependent manner to improve performance and correctness.
--|
--| Revision 1.22.4.7  2000/08/17 23:37:51  rogers
--| removed fixme not_Reviewed. Comments, formatting.
--|
--| Revision 1.22.4.6  2000/07/18 22:34:26  rogers
--| Renamed initialize to initialize_pixmaps. Added defaults for values.
--|
--| Revision 1.22.4.5  2000/07/18 17:35:19  rogers
--| Added initialize, which sets pixmaps_width and pixmaps_height.
--|
--| Revision 1.22.4.4  2000/07/18 17:24:34  rogers
--| Added pixmaps_width, pixmaps_height, set_pixmaps_size and pixmaps_size_changed.
--|
--| Revision 1.22.4.3  2000/06/20 01:00:05  manus
--| No more `extended_height' and `set_extended_height' because we will now display
--| the combobox the best possible way. Emulated on Windows, native on GTK.
--|
--| Revision 1.22.4.2  2000/05/10 18:50:37  king
--| Integrated ev_list_item_list
--|
--| Revision 1.22.4.1  2000/05/03 19:09:06  oconnor
--| mergred from HEAD
--|
--| Revision 1.26  2000/04/20 21:05:41  king
--| Removed redundant make_with_text
--|
--| Revision 1.25  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.24  2000/02/17 02:19:23  oconnor
--| released
--|
--| Revision 1.23  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.22.6.6  2000/01/27 19:30:03  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.22.6.5  2000/01/15 00:53:44  oconnor
--| renamed is_multiple_selection -> multiple_selection_enabled, set_multiple_selection -> enable_multiple_selection & set_single_selection -> disable_multiple_selection
--|
--| Revision 1.22.6.4  1999/12/09 03:15:06  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.22.6.3  1999/12/03 07:46:36  oconnor
--| removed  set_default_options
--|
--| Revision 1.22.6.2  1999/11/30 22:47:14  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.22.6.1  1999/11/24 17:30:11  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.22.2.3  1999/11/04 23:10:44  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.22.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

indexing
	description: "List of default colors used by the system.%
				% Mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_COLORS_IMP 

feature -- Access

	Color_dialog, Color_3d_face: EV_COLOR is
			-- Color usually used for the background of dialogs.
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id (Wel_color_constants.Color_btnface)
		end

	Color_3d_highlight: EV_COLOR is
			-- Used for 3D-effects (light color)
			-- Name "color highlight"
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id
				(Wel_color_constants.Color_btnhighlight)
		end

	Color_3d_shadow: EV_COLOR is
			-- Used for 3D-effects (dark color)
			-- Name "color shadow"
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id (Wel_color_constants.Color_btnshadow)
		end

	Color_read_only: EV_COLOR is
			-- Color usually used for the background of editable
			-- widgets when they are read_only.
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id
				(Wel_color_constants.Color_inactiveborder)
		end

	Color_read_write: EV_COLOR is
			-- Color usely used for the background of editable
			-- widgets when they are in read / write mode.
		do
			create Result.make_with_rgb (1, 1, 1)
		end

	default_background_color: EV_COLOR is
			-- Default background color for most widgets.
		do
			Result := Color_dialog
		end

	default_foreground_color: EV_COLOR is
			-- Default foreground color for most widgets.
		do
			create Result.make_with_rgb (0, 0, 0)
		end

feature {NONE} -- Constants

	wel_color_constants: WEL_COLOR_CONSTANTS is
		once
			create Result
		end

end -- class EV_STOCK_COLORS_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.11  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.10  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.8.4  2000/11/06 19:37:08  king
--| Accounted for default to stock name change
--|
--| Revision 1.4.8.3  2000/08/11 19:12:43  rogers
--| Fixed copyright clause. Now use ! instead of |. Formatting.
--|
--| Revision 1.4.8.2  2000/05/13 03:27:24  pichery
--| Added new colors, refactoring: replaced
--| inheritance with once.
--|
--| Revision 1.4.8.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/04/24 16:04:29  rogers
--| Improved comments.
--|
--| Revision 1.6  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.5  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.10.4  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.10.3  1999/12/17 17:14:54  rogers
--| Altered to fit in with the review branch. Alterations to comply with the
--| new colors.
--|
--| Revision 1.4.10.2  1999/12/17 17:07:14  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP.
--| ev_item_holder_imp.e
--|
--| Revision 1.4.10.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

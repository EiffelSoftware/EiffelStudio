--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "List of default colors used by the system.%
				% Mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DEFAULT_COLORS_IMP 

inherit
	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	Color_dialog: EV_COLOR is
			-- Color usely used for the background of dialogs
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id (Color_btnface)
		end

	Color_read_only: EV_COLOR is
			-- Color usely used for the background of editable
			-- when they are read_only
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id (Color_inactiveborder)
		end

	Color_read_write: EV_COLOR is
			-- Color usely used for the background of editable
			-- when they are in read / write mode
		do
			!! Result.make_with_rgb (1, 1, 1)
		end

	default_background_color: EV_COLOR is
			-- Default background color for most of the widgets.
		do
			Result := Color_dialog
		end

	default_foreground_color: EV_COLOR is
			-- Default foreground color for most of the widgets.
		do
			!! Result.make_with_rgb (0, 0, 0)
		end

end -- class EV_DEFAULT_COLORS_IMP

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
--| Revision 1.5  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.10.4  2000/01/27 19:30:14  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.10.3  1999/12/17 17:14:54  rogers
--| Altered to fit in with the review branch. Alterations to comply with the new colors.
--|
--| Revision 1.4.10.2  1999/12/17 17:07:14  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP. ev_item_holder_imp.e
--|
--| Revision 1.4.10.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

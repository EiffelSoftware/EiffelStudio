--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision print dialog, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_DIALOG_IMP

inherit
	EV_PRINT_DIALOG_I

	EV_STANDARD_DIALOG_IMP

	WEL_PRINT_DIALOG
		rename
			make as wel_make,
			maximum_page as maximum_range,
			set_maximum_page as set_maximum_range,
			set_parent as wel_set_parent
		redefine
			wel_make
		end

creation
	make

feature {NONE} -- Initialization

	wel_make is
			-- Make and setup the structure
		do
			{WEL_PRINT_DIALOG} Precursor
			enable_page_numbers
			set_maximum_range (1)
		end

feature {NONE} -- Implementation

	dispatch_events is
		do
		end

end -- class EV_PRINT_DIALOG_IMP

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
--| Revision 1.3  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.2  2000/01/27 19:30:19  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.1  1999/11/24 17:30:25  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

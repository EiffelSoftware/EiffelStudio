--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision information dialog. Mswindows implemenation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_INFORMATION_DIALOG_IMP

inherit
	EV_INFORMATION_DIALOG_I

	EV_MESSAGE_DIALOG_IMP
			redefine
			make, 
			make_default,
			make_with_text
		end

creation
	make,
	make_default,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a message dialog with `par' as parent.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par)
			dialog_style := Mb_iconinformation
		end

	make_with_text (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create a message box with `par' as parent, `a_title' as
			-- title and `a_msg' as message.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par, a_title, a_msg)
			dialog_style := Mb_iconinformation
		end

	make_default (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create the default message dialog with `par' as
			-- parent, `a_title' as title and `a_msg' as message
			-- and displays it.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par, a_title, a_msg)
			dialog_style := Mb_iconinformation + Mb_ok
			show
		end

end -- class EV_MESSAGE_DIALOG_I

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--| Revision 1.4  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.2  2000/01/27 19:30:19  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.1  1999/11/24 17:30:25  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

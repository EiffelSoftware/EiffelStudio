indexing
	description:
		"EiffelVision warning dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WARNING_DIALOG

inherit
	EV_MESSAGE_DIALOG
		redefine
			initialize
		end

create
	default_create,
	make_with_text,
	make_with_text_and_actions

feature {NONE} -- Initialization

	initialize is
		local
			ok_button: EV_BUTTON
		do
			Precursor
			set_title ("Warning")
			set_pixmap (Default_pixmaps.Warning_pixmap)
			set_buttons (<<"OK">>)
			ok_button := button ("OK")
			set_default_push_button(ok_button)
			set_default_cancel_button(ok_button)
		end

end -- class EV_WARNING_DIALOG

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
--| Revision 1.14  2000/04/29 03:37:24  pichery
--| Changed Dialogs. Added default & cancel
--| buttons, Default pixmaps, ...
--|
--| Revision 1.13  2000/03/06 19:17:42  oconnor
--| Added make_with_text_and_actions,
--| moved make_with_text from decendants to EV_MESSAGE_DIALOG.
--|
--| Revision 1.12  2000/02/29 18:09:09  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.11  2000/02/22 18:39:50  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/14 11:40:50  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.6  2000/02/05 05:26:14  oconnor
--| redefine initialize
--|
--| Revision 1.9.6.5  2000/01/28 22:24:23  oconnor
--| released
--|
--| Revision 1.9.6.4  2000/01/28 22:20:37  brendel
--| Added `default_create' to create-clause.
--|
--| Revision 1.9.6.3  2000/01/27 19:30:50  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.2  2000/01/26 18:17:21  brendel
--| Completed in a platform independant way.
--|
--| Revision 1.9.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: "EiffelVision error dialog. Gtk implemenation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 

	EV_ERROR_DIALOG_IMP

inherit

	EV_ERROR_DIALOG_I

	EV_MESSAGE_DIALOG_IMP	
		redefine
			set_default,
			icon_build
		end

create
	make,
	make_default,
	make_with_text

feature {NONE} -- Implementstion

	set_default (msg, dtitle: STRING) is
			-- Set default settings
		do
			set_message (msg)
			set_title (dtitle)
			show_abort_retry_ignore_buttons
		end

	icon_build (par: EV_CONTAINER) is
			-- Load the icon
		local
			icon: EV_PIXMAP
		do
			--create icon.make (par)
		end

end -- class EV_ERROR_DIALOG_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.4  2000/02/04 21:35:43  oconnor
--| unreleased
--|
--| Revision 1.4.6.3  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.4.6.2  2000/01/27 19:29:41  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:29:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

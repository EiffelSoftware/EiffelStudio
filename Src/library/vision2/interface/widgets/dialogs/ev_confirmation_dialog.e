indexing
	description: "EiffelVision confirmation dialog."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CONFIRMATION_DIALOG

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
			-- Initialize `Current'.
		do
			Precursor {EV_MESSAGE_DIALOG}
			set_pixmap (Default_pixmaps.Question_pixmap)
			set_title (ev_confirmation_dialog_title)
			set_buttons (<<ev_ok, ev_cancel>>)
			set_default_push_button (button (ev_ok))
			set_default_cancel_button (button (ev_cancel))
		end

end -- class EV_CONFIRMATION_DIALOG

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

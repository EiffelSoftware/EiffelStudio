indexing
	description: "Custom warning dialog"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WARNING_DIALOG

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
			set_pixmap (Default_pixmaps.warning_pixmap)
			set_title (ev_confirmation_dialog_title)
			set_buttons (<<ev_ok, ev_cancel>>)
			set_default_push_button (button (ev_ok))
			set_default_cancel_button (button (ev_cancel))
		end

end -- class WARNING_DIALOG


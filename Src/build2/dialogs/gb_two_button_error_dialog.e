indexing
	description: "Objects that represent an error dialog with%
		%continue and abort buttons."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TWO_BUTTON_ERROR_DIALOG
	
inherit

	EV_MESSAGE_DIALOG
		redefine
			initialize
		end

create
	make_with_text

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_MESSAGE_DIALOG}
			set_title (ev_error_dialog_title)
			set_pixmap (Default_pixmaps.Error_pixmap)
			set_buttons (<<"Continue", ev_abort>>)
			set_default_push_button(button ("Continue"))
			set_default_cancel_button(button (ev_abort))
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
		end

end -- class GB_TWO_BUTTON_ERROR_DIALOG

indexing
	description: "Objects that represent a dialog informing the user that the%
		%object name they have just entered already exists."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DUPLICATE_OBJECT_NAME_DIALOG

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
			set_title (ev_question_dialog_title)
			set_pixmap (Default_pixmaps.Error_pixmap)
			set_buttons (<<"Modify", ev_cancel>>)
			set_default_push_button(button ("Modify"))
			set_default_cancel_button(button (ev_cancel))
		end
end -- class GB_DUPLICATE_OBJECT_NAME_DIALOG

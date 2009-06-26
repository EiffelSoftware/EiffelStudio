note
	description: "EiffelVision file save dialog."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_SAVE_DIALOG_IMP

inherit
	EV_FILE_SAVE_DIALOG_I
		redefine
			interface
		end

	EV_FILE_DIALOG_IMP
		undefine
			internal_accept
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create save_panel.make
			window_item := save_panel.item
			Precursor {EV_FILE_DIALOG_IMP}
			set_title ("Save As")
		end

feature {NONE} -- Implementation

	interface: EV_FILE_SAVE_DIALOG

	file_chooser_action: INTEGER
			-- Action constant of the file chooser, ie: to open or save files, etc.
		do
		end

end -- class EV_FILE_SAVE_DIALOG_IMP

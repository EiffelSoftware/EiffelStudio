note
	description: "EiffelVision file save dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			initialize,
			window
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a window with a parent.
		do
			base_make (an_interface)
			create save_panel.save_panel
		end

	initialize
		do
			Precursor {EV_FILE_DIALOG_IMP}
			set_title ("Save As")
		end

feature {NONE} -- Implementation

	window: NS_WINDOW
		do
			Result ?= save_panel
		end

	interface: EV_FILE_SAVE_DIALOG

	file_chooser_action: INTEGER
			-- Action constant of the file chooser, ie: to open or save files, etc.
		do
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_FILE_SAVE_DIALOG_IMP


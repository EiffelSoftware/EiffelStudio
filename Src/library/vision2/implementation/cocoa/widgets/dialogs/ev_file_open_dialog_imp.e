indexing
	description: "Eiffel Vision file open dialog. Cocoa implementation."


class
	EV_FILE_OPEN_DIALOG_IMP

inherit
	EV_FILE_OPEN_DIALOG_I
		redefine
			interface
		end

	EV_FILE_DIALOG_IMP
		undefine
			internal_accept
		redefine
			make,
			interface,
			initialize,
			window
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a window with a parent.
		local
			button: INTEGER
		do
			base_make (an_interface)
			create open_panel.open_panel
			button := open_panel.run_modal
		end

	initialize
		do
			Precursor
			--set_title ("Open")
		end

feature {NONE} -- Access

	multiple_selection_enabled: BOOLEAN
		-- Is dialog enabled to select multiple files.
		do
			Result := open_panel.allows_multiple_selection
		end

	file_names: ARRAYED_LIST [STRING_32]
			-- List of filenames selected by user
		local
			l_filenames: NS_ARRAY [NS_STRING]
		do
			l_filenames := open_panel.filenames
			create Result.make (l_filenames.count)
		end

feature {NONE} -- Setting

	enable_multiple_selection
			-- Enable multiple file selection
		do
			open_panel.set_allows_multiple_selection (True)
		end

	disable_multiple_selection
			-- Disable multiple file selection
		do
			open_panel.set_allows_multiple_selection (False)
		end

feature {NONE} -- Implementation

	open_panel: NS_OPEN_PANEL

	window: NS_WINDOW
		do
			Result ?= open_panel
		end

	interface: EV_FILE_OPEN_DIALOG;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_FILE_OPEN_DIALOG_IMP


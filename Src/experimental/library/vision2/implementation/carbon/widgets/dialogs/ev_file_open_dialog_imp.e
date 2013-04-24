note
	description: "Eiffel Vision file open dialog. Carbon implementation."


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
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize
		do
			Precursor
			set_title ("Open")
		end

feature {NONE} -- Access

	multiple_selection_enabled: BOOLEAN
		-- Is dialog enabled to select multiple files.

	file_names: ARRAYED_LIST [STRING_32]
			-- List of filenames selected by user
		do
			create Result.make_from_array (<<>>)
		end

feature {NONE} -- Setting

	enable_multiple_selection
			-- Enable multiple file selection
		do
		end

	disable_multiple_selection
			-- Disable multiple file selection
		do
		end

feature {NONE} -- Implementation

	file_chooser_action: INTEGER
			-- Action constant of the file chooser, ie: to open or save files, etc.
		do
		end

	interface: EV_FILE_OPEN_DIALOG;

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_FILE_OPEN_DIALOG_IMP


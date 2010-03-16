note
	description: "Objects that allow access to the operating system clipboard. Cocoa implementation"
	author: "Daniel Furrer."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CLIPBOARD_IMP

inherit
	EV_CLIPBOARD_I

create
	make

feature {NONE}-- Initialization

	old_make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Access

	has_text: BOOLEAN
			-- Does the clipboard currently contain text?
		do
		end

	text: STRING_32
			-- `Result' is current clipboard content.
		do
			create Result.make_empty
		end

feature -- Status Setting

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to clipboard.
		do
		end

feature {EV_ANY_I}

	destroy
			-- Destroy `Current'
		do
		end

end -- class EV_CLIPBOARD_IMP

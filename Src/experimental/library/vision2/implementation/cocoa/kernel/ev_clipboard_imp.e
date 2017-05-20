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

	old_make (an_interface: attached like interface)
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

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to clipboard.
		do
		end

feature {EV_ANY_I}

	destroy
			-- Destroy `Current'
		do
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_CLIPBOARD_IMP

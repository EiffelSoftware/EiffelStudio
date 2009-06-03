note
	description: "Objects that allow access to the operating %N%
	%system clipboard. Cocoa implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CLIPBOARD_IMP

inherit
	EV_CLIPBOARD_I
		redefine
			interface
		end

	EV_ANY_I
		redefine
			interface
		end

create
	make

feature {NONE}-- Initialization

	make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
		end

	initialize
			-- initialize `Current'.
		do
		end

feature -- Access

	has_text: BOOLEAN
			-- Does the clipboard currently contain text?
		do
		end

	text: STRING_32
			-- `Result' is current clipboard content.
		do
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

	interface: EV_CLIPBOARD;
		-- Interface of `Current'

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_CLIPBOARD_IMP


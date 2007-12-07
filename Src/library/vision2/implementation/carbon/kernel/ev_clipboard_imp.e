indexing
	description: "Objects that allow access to the operating %N%
	%system clipboard."
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

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
		end

	initialize is
			-- initialize `Current'.
		do
		end

feature -- Access

	has_text: BOOLEAN is
			-- Does the clipboard currently contain text?
		do
		end

	text: STRING_32 is
			-- `Result' is current clipboard content.
		do
		end

feature -- Status Setting

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to clipboard.
		do
		end

feature {EV_TEXT_COMPONENT_IMP} -- Implementation

	clipboard: POINTER
			-- Pointer to the CLIPBOARD Gtk clipboard

feature {NONE} -- Implementation

	primary: POINTER
			-- Pointer to the PRIMARY Gtk clipboard

feature {EV_ANY_I}

	destroy is
			-- Destroy `Current'
		do
		end

	interface: EV_CLIPBOARD;
		-- Interface of `Current'

indexing
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


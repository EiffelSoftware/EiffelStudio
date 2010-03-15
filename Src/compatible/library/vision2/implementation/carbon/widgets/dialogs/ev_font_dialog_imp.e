note
	description: "EiffelVision font selection dialog, implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			initialize
		end

create
	make


feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Connect `interface' and initialize `c_object'.
		do
		end

	initialize
			-- Initialize the dialog.
		do
		end

feature -- Access

	font: EV_FONT
			-- Current selected font.
		do
		end

feature -- Element change

	set_font (a_font: EV_FONT)
			-- Select `a_font'.
		do
		end

feature {NONE} -- Implementation

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT_DIALOG;

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




end -- class EV_FONT_DIALOG_IMP


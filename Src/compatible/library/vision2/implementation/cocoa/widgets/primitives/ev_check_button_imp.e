note
	description: "EiffelVision check button, Cocoa implementation."
	author:	"Daniel Furrer"
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end

	EV_TOGGLE_BUTTON_IMP
		undefine
			default_alignment
		redefine
			make,
			interface,
			initialize,
			accommodate_text
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a Cocoa check button.
		do
			base_make (an_interface)
			cocoa_make
			cocoa_item := current
			set_bezel_style ({NS_BUTTON}.rounded_bezel_style)
			set_button_type ({NS_BUTTON}.switch_button)

			align_text_left
		end

	initialize
			-- Initialize 'Current'
		do
			Precursor {EV_TOGGLE_BUTTON_IMP}
		end

	accommodate_text (a_text: STRING_GENERAL)
			-- Change internal minimum size to make `a_text' fit.
		local
			t: TUPLE [width: INTEGER; height: INTEGER]
			a_width, a_height: INTEGER
		do
			t := internal_font.string_size (a_text)
			a_width := t.width
			a_height := t.height
			internal_set_minimum_size (a_width.abs + 25, a_height.abs + 5)
		end

feature {EV_ANY_I}

	interface: EV_CHECK_BUTTON;

end -- class EV_CHECK_BUTTON_IMP

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
			old_make,
			interface,
			accomodate_text
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create a Cocoa check button.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize 'Current'
		do
			cocoa_make
			cocoa_item := current
			set_bezel_style ({NS_BUTTON}.rounded_bezel_style)
			set_button_type ({NS_BUTTON}.switch_button)

			align_text_left
			Precursor {EV_TOGGLE_BUTTON_IMP}
		end

	accomodate_text (a_text: STRING_GENERAL)
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

	interface: detachable EV_CHECK_BUTTON note option: stable attribute end;

end -- class EV_CHECK_BUTTON_IMP

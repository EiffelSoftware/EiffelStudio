indexing

	description: 
		"EiffelVision implementation of a Motif button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BUTTON_M 

inherit

	PRIMITIVE_M;

	MEL_LABEL
		rename
			make as mel_label_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen
		end

feature -- Status report

	text: STRING is
			-- Text of button
		do
			Result := label_as_string
		end; 

feature -- Status setting

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		require
			not_text_void: a_text /= Void
		do
			set_label_as_string (a_text)
		ensure
			text_set: text.is_equal (a_text)
		end;

	set_left_alignment is
			-- Set text alignment to left.
		do
			set_beginning_alignment
		end;

	set_right_alignment is
			-- Set text alignment to left.
		do
			set_end_alignment
		end;

end -- class BUTTON_M

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

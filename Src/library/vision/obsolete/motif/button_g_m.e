indexing

	description: 
		"EiffelVision implementation of a Motif gadget button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BUTTON_G_M 

inherit

	WIDGET_M
		undefine
			clean_up_callbacks
		redefine
			remove_action, set_action,
			set_background_color, set_background_pixmap
		end;

	FONTABLE_M;

	MEL_LABEL_GADGET
		rename
			make as mel_label_make,
			destroy as mel_destroy,
			screen as mel_screen
		end

feature -- Access

	is_stackable: BOOLEAN is
			-- Is the Current widget stackable?
		do
			Result := True
		end;

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

feature -- Removal

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		do
		end;

feature {NONE} -- Implementation

	foreground_color: COLOR is
			-- Foreground color of gadget (Is Void)
		do
		end

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		do
		end; 

	set_background_color (new_color: COLOR) is
			-- Set background color to `new_color'.
		do
		end; 

	set_foreground_color (new_color: COLOR) is
			-- Set foreground_color color to `new_color'.
		do
		end;

	update_foreground_color is
			-- Do nothing.
		do
		end;

	set_background_pixmap (new_pixmap: PIXMAP) is
			-- Set background_pixmap to `new_color'.
		do
		end

end -- class BUTTON_G_M

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

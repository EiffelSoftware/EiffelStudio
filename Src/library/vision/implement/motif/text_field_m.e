indexing

	description:
		"EiffelVision implementation of Motif text field widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TEXT_FIELD_M 

inherit

	TEXT_FIELD_I;

	FONTABLE_M;

	PRIMITIVE_M
		rename
			is_shown as shown
		undefine
			create_callback_struct
		end;

	MEL_TEXT_FIELD
		rename
			make as mel_text_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			string as text,
			set_string as set_text,
			max_length as maximum_size,
			set_max_length as set_maximum_size,
			insert as mel_insert,
			is_shown as shown
		end

creation

	make

feature {NONE} -- Creation

	make (a_text_field: TEXT_FIELD; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif text_field.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_text_make (a_text_field.identifier, mc, man);
			a_text_field.set_font_imp (Current)
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed
			-- when an acitvate event occurs.
		do
			add_activate_callback (mel_vision_callback (a_command), argument)
		end;
 
	insert (a_text: STRING; a_position: INTEGER) is
			-- Insert `a_text' in current text field at `a_position'.
			-- Same as `replace (a_position, a_position, a_text)'.
		do
			mel_insert (a_position, a_text)
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to be executed
			-- when an acitvate event occurs.
		do
			remove_activate_callback (mel_vision_callback (a_command), argument)
		end;

end -- class TEXT_FIELD_M

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

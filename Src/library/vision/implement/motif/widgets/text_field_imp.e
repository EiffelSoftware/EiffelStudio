indexing

	description:
		"EiffelVision implementation of Motif text field widget."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	TEXT_FIELD_IMP

inherit

	TEXT_FIELD_I;

	FONTABLE_IMP;

	PRIMITIVE_IMP
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

create

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
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (activate_command);
			if list = Void then
				create list.make;
				set_activate_callback (list, Void)
			end;
			list.add_command (a_command, argument)
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
			remove_command (activate_command, a_command, argument)
		end;

feature -- Non-implemented feature for Motif systems

	wel_set_focus is
		do
		end

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




end -- class TEXT_FIELD_IMP


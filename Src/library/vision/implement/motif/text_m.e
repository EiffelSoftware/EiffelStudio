indexing

	description:
		"EiffelVision implementation of Motif text widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TEXT_M

inherit

	TEXT_I;

	FONTABLE_M;

	MEL_CALLBACK_STRUCT_CONSTANTS;

	SHARED_CALLBACK_STRUCT;

	PRIMITIVE_M
		rename
			is_shown as shown
		undefine
			create_callback_struct
		end;

	MEL_TEXT
		rename
			make as mel_text_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			set_editable as mel_set_editable,
			pos_to_x as x_coordinate,
			pos_to_y as y_coordinate,
			xy_to_pos as character_position,
			resize_height as is_height_resizable,
			resize_width as is_width_resizable,
			word_wrap as is_word_wrap_mode,
			verify_bell as is_bell_enabled,
			string as text,
			set_string as set_text,
			max_length as maximum_size,
			set_max_length as set_maximum_size,
			top_character as top_character_position,
			set_top_character as set_top_character_position,
			clear_selection as clear_selecton_with_time,
			clear_selection_with_current_time as clear_selection,
			set_selection as set_selecton_with_time,
			set_selection_with_current_time as set_selection,
			insert as mel_insert,
			is_shown as shown
		end

creation

	make, make_word_wrapped

feature {NONE} -- Initialization

	make (a_text: TEXT; man: BOOLEAN) is
			-- Create a motif text.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_text_make (a_text.identifier,
					mel_parent (a_text, widget_index),
					man);
			a_text.set_font_imp (Current)
		end;

	make_word_wrapped (a_text: TEXT; man: BOOLEAN) is
			-- Create a motif text enabling word wrap.
		do
			make (a_text, man);
			set_multi_line_mode;
			set_word_wrap (True)
		end;

feature -- Access

	is_in_a_verification_callback: BOOLEAN is
			-- Is the program in a `motion' or `modify' action ?
		local
			ts: MEL_TEXT_VERIFY_CALLBACK_STRUCT
		do
			ts ?= last_callback_struct;
			if ts /= Void then
				Result := 	
					ts.reason = XmCR_MOVING_INSERT_CURSOR or else
					ts.reason = XmCR_MODIFYING_TEXT_VALUE
			end
		end;

feature -- Status report

	is_multi_line_mode: BOOLEAN is
			-- Is Current editing a multiline text?
		do
			Result := not single_line_edit_mode
		end;

	is_any_resizable: BOOLEAN is
			-- Is width and height of current text resizable?
		do
			Result := is_height_resizable and then is_width_resizable
		end;

	is_read_only: BOOLEAN is
			-- Is current text in read only mode?
		do
			Result := not is_editable
		end;

feature -- Status setting

	allow_action is
			-- Allow the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		local
			ts: MEL_TEXT_VERIFY_CALLBACK_STRUCT
		do
			ts ?= last_callback_struct;
			ts.set_do_it (True);
		end;

	forbid_action is
			-- Forbid the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		local
			ts: MEL_TEXT_VERIFY_CALLBACK_STRUCT
		do
			ts ?= last_callback_struct;
			ts.set_do_it (False);
		end;

	disable_verify_bell is
			-- Disable the bell when an action is forbidden
		do
			set_verify_bell (False)
		end;

	enable_verify_bell is
			-- enable the bell when an action is forbidden
		do
			set_verify_bell (True)
		end;

	set_editable is
			-- Set current text to be editable.
		do
			mel_set_editable (True)
		end;

	set_read_only is
			-- Set current text to be read only.
		do
			mel_set_editable (False)
		end;

	disable_resize is
			-- Disable that current text widget attempts to resize its width an
			-- height to accommodate all the text contained.
		do
			set_resize_width (False);
			set_resize_height (False);
		end;

	disable_resize_height is
			-- Disable that current text widget attempts to resize its height
			-- to accommodate all the text contained.
		do
			set_resize_height (False);
		end;

	disable_resize_width is
			-- Disable that current text widget attempts to resize its width
			-- to accommodate all the text contained.
		do
			set_resize_width (False);
		end;

	enable_resize is
			-- Enable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		do
			set_resize_height (True);
			set_resize_width (True);
		end;

	enable_resize_height is
			-- Enable that current text widget attempts to resize its height to
			-- accomodate all the text contained.
		do
			set_resize_height (True);
		end;

	enable_resize_width is
			-- Enable that current text widget attempts to resize its width to
			-- accommodate all the text contained.
		do
			set_resize_width (True);
		end;

	set_single_line_mode is
			-- Enable single line editing.
		do
			set_single_line_edit_mode (True)
		end;

	set_multi_line_mode is
			-- Enabble multi line editing.
		do
			set_single_line_edit_mode (False)
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		do
			add_activate_callback (mel_vision_callback (a_command), argument)
		end;
 
	add_modify_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		do
			add_modify_verify_callback (mel_vision_callback (a_command), argument)
		end;

	add_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before insert
			-- cursor is moved to a new position.
		do
			add_motion_verify_callback (mel_vision_callback (a_command), argument)
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
			-- when an acitvate event occurs
		do
			remove_activate_callback (mel_vision_callback (a_command), argument)
		end;
 
	remove_modify_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		do
			remove_modify_verify_callback (mel_vision_callback (a_command), argument)
		end;

	remove_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- insert cursor is moved to a new position.
		do
			remove_motion_verify_callback (mel_vision_callback (a_command), argument)
		end;

end -- class TEXT_M

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

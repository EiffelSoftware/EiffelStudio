indexing

	description:
		"EiffelVision implementation of Motif text widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TEXT_IMP

inherit

	TEXT_I;

	FONTABLE_IMP;

	MEL_CALLBACK_STRUCT_CONSTANTS;

	SHARED_CALLBACK_STRUCT;

	PRIMITIVE_IMP
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
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			pos_to_x as x_coordinate,
			pos_to_y as y_coordinate,
			xy_to_pos as character_position,
			is_word_wrapped as is_word_wrap_mode,
			is_verify_bell_enabled as is_bell_enabled,
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
			is_shown as shown,
			set_single_line_edit_mode as set_single_line_mode,
			set_multi_line_edit_mode as set_multi_line_mode,
			set_cursor_position_visible as mel_set_cursor_position_visible,
			show_auto_cursor_position as show_selection,
			hide_auto_show_cursor_position as hide_selection,
			is_auto_show_cursor_position as is_selection_visible
		end

creation

	make, make_word_wrapped

feature {NONE} -- Initialization

	make (a_text: TEXT; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif text.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_text_make (a_text.identifier, mc, man);
			set_multi_line_mode;
			a_text.set_font_imp (Current)
		end;

	make_word_wrapped (a_text: TEXT; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif text enabling word wrap.
		do
			make (a_text, man, oui_parent);
			set_multi_line_mode;
			enable_word_wrap
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

	coordinate (char_pos: INTEGER): COORD_XY is
			-- Coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		do
			!! Result;
			Result.set (x_coordinate (char_pos), y_coordinate (char_pos))
		end;

feature -- Status report

	is_multi_line_mode: BOOLEAN is
			-- Is Current editing a multiline text?
		do
			Result := not is_single_line_edit_mode
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

	set_cursor_position_visible (flag: BOOLEAN) is
			-- Set is_cursor_position_visible to flag.
		do
			if flag then	
				mel_set_cursor_position_visible
			else
				set_cursor_position_invisible
			end
		end

	allow_action is
			-- Allow the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		local
			ts: MEL_TEXT_VERIFY_CALLBACK_STRUCT
		do
			ts ?= last_callback_struct;
			ts.set_do_it;
		end;

	forbid_action is
			-- Forbid the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		local
			ts: MEL_TEXT_VERIFY_CALLBACK_STRUCT
		do
			ts ?= last_callback_struct;
			ts.unset_do_it;
		end;

	disable_resize is
			-- Disable that current text widget attempts to resize its width an
			-- height to accommodate all the text contained.
		do
			disable_resize_width;
			disable_resize_height
		end;

	enable_resize is
			-- Enable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		do
			enable_resize_height;
			enable_resize_width
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (activate_command);
			if list = Void then
				!! list.make;
				set_activate_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;
 
	add_modify_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (modify_verify_command);
			if list = Void then
				!! list.make;
				set_modify_verify_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before insert
			-- cursor is moved to a new position.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (motion_verify_command);
			if list = Void then
				!! list.make;
				set_motion_verify_callback (list, Void)
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
			-- when an acitvate event occurs
		do
			remove_command (activate_command, a_command, argument)
		end;
 
	remove_modify_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		do
			remove_command (modify_verify_command, a_command, argument)
		end;

	remove_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- insert cursor is moved to a new position.
		do
			remove_command (motion_verify_command, a_command, argument)
		end;

end -- class TEXT_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


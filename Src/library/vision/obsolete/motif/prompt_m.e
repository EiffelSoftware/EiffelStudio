indexing

	description:
		"EiffelVision Implementation of a selection box.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PROMPT_M

inherit

	PROMPT_I;

	TERMINAL_M
		undefine
			create_callback_struct, create_widget,
			default_button, cancel_button
		redefine
			make
		end;

	MEL_SELECTION_BOX
		rename
			make as selection_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen
		select
			selection_make, make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_prompt: PROMPT; man: BOOLEAN) is
			-- Create a motif prompt.
		do
			widget_index := widget_manager.last_inserted_position;
			selection_make (a_prompt.identifier,
					mel_parent (a_prompt, widget_index),
					man);
		end;

feature -- Status Report

	selection_text: STRING is
			-- Current text in selection box
		local
			t: MEL_STRING
		do
			t := text_string;
			Result := t.to_eiffel_string;
			t.free
		end;

feature -- Status Setting

	set_apply_label (a_label: STRING) is
			-- Set `a_label' as label for apply button,
			-- by default this label is `apply'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_label);
			set_apply_label_string (ms);
			ms.free
		end;

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_label);
			set_cancel_label_string (ms);
			ms.free
		end;

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_label);
			set_help_label_string (ms);
			ms.free
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_label);
			set_ok_label_string (ms);
			ms.free
		end;

	set_selection_label (a_label: STRING) is
			-- Set `a_label' as selection label,
			-- by default this label is `selection'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_label);
			set_apply_label_string (ms);
			ms.free
		end;

	set_selection_text (a_text: STRING) is
			-- Set selection text to `a_text'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_text);
			set_text_string (ms);
			ms.free
		end;

feature -- Display

	hide_apply_button is
			-- Make apply button invisible.
		do
			apply_button.unmanage
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			cancel_button.unmanage
		end;

	hide_help_button is
			-- Make help button invisible.
		do
			help_button.unmanage
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			ok_button.unmanage
		end;

	show_apply_button is
			-- Make apply button visible.
		do
			apply_button.manage
		end;

	show_cancel_button is
			-- Make cancel button visible.
		do
			cancel_button.manage
		end;

	show_help_button is
			-- Make help button visible.
		do
			help_button.manage
		end;

	show_ok_button is
			-- Make ok button visible.
		do
			ok_button.manage
		end;

feature -- Element change

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		do
			add_apply_callback (mel_vision_callback (a_command), argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
			add_cancel_callback (mel_vision_callback (a_command), argument)
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		do
			add_help_callback (mel_vision_callback (a_command), argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
			add_ok_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Removal

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		do
			remove_apply_callback (mel_vision_callback (a_command), argument)
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			remove_cancel_callback (mel_vision_callback (a_command), argument)
		end;

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		do
			remove_help_callback (mel_vision_callback (a_command), argument)
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			remove_ok_callback (mel_vision_callback (a_command), argument)
		end;

feature {NONE} -- Color

	update_other_fg_color (pixel: POINTER) is
		local
			ext_name: ANY;
		do
			--ext_name := Mforeground_color.to_c
			--c_set_color (xm_selection_box_get_child 
					--(screen_object, MDIALOG_TEXT),
					--pixel,
					--$ext_name);
		end;

	update_other_bg_color (pixel: POINTER) is
		do
			xm_set_children_bg_color (pixel, screen_object)
		end;

feature {NONE} -- Font

	update_text_font (f_ptr: POINTER) is
		do
			--set_primitive_font (xm_selection_box_get_child 
					--(screen_object, MDIALOG_TEXT),
					--f_ptr)
		end;

	update_label_font (f_ptr: POINTER) is
		do
			--set_primitive_font (xm_selection_box_get_child 
					--(screen_object, MDIALOG_SELECTION_LABEL),
					--f_ptr)
		end;

	update_button_font (f_ptr: POINTER) is
		do
			--set_primitive_font (xm_selection_box_get_child 
					--(screen_object, MDIALOG_APPLY_BUTTON),
					--f_ptr)
			--set_primitive_font (xm_selection_box_get_child 
					--(screen_object, MDIALOG_CANCEL_BUTTON),
					--f_ptr)
			--set_primitive_font (xm_selection_box_get_child 
					--(screen_object, MDIALOG_DEFAULT_BUTTON),
					--f_ptr)
			--set_primitive_font (xm_selection_box_get_child 
					--(screen_object, MDIALOG_HELP_BUTTON),
					--f_ptr)
			--set_primitive_font (xm_selection_box_get_child 
					--(screen_object, MDIALOG_OK_BUTTON),
					--f_ptr)
		end;

end -- class PROMPT_M

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

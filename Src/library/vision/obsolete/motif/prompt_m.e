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
			make, set_foreground_color_from_imp
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
			screen as mel_screen,
			is_shown as shown
		select
			selection_make, make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_prompt: PROMPT; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif prompt.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			selection_make (a_prompt.identifier, mc, man)
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
			!! ms.make_default_l_to_r (a_label);
			set_apply_label_string (ms);
			ms.free
		end;

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_cancel_label_string (ms);
			ms.free
		end;

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_help_label_string (ms);
			ms.free
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_ok_label_string (ms);
			ms.free
		end;

	set_selection_label (a_label: STRING) is
			-- Set `a_label' as selection label,
			-- by default this label is `selection'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_apply_label_string (ms);
			ms.free
		end;

	set_selection_text (a_text: STRING) is
			-- Set selection text to `a_text'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_text);
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

feature {NONE} -- Implementation

	set_foreground_color_from_imp (color_imp: COLOR_X) is
			-- Set the background color from implementation `color_imp'.
		do
			mel_set_foreground_color (color_imp);
			text.set_foreground_color (color_imp)
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

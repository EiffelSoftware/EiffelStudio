indexing

	description: 
		"EiffelVision Implementation of a Motif message box.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	MESSAGE_M

inherit

	MESSAGE_I;

	TERMINAL_M
		undefine
			cancel_button, create_widget
		redefine
			make
		end;

	MEL_MESSAGE_BOX
		rename
			make as message_make,
			make_no_auto_unmanage as message_make_no_auto_unmanage,
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
			message_make, message_make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_message: MESSAGE; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif message box.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			message_make (a_message.identifier, mc, man)
		end

feature -- Status setting

	set_left_alignment is
			-- Set message alignment to beginning.
		do
			set_alignment_beginning
		end;

	set_center_alignment is
			-- Set message alignment to center.
		do
			set_alignment_center
		end;

	set_right_alignment is
			-- Set message alignment to right.
		do
			set_alignment_end
		end;

	set_message (a_message: STRING) is
			-- Set `a_message' as message.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_message);
			set_message_string (ms);
			ms.destroy
		end;

	set_cancel_label (a_label: STRING) is
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_cancel_label_string (ms);
			ms.destroy
		end;

	set_help_label (a_label: STRING) is
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_help_label_string (ms);
			ms.destroy
		end;

	set_ok_label (a_label: STRING) is
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_ok_label_string (ms);
			ms.destroy
		end;

feature -- Display

	hide_help_button is
			-- Make help button invisible.
		do
			help_button.unmanage
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			cancel_button.unmanage
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			ok_button.unmanage
		end;

	show_help_button is
			-- Make help button visible.
		do
			help_button.manage
		end;

	show_cancel_button is
			-- Make cancel button visible.
		do
			cancel_button.manage
		end;

	show_ok_button is
			-- Make ok button visible.
		do
			ok_button.manage
		end

feature -- Element change

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

end -- class MESSAGE_M

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

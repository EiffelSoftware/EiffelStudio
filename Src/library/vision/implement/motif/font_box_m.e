
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FONT_BOX_M

inherit

	TERMINAL_M
		rename
			clean_up as terminal_clean_up
		undefine
			make
		end

	TERMINAL_M
		undefine
			make
		redefine
			clean_up
		select
			clean_up
		end;

	FONT_BOX_I;

	FONT_BOX_R_M
		export
			{NONE} all
		end

creation

	make

feature {NONE} -- Creation

	make (a_font_box: FONT_BOX; man: BOOLEAN) is
			-- Create a motif font box.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_font_box.identifier.to_c;
			data := font_box_create ($ext_name,
					parent_screen_object (a_font_box, widget_index),
					False, man);
			screen_object := font_box_form (data)
		end;

feature 

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (apply_actions = Void) then
				!! apply_actions.make (font_box_apply_button (data), Mactivate, widget_oui)
			end;
			apply_actions.add (a_command, argument)
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (cancel_actions = Void) then
				!! cancel_actions.make (font_box_cancel_button (data), Mactivate, widget_oui)
			end;
			cancel_actions.add (a_command, argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (ok_actions = Void) then
				!! ok_actions.make (font_box_ok_button (data), Mactivate, widget_oui)
			end;
			ok_actions.add (a_command, argument)
		end;

	
feature {NONE}

	ok_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when ok button is
			-- activated

	apply_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when apply button is
			-- activated

	cancel_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when cancel button is
			-- activated

	data: POINTER;
			-- Pointer to the font_box_data structure

	clean_up is
		do
			terminal_clean_up;
			if cancel_actions /= Void then
				cancel_actions.free_cdfd
			end;
			if apply_actions /= Void then
				apply_actions.free_cdfd
			end;
			if ok_actions /= Void then
				ok_actions.free_cdfd
			end;
			free_data (data);
		ensure then
			data_freed: data = null_pointer
		end;

feature 

	font: FONT is
			-- Font currently selected by the user
		local
			str: STRING
		do
			!! str.make (1);
			str.from_c (font_box_current_font (data));
			!! Result.make;
			Result.set_name (str)
		ensure then
			not (Result = Void)
		end;

	hide_apply_button is
			-- Make apply button invisible.
		do
			font_box_hide_apply (data)
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			font_box_hide_cancel (data)
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			font_box_hide_ok (data)
		end;

feature 

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			apply_actions.remove (a_command, argument)
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			cancel_actions.remove (a_command, argument)
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			ok_actions.remove (a_command, argument)
		end;

	set_font (a_font: FONT) is
			-- Edit `a_font'.
		require else
			a_font_exists: not (a_font = Void)
		do
			font_box_set_font (a_font.name.to_c, data)
		end;

	show_apply_button is
			-- Make apply button visible.
		do
			font_box_show_apply (data)
		end;

	show_cancel_button is
			-- Make cancel button visible.
		do
			font_box_show_cancel (data)
		end;

	show_ok_button is
			-- Make ok button visible.
		do
			font_box_show_ok (data)
		end

feature {NONE} -- External features

	font_box_set_font (a_name: ANY; value: POINTER) is
		external
			"C"
		end;

	font_box_apply_button (value: POINTER): POINTER is
		external
			"C"
		end;

	font_box_show_ok (value: POINTER) is
		external
			"C"
		end;

	font_box_show_cancel (value: POINTER) is
		external
			"C"
		end;

	font_box_show_apply (value: POINTER) is
		external
			"C"
		end;

	font_box_hide_ok (value: POINTER) is
		external
			"C"
		end;

	font_box_hide_cancel (value: POINTER) is
		external
			"C"
		end;

	font_box_hide_apply (value: POINTER) is
		external
			"C"
		end;

	font_box_current_font (value: POINTER): POINTER is
		external
			"C"
		end;

	font_box_ok_button (value: POINTER): POINTER is
		external
			"C"
		end;

	font_box_cancel_button (value: POINTER): POINTER is
		external
			"C"
		end;

	font_box_create (b_name: POINTER; scr_obj: POINTER; 
			is_dial, man: BOOLEAN): POINTER is
		external
			"C"
		end;

	font_box_form (value: POINTER): POINTER is
		external
			"C"
		end;

	free_data (p: POINTER) is
		external
			"C"
		alias
			"xfree"
		end

end


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

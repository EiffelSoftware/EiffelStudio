indexing
	description: 
		"MEL Font Box widget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONT_BOX

inherit

	MEL_FORM
		redefine
			set_default
		end

creation
	make

feature -- Access

	select_form, buttons_form: MEL_FORM;
	text: MEL_TEXT;
	non_stand_list: MEL_SCROLLED_LIST;
	stand_frame: MEL_FRAME;
	stand_column: MEL_ROW_COLUMN;
	ok_b, apply_b, cancel_b, stand_font_b, non_stand_font_b: MEL_PUSH_BUTTON_GADGET;
	switch_menu_button, family_menu_button, weight_menu_button, slant_menu_button, 
	width_menu_button, point_menu_button, resolution_menu_button: MEL_OPTION_MENU;
	switch_menu, family_menu, weight_menu, slant_menu, width_menu, point_menu,
	resolution_menu : MEL_PULLDOWN_MENU;

feature -- Status setting

	hide_ok_button is
			-- Hide the OK button.
		require
			ok_button_displayed: ok_b.is_managed
		do
			ok_b.unmanage;
			adjust_buttons
		ensure
			ok_button_hidden: not ok_b.is_managed
		end;

	show_ok_button is
			-- Show the OK button.
		require
			ok_button_hidden: not ok_b.is_managed
		do
			ok_b.manage;
			adjust_buttons
		ensure
			ok_button_displayed: ok_b.is_managed
		end;

	hide_apply_button is
			-- Hide the apply button.
		require
			apply_button_displayed: apply_b.is_managed
		do
			apply_b.unmanage;
			adjust_buttons
		ensure
			apply_button_hidden: not apply_b.is_managed
		end;

	show_apply_button is
			-- Show the apply button.
		require
			apply_button_hidden: not apply_b.is_managed
		do
			apply_b.manage;
			adjust_buttons
		ensure
			apply_button_displayed: apply_b.is_managed
		end;

	hide_cancel_button is
			-- Hide the cancel button.
		require
			cancel_button_displayed: cancel_b.is_managed
		do
			cancel_b.unmanage;
			adjust_buttons
		ensure
			cancel_button_hidden: not cancel_b.is_managed
		end;

	show_cancel_button is
			-- Show the cancel button.
		require
			cancel_button_hidden: not cancel_b.is_managed
		do
			cancel_b.manage;
			adjust_buttons
		ensure
			cancel_button_displayed: cancel_b.is_managed
		end;

feature {NONE} -- Implementation

	set_widget_default is
			-- Create the Font Box.
		do
			add_select_form;
			!! text.make ("text", Current, True);
			add_buttons_form;
			attach_select_form;
			text.set_multi_line_edit;
			set_top_offset (text, 10);
			attach_top_to_widget (text, select_form);
			set_bottom_offset (text, 10);
			attach_bottom_to_widget (text, buttons_form);
			set_left_offset (text, 10);
			attach_left_to_form (text);
			set_right_offset (text, 10);
			attach_right_to_form (text);
			attach_buttons_forms;
		end;

	add_select_form is
			-- Create the select form.
		do
			!! select_form.make ("selectForm", Current, False);
			!! switch_menu_button.make ("switchMenuButton", select_form, False);
			!! switch_menu.make ("switchMenu", select_form, False);
			!! stand_font_b.make ("standFont", switch_menu, False);
			stand_font_b.set_text_as_string ("Standard fonts");
			stand_font_b.manage;
			!! non_stand_font_b.make ("nonStandFont", switch_menu, False);
			non_stand_font_b.set_text_as_string ("Non standard fonts");
			non_stand_font_b.manage;
			switch_menu_button.set_sub_menu (switch_menu);
			switch_menu_button.manage;
			select_form.set_top_offset (switch_menu_button, 0);
			select_form.attach_top_to_form (switch_menu_button);
			select_form.set_left_offset (switch_menu_button, 0);
			select_form.attach_left_to_form (switch_menu_button);
			-- !! non_stand_list.make_variable ("nonStandList", select_form, False);
			-- select_form.set_left_offset (non_stand_list, 0);
			-- select_form.attach_left_to_form (non_stand_list);
			-- select_form.set_right_offset (non_stand_list, 0);
			-- select_form.attach_right_to_form (non_stand_list);
			-- select_form.set_bottom_offset (non_stand_list, 0);
			-- select_form.attach_bottom_to_form (non_stand_list);
			!! stand_frame.make ("standFrame", select_form, True);
			select_form.set_left_offset (stand_frame, 0);
			select_form.attach_left_to_form (stand_frame);
			select_form.set_right_offset (stand_frame, 0);
			select_form.attach_right_to_form (stand_frame);
			select_form.set_bottom_offset (stand_frame, 0);
			select_form.attach_bottom_to_form (stand_frame);
			!! stand_column.make ("standColumn", stand_frame, False);
			!! family_menu_button.make ("familyMenuButton", stand_column, True);
			!! weight_menu_button.make ("weightMenuButton", stand_column, True);
			!! slant_menu_button.make ("slantMenuButton", stand_column, True);
			!! width_menu_button.make ("widthMenuButton", stand_column, True);
			!! point_menu_button.make ("pointMenuButton", stand_column, True);
			!! resolution_menu_button.make ("resolutionMenuButton", stand_column, True);
			-- select_form.set_top_offset (non_stand_list, 5);
			-- select_form.attach_top_to_widget (non_stand_list, switch_menu_button);
			select_form.set_top_offset (stand_frame, 5);
			select_form.attach_top_to_widget (stand_frame, switch_menu_button);
			stand_column.manage;
			-- stand_frame.manage;
			select_form.manage
		end;

	add_buttons_form is
			-- Create the buttons form.
		do
			!! buttons_form.make ("buttonsForm", Current, False);
			!! ok_b.make ("OK", buttons_form, True);
			!! apply_b.make ("Apply", buttons_form, True);
			!! cancel_b.make ("Cancel", buttons_form, True);
			adjust_buttons
		end;

	adjust_buttons is
			-- Adjust the buttons of the buttons_form.
		local
			i: INTEGER;
		do
			if (ok_b.is_managed) then
				i := i + 1
			end;
			if (apply_b.is_managed) then
				i := i + 1
			end;
			if (cancel_b.is_managed) then
				i := i + 1
			end;
			i := 2 * i - 1;
			buttons_form.unmanage;
			buttons_form.set_fraction_base (i);
			if (ok_b.is_managed) then
				buttons_form.set_top_offset (ok_b, 0);
		   		buttons_form.attach_top_to_form (ok_b);
				buttons_form.set_bottom_offset (ok_b, 0);
				buttons_form.attach_bottom_to_form (ok_b);
				buttons_form.attach_left_to_position (ok_b, 0);
				buttons_form.attach_right_to_position (ok_b, 1)
			end;
			if (apply_b.is_managed) then
				buttons_form.set_top_offset (apply_b, 0);
				buttons_form.attach_top_to_form (apply_b);
				buttons_form.set_bottom_offset (apply_b, 0);
				buttons_form.attach_bottom_to_form (apply_b);
				buttons_form.attach_left_to_position (apply_b, i - 3);
				buttons_form.attach_right_to_position (apply_b, i - 2)
			end;
			if (cancel_b.is_managed) then
				buttons_form.set_top_offset (cancel_b, 0);
				buttons_form.attach_top_to_form (cancel_b);
				buttons_form.set_bottom_offset (cancel_b, 0);
				buttons_form.attach_bottom_to_form (cancel_b);
				buttons_form.attach_left_to_position (cancel_b, i - 1);
				buttons_form.attach_right_to_position (cancel_b, i)
			end;
			buttons_form.manage
		end;

	attach_select_form is
			-- Set the attachments for the select form.
		do
			set_top_offset (select_form, 10);
			attach_top_to_form (select_form);
			set_left_offset (select_form, 10);
			attach_left_to_form (select_form);
			set_right_offset (select_form, 10);
			attach_right_to_form (select_form)
		end;

	attach_buttons_forms is
			-- Set the attachments for the buttons form.
		do
			set_bottom_offset (buttons_form, 10);
			attach_bottom_to_form (buttons_form);
			set_left_offset (buttons_form, 10);
			attach_left_to_form (buttons_form);
			set_right_offset (buttons_form, 10);
			attach_right_to_form (buttons_form)
		end;

end -- class MEL_FONT_BOX

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------

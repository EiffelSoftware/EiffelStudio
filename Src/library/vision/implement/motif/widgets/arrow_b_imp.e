indexing

	description: 
		"EiffelVision implementation of a Motif arrow button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	ARROW_B_IMP

inherit

	ARROW_B_I;

	PRIMITIVE_IMP
		undefine
			create_callback_struct
		end;

	MEL_ARROW_BUTTON
		rename
			make as mel_arrow_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_left as left,
			is_right as right,
			is_down as down,
			is_up as up,
			is_shown as shown
		select
			shown
		end

creation

	make

feature {NONE} -- Initialization

	make (an_arrow_b: ARROW_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif arrow button.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			an_arrow_b.set_font_imp (Current);
			mel_arrow_make (an_arrow_b.identifier, mc, man)
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- arrow button is activated.
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

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- arrow button is armed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (arm_command);
			if list = Void then
				!! list.make;
				set_arm_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- arrow button is released.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (disarm_command);
			if list = Void then
				!! list.make;
				set_disarm_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current arrow button is activated.
		do
			remove_command (activate_command, a_command, argument)
		end; 

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current arrow button is armed.
		do
			remove_command (arm_command, a_command, argument)
		end; 

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current arrow button is released.
		do
			remove_command (disarm_command, a_command, argument)
		end; 

feature {NONE} -- Implementation

	font: FONT is
			-- Font of arrow button
		do
		end;

	set_font (f: FONT) is
			-- Font of arrow button
		do
		end;

	text: STRING is
			-- Text of current button
		do
		end;

	set_text (a_text: STRING) is
			-- Set current button text to `a_text'.
		do
		end;

	set_left_alignment is
			--	Set text alignment to left. 
		do
		end;

	set_center_alignment is
			--	Set text alignment to center. 
		do
		end;

	allow_recompute_size is
			-- Allow current button to recompute its  size according to
			-- some changes on its text.
		do
		end;

	forbid_recompute_size is
			-- Forbid current button to recompute its size according to
			-- some changes on its text.
		do
		end;

end -- class ARROW_B_IMP


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


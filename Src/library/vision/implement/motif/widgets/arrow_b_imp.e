note

	description: 
		"EiffelVision implementation of a Motif arrow button."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

create

	make

feature {NONE} -- Initialization

	make (an_arrow_b: ARROW_B; man: BOOLEAN; oui_parent: COMPOSITE)
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

	add_activate_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when current
			-- arrow button is activated.
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

	add_arm_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when current
			-- arrow button is armed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (arm_command);
			if list = Void then
				create list.make;
				set_arm_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when current
			-- arrow button is released.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (disarm_command);
			if list = Void then
				create list.make;
				set_disarm_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- current arrow button is activated.
		do
			remove_command (activate_command, a_command, argument)
		end; 

	remove_arm_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- current arrow button is armed.
		do
			remove_command (arm_command, a_command, argument)
		end; 

	remove_release_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- current arrow button is released.
		do
			remove_command (disarm_command, a_command, argument)
		end; 

feature {NONE} -- Implementation

	font: FONT
			-- Font of arrow button
		do
		end;

	set_font (f: FONT)
			-- Font of arrow button
		do
		end;

	text: STRING
			-- Text of current button
		do
		end;

	set_text (a_text: STRING)
			-- Set current button text to `a_text'.
		do
		end;

	set_left_alignment
			--	Set text alignment to left. 
		do
		end;

	set_center_alignment
			--	Set text alignment to center. 
		do
		end;

	allow_recompute_size
			-- Allow current button to recompute its  size according to
			-- some changes on its text.
		do
		end;

	forbid_recompute_size
			-- Forbid current button to recompute its size according to
			-- some changes on its text.
		do
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ARROW_B_IMP


indexing

	description: 
		"EiffelVision implementation of Motif drawn button."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	DRAW_B_IMP

inherit

	DRAW_B_I
		undefine
			is_equal
		end;

	DRAWING_IMP
		undefine
			display
		redefine
			display_handle
		end;

	BUTTON_IMP
		undefine
			create_callback_struct, shown, is_equal
		redefine
			display_handle
		end;

	MEL_DRAWN_BUTTON
		rename
			make as mel_drawn_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			draw_arc as mel_draw_arc,
			draw_point as mel_draw_point,
			draw_rectangle as mel_draw_rectangle,
			fill_arc as mel_fill_arc,
			fill_polygon as mel_fill_polygon,
			fill_rectangle as mel_fill_rectangle,
			is_shown as shown
		undefine
			is_equal
		redefine
			display_handle
		select
			mel_drawn_make
		end

create

	make

feature {NONE} -- Initialization

	make (a_draw_b: DRAW_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif draw button.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_drawn_make (a_draw_b.identifier, mc, man);
			set_shadow_out;
			enable_push_button;
			a_draw_b.set_font_imp (Current);
			create_gc (mel_screen)
		end;

feature -- Access

	display_handle: POINTER;
			-- C handle to the display

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is activated.
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

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is armed.
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

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is released.
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

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current draw button is exposed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (expose_command);
			if list = Void then
				create list.make;
				set_expose_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is activated.
		do
			remove_command (activate_command, a_command, argument)
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is armed.
		do
			remove_command (arm_command, a_command, argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is released.
		do
			remove_command (disarm_command, a_command, argument)
		end;

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current draw button is exposed.
		do
			remove_command (expose_command, a_command, argument)
		end;

feature {NONE} -- Implementation

	font: FONT is
		do
		end;

	set_font (a_font: FONT) is
			-- Set font label to `font_name'.
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




end -- class DRAW_B_IMP


indexing

	description: 
		"EiffelVision implementation of Motif drawn button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	DRAW_B_M 

inherit

	DRAW_B_I
		undefine
			is_equal
		end;

	DRAWING_X
		undefine
			display
		redefine
			display_handle
		end;

	BUTTON_M
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

creation

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
			set_shadow_in (False);
			set_push_button_enabled (True);
			a_draw_b.set_font_imp (Current);
			create_gc (mel_screen)
		end;

feature -- Access

	display_handle: POINTER;
			-- C handle to the display

feature -- Status setting

	allow_recompute_size is
			-- Allow Current to recompute its size
			-- according to the children.
		do
			set_recomputing_size_allowed (True)
		end;

	forbid_recompute_size is
			-- Forbid Current to recompute its size
			-- according to the children.
		do
			set_recomputing_size_allowed (False)
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is activated.
		do
			add_activate_callback (mel_vision_callback (a_command), argument)
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is armed.
		do
			add_arm_callback (mel_vision_callback (a_command), argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current push button is released.
		do
			add_disarm_callback (mel_vision_callback (a_command), argument)
		end;

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current draw button is exposed.
		do
			add_expose_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is activated.
		do
			remove_activate_callback (mel_vision_callback (a_command), argument)
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is armed.
		do
			remove_arm_callback (mel_vision_callback (a_command), argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is released.
		do
			remove_disarm_callback (mel_vision_callback (a_command), argument)
		end;

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current draw button is exposed.
		do
			remove_expose_callback (mel_vision_callback (a_command), argument)
		end;

feature {NONE} -- Implementation

	font: FONT is
		do
		end;

	set_font (a_font: FONT) is
			-- Set font label to `font_name'.
		do
		end

end -- class DRAW_B_M

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

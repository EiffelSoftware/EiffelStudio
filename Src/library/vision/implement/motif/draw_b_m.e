indexing

	description: 
		"EiffelVision implementation of Motif drawn button.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	DRAW_B_M 

inherit

	DRAWING_X;

	DRAW_B_I;

	BUTTON_M
		undefine
			create_callback_struct, shown
		end;

	FONTABLE_M;

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
			is_shown as shown
		select
			mel_drawn_make
		end

creation

	make

feature {NONE} -- Initialization

	make (a_draw_b: DRAW_B; man: BOOLEAN) is
			-- Create a motif draw button.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_drawn_make (a_draw_b.identifier,
					mel_parent (a_draw_b, widget_index),
					man);
			set_shadow_in (False);
			set_push_button_enabled (True);
			display_pointer := xt_display (screen_object);
			create_gc
		end;

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

feature {NONE}

	window_object: POINTER is
			-- X identifier of the drawable.
		do
			--Result := xt_window (screen_object)
		end;

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

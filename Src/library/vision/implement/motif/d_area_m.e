indexing

	description: 
		"EiffelVision implementation of a Motif drawing area.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	D_AREA_M 

inherit

	DRAWING_X
		export
			{NONE} all
		undefine
			display, is_equal
		redefine
			display_handle
		end;

	D_AREA_I
		undefine
			is_equal
		end;

	PRIMITIVE_M
		undefine
			create_callback_struct, clean_up, object_clean_up, mel_destroy
		redefine	
			display_handle
		end;

	MEL_DRAWING_AREA
		rename
			make as mel_draw_make,
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
			shown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_drawing_area: DRAWING_AREA; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif drawing area.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_draw_make (a_drawing_area.identifier, mc, man);
			create_gc (mel_screen)
		end

feature -- Access

	display_handle: POINTER;
			-- C handle to the display

feature -- Element change

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		do
			add_expose_callback (mel_vision_callback (a_command), argument)
		end;

	add_input_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- a key is pressed or when a mouse button is pressed.
		do
			add_input_callback (mel_vision_callback (a_command), argument)
		end;

	add_resize_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is resized.
		do
			add_resize_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Removal

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		do
			remove_expose_callback (mel_vision_callback (a_command), argument)
		end;

	remove_input_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- a key is pressed or when a mouse button is pressed.
		do
			remove_input_callback (mel_vision_callback (a_command), argument)
		end;

	remove_resize_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is resized.
		do
			remove_resize_callback (mel_vision_callback (a_command), argument)
		end;

feature {NONE} -- Implementation

	window_object: POINTER is
			-- X identifier of the drawable.
		do
			--Result := xt_window (screen_object)
		end;

end -- class D_AREA_M

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

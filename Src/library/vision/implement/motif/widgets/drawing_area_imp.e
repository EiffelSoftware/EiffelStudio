indexing

	description: 
		"EiffelVision implementation of a Motif drawing area.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	DRAWING_AREA_IMP

inherit

	DRAWING_IMP
		export
			{NONE} all
		undefine
			display, is_equal
		redefine
			display_handle
		end;

	DRAWING_AREA_I
		undefine
			is_equal
		end;

	PRIMITIVE_IMP
		undefine
			create_callback_struct, clean_up, object_clean_up, mel_destroy,
			mel_set_insensitive
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
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (expose_command);
			if list = Void then
				!! list.make;
				set_expose_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_input_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- a key is pressed or when a mouse button is pressed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (input_command);
			if list = Void then
				!! list.make;
				set_input_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_resize_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is resized.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (resize_command);
			if list = Void then
				!! list.make;
				set_resize_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

feature -- Removal

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		do
			remove_command (expose_command, a_command, argument)
		end;

	remove_input_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- a key is pressed or when a mouse button is pressed.
		do
			remove_command (input_command, a_command, argument)
		end;

	remove_resize_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is resized.
		do
			remove_command (resize_command, a_command, argument)
		end;

feature {NONE} -- Implementation

	window_object: POINTER is
			-- X identifier of the drawable.
		do
			--Result := xt_window (screen_object)
		end;

end -- class DRAWING_AREA_IMP


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


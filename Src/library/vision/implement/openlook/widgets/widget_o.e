
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class WIDGET_O 

inherit

	WIDGET_R_O
		export
			{NONE} all
		end;

	G_ANY_O
		export
			{NONE} all
		end;

	WIDGET_X
		export
			{NONE} all
		end;
	
feature {NONE}

	destroy_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when
			-- current widget is destroyed

feature 

	add_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current widget is destroyed.
		require
			not_a_command_void: not (a_command = Void)
		do
			if (destroy_actions = Void) then
				!! destroy_actions.make (action_target, Odestroy, widget_oui)
			end;
			destroy_actions.add (a_command, argument)
		end;

	remove_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current widget is destroyed.
		require
			not_a_command_void: not (a_command = Void)
		do
			destroy_actions.remove (a_command, argument)
		end; 

	height: INTEGER is
			-- Height of widget
		
		local
			ext_name: ANY;
		do
			ext_name := Oheight.to_c;		
			Result := get_dimension (screen_object, $ext_name)
		ensure
			height_large_enough: Result >= 0
		end;	
	
	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		require
			a_color_exists: not (a_color = Void)
		
		local
			color_implementation: COLOR_X;
			pixmap_implementation: PIXMAP_X;
			ext_name: ANY;
		do
			if not (background_pixmap = Void) then
				pixmap_implementation ?= background_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				background_pixmap := Void
			end;
			if not (bg_color = Void) then
				color_implementation ?= bg_color.implementation;
				color_implementation.remove_object (Current)
			end;
			bg_color := a_color;
			color_implementation ?= bg_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Obackground.to_c;		
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		ensure
			background_color = a_color;
			(background_pixmap = Void)
		end;

	set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set background_pixmap to `a_pixmap'.
		require
			a_pixmap_exists: not (a_pixmap = Void)
		
		local
			color_implementation: COLOR_X;
			pixmap_implementation: PIXMAP_X;
			ext_name: ANY;
		do
			if not (background_color = Void) then
				color_implementation ?= background_color.implementation;
				color_implementation.remove_object (Current);
				bg_color := Void
			end;
			if not (background_pixmap = Void) then
				pixmap_implementation ?= background_pixmap.implementation;
				pixmap_implementation.remove_object (Current)
			end;
			background_pixmap := a_pixmap;
			pixmap_implementation ?= background_pixmap.implementation;
			pixmap_implementation.put_object (Current);
			ext_name := ObackgroundPixmap.to_c;		
			c_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
		ensure
			background_pixmap = a_pixmap;
			(background_color = Void)
		end; 

	set_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set cursor label to `cursor_name'.
		require
			a_cursor_exists: not (a_cursor = Void)
		
		local
			display_pointer: POINTER;
			cursor_implementation: SCREEN_CURSOR_X
		do
			if not (cursor = Void) then
				cursor_implementation ?= cursor.implementation;
				cursor_implementation.remove_object (Current)
			end;
			cursor := a_cursor;
			cursor_implementation ?= cursor.implementation;
			cursor_implementation.put_object (Current);
			display_pointer := xt_display (screen_object);
			x_define_cursor (display_pointer, xt_window (screen_object), cursor_implementation.cursor_id (screen));
			x_flush (display_pointer)
		ensure
			cursor = a_cursor
		end; 

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		require
			height_large_enough: new_height >= 0
		
		local
			ext_name: ANY;
		do
			ext_name := Oheight.to_c;		
			set_dimension (screen_object, new_height, $ext_name)
		end; 

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		require
			width_large_enough: new_width >= 0;
			height_large_enough: new_height >= 0
		do
			set_width (new_width);
			set_height (new_height);
		end; 

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		require
			width_large_enough: new_width >= 0;
		local
			ext_width: ANY
		do
			ext_width := Owidth.to_c;
			set_dimension (screen_object, new_width, $ext_width);
		end;

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		local
			ext_name: ANY;
		do
			ext_name := Ox.to_c;		
			set_posit (screen_object, new_x, $ext_name)
		end; 

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		local
			ext_x, ext_y: ANY
		do
			ext_x := Ox.to_c;
			ext_y := Oy.to_c;
			set_posit (screen_object, new_x, $ext_x);
			set_posit (screen_object, new_y, $ext_y)
		end; 

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		
		local
			ext_y: ANY
		do
			ext_y := Oy.to_c;
			set_posit (screen_object, new_y, $ext_y)
		end; 
			
feature {COLOR_X}

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		
		local
			ext_name: ANY;
			color_implementation: COLOR_X
		do
			ext_name := Obackground.to_c;		
			color_implementation ?= background_color.implementation;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		end;

	
feature {PIXMAP_X}

	update_background_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			ext_name: ANY;
			pixmap_implementation: PIXMAP_X
		do
			ext_name := ObackgroundPixmap.to_c;
			pixmap_implementation ?= background_pixmap.implementation;
			c_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
		end; 

			
feature 

	width: INTEGER is
			-- Width of widget
		local
			ext_name: ANY;
		do
			ext_name := Owidth.to_c;		
			Result := get_dimension (screen_object, $ext_name)
		ensure
			width_large_enough: Result >= 0
		end; 

	x: INTEGER is
			-- Horizontal position relative to parent
		local
			ext_name: ANY;
		do
			ext_name := Ox.to_c;		
			Result := get_position (screen_object, $ext_name)
		end; 

	y: INTEGER is
			-- Vertical position relative to parent
		
		local
			ext_name: ANY;
		do
			ext_name := Oy.to_c;		
			Result := get_position (screen_object, $ext_name)
		end

invariant

	(background_color = Void) or (background_pixmap = Void)

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

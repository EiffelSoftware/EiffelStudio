
-- Motif widget implementation.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class WIDGET_M 

inherit

	WIDGET_R_M
		export
			{NONE} all
		end;

	G_ANY_M
		export
			{NONE} all
		end;

	WIDGET_X
		rename	
			clean_up as widget_x_clean_up
		end

	WIDGET_X 
		redefine
			clean_up
		select
			clean_up
		end

feature

	height: INTEGER is
			-- Height of widget
		local
			ext_name: ANY
		do
			ext_name := Mheight.to_c;
			Result := get_dimension (screen_object, $ext_name)
		ensure
			height_large_enough: Result >= 0
		end;

	xt_xm_string (a_resource_name: STRING): POINTER is
			-- Value of motif XmString resource with `a_resource_name'
			-- as name
		require
			not_a_resource_name_void: not (a_resource_name = Void)
		local
			ext_name: ANY
		do
			ext_name := a_resource_name.to_c;
			Result := get_xm_string (screen_object, $ext_name)
		end;

feature {NONE}

	clean_up is
		do
			widget_x_clean_up;
			if destroy_actions /= Void then
				destroy_actions.free_cdfd
			end
		end;

	destroy_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when
			-- current widget is destroyed

	parent_screen_object (a_widget: WIDGET; index: INTEGER): POINTER is
		do
			Result := widget_manager.parent_using_index
						(a_widget, index).implementation.screen_object
		end;

feature

	remove_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current widget is destroyed.
		require
			not_a_command_void: not (a_command = Void)
		do
			destroy_actions.remove (a_command, argument)
		end;

	add_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current widget is destroyed.
		require
			not_a_command_void: not (a_command = Void)
		do
			if (destroy_actions = Void) then
				!! destroy_actions.make (action_target,
						Mdestroy, widget_oui)
			end;
			destroy_actions.add (a_command, argument)
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		require
			a_color_exists: a_color /= Void
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if not (background_pixmap = Void) then
				pixmap_implementation ?= background_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				background_pixmap := Void
			end;
			if not (background_color = Void) then
				color_implementation ?= background_color.implementation;
				color_implementation.remove_object (Current)
			end;
			bg_color := a_color;
			color_implementation ?= background_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mbackground.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		ensure
			background_color = a_color;
			(background_pixmap = Void)
		end;

	set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set background_pixmap to `a_pixmap'.
		require
			a_pixmap_exists: a_pixmap /= Void
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY
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
			ext_name := MbackgroundPixmap.to_c;
			c_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
		ensure
			background_pixmap = a_pixmap;
			--(background_color = Void)
		end;

	set_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set cursor label to `cursor_name'.
		require
			a_cursor_exists: not (a_cursor = Void)
		local
			display_pointer: POINTER;
			cursor_implementation: SCREEN_CURSOR_X
		do
			cursor_implementation ?= a_cursor.implementation;
			if cursor /= Void then
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
			ext_name: ANY
		do
			ext_name := Mheight.to_c;
			set_dimension (screen_object, new_height, $ext_name)
		end;

feature {NONE}

	set_xt_xm_string (a_xm_string: POINTER; a_resource_name: STRING) is
			-- Assign `a_xm_string' to motif XmString resource
			-- with `a_resource_name' as name.
		require
			not_a_resource_name_void: not (a_resource_name = Void)
		local
			ext_name: ANY
		do
			ext_name := a_resource_name.to_c;
			set_xm_string (screen_object, a_xm_string, $ext_name)
		end;

feature 

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		require
			width_large_enough: new_width >= 0;
			height_large_enough: new_height >= 0
		local
			ext_name_Mw, ext_name_Mh: ANY
		do
			ext_name_Mw := Mwidth.to_c;
			ext_name_Mh := Mheight.to_c;
			set_dimension (screen_object, new_width, $ext_name_Mw);
			set_dimension (screen_object, new_height, $ext_name_Mh)
		end;

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		require
			width_large_enough: new_width >= 0;
		local
			ext_name_Mw: ANY
		do
			ext_name_Mw := Mwidth.to_c;
			set_dimension (screen_object, new_width, $ext_name_Mw)
		end;

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		local
			ext_name: ANY
		do
			ext_name := Mx.to_c;
			set_posit (screen_object, new_x, $ext_name)
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		local
			ext_name_Mx, ext_name_My: ANY
		do
			ext_name_Mx := Mx.to_c;
			ext_name_My := My.to_c;
			set_posit (screen_object, new_x, $ext_name_Mx);
			set_posit (screen_object, new_y, $ext_name_My)
		end;

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		local
			ext_name: ANY
		do
			ext_name := My.to_c;
			set_posit (screen_object, new_y, $ext_name)
		end;

feature {COLOR_X}

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X;
		do
			ext_name := Mbackground.to_c;
			color_implementation ?= background_color.implementation;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name) 
		end;

feature {PIXMAP_X}

	update_background_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			ext_name: ANY;
			pixmap_implementation: PIXMAP_X;
		do
			ext_name := MbackgroundPixmap.to_c;
			pixmap_implementation ?= background_pixmap.implementation;
			c_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
		end;

feature 

	width: INTEGER is
			-- Width of widget
		local
			ext_name: ANY
		do
			ext_name := Mwidth.to_c;
			Result := get_dimension (screen_object, $ext_name)
		ensure
			width_large_enough: Result >= 0
		end;

	x: INTEGER is
			-- Horizontal position relative to parent
		local
			ext_name: ANY
		do
			ext_name := Mx.to_c;
			Result := get_position (screen_object, $ext_name)
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		local
			ext_name: ANY
		do
			ext_name := My.to_c;
			Result := get_position (screen_object, $ext_name)
		end

feature {NONE} -- External features

	set_xm_string (scr_obj: POINTER; value: POINTER; name: ANY) is
		external
			"C"
		end;

	get_xm_string (scr_obj: POINTER; r_name: ANY): POINTER is
		external
			"C"
		end;

invariant

	(background_color = Void) or (background_pixmap = Void)

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


indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PULLDOWN_O 

inherit

	PULLDOWN_I
		
		export
			{NONE} all
		end;

	MENU_O
		redefine
			action_target,
			destroy,
			grab,
			height, width,
			hide, show, insensitive,
			managed, real_x, real_y,
			set_foreground,
			set_background_color,
			set_background_pixmap,
			realize, realized,
			set_cursor,
			set_insensitive,
			set_height, set_size, set_width,
			set_managed,
			set_x, set_x_y, set_y,
			shown,
			ungrab, unrealize,
			update_background_color,
			update_background_pixmap,
			update_cursor,
			x, y
		end;
	
feature 

	button: BUTTON;

	text: STRING is
			-- Label of option button
		do
			Result := button.text
		end; 

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		do
			button.set_text(a_text)
		end; 

	width: INTEGER is
			-- Width of widget
		do
			Result := button.width
		ensure then
			width_large_enough: Result >= 0
		end;

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := button.x
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := button.y
		end;

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		do
		end;

	update_background_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		do
		end;

	update_cursor is
			-- Update the X cursor after a change inside the Eiffel cursor.
		do
		end;

	ungrab is
			-- Release the mouse and the keyboard from an earlier grab.
		require else
			widget_realized: realized
		do
			button.ungrab
		end;

	unrealize is
			-- Destroy screen window implementation and all
			-- screen window implementations of its children if `flag'.
		do
		end; 

	show is
			-- Make widget visible on the screen.
		require else
			widget_realized: realized
		do
			button.show
		ensure then
			shown
		end;

	shown: BOOLEAN is
			-- Is current widget visible on the screen?
		require else
			widget_realized: realized
		do
			Result := button.shown
		end;

	set_foreground (a_color: COLOR) is
			-- Set `foreground' to `a_color'.
		require else
			a_color_exists: not (a_color = Void)
		do
			button.set_foreground (a_color);
		ensure then
			foreground = a_color
		end;


	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		do
			button.set_x (new_x)
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do
			button.set_x_y (new_x, new_y)
		end; -- set_x_y

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		do
			button.set_y (new_y)
		end;

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		require else
			width_large_enough: new_width >= 0;
		do
			button.set_width (new_width)
		end;

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		require else
			width_large_enough: new_width >= 0;
			height_large_enough: new_height >= 0
		do
			button.set_size (new_width, new_height)
		end;

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		require else
			height_large_enough: new_height >= 0
		do
			button.set_height (new_height)
		end;

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		do
			if flag then
				button.manage
			else
				button.unmanage
			end
		ensure then
			managed = flag
		end; 
		
	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if `flag'. This means
			-- that any events with an event type of KeyPress,
			-- KeyRelease, ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or FocusOut will
			-- not be dispatched to current widget and to all its children.
			-- Set it to sensitive mode otherwise.
		do
			if flag then
				button.set_insensitive
			else
				button.set_sensitive
			end
		ensure then
			insensitive = flag
		end;

	set_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set cursor label to `cursor_name'.
		require else
			a_cursor_exists: not (a_cursor = Void)
		do
			button.set_cursor (a_cursor)
		ensure then
			cursor = a_cursor
		end;

	set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set background_pixmap to `a_pixmap'.
		require else
			a_pixmap_exists: not (a_pixmap = Void)
		do
			button.set_background_pixmap (a_pixmap);
		ensure then
			background_pixmap = a_pixmap;
			background_color = Void
		end; 

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		require else
			a_color_exists: not (a_color = Void)
		do
			button.set_background_color (a_color);
		ensure then
			background_color = a_color;
			background_pixmap = Void
		end;

	realize is
			-- Create screen window implementation and all
			-- screen window implementations of its children if `flag'.
		do
		end; 

	realized: BOOLEAN is
			-- Is X window realized?
		do
			Result :=  button.realized
		end;

	real_x: INTEGER is
			-- Vertical position relative to root window
		do
			Result := button.real_x
		end;

	real_y: INTEGER is
			-- Horizontal position relative to root window
		do
			Result := button.real_y
		end;

	managed: BOOLEAN is
			-- Is there geometry managment on X widget implementation
			-- perform by window manager of parent widget?
		do
			Result := button.managed
		end;

	insensitive: BOOLEAN is
			-- Is current widget insensitive?
		do
			Result := button.insensitive
		end;

	height: INTEGER is
			-- Height of widget
		do
			Result := button.height
		end;

	hide is
			-- Make widget invisible on the screen.
		require else
			widget_realized: realized
		do
			button.hide
		end;

	grab (a_cursor: SCREEN_CURSOR) is
			-- Grab the mouse and the keyboard.
			-- If `cursor' is not void, the pointer will have the shape
			-- set by cursor during the grab.
		require else
			widget_realized: realized
		do
			button.grab (a_cursor)
		end;

	destroy is
			-- Destroy X widget implementation and all
			-- X widget implementations of its children.
		do
			button.destroy
		end;

	action_target: POINTER is
			-- Widget ID on which action must be applied
		do
			Result := button.implementation.screen_object
		end;


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

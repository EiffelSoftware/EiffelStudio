
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class WM_SHELL_O

inherit

	WM_SHELL_R_O
		export
			{NONE} all
		end;

	WM_SHELL_I

feature {NONE}

	screen_object: POINTER is
		-- Pointer on current openlook window manager shell
		deferred
		end;
	
feature 

	set_base_height (a_height: INTEGER) is
			-- Set `base_height' to `a_height'. 
		require else
			height_large_enough: a_height >= 0
		do
			set_xt_int (screen_object, a_height, ObaseHeight)
		ensure then
			base_height = a_height
		end;

 	base_height: INTEGER is
			-- Base for a progression of preferred heights
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred heights are `base_heights' plus
			-- integral multiples of `height_inc'
		do
			Result := xt_int (screen_object, ObaseHeight)
		ensure then
			Result >= 0
		end;

	set_base_width (a_width: INTEGER) is
			-- Set `base_width' to `a_width'.
		require else
			width_large_enough: a_width >= 0
		do
			set_xt_int (screen_object, a_width, ObaseWidth)
		ensure then
			base_width = a_width
		end; 

	base_width: INTEGER is
			-- Base for a progression of preferred widths
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred widths are `base_heights' plus
			-- integral multiples of `width_inc'
		do
			Result := xt_int (screen_object, ObaseWidth)
		ensure then
			Result >= 0
		end;

	set_height_inc (an_increment: INTEGER) is
			-- Set `height_inc' to `an_increment'.
		require else
			an_increment_large_enought: an_increment >= 0
		
		do
			set_xt_int (screen_object, an_increment, OheightInc)
		ensure then
			height_inc = an_increment
		end;

	height_inc: INTEGER is
			-- Increment for a progression of preferred
			-- heights for the window manager tu use in sizing 
			-- widgets.
		do
			Result := xt_int (screen_object, OheightInc)
		ensure then
			Result >= 0
		end;

	set_width_inc (an_increment: INTEGER) is
			-- Set `width_inc' to `an_increment'.
		require else
			an_increment_large_enough: an_increment >= 0
		
		do
			set_xt_int (screen_object, an_increment, OwidthInc)
		ensure then
			width_inc = an_increment
		end;

	width_inc: INTEGER is
			-- Increment for a progression of preferred
			-- widths for the window manager tu use in sizing
			-- widgets.
		do
			Result := xt_int (screen_object, OwidthInc)
		ensure then
			Result >= 0
		end; 

	set_icon_mask (a_mask: PIXMAP) is
			-- Set `icon_mask' to `a_mask'.
		require else
			not_a_mask_void: not (a_mask = Void)
		do
		end;

	icon_mask: PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
		end;

	set_icon_pixmap (a_pixmap: PIXMAP) is
			-- Set `icon_pixmap' to `a_pixmap'.
		require else
			not_a_pixmap_void: not (a_pixmap = Void)
		do
		end; 

	icon_pixmap: PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		do
		end;

	set_icon_x (x_value: INTEGER) is
			-- Set `icon_x' to `x_value'.
		do
			set_xt_int (screen_object, x_value, OiconX)
		end;

	icon_x: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
			Result := xt_int (screen_object, OiconX)
		end; 

	set_icon_y (y_value: INTEGER) is
			-- Set `icon_y' to `y_value'.
		do
			set_xt_int (screen_object, y_value, OiconY)
		end;

	icon_y: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
			Result := xt_int (screen_object, OiconY)
		end;

	set_max_aspect_x (a_max: INTEGER) is
			-- Set `max_aspect_x' to `a_max'.
		do
			set_xt_int (screen_object, a_max, OmaxAspectX)
		ensure then
			max_aspect_x = a_max
		end;

	max_aspect_x: INTEGER is
			-- Numerator of maximum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
			Result := xt_int (screen_object, OmaxAspectX)
		end;

	set_max_aspect_y (a_max: INTEGER) is
			-- Set `max_aspect_y' to `a_max'.
		do
			set_xt_int (screen_object, a_max, OmaxAspectY)
		ensure then
			max_aspect_y = a_max
		end;

	max_aspect_y: INTEGER is
			-- Denominator of maximum ration (X/Y) that
			-- application wishes widget instance to have
		do
			Result := xt_int (screen_object, OmaxAspectY)
		end; -- max_aspect_y

	set_max_height (a_height: INTEGER) is
			-- Set `max_height' to `a_height'.
		require else
			a_height_large_enough: a_height >= 1
		do
			set_xt_int (screen_object, a_height, OmaxHeight)
		ensure then
			max_height = a_height
		end;

	max_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		do
			Result := xt_int (screen_object, OmaxHeight)
		ensure then
			Result >= 1
		end;

	set_max_width (a_max: INTEGER) is
			-- Set `max_width' to `a_max'.
		require else
			a_max_large_enough: a_max >= 1
		do
			set_xt_int (screen_object, a_max, OmaxWidth)
		ensure then
			max_width = a_max
		end;

	max_width: INTEGER is
			-- Maximum width that application wishes widget
			-- instance to have
		do
			Result := xt_int (screen_object, OmaxWidth)
		ensure then
			Result >= 1
		end;

	set_min_aspect_x (a_min: INTEGER) is
			-- Set `min_aspect_x' to `a_min'.
		do
			set_xt_int (screen_object, a_min, OminAspectX)
		ensure then
			min_aspect_x = a_min
		end;

	min_aspect_x: INTEGER is
			-- Numerator of minimum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
			Result := xt_int (screen_object, OminAspectX)
		end;

	set_min_aspect_y (a_min: INTEGER) is
			-- Set `min_aspect_y' to `a_min'.
		do
			set_xt_int (screen_object, a_min, OminAspectY)
		ensure then
			min_aspect_y = a_min
		end;

	min_aspect_y: INTEGER is
			-- Denominator of minimum ration (X/Y) that
			-- application wishes widget instance to have
		
		do
			Result := xt_int (screen_object, OminAspectY)
		end;

	set_min_height (a_min: INTEGER) is
			-- Set `min_height' to `a_min'.
		require else
			a_min_large_enough: a_min >= 1
		do
			set_xt_int (screen_object, a_min, OminHeight)
		ensure then
			min_height = a_min
		end;

	min_height: INTEGER is
			-- minimum height that application wishes widget
			-- instance to have
		do
			Result := xt_int (screen_object, OminHeight)
		ensure then
			Result >= 1
		end;

	set_min_width (a_min: INTEGER) is
			-- Set `min_width' to `a_min'.
		require else
			a_min_large_enough: a_min >= 1
		do
			set_xt_int (screen_object, a_min, OminWidth)
		ensure then
			min_width = a_min
		end; 

	min_width: INTEGER is
			-- minimum width that application wishes widget
			-- instance to have
		do
			Result := xt_int (screen_object, OminWidth)
		ensure then
			Result >= 1
		end;

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		require else
			not_a_title_void: not (a_title = Void)
		do
			set_xt_string (screen_object, a_title, Otitle)
		end;

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		do
			Result := xt_string (screen_object, Otitle)
		end;

	set_widget_group (a_widget: WIDGET) is
			-- Set `widget_group' to `a_widget'.
		do
		end; 

	widget_group: WIDGET;
			-- Widget with which current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together

	xt_int (target: POINTER; a_resource: STRING): INTEGER is
		deferred
		end;

	xt_string (target: POINTER; a_resource: STRING): STRING is
		deferred
		end;

	set_xt_int (target: POINTER; val: INTEGER; a_resource: STRING) is
		deferred
		end;

	set_xt_string (target: POINTER; val: STRING; a_resource: STRING) is
		deferred
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

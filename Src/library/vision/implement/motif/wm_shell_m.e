
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class WM_SHELL_M

inherit

	WM_SHELL_R_M
		export
			{NONE} all
		end;

	WM_SHELL_I;

feature {NONE}

	screen_object: POINTER is
		-- Pointer on current motif window manager shell
		deferred
		end; -- screen_object

feature 

	set_base_height (a_height: INTEGER) is
			-- Set `base_height' to `a_height'. 
		require else
			height_large_enough: a_height >= 0
		local
			ext_name: ANY
		do
			ext_name := MbaseHeight.to_c;
			m_wm_shell_set_int (screen_object, a_height, $ext_name)
		ensure then
			base_height = a_height
		end;

 	base_height: INTEGER is
			-- Base for a progression of preferred heights
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred heights are `base_heights' plus
			-- integral multiples of `height_inc'
		local
			ext_name: ANY
		do
			ext_name := MbaseHeight.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		ensure then
			Result >= 0
		end;

	set_base_width (a_width: INTEGER) is
			-- Set `base_width' to `a_width'.
		require else
			width_large_enough: a_width >= 0
		local
			ext_name: ANY
		do
			ext_name := MbaseWidth.to_c;
			m_wm_shell_set_int (screen_object, a_width, $ext_name)
		ensure then
			base_width = a_width
		end;

	base_width: INTEGER is
			-- Base for a progression of preferred widths
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred widths are `base_heights' plus
			-- integral multiples of `width_inc'
		local
			ext_name: ANY
		do
			ext_name := MbaseWidth.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		ensure then
			Result >= 0
		end;

	set_height_inc (an_increment: INTEGER) is
			-- Set `height_inc' to `an_increment'.
		require else
			an_increment_large_enought: an_increment >= 0
		local
			ext_name: ANY
		do
			ext_name := MheightInc.to_c;
			m_wm_shell_set_int (screen_object, an_increment, $ext_name)
		ensure then
			height_inc = an_increment
		end;

	height_inc: INTEGER is
			-- Increment for a progression of preferred
			-- heights for the window manager tu use in sizing 
			-- widgets.
		local
			ext_name: ANY
		do
			ext_name := MheightInc.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		ensure then
			Result >= 0
		end;

	set_width_inc (an_increment: INTEGER) is
			-- Set `width_inc' to `an_increment'.
		require else
			an_increment_large_enough: an_increment >= 0
		local
			ext_name: ANY
		do
			ext_name := MwidthInc.to_c;
			m_wm_shell_set_int (screen_object, an_increment, $ext_name)
		ensure then
			width_inc = an_increment
		end;

	width_inc: INTEGER is
			-- Increment for a progression of preferred
			-- widths for the window manager tu use in sizing
			-- widgets.
		local
			ext_name: ANY
		do
			ext_name := MwidthInc.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
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
			not_a_pixmap_void: not (a_pixmap = Void);

		local
			pixmap_implementation: PIXMAP_X;
			ext_name: ANY;
			c_bitmap: POINTER;
		do
			if not (icon_pixmap = Void) then
				pixmap_implementation ?= icon_pixmap.implementation;
				pixmap_implementation.remove_object (Current)
			end;
			icon_pixmap := a_pixmap;
			pixmap_implementation ?= icon_pixmap.implementation;
			c_bitmap := pixmap_implementation.resource_pixmap (screen);
			pixmap_implementation.put_object (Current);
			ext_name := MiconPixmap.to_c;
			c_set_pixmap (screen_object, c_bitmap, $ext_name)
		ensure then
			icon_pixmap = a_pixmap

		end;

	icon_pixmap: PIXMAP;
			-- Bitmap that could be used by the window manager
			-- as the application's icon

feature {NONE}

	screen: SCREEN_I is
			--widget screen
		deferred
		ensure
			valid_screen: Result /= Void;
		end;

	update_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			ext_name: ANY;
			pixmap_implementation: PIXMAP_X
		do
			ext_name := MiconPixmap.to_c;
			pixmap_implementation ?= icon_pixmap.implementation;
			c_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
		end


feature

	set_icon_x (x_value: INTEGER) is
			-- Set `icon_x' to `x_value'.
		local
			ext_name: ANY
		do
			ext_name := MiconX.to_c;
			m_wm_shell_set_int (screen_object, x_value, $ext_name)
		end;

	icon_x: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		local
			ext_name: ANY
		do
			ext_name := MiconX.to_c;	
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		end; -- icon_x

	set_icon_y (y_value: INTEGER) is
			-- Set `icon_y' to `y_value'.
		local
			ext_name: ANY
		do
			ext_name := MiconY.to_c;
			m_wm_shell_set_int (screen_object, y_value, $ext_name)
		end; -- set_icon_y

	icon_y: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		local	
			ext_name: ANY
		do
			ext_name := MiconY.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		end;

	set_max_aspect_x (a_max: INTEGER) is
			-- Set `max_aspect_x' to `a_max'.
		local
			ext_name: ANY
		do
			ext_name := MmaxAspectX.to_c;
			m_wm_shell_set_int (screen_object, a_max, $ext_name)
		ensure then
			max_aspect_x = a_max
		end;

	max_aspect_x: INTEGER is
			-- Numerator of maximum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		local
			ext_name: ANY
		do
			ext_name := MmaxAspectX.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		end;

	set_max_aspect_y (a_max: INTEGER) is
			-- Set `max_aspect_y' to `a_max'.
		local
			ext_name: ANY
		do
			ext_name := MmaxAspectY.to_c;
			m_wm_shell_set_int (screen_object, a_max, $ext_name)
		ensure then
			max_aspect_y = a_max
		end;

	max_aspect_y: INTEGER is
			-- Denominator of maximum ration (X/Y) that
			-- application wishes widget instance to have
		local
			ext_name: ANY
		do
			ext_name := MmaxAspectY.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		end;

	set_max_height (a_height: INTEGER) is
			-- Set `max_height' to `a_height'.
		require else
			a_height_large_enough: a_height >= 1
		local
			ext_name: ANY
		do
			m_wm_shell_set_int (screen_object, a_height, $ext_name)
		ensure then
			max_height = a_height
		end;

	max_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		local
			ext_name: ANY
		do
			ext_name := MmaxHeight.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		ensure then
			Result >= 1
		end;

	set_max_width (a_max: INTEGER) is
			-- Set `max_width' to `a_max'.
		require else
			a_max_large_enough: a_max >= 1
		local
			ext_name: ANY
		do
			ext_name := MmaxWidth.to_c;
			m_wm_shell_set_int (screen_object, a_max, $ext_name)
		ensure then
			max_width = a_max
		end;

	max_width: INTEGER is
			-- Maximum width that application wishes widget
			-- instance to have
		local
			ext_name: ANY
		do
			ext_name := MmaxWidth.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		ensure then
			Result >= 1
		end;

	set_min_aspect_x (a_min: INTEGER) is
			-- Set `min_aspect_x' to `a_min'.
		local	
			ext_name: ANY
		do	
			ext_name := MminAspectX.to_c;
			m_wm_shell_set_int (screen_object, a_min, $ext_name)
		ensure then
			min_aspect_x = a_min
		end;

	min_aspect_x: INTEGER is
			-- Numerator of minimum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		local
			ext_name: ANY
		do
			ext_name := MminAspectX.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		end;

	set_min_aspect_y (a_min: INTEGER) is
			-- Set `min_aspect_y' to `a_min'.
		local
			ext_name: ANY
		do
			ext_name := MminAspectY.to_c;
			m_wm_shell_set_int (screen_object, a_min, $ext_name)
		ensure then
			min_aspect_y = a_min
		end;

	min_aspect_y: INTEGER is
			-- Denominator of minimum ration (X/Y) that
			-- application wishes widget instance to have
		local
			ext_name: ANY
		do
			ext_name := MminAspectY.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name) 
		end;

	set_min_height (a_min: INTEGER) is
			-- Set `min_height' to `a_min'.
		require else
			a_min_large_enough: a_min >= 1
		local
			ext_name: ANY
		do
			ext_name := MminHeight.to_c;
			m_wm_shell_set_int (screen_object, a_min, $ext_name)
		ensure then
			min_height = a_min
		end;

	min_height: INTEGER is
			-- minimum height that application wishes widget
			-- instance to have
		local
			ext_name: ANY
		do
			ext_name := MminHeight.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		ensure then
			Result >= 1
		end;

	set_min_width (a_min: INTEGER) is
			-- Set `min_width' to `a_min'.
		require else
			a_min_large_enough: a_min >= 1
		local
			ext_name: ANY
		do
			ext_name := MminWidth.to_c;
			m_wm_shell_set_int (screen_object, a_min, $ext_name)
		ensure then
			min_width = a_min
		end;

	min_width: INTEGER is
			-- minimum width that application wishes widget
			-- instance to have
		local
			ext_name: ANY
		do
			ext_name := MminWidth.to_c;
			Result := m_wm_shell_get_int (screen_object, $ext_name)
		ensure then
			Result >= 1
		end;

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		require else
			not_a_title_void: not (a_title = Void)
		local
			ext_name, ext_name_title: ANY
		do
			ext_name_title := a_title.to_c;
			ext_name := Mtitle.to_c;
			m_wm_shell_set_string (screen_object, $ext_name_title,
$ext_name)
		end;

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		local
			ext_name: ANY
		do
			ext_name := Mtitle.to_c;
			Result := m_wm_shell_get_string (screen_object, $ext_name)
		end;

	set_widget_group (a_widget: WIDGET) is
			-- Set `widget_group' to `a_widget'.
		do
		end;

	widget_group: WIDGET

feature {NONE} -- External features

	m_wm_shell_set_int (scr_obj: POINTER; value: INTEGER; name: ANY) is
		external
			"C"
		end;

	m_wm_shell_get_string (scr_obj: POINTER; name: ANY): STRING is
		external
			"C"
		end;

	m_wm_shell_set_string (scr_obj: POINTER; name1, name2: ANY) is
		external
			"C"
		end;

	m_wm_shell_get_int (scr_obj: POINTER; name: ANY): INTEGER is
		external
			"C"
		end;

	c_set_pixmap (scr_obj, pix: POINTER; resource: ANY) is
		external
			"C"
		end; 


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

indexing

	description:
		"WMShell contains information that is required by the window %
		%manager (e.g. size, its icon)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	WM_SHELL 

feature -- Access

	icon_mask: PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		require
			exists: not destroyed
		do
			Result := implementation.icon_mask
		end;

	icon_pixmap: PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		require
			exists: not destroyed
		do
			Result := implementation.icon_pixmap
		ensure
			valid_result: Result /= Void
		end;

	icon_x: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		require
			exists: not destroyed
		do
			Result := implementation.icon_x
		end;

	icon_y: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		require
			exists: not destroyed
		do
			Result := implementation.icon_y
		end;

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		require
			exists: not destroyed
		do
			Result := implementation.title
		end;

	widget_group: WIDGET is
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		require
			exists: not destroyed
		do
			Result := implementation.widget_group
		end 

feature -- Status report

	destroyed: BOOLEAN is
		deferred
		end;

feature -- Measurement

 	base_height: INTEGER is
			-- Base for a progression of preferred heights
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred heights are `base_heights' plus
			-- integral multiples of `height_inc'
		require
			exists: not destroyed
		do
			Result := implementation.base_height
		ensure
			Result >= 0
		end;

	base_width: INTEGER is
			-- Base for a progression of preferred widths
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred widths are `base_heights' plus
			-- integral multiples of `width_inc'
		require
			exists: not destroyed
		do
			Result := implementation.base_width
		ensure
			Result >= 0
		end;

	height_inc: INTEGER is
			-- Increment for a progression of preferred
			-- heights for the window manager tu use in sizing 
			-- widgets.
		require
			exists: not destroyed
		do
			Result := implementation.height_inc
		ensure
			Result >= 0
		end;

	width_inc: INTEGER is
			-- Increment for a progression of preferred
			-- widths for the window manager tu use in sizing
			-- widgets.
		require
			exists: not destroyed
		do
			Result := implementation.width_inc
		ensure
			Result >= 0
		end;

	max_aspect_x: INTEGER is
			-- Numerator of maximum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		require
			exists: not destroyed
		do
			Result := implementation.max_aspect_x
		end;

	max_aspect_y: INTEGER is
			-- Denominator of maximum ration (X/Y) that
			-- application wishes widget instance to have
		require
			exists: not destroyed
		do
			Result := implementation.max_aspect_y
		end;

	max_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.max_height
		ensure
			Result >= 1
		end;

	max_width: INTEGER is
			-- Maximum width that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.max_width
		ensure
			Result >= 1
		end;

	min_aspect_x: INTEGER is
			-- Numerator of minimum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		require
			exists: not destroyed
		do
			Result := implementation.min_aspect_x
		end;

	min_aspect_y: INTEGER is
			-- Denominator of minimum ration (X/Y) that
			-- application wishes widget instance to have
		require
			exists: not destroyed
		do
			Result := implementation.min_aspect_y
		end;

	min_height: INTEGER is
			-- minimum height that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.min_height
		ensure
			Result >= 1
		end;

	min_width: INTEGER is
			-- minimum width that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.min_width
		ensure
			Result >= 1
		end;

feature -- Resizig

	set_base_height (a_height: INTEGER) is
			-- Set `base_height' to `a_height'. 
		require
			exists: not destroyed;
			height_large_enough: a_height >= 0
		do
			implementation.set_base_height (a_height)
		ensure
			base_height = a_height
		end;

	set_base_width (a_width: INTEGER) is
			-- Set `base_width' to `a_width'.
		require
			exists: not destroyed;
			width_large_enough: a_width >= 0
		do
			implementation.set_base_width (a_width)
		ensure
			base_width = a_width
		end;

	set_height_inc (an_increment: INTEGER) is
			-- Set `height_inc' to `an_increment'.
		require
			exists: not destroyed;
			an_increment_large_enought: an_increment >= 0
		do
			implementation.set_height_inc (an_increment)
		ensure
			height_inc = an_increment
		end;

	set_width_inc (an_increment: INTEGER) is
			-- Set `width_inc' to `an_increment'.
		require
			exists: not destroyed;
			an_increment_large_enough: an_increment >= 0
		do
			implementation.set_width_inc (an_increment)
		ensure
			width_inc = an_increment
		end;

	set_max_aspect_x (a_max: INTEGER) is
			-- Set `max_aspect_x' to `a_max'.
		require
			exists: not destroyed
		do
			implementation.set_max_aspect_x (a_max)
		ensure
			max_aspect_x = a_max
		end;

	set_max_aspect_y (a_max: INTEGER) is
			-- Set `max_aspect_y' to `a_max'.
		require
			exists: not destroyed
		do
			implementation.set_max_aspect_y (a_max)
		ensure
			max_aspect_y = a_max
		end;

	set_max_height (a_height: INTEGER) is
			-- Set `max_height' to `a_height'.
		require
			exists: not destroyed;
			a_height_large_enough: a_height >= 1
		do
			implementation.set_max_height (a_height)
		ensure
			max_height = a_height
		end;

	set_max_width (a_max: INTEGER) is
			-- Set `max_width' to `a_max'.
		require
			exists: not destroyed;
			a_max_large_enough: a_max >= 1
		do
			implementation.set_max_width (a_max)
		ensure
			max_width = a_max
		end; 

	set_min_aspect_x (a_min: INTEGER) is
			-- Set `min_aspect_x' to `a_min'.
		require
			exists: not destroyed
		do
			implementation.set_min_aspect_x (a_min)
		ensure
			min_aspect_x = a_min
		end;

	set_min_aspect_y (a_min: INTEGER) is
			-- Set `min_aspect_y' to `a_min'.
		require
			exists: not destroyed
		do
			implementation.set_min_aspect_y (a_min)
		ensure
			min_aspect_y = a_min
		end; 

	set_min_height (a_height: INTEGER) is
			-- Set `min_height' to `a_height'.
		require
			exists: not destroyed;
			a_height_large_enough: a_height >= 1
		do
			implementation.set_min_height (a_height)
		ensure
			min_height = a_height
		end;

	set_min_width (a_min: INTEGER) is
			-- Set `min_width' to `a_min'.
		require
			exists: not destroyed;
			a_min_large_enough: a_min >= 1
		do
			implementation.set_min_width (a_min)
		ensure
			min_width = a_min
		end;

feature -- Element change

	set_icon_mask (a_mask: PIXMAP) is
			-- Set `icon_mask' to `a_mask'.
		require
			exists: not destroyed;
			not_a_mask_void: a_mask /= Void
		do
			implementation.set_icon_mask (a_mask)
		end;

	set_icon_pixmap (a_pixmap: PIXMAP) is
			-- Set `icon_pixmap' to `a_pixmap'.
		require
			exists: not destroyed;
			not_a_pixmap_void: a_pixmap /= Void;
			valid_a_pixmap: a_pixmap.is_valid
		do
			implementation.set_icon_pixmap (a_pixmap)
		end;

	set_icon_x (x_value: INTEGER) is
			-- Set `icon_x' to `x_value'.
		require
			exists: not destroyed
		do
			implementation.set_icon_x (x_value)
		end;

	set_icon_y (y_value: INTEGER) is
			-- Set `icon_y' to `y_value'.
		require
			exists: not destroyed
		do
			implementation.set_icon_y (y_value)
		end;

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		require
			exists: not destroyed;
			not_a_title_void: a_title /= Void
		do
			implementation.set_title (a_title)
		end;

	set_widget_group (a_widget: WIDGET) is
			-- Set `widget_group' to `a_widget'.
		require
			exists: not destroyed
		do
			implementation.set_widget_group (a_widget)
		end;

feature {WM_SHELL_I} -- Implementation

	set_wm_imp (a_wm_shell_imp: WM_SHELL_I) is
			-- Set window manager shell implementation to `a_wm_shell_imp'.
		do
			implementation := a_wm_shell_imp
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: WM_SHELL_I;
			-- Implementation of window manager shell

end  -- class WM_SHELL



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


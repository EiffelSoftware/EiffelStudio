indexing

	description: 
		"EiffelVision wm_shell, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"
	
--XX deferred class
class
	WM_SHELL_IMP

inherit
	WM_SHELL_I


feature -- Access

 	base_height: INTEGER is
			-- Base for a progression of preferred heights
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred heights are `base_heights' plus
			-- integral multiples of `height_inc'
		do
			check
				not_be_called: False
			end
		end;

	base_width: INTEGER is
			-- Base for a progression of preferred widths
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred widths are `base_heights' plus
			-- integral multiples of `width_inc'
		do
			check
				not_be_called: False
			end
		end;

	height_inc: INTEGER is
			-- Increment for a progression of preferred
			-- heights for the window manager tu use in sizing 
			-- widgets.
		do
			check
				not_be_called: False
			end
		end;

	width_inc: INTEGER is
			-- Increment for a progression of preferred
			-- widths for the window manager tu use in sizing
			-- widgets.
		do
			check
				not_be_called: False
			end
		end;

	icon_mask: PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
			check
				not_be_called: False
			end
		end;

	max_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		do
			check
				not_be_called: False
			end
		end;

	icon_pixmap: PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		do
			check
				not_be_called: False
			end
		end;

	max_aspect_x: INTEGER is
			-- Numerator of maximum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
			check
				not_be_called: False
			end
		end;

	icon_x: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
			check
				not_be_called: False
			end
		end;

	icon_y: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
			check
				not_be_called: False
			end
		end;

	max_aspect_y: INTEGER is
			-- Denominator of maximum ration (X/Y) that
			-- application wishes widget instance to have
		do
			check
				not_be_called: False
			end
		end;

	max_width: INTEGER is
			-- Maximum width that application wishes widget
			-- instance to have
		do
			check
				not_be_called: False
			end
		end;

	min_height: INTEGER is
			-- minimum height that application wishes widget
			-- instance to have
		do
			check
				not_be_called: False
			end
		end;

	min_width: INTEGER is
			-- minimum width that application wishes widget
			-- instance to have
		do
			check
				not_be_called: False
			end
		end;

	min_aspect_x: INTEGER is
			-- Numerator of minimum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
			check
				not_be_called: False
			end
		end;

	min_aspect_y: INTEGER is
			-- Denominator of minimum ration (X/Y) that
			-- application wishes widget instance to have
		do
			check
				not_be_called: False
			end
		end;

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		do
			check
				not_be_called: False
			end
		end;

	widget_group: WIDGET is
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		do
			check
				not_be_called: False
			end
		end

feature -- Element change

	set_base_height (a_height: INTEGER) is
			-- Set `base_height' to `a_height'. 
		do
			check
				not_be_called: False
			end
		end;

	set_base_width (a_width: INTEGER) is
			-- Set `base_width' to `a_width'.
		do
			check
				not_be_called: False
			end
		end;

	set_height_inc (an_increment: INTEGER) is
			-- Set `height_inc' to `an_increment'.
		do
			check
				not_be_called: False
			end
		end;

	set_width_inc (an_increment: INTEGER) is
			-- Set `width_inc' to `an_increment'.
		do
			check
				not_be_called: False
			end
		end;

	set_icon_mask (a_mask: PIXMAP) is
			-- Set `icon_mask' to `a_mask'.
		do
			check
				not_be_called: False
			end
		end;

	set_icon_pixmap (a_pixmap: PIXMAP) is
			-- Set `icon_pixmap' to `a_pixmap'.
		do
			check
				not_be_called: False
			end
		end;

	set_icon_x (x_value: INTEGER) is
			-- Set `icon_x' to `x_value'.
		do
			check
				not_be_called: False
			end
		end;

	set_icon_y (y_value: INTEGER) is
			-- Set `icon_y' to `y_value'.
		do
			check
				not_be_called: False
			end
		end;

	set_max_aspect_x (a_max: INTEGER) is
			-- Set `max_aspect_x' to `a_max'.
		do
			check
				not_be_called: False
			end
		end;

	set_max_aspect_y (a_max: INTEGER) is
			-- Set `max_aspect_y' to `a_max'.
		do
			check
				not_be_called: False
			end
		end;

	set_max_height (a_height: INTEGER) is
			-- Set `max_height' to `a_height'.
		do
			check
				not_be_called: False
			end
		end;

	set_max_width (a_max: INTEGER) is
			-- Set `max_width' to `a_max'.
		do
			check
				not_be_called: False
			end
		end;

	set_min_aspect_x (a_min: INTEGER) is
			-- Set `min_aspect_x' to `a_min'.
		do
			check
				not_be_called: False
			end
		end;

	set_min_aspect_y (a_min: INTEGER) is
			-- Set `min_aspect_y' to `a_min'.
		do
			check
				not_be_called: False
			end
		end;

	set_min_height (a_height: INTEGER) is
			-- Set `min_height' to `a_height'.
		do
			check
				not_be_called: False
			end
		end;

	set_min_width (a_min: INTEGER) is
			-- Set `min_width' to `a_min'.
		do
			check
				not_be_called: False
			end
		end;

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		do
			check
				not_be_called: False
			end
		end;

	set_widget_group (a_widget: WIDGET) is
			-- Set `widget_group' to `a_widget'.
		do
			check
				not_be_called: False
			end
		end;

feature {PIXMAP_IMP} -- Implementation

	private_icon_pixmap: PIXMAP;
			-- Icon pixmap for Current Shell
	
	update_pixmap is
			-- Update the X pixmap after a change inside
			-- the Eiffel pixmap.
		local
			pixmap_implementation: PIXMAP_IMP
		do
			pixmap_implementation ?= private_icon_pixmap.implementation;
--XX			mel_set_icon_pixmap (pixmap_implementation)
		end


end

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

indexing
	description: "Abstraction for Window Manager controlled shells"
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	WM_CONTROL_WINDOWS 

feature -- Status report

 	base_height: INTEGER is
			-- Base for a progression of preferred heights
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred heights are `base_heights' plus
			-- integral multiples of `height_inc'
		do
			Result := 0
 		ensure then
			Result >= 0
		end

	base_width: INTEGER is
			-- Base for a progression of preferred widths
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred widths are `base_heights' plus
			-- integral multiples of `width_inc'
		do
			Result := 0
 		ensure then
			Result >= 0
		end

	height_inc: INTEGER is
			-- Increment for a progression of preferred
			-- heights for the window manager tu use in sizing 
			-- widgets.
		do
			Result := 0
 		ensure then
			Result >= 0
		end

	icon_mask: PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
		end

	icon_pixmap: PIXMAP
			-- Bitmap that could be used by the window manager
			-- as the application's icon

	icon_x: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
		end

	icon_y: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
		end

	max_aspect_x: INTEGER is
			-- Numerator of maximum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
		end

	max_aspect_y: INTEGER is
			-- Denominator of maximum ration (X/Y) that
			-- application wishes widget instance to have
		do
		end

	max_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have

	max_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have
 
	min_aspect_x: INTEGER is
			-- Numerator of minimum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
		end

	min_aspect_y: INTEGER is
			-- Denominator of minimum ration (X/Y) that
			-- application wishes widget instance to have
		do
		end

	min_height: INTEGER
			-- minimum height that application wishes widget
			-- instance to have

	min_width: INTEGER
			-- minimum width that application wishes widget
			-- instance to have

	width_inc: INTEGER is
			-- Increment for a progression of preferred
			-- widths for the window manager tu use in sizing
			-- widgets.
		do
			Result := 0
		ensure then
			Result >= 0
		end

	widget_group: WIDGET

feature -- Status setting

 	set_base_height (a_height: INTEGER) is
			-- Set `base_height' to `a_height'. 
		do
		ensure then
			base_height = a_height
		end

	set_base_width (a_width: INTEGER) is
			-- Set `base_width' to `a_width'.
		do
		ensure then
			base_width = a_width
		end

	set_height_inc (an_increment: INTEGER) is
			-- Set `height_inc' to `an_increment'.
		do
		ensure then
			height_inc = an_increment
		end

	set_width_inc (an_increment: INTEGER) is
			-- Set `width_inc' to `an_increment'.
		do
		ensure then
			width_inc = an_increment
		end

	set_icon_mask (a_mask: PIXMAP) is
			-- Set `icon_mask' to `a_mask'.
		do
		end

	set_icon_pixmap (a_pixmap: PIXMAP) is
			-- Set `icon_pixmap' to `a_pixmap'.
		do
			icon_pixmap := a_pixmap
		ensure then
			icon_pixmap = a_pixmap
		end

	set_icon_x (x_value: INTEGER) is
			-- Set `icon_x' to `x_value'.
		do
		end

	set_icon_y (y_value: INTEGER) is
			-- Set `icon_y' to `y_value'.
		do
		end 

	set_max_aspect_x (a_max: INTEGER) is
			-- Set `max_aspect_x' to `a_max'.
		do
		ensure then
			max_aspect_x = a_max
		end

	set_max_aspect_y (a_max: INTEGER) is
			-- Set `max_aspect_y' to `a_max'.
		do
		ensure then
			max_aspect_y = a_max
		end

	set_max_height (a_height: INTEGER) is
			-- Set `max_height' to `a_height'.
		do
			max_height := a_height
		ensure then
			max_height = a_height
		end

	set_max_width (a_max: INTEGER) is
			-- Set `max_width' to `a_max'.
		do
			max_width := a_max
		ensure then
			max_width = a_max
		end

	set_min_aspect_x (a_min: INTEGER) is
			-- Set `min_aspect_x' to `a_min'.
		do	
		ensure then
			min_aspect_x = a_min
		end

	set_min_aspect_y (a_min: INTEGER) is
			-- Set `min_aspect_y' to `a_min'.
		do
		ensure then
			min_aspect_y = a_min
		end

	set_min_height (a_min: INTEGER) is
			-- Set `min_height' to `a_min'.
		do
			min_height := a_min
		ensure then
			min_height = a_min
		end

	set_min_width (a_min: INTEGER) is
			-- Set `min_width' to `a_min'.
		do
			min_width := a_min
		ensure then
			min_width = a_min
		end

	set_widget_group (a_widget: WIDGET) is
			-- Set `widget_group' to `a_widget'.
		do
		end

end -- class WM_CONTROL_WINDOWS



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


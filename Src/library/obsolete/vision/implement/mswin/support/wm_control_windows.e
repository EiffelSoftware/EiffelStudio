note
	description: "Abstraction for Window Manager controlled shells"
	legal: "See notice at end of class."
	status: "See notice at end of class."; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	WM_CONTROL_WINDOWS 

feature -- Status report

 	base_height: INTEGER
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

	base_width: INTEGER
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

	height_inc: INTEGER
			-- Increment for a progression of preferred
			-- heights for the window manager tu use in sizing 
			-- widgets.
		do
			Result := 0
 		ensure then
			Result >= 0
		end

	icon_mask: PIXMAP
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
		end

	icon_pixmap: PIXMAP
			-- Bitmap that could be used by the window manager
			-- as the application's icon

	icon_x: INTEGER
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
		end

	icon_y: INTEGER
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
		end

	max_aspect_x: INTEGER
			-- Numerator of maximum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
		end

	max_aspect_y: INTEGER
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
 
	min_aspect_x: INTEGER
			-- Numerator of minimum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
		end

	min_aspect_y: INTEGER
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

	width_inc: INTEGER
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

 	set_base_height (a_height: INTEGER)
			-- Set `base_height' to `a_height'. 
		do
		ensure then
			base_height = a_height
		end

	set_base_width (a_width: INTEGER)
			-- Set `base_width' to `a_width'.
		do
		ensure then
			base_width = a_width
		end

	set_height_inc (an_increment: INTEGER)
			-- Set `height_inc' to `an_increment'.
		do
		ensure then
			height_inc = an_increment
		end

	set_width_inc (an_increment: INTEGER)
			-- Set `width_inc' to `an_increment'.
		do
		ensure then
			width_inc = an_increment
		end

	set_icon_mask (a_mask: PIXMAP)
			-- Set `icon_mask' to `a_mask'.
		do
		end

	set_icon_pixmap (a_pixmap: PIXMAP)
			-- Set `icon_pixmap' to `a_pixmap'.
		do
			icon_pixmap := a_pixmap
		ensure then
			icon_pixmap = a_pixmap
		end

	set_icon_x (x_value: INTEGER)
			-- Set `icon_x' to `x_value'.
		do
		end

	set_icon_y (y_value: INTEGER)
			-- Set `icon_y' to `y_value'.
		do
		end 

	set_max_aspect_x (a_max: INTEGER)
			-- Set `max_aspect_x' to `a_max'.
		do
		ensure then
			max_aspect_x = a_max
		end

	set_max_aspect_y (a_max: INTEGER)
			-- Set `max_aspect_y' to `a_max'.
		do
		ensure then
			max_aspect_y = a_max
		end

	set_max_height (a_height: INTEGER)
			-- Set `max_height' to `a_height'.
		do
			max_height := a_height
		ensure then
			max_height = a_height
		end

	set_max_width (a_max: INTEGER)
			-- Set `max_width' to `a_max'.
		do
			max_width := a_max
		ensure then
			max_width = a_max
		end

	set_min_aspect_x (a_min: INTEGER)
			-- Set `min_aspect_x' to `a_min'.
		do	
		ensure then
			min_aspect_x = a_min
		end

	set_min_aspect_y (a_min: INTEGER)
			-- Set `min_aspect_y' to `a_min'.
		do
		ensure then
			min_aspect_y = a_min
		end

	set_min_height (a_min: INTEGER)
			-- Set `min_height' to `a_min'.
		do
			min_height := a_min
		ensure then
			min_height = a_min
		end

	set_min_width (a_min: INTEGER)
			-- Set `min_width' to `a_min'.
		do
			min_width := a_min
		ensure then
			min_width = a_min
		end

	set_widget_group (a_widget: WIDGET)
			-- Set `widget_group' to `a_widget'.
		do
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WM_CONTROL_WINDOWS


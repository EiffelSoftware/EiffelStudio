indexing
	description	: "EiffelVision pixmap. Mswindows implementation for %
				  %widget pixmap (drawable & self-displayable)"
	status		: "See notice at end of class"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EV_PIXMAP_IMP_WIDGET

inherit
	EV_PIXMAP_IMP_DRAWABLE
		undefine
			has_focus, is_sensitive, is_displayed, set_focus, x_position, 
			y_position, on_parented, on_orphaned, disable_sensitive,
			enable_sensitive, show, pointed_target, remove_tooltip, 
			set_minimum_width, set_tooltip, screen_x, screen_y, set_size,
			parent, is_show_requested, minimum_width, draw_rubber_band, 
			set_pointer_style, erase_rubber_band, disable_transport, 
			destroy, set_minimum_height, set_minimum_size,
			disable_capture, pointer_position, start_transport, 
			enable_transport, pointer_style, tooltip, has_capture,
			end_transport, enable_capture, minimum_height, 
			hide, set_pebble, create_drop_actions, real_pointed_target,
			set_actual_drop_target_agent, has_parent, parent_is_sensitive,
			internal_set_pointer_style
		redefine
			interface, initialize,
			read_from_named_file, 
			clear, stretch, set_size, clear_rectangle, draw_point,
			draw_text, draw_segment, draw_straight_line, draw_arc, 
			draw_pixmap, draw_rectangle, draw_ellipse, draw_polyline, 
			draw_pie_slice, fill_rectangle, fill_ellipse, fill_polygon, 
			fill_pie_slice, set_with_default, flush
		select
			width,
			height,
			initialize
		end

	EV_PRIMITIVE_IMP
		rename
			height as display_height, width as display_width,
			initialize as widget_initialize
		undefine
			set_background_color, set_foreground_color, background_color,
			foreground_color, set_default_colors
		redefine
			interface, on_parented, on_orphaned, set_size, destroy,
			translate_coordinates, on_middle_button_down,
			on_left_button_down, on_right_button_down
		end

	EV_WEL_CONTROL_WINDOW
		undefine
			on_sys_key_down,
			wel_font, wel_set_font
		redefine
			on_paint, on_erase_background, class_background, default_style,
			class_style, on_size
		end

creation
	make_with_simple,
	make_with_drawable

feature {NONE} -- Initialization

	make_with_drawable (other: EV_PIXMAP_IMP_DRAWABLE) is
			-- Create `Current' using attributes of `other'.
		local
			titled_window: EV_TITLED_WINDOW_IMP
		do
				-- Create this new implementation using the
				-- same interface as other.
			base_make (other.interface)

				-- Create the window control
			background_color := other.background_color
			clip_area := other.clip_area
			dashed_line_style := other.dashed_line_style
			foreground_color := other.foreground_color
			internal_brush := other.internal_brush
			if internal_brush /= Void then
				internal_brush.increment_reference
			end
			private_font := other.private_font
			private_wel_font := other.private_wel_font
			internal_initialized_background_brush := 
				other.internal_initialized_background_brush
			internal_background_brush := other.internal_background_brush
			if internal_background_brush /= Void then
				internal_background_brush.increment_reference
			end
			internal_initialized_brush := other.internal_initialized_brush
			internal_initialized_pen := other.internal_initialized_pen
			internal_pen := other.internal_pen
			if internal_pen /= Void then
				internal_pen.increment_reference
			end

			line_width := other.line_width
			tile := other.tile
			wel_drawing_mode := other.wel_drawing_mode
			dc := other.dc
			dc.increment_reference
			height := other.height
			width := other.width
			internal_bitmap := other.internal_bitmap
			internal_bitmap.increment_reference
			internal_mask_bitmap := other.internal_mask_bitmap
			if internal_mask_bitmap /= Void then
				internal_mask_bitmap.increment_reference
			end
			mask_dc := other.mask_dc
			if mask_dc /= Void then
				mask_dc.increment_reference
			end
			palette := other.palette
			if palette /= Void then
				palette.increment_reference
			end
			transparent_color := other.transparent_color

				-- Pick and drop info
			pebble := other.pebble
			pebble_function := other.pebble_function

				-- Create the window control
			wel_make (default_parent, "EV_PIXMAP")

				-- initialize from EV_WIDGET_IMP
			initialize_sizeable
 			set_default_minimum_size
			titled_window ?= Current;
 			if titled_window /= void then
 				show
 			end

				-- Is_initialized should be set to True
				-- when the bridge pattern is linked.
			is_initialized := False

				-- Destroy `other' implementation
			other.destroy
		end

	initialize is
			-- Initialize `Current'.
		do
			wel_make (default_parent, "EV_PIXMAP")
			Precursor {EV_PIXMAP_IMP_DRAWABLE}

				-- Precursor has set `is_initialized' to True
				-- but we are still in the middle of our
				-- initialization. So we set it to False.
			is_initialized := False

			widget_initialize
		end

feature -- Loading/Saving

	read_from_named_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			--
			-- Exceptions "Unable to retrieve icon information", 
			--            "Unable to load the file"
		do
			Precursor (file_name)
			update_display
		end

 	set_with_default is
			-- Initialize `Current' with the default
			-- pixmap (vision2 logo).
			--
			-- Exceptions "Unable to retrieve icon information", 
		do
			Precursor
			update_display
		end

feature -- Status setting

	stretch (new_width, new_height: INTEGER) is
			-- Stretch `Current' to fit in size 
			-- `new_width' by `new_height'.
		do
			Precursor (new_width, new_height)
			update_display
		end

	set_size (new_width, new_height: INTEGER) is
			-- Resize the `Current'. If the new size
			-- is smaller than the old one, the bitmap is
			-- clipped.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (new_width, new_height)
			update_display
		end

feature -- Clearing and drawing operations

	clear is
			-- Erase `Current' with `background_color'.
		do
			Precursor
			update_display
		end

	clear_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height' in `background_color'.
		do
			Precursor (x1, y1, a_width, a_height)
			update_display
		end

feature -- Drawing operations

	flush is
			-- Execute any delayed calls to `expose_actions' without waiting
			-- for next idle.
		do
			update
		end

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		do
			Precursor (x, y)
			update_display
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' at (`x', `y') using `font'.
		do
			Precursor (x, y, a_text)
			update_display
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			Precursor (x1, y1, x2, y2)
			update_display
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1','y1') and (`x2','y2').
		do
			Precursor (x1, y1, x2, y2)
			update_display
		end

	draw_arc (
		x,y : INTEGER;
		a_vertical_radius, a_horizontal_radius: INTEGER;
		a_start_angle, an_aperture: REAL
	) is
			-- Draw a part of an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle'
			-- + `an_aperture'.
			-- Angles are measured in radians.
		do
			Precursor (
				x, y, 
				a_vertical_radius, a_horizontal_radius, 
				a_start_angle, 
				an_aperture
				)
			update_display
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		do
			Precursor (x, y, a_pixmap)
			update_display
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		do
			Precursor (x, y, a_width, a_height)
			update_display
		end

	draw_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
		do
			Precursor (x, y, a_vertical_radius, a_horizontal_radius)
			update_display
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		do
			Precursor (points, is_closed)
			update_display
		end

	draw_pie_slice (
		x, y: INTEGER;
		a_vertical_radius, a_horizontal_radius: INTEGER;
		a_start_angle, an_aperture: REAL
	) is
			-- Draw a part of an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + 
			-- `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		do
			Precursor (
				x, 
				y, 
				a_vertical_radius, 
				a_horizontal_radius, 
				a_start_angle, 
				an_aperture
				)
			update_display
		end

feature -- Filling operations

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'. Fill with `foreground_color'.
		do
			Precursor (x, y, a_width, a_height)
			update_display
		end 

	fill_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Fill with `background_color'.
		do
			Precursor (
				x, y, 
				a_vertical_radius, a_horizontal_radius
				)
			update_display
		end

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `foreground_color'.
		do
			Precursor (points)
		end

	fill_pie_slice (
		x, y :INTEGER;
		a_vertical_radius, a_horizontal_radius: INTEGER;
		a_start_angle, an_aperture: REAL
	) is
			-- Draw a part of an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' +
			-- `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		do
			Precursor (
				x, y, 
				a_vertical_radius, a_horizontal_radius, 
				a_start_angle, 
				an_aperture
				)
			update_display
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy the widget and the internal pixmaps
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE}
			Precursor {EV_PRIMITIVE_IMP}
		end

	class_background: WEL_BRUSH is
			-- Set the class background to NULL in order
			-- to have full control on the WM_ERASEBKG event
			-- (on_erase_background)
		once
			create Result.make_by_pointer (Default_pointer)
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Process Wm_erasebkgnd message.
		do
				-- Disable the default windows processing.
			disable_default_processing

				-- return a correct value to Windows, i.e. nonzero value
				-- to tell windows no to erase the background.
			set_message_return_value (1)
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
				-- Call registered onPaint actions if any
			if expose_actions_internal /= Void then
					-- Switch the dc from screen_dc to paint_dc.
				display_dc := paint_dc

					-- Call actions
				expose_actions_internal.call ([
					invalid_rect.x, invalid_rect.y,
					invalid_rect.width, invalid_rect.height
					])

					-- Switch back the dc fron paint_dc to Void.
					-- (To avoid using the DC outside paint msg)
				display_dc := Void
			end
		end

	paint_bitmap (a_x, a_y, a_width, a_height: INTEGER) is
			-- Paint the bitmap onto the screen (i.e. the display_dc).
		local
			wel_rect: WEL_RECT
			bitmap_top, bitmap_left: INTEGER
				-- Coordinates of the top-left corner of the 
				-- bitmap inside the drawn area
			bitmap_right, bitmap_bottom: INTEGER
				-- Coordinates of the bottom-right corner of the
				--- bitmap inside the drawn area
			bitmap_width, bitmap_height: INTEGER
			window_width, window_height: INTEGER
			container_background_brush: WEL_BRUSH
			display_bitmap: WEL_BITMAP
			display_mask_bitmap: WEL_BITMAP
			display_bitmap_dc: WEL_MEMORY_DC
			display_mask_dc: WEL_MEMORY_DC
		do
				-- Get the background color of the container
			create container_background_brush.make_solid (wel_background_color)

				-- Compute usefull constants
			bitmap_height := height
			bitmap_width := width
			window_width := ev_width
			window_height := ev_height
			bitmap_left := (window_width - bitmap_width) // 2
			bitmap_top := (window_height - bitmap_height) // 2
			bitmap_right := bitmap_left + bitmap_width
			bitmap_bottom := bitmap_top + bitmap_height
						
				-- Draw the bitmap (If it is larger than the displayed
				-- area, it will be clipped by Windows.
			if has_mask then
					-- Create the mask and image used for display. 
					-- They are different than the real image because 
					-- we need to apply logical operation in order 
					-- to display the masked bitmap.
				display_mask_bitmap := get_mask_bitmap
				create display_mask_dc.make
				display_mask_dc.select_bitmap (display_mask_bitmap)
				display_mask_dc.pat_blt (0, 0, bitmap_width, bitmap_height, Dstinvert)

				display_bitmap := get_bitmap
				create display_bitmap_dc.make_by_dc (display_dc)
				display_bitmap_dc.select_bitmap (display_bitmap)
				display_bitmap_dc.bit_blt (0, 0, bitmap_width, bitmap_height, display_mask_dc, 0, 0, Srcand)

					-- Erase the background (otherwise we cannot apply 
					-- the mask).
				create wel_rect.make (bitmap_left, bitmap_top, bitmap_right, bitmap_bottom)
				display_dc.fill_rect(wel_rect, container_background_brush)

					-- Paint the bitmap using mask.
				display_dc.bit_blt (bitmap_left, bitmap_top, bitmap_width, bitmap_height, display_mask_dc, 0, 0, Maskpaint)
				display_dc.bit_blt (bitmap_left, bitmap_top, bitmap_width, bitmap_height, display_bitmap_dc,0, 0, Srcpaint)

					-- Free GDI ressources
				display_mask_bitmap.decrement_reference
				display_bitmap.decrement_reference
				display_mask_dc.delete
				display_bitmap_dc.delete
			else
				display_dc.bit_blt (bitmap_left, bitmap_top, bitmap_width, bitmap_height, dc, 0, 0, Srccopy)
			end
			

				--|  If the displayed area is larger than the bitmap, 
				--|  we erase the background that is outside the bitmap
				--|  (i.e: AREA 1, 2, 3 & 4)
				--|
				--|  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
				--|  X                             X
				--|  X          AREA 1             X
				--|  X                             X
				--|  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
				--|  X         X         X         X
				--|  X AREA 3  X BITMAP  X  AREA 4 X
				--|  X         X         X         X
				--|  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
				--|  X                             X
				--|  X          AREA 2             X
				--|  X                             X
				--|  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

			create wel_rect.make (0, 0, 0, 0)
				-- fill AREA 1
			if bitmap_top > 0 then
				wel_rect.set_rect (0, 0, window_width, bitmap_top)
				display_dc.fill_rect (wel_rect, container_background_brush)
			end

				-- fill AREA 2
			if bitmap_bottom < window_height then
				wel_rect.set_rect (0, bitmap_bottom, window_width, window_height)
				display_dc.fill_rect (wel_rect, container_background_brush)
			end

				-- fill AREA 3
			if bitmap_left > 0 then
				wel_rect.set_rect (0, bitmap_top, bitmap_left, bitmap_bottom)
				display_dc.fill_rect (wel_rect, container_background_brush)
			end

				-- fill AREA 4
			if bitmap_right < window_width then
				wel_rect.set_rect (bitmap_right, bitmap_top, window_width, bitmap_bottom)
				display_dc.fill_rect (wel_rect, container_background_brush)
			end
			container_background_brush.delete
		end

feature {NONE} -- Implementation

	update_display is
			-- Update the screen.
		do
				-- If the bitmap is exposed, then ask for
				-- redrawing it (`invalidate' causes
				-- `paint_bitmap' to be called)
			if parent /= Void then
				invalidate
			end
		end

	display_dc: WEL_PAINT_DC
			-- Paint DC from on_paint message.

feature {NONE} -- Windows events

	translate_coordinates (a_x, a_y: INTEGER): TUPLE [INTEGER, INTEGER, INTEGER,
		INTEGER] is
			-- For `a_x', `a_y', give actual x and y and screen x and y.
		local
			pt: WEL_POINT
		do
			pt := client_to_screen (a_x, a_y)
			Result := [
				a_x - (ev_width - width) // 2,
				a_y - (ev_height - height) // 2,
				pt.x,
				pt.y
			]
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- Redefined as the button press does not set the
			-- focus automatically.
		do
			set_focus
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- Redefined as the button press does not set the
			-- focus automatically.
		do
			set_focus
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- Redefined as the button press does not set the
			-- focus automatically.
		do
			set_focus
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

feature {NONE} -- Private Implementation

	parented: BOOLEAN
			-- Is the pixmap in a container?
	
	on_parented is
			-- `Current' has just been added to a container
		do
			parented := True
			if paint_bitmap_agent = Void then
				paint_bitmap_agent := ~paint_bitmap
			end
			interface.expose_actions.extend (paint_bitmap_agent)
		end
	
	on_orphaned is
			-- `Current' has just been added to a container
		do
			parented := False
			interface.expose_actions.prune_all (paint_bitmap_agent)
		end

	paint_bitmap_agent: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER,
		INTEGER]]
			-- `paint_bitmap' delayed.

	default_style: INTEGER is
			-- Default style that memories the drawings.
		do
			Result := Ws_child + Ws_visible
		end

	class_style: INTEGER is
   			-- Standard style used to create the window class.
   			-- Can be redefined to return a user-defined style.
   			-- (from WEL_FRAME_WINDOW)
   		once
			Result := 
				cs_hredraw + 
				cs_vredraw + 
				cs_dblclks + 
				Cs_owndc + 
				Cs_savebits
 		end

 	interface: EV_PIXMAP
			-- Interface for the bridge pattern.

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

end -- class EV_PIXMAP_IMP_WIDGET

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2001/06/14 18:26:17  rogers
--| Renamed EV_COORDINATES to EV_COORDINATE.
--|
--| Revision 1.12  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.2.40  2001/05/07 20:57:10  rogers
--| Changed arguments of clear_rectangle to width and height instead of
--| absolute coordinates.
--|
--| Revision 1.6.2.39  2001/03/04 22:35:53  pichery
--| - Renammed `bitmap' into `get_bitmap'
--|
--| Revision 1.6.2.38  2001/01/29 21:10:48  rogers
--| Undefined internal_set_pointer_style inherited from EV_PIXMAP_IMP_DRAWABLE.
--|
--| Revision 1.6.2.37  2000/12/06 15:44:51  pichery
--| Added 2 undefine clauses since `font' and `set_font' have been
--| added to WEL_CONTROL_WINDOW
--|
--| Revision 1.6.2.36  2000/11/20 22:17:08  rogers
--| Redefined on_***_button_down to set the focus to `Current'.
--|
--| Revision 1.6.2.35  2000/11/06 18:31:36  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.6.2.34  2000/11/02 13:32:33  pichery
--| - Fixed GDI leak (`mask_bitmap' creates a WEL_BITMAP at
--| each call).
--| - Removed temporary attributes `display_bitmap',
--| `display_mask_bitmap', ...
--| - Cosmetics
--|
--| Revision 1.6.2.33  2000/10/28 01:13:32  manus
--| Use copy of `private_font' and `private_wel_font' instead of `internal_font' due to changes
--| in EV_FONTABLE_IMP whom EV_DRAWABLE_IMP inherits now.
--|
--| Revision 1.6.2.32  2000/10/27 21:16:53  manus
--| Temporary fix in order to have correct background and foreground colors.
--|
--| Revision 1.6.2.31  2000/10/27 02:55:34  manus
--| Use of `wel_background_color' to draw.
--| But there is a problem with the inheritance from EV_DRAWABLE_IMP because EV_WIDGET_IMP does
--| not rely on the same assumption for `background_color' and `foreground_color'.
--| Needs to be fixed later.
--|
--| Revision 1.6.2.30  2000/10/19 23:25:09  rogers
--| removed fixme_not_reviewed. Comments, formatting.
--|
--| Revision 1.6.2.29  2000/10/16 14:44:41  pichery
--| - replaced `dispose' with `delete'.
--| - cosmetics
--| - improved `destroy'.
--|
--| Revision 1.6.2.28  2000/10/12 15:50:29  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.6.2.27  2000/10/02 22:42:22  rogers
--| Paint_bitmap now destroys `container_background_brush' which stops the
--| GDI object count going up by one very time this feature is called.
--|
--| Revision 1.6.2.26  2000/09/13 22:07:45  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.6.2.25  2000/09/13 15:49:47  manus
--| Instead of doing a make_by_pointer of `bitmap' in `paint_bitmap', we simply
--| do an assignment of `bitmap' to `display_bitmap' since it is a function
--| always returning a new object.
--|
--| Revision 1.6.2.24  2000/08/15 23:58:14  rogers
--| Undefined has_parent and parent_is_sensitive from
--| EV_PIXMAP_IMP_DRAWABLE.
--|
--| Revision 1.6.2.23  2000/08/11 23:16:03  brendel
--| Now removes the `paint_bitmap' agent from the expose actions.
--|
--| Revision 1.6.2.22  2000/08/08 02:23:15  manus
--| Use of `EV_WEL_CONTROL_WINDOW' instead of `WEL_CONTROL_WINDOW' so that it
--| simplifies the inheritance tree.
--| Cosmetics on initialization of `pebble' and `pebble_function' in
--| `make_with_drawable'. Speed improvement with new action sequences.
--| Use of `ev_width' and `ev_height' instead of `wel_width' and `wel_height'.
--|
--| Revision 1.6.2.21  2000/08/04 20:16:35  brendel
--| Fixed make_from_drawable.
--|
--| Revision 1.6.2.20  2000/07/26 01:23:26  brendel
--| Removed redundant comments and commented out code.
--|
--| Revision 1.6.2.19  2000/07/25 22:20:49  brendel
--| No need to redefine all coordinate-events anymore. `translate_coordinates'
--| suffices.
--|
--| Revision 1.6.2.18  2000/07/25 20:54:20  brendel
--| Added set_actual_drop_target_agent to functions that require promotion
--| to widget.
--|
--| Revision 1.6.2.17  2000/07/25 19:14:40  brendel
--| Undefined real_pointed_target from EV_PIXMAP_IMP_DRAWABLE instead of
--| the correct on from EV_PRIMITIVE.
--|
--| Revision 1.6.2.16  2000/07/25 15:54:02  brendel
--| Undefined create_drop_actions.
--|
--| Revision 1.6.2.15  2000/07/25 01:28:45  rogers
--| On paint no longer calls interface.expose_actions, just expose_Actions.
--|
--| Revision 1.6.2.14  2000/07/17 17:56:54  brendel
--| Adapted inherit clause to fit with API changes to pick and dropable
--| classes.
--|
--| Revision 1.6.2.13  2000/07/12 00:09:24  rogers
--| Undefined set_pebble from EV_PIXMAP_IMP_DRAWABLE. Fixed the button values
--| passed to pnd_press in on_***_button_down.
--|
--| Revision 1.6.2.12  2000/07/01 08:59:27  pichery
--| Fixed bugs
--|
--| Revision 1.6.2.11  2000/06/29 03:11:44  pichery
--| Fixed coordinates problems
--|
--| Revision 1.6.2.10  2000/06/26 23:28:01  pichery
--| Cosmetics
--|
--| Revision 1.6.2.9  2000/06/26 23:26:28  pichery
--| - Added `flush' feature
--| - Fixed bug in coordinates computation for motion events.
--|
--| Revision 1.6.2.8  2000/06/22 19:16:35  pichery
--| Removed compiler hack.
--|
--| Revision 1.6.2.7  2000/06/13 18:32:34  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.6.2.6  2000/06/09 20:55:39  manus
--| Removed useless undefinition of `position_set'
--|
--| Revision 1.6.2.5  2000/05/30 16:26:49  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.6.2.4  2000/05/04 04:23:07  pichery
--| Adapted inheritance clause since
--| EV_PIXMAP_IMP_STATE now
--| define `interface'.
--|
--| Revision 1.6.2.3  2000/05/03 22:35:06  brendel
--| Fixed resize_actions.
--|
--| Revision 1.6.2.2  2000/05/03 22:14:43  pichery
--| - Removed some obsolete features
--| - Replaced calls to `width' to calls to `wel_width'
--|
--|
--| Revision 1.6.2.1  2000/05/03 19:09:53  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/05/03 04:36:40  pichery
--| Removed parameter in feature `set_with_default'.
--|
--| Revision 1.5  2000/04/28 16:32:43  pichery
--| Added feature `set_with_default' To load a default
--| pixmap.
--|
--| Revision 1.4  2000/04/13 18:32:06  pichery
--| Added destroy feature in order to correctly free
--| unused objects.
--|
--| Revision 1.3  2000/04/13 00:26:48  pichery
--| - Added comments for `is_initialized := False' in
--|   `initialize'.
--|
--| Revision 1.2  2000/04/12 17:30:10  brendel
--| Setting is_initialized to False to avoid contracts being checked
--| while interface is still Void.
--|
--| Revision 1.1  2000/04/12 01:34:56  pichery
--| New pixmap implementation.
--| Use 3 differents states depending on
--| what the user is doing with the pixmap.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

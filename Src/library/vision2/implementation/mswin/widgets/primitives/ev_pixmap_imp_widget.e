--| FIXME NOT_REVIEWED this file has not been reviewed
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
			y_position, on_parented, disable_sensitive, enable_sensitive,
			show, pointed_target, remove_tooltip, 
			set_minimum_width, set_tooltip, screen_x, screen_y, set_size,
			parent, is_show_requested, minimum_width, draw_rubber_band, 
			set_pointer_style, erase_rubber_band, disable_transport, 
			destroy, set_minimum_height, set_minimum_size,
			disable_capture, pointer_position, start_transport, 
			enable_transport, pointer_style, tooltip,
			end_transport, enable_capture, minimum_height,
			hide 
		redefine
			interface, initialize,
			read_from_file, read_from_named_file, set_with_buffer,
			clear, stretch, set_size, clear_rectangle, draw_point,
			draw_text, draw_segment, draw_straight_line, draw_arc, 
			draw_pixmap, draw_rectangle, draw_ellipse, draw_polyline, 
			draw_pie_slice, fill_rectangle, fill_ellipse, fill_polygon, 
			fill_pie_slice, set_with_default
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
			foreground_color
		redefine
			interface, on_parented, set_size, destroy
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make, parent as wel_window_parent, 
			set_parent as wel_set_parent, shown as is_displayed,
			destroy as wel_destroy, destroy_item as wel_destroy_item,
			item as wel_item, enabled as is_sensitive,
			width as wel_width, height as wel_height, x as x_position,
			y as y_position, move as wel_move, resize as wel_resize,
			move_and_resize as wel_move_and_resize
		undefine
			window_process_message, set_width, set_height, remove_command,
			on_left_button_down, on_mouse_move, on_left_button_up,
			on_right_button_down, on_right_button_up, 
			on_left_button_double_click, on_right_button_double_click,
			on_key_down, on_key_up, on_kill_focus, on_set_focus, 
			on_set_cursor, show, hide, on_size
		redefine
			on_paint, on_erase_background, class_background, default_style,
			class_style, on_size
		end

creation
	make_with_simple,
	make_with_drawable

feature {NONE} -- Initialization

	make_with_drawable(other: EV_PIXMAP_IMP_DRAWABLE) is
			-- Create the current implementation using `other's
			-- attributes.
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
			internal_background_brush := other.internal_background_brush
			internal_brush := other.internal_brush
			internal_font := other.internal_font
			internal_initialized_background_brush := 
				other.internal_initialized_background_brush
			internal_initialized_brush := other.internal_initialized_brush
			internal_initialized_pen := other.internal_initialized_pen
			internal_initialized_background_brush := False
			internal_initialized_brush := False
			internal_initialized_pen := False

			internal_pen := other.internal_pen
			line_width := other.line_width
			tile := other.tile
			wel_drawing_mode := other.wel_drawing_mode

			dc := other.dc
			height := other.height
			internal_bitmap := other.internal_bitmap
			internal_mask_bitmap := other.internal_mask_bitmap
			mask_dc := other.mask_dc
			palette := other.palette
			transparent_color := other.transparent_color
			width := other.width

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
		end

	initialize is
			-- Set some default values.
		do
			wel_make (default_parent, "EV_PIXMAP")
			{EV_PIXMAP_IMP_DRAWABLE} Precursor

				-- Precursor has set `is_initialized' to True
				-- but we are still in the middle of our
				-- initialization. So we set it to False.
			is_initialized := False

			widget_initialize
		end

feature -- Loading/Saving

	read_from_file (a_file: IO_MEDIUM) is
			-- Load the pixmap described in 'file_name'. 
		do
			Precursor (a_file)
			update_display
		end

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
			-- Initialize the pixmap with the default
			-- pixmap (vision2 logo).
			--
			-- Exceptions "Unable to retrieve icon information", 
		do
			Precursor
			update_display
		end

	set_with_buffer (a_buffer: STRING) is
			-- Load pixmap data from `a_buffer' intoemory.
		do
			Precursor (a_buffer)
			update_display
		end

feature -- Access

	wel_parent: WEL_WINDOW is
			--|---------------------------------------------------------------
			--| FIXME ARNAUD
			--|---------------------------------------------------------------
			--| Small hack in order to avoid a SEGMENTATION VIOLATION
			--| with Compiler 4.6.008. To remove the hack, simply remove
			--| this feature and replace "parent as wel_window_parent" with
			--| "parent as wel_parent" in the inheritance clause of this class
			--|---------------------------------------------------------------
		do
			Result := wel_window_parent
		end

feature -- Status setting

	stretch (new_width, new_height: INTEGER) is
			-- Stretch the image to fit in size 
			-- `new_width' by `new_height'.
		do
			Precursor (new_width, new_height)
			update_display
		end

	set_size (new_width, new_height: INTEGER) is
			-- Resize the current bitmap. If the new size
			-- is smaller than the old one, the bitmap is
			-- clipped.
		do
			{EV_PIXMAP_IMP_DRAWABLE} Precursor (new_width, new_height)
			update_display
		end

feature -- Clearing and drawing operations

	clear is
			-- Erase `Current' with `background_color'.
		do
			Precursor
			update_display
		end

	clear_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Erase rectangle (`x1, `y1) - (`x2', `y2') 
			-- with `background_color'.
		do
			Precursor (x1, y1, x2, y2)
			update_display
		end

feature -- Drawing operations

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
				x, 
				y, 
				a_vertical_radius, 
				a_horizontal_radius, 
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

	draw_polyline (points: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
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
				x, 
				y, 
				a_vertical_radius, 
				a_horizontal_radius
				)
			update_display
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
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
				x, 
				y, 
				a_vertical_radius, 
				a_horizontal_radius, 
				a_start_angle, 
				an_aperture
				)
			update_display
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy the widget and the internal pixmaps
		do
			if display_bitmap_dc /= Void and then display_bitmap_dc.exists then
				display_bitmap_dc.unselect_bitmap
				display_bitmap_dc.delete
			end

			if display_mask_dc /= Void and then display_mask_dc.exists then
				display_mask_dc.unselect_bitmap
				display_mask_dc.delete
			end

			if display_mask_bitmap /= Void and then display_mask_bitmap.exists then
				display_mask_bitmap.delete
			end

			if display_bitmap /= Void and then display_bitmap.exists then
				display_bitmap.delete
			end

			{EV_PRIMITIVE_IMP} Precursor
		end

	class_background: WEL_BRUSH is
			-- Set the class background to NULL in order
			-- to have full control on the WM_ERASEBKG event
			-- (on_erase_background)
		once
			create Result.make_by_pointer(Default_pointer)
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
				-- Switch the dc from screen_dc to paint_dc.
			display_dc := paint_dc
			
				-- Call registered onPaint actions
			interface.expose_actions.call ([
				invalid_rect.x,
				invalid_rect.y,
				invalid_rect.width,
				invalid_rect.height
				])

				-- Switch back the dc fron paint_dc to Void.
				-- (To avoid using the DC outside paint msg)
			display_dc := Void
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
			a_color_imp: EV_COLOR_IMP
		do
				-- Get the background color of the container
			a_color_imp ?= parent.background_color.implementation
			create container_background_brush.make_solid(a_color_imp)

				-- Compute usefull constants
			bitmap_height := height
			bitmap_width := width
			window_width := display_width
			window_height := display_height
			bitmap_left := (display_width - bitmap_width) // 2
			bitmap_top := (display_height - bitmap_height) // 2
			bitmap_right := bitmap_left + bitmap_width
			bitmap_bottom := bitmap_top + bitmap_height
						
				-- Draw the bitmap (If it is larger than the displayed
				-- area, it will be clipped by Windows.
			if has_mask then
					-- Create the mask and image used for display. 
					-- They are different than the real image because 
					-- we need to apply logical operation in order 
					-- to display the masked bitmap.
				if display_bitmap = Void or 
				   display_mask_bitmap = Void or 
				   update_display_bitmap then
					create display_mask_bitmap.make_by_bitmap(mask_bitmap)
					create display_mask_dc.make--_by_dc(display_dc)
					display_mask_dc.select_bitmap(display_mask_bitmap)
					display_mask_dc.pat_blt(
						0, 
						0, 
						bitmap_width, 
						bitmap_height, 
						Dstinvert
						)

					create display_bitmap.make_by_bitmap(bitmap)
					create display_bitmap_dc.make_by_dc(display_dc)
					display_bitmap_dc.select_bitmap(display_bitmap)
					display_bitmap_dc.bit_blt (
						0, 
						0, 
						bitmap_width, 
						bitmap_height, 
						display_mask_dc, 
						0, 
						0, 
						Srcand
						)

					update_display_bitmap := False
				end

					-- Erase the background (otherwise we cannot apply 
					-- the mask
				create wel_rect.make (
					bitmap_left, 
					bitmap_top, 
					bitmap_right, 
					bitmap_bottom
					)
				display_dc.fill_rect(
					wel_rect, 
					our_background_brush
					)

				display_dc.bit_blt (
					bitmap_left, 
					bitmap_top, 
					bitmap_width, 
					bitmap_height, 
					display_mask_dc, 
					0, 
					0, 
					Maskpaint
					)

				display_dc.bit_blt (
					bitmap_left, 
					bitmap_top,
					bitmap_width, 
					bitmap_height, 
					display_bitmap_dc,
					0, 
					0, 
					Srcpaint
					)
			else
				display_dc.bit_blt (
					bitmap_left, 
					bitmap_top, 
					bitmap_width, 
					bitmap_height, 
					dc, 
					0, 
					0, 
					Srccopy
					)
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
				wel_rect.set_rect (
					0, 
					0, 
					window_width, 
					bitmap_top
					)
				display_dc.fill_rect(wel_rect, container_background_brush)
			end

				-- fill AREA 2
			if bitmap_bottom < window_height then
				wel_rect.set_rect (
					0, 
					bitmap_bottom, 
					window_width, 
					window_height
					)
				display_dc.fill_rect(wel_rect, container_background_brush)
			end

				-- fill AREA 3
			if bitmap_left > 0 then
				wel_rect.set_rect (
					0, 
					bitmap_top, 
					bitmap_left, 
					bitmap_bottom
					)
				display_dc.fill_rect(wel_rect, container_background_brush)
			end

				-- fill AREA 4
			if bitmap_right < window_width then
				wel_rect.set_rect (
					bitmap_right, 
					bitmap_top, 
					window_width, 
					bitmap_bottom
					)
				display_dc.fill_rect(wel_rect, container_background_brush)
			end
		end

feature {NONE} -- Implementation

	display_bitmap: WEL_BITMAP
			-- Temporary bitmap used for display (in feature paint_bitmap)

	display_mask_bitmap: WEL_BITMAP
			-- Temporary bitmap used for display (in feature paint_bitmap)

	display_bitmap_dc: WEL_MEMORY_DC
			-- Temporary device context used for display
			-- (in feature paint_bitmap)

	display_mask_dc: WEL_MEMORY_DC
			-- Temporary device context bitmap used for display
			-- (in feature paint_bitmap)

	update_display is
			-- Update the screen.
		do
				-- If the bitmap is exposed, then ask for
				-- redrawing it (`invalidate' causes
				-- `paint_bitmap' to be called)
			if parent /= Void then
				invalidate
			end
			update_display_bitmap := True
		end

	update_display_bitmap: BOOLEAN
			-- Should we update the temporary bitmap used
			-- for display.

	display_dc: WEL_PAINT_DC
			-- Paint DC from on_paint message.

feature {EV_PIXMAP} -- Duplication

feature {NONE} -- Private Implementation

	parented: BOOLEAN
			-- Is the pixmap in a container?
	
	on_parented is
			-- `Current' has just been added to a container
		do
			parented := True
			interface.expose_actions.extend (~paint_bitmap)
		end

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
--| Revision 1.10  2000/06/08 18:59:37  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.9  2000/06/08 18:46:51  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.8  2000/06/07 17:28:02  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
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
--| Revision 1.7  2000/05/03 20:13:29  brendel
--| Fixed resize_actions.
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

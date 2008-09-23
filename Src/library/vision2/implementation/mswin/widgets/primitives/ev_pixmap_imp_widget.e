indexing
	description	: "EiffelVision pixmap. Mswindows implementation for %
				  %widget pixmap (drawable & self-displayable)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_PIXMAP_IMP_WIDGET

inherit
	EV_PIXMAP_IMP_DRAWABLE
		undefine
			has_focus, is_sensitive, is_displayed, set_focus, x_position,
			y_position, on_parented, on_orphaned, disable_sensitive,
			enable_sensitive, show, pointed_target,
			set_minimum_width, set_tooltip, screen_x, screen_y, set_size,
			parent, is_show_requested, minimum_width, draw_rubber_band,
			set_pointer_style, erase_rubber_band, disable_transport,
			destroy, set_minimum_height, set_minimum_size,
			disable_capture, pointer_position, start_transport,
			enable_transport, pointer_style, tooltip, has_capture,
			end_transport, enable_capture, minimum_height,
			hide, set_pebble, create_drop_actions, real_pointed_target,
			set_actual_drop_target_agent, has_parent, parent_is_sensitive,
			internal_set_pointer_style, widget_imp_at_pointer_position,
			pnd_screen, internal_enable_dockable, internal_disable_dockable,
			update_buttons, refresh_now, create_file_drop_actions, update_for_pick_and_drop,
			is_tabable_from, is_tabable_to, enable_tabable_from, enable_tabable_to,
			disable_tabable_from, disable_tabable_to
		redefine
			interface, initialize,
			read_from_named_file,
			clear, stretch, set_size, clear_rectangle, draw_point,
			draw_text, draw_segment, draw_straight_line, draw_arc,
			draw_pixmap, draw_rectangle, draw_ellipse, draw_polyline,
			draw_pie_slice, fill_rectangle, fill_ellipse, fill_polygon,
			fill_pie_slice, set_with_default, flush, copy_pixmap, redraw
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
			on_left_button_down, on_right_button_down, on_size
		end

	EV_WEL_CONTROL_WINDOW
		undefine
			on_sys_key_down,
			wel_font, wel_set_font, on_getdlgcode,
			on_wm_dropfiles
		redefine
			on_paint, on_erase_background,
			class_background,
			default_style,
			class_style
		end

create
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

 				-- update events from `other'.
			copy_events_from_other (other)

				-- Update navigation attribute
			if other.is_tabable_from then
				enable_tabable_from
			else
				disable_tabable_from
			end
			if other.is_tabable_to then
				enable_tabable_to
			else
				disable_tabable_to
			end

				-- Is_initialized should be set to True
				-- when the bridge pattern is linked.
			set_is_initialized (False)

				-- Destroy `other' implementation
			other.safe_destroy
		end

	initialize is
			-- Initialize `Current'.
		do
			wel_make (default_parent, "EV_PIXMAP")
			Precursor {EV_PIXMAP_IMP_DRAWABLE}

				-- Precursor has set `is_initialized' to True
				-- but we are still in the middle of our
				-- initialization. So we set it to False.
			set_is_initialized (False)

			widget_initialize
		end

feature -- Loading/Saving

	read_from_named_file (file_name: STRING_GENERAL) is
			-- Load the pixmap described in 'file_name'.
			--
			-- Exceptions "Unable to retrieve icon information",
			--            "Unable to load the file"
		do
				-- If we have already loaded, an icon, then
				-- we need to remove `internal_mask_bitmap' as it is
				-- only required for icons. Problem occurs, if you call
				-- `set_with_named_file' twice, firstly with an icon, and
				-- then a png file, without the following line, then the
				-- png would be corrupted/system crash.
			if internal_mask_bitmap /= Void then
				internal_mask_bitmap.decrement_reference
				internal_mask_bitmap := Void
			end
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (file_name)
			update_display
		end

 	set_with_default is
			-- Initialize `Current' with the default
			-- pixmap (vision2 logo).
			--
			-- Exceptions "Unable to retrieve icon information",
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE}
			update_display
		end

feature -- Status setting

	stretch (new_width, new_height: INTEGER) is
			-- Stretch `Current' to fit in size
			-- `new_width' by `new_height'.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (new_width, new_height)
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

	redraw is
			-- Force `Current' to redraw itself.
		do
			update_display
		end

	clear is
			-- Erase `Current' with `background_color'.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE}
			update_display
		end

	clear_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height' in `background_color'.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (x1, y1, a_width, a_height)
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
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (x, y)
			update_display
		end

	draw_text (x, y: INTEGER; a_text: STRING_GENERAL) is
			-- Draw `a_text' at (`x', `y') using `font'.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (x, y, a_text)
			update_display
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (x1, y1, x2, y2)
			update_display
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1','y1') and (`x2','y2').
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (x1, y1, x2, y2)
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
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (
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
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (x, y, a_pixmap)
			update_display
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (x, y, a_width, a_height)
			update_display
		end

	draw_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (x, y, a_vertical_radius, a_horizontal_radius)
			update_display
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (points, is_closed)
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
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (
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
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (x, y, a_width, a_height)
			update_display
		end

	fill_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Fill with `background_color'.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (
				x, y,
				a_vertical_radius, a_horizontal_radius
				)
			update_display
		end

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `foreground_color'.
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (points)
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
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (
				x, y,
				a_vertical_radius, a_horizontal_radius,
				a_start_angle,
				an_aperture
				)
			update_display
		end

feature {NONE} -- Implementation

	copy_pixmap (other_interface: EV_PIXMAP) is
			-- Update `Current' to have same appearence as `other_interface'.
			-- (So as to satisfy `is_equal'.)
		do
			Precursor {EV_PIXMAP_IMP_DRAWABLE} (other_interface)
				-- As `Current' may be parented, invalidate
				-- so it is updated on screen.
			invalidate_without_background
		end

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
			set_message_return_value (to_lresult (1))
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		local
			l_bitmap_dc: WEL_MEMORY_DC
			l_bitmap: WEL_BITMAP
			l_mask_bitmap: WEL_BITMAP
			l_mask_dc: WEL_MEMORY_DC
			bitmap_top, bitmap_left: INTEGER
				-- Coordinates of the top-left corner of the
				-- bitmap inside the drawn area
			bitmap_right, bitmap_bottom: INTEGER
				-- Coordinates of the bottom-right corner of the
				--- bitmap inside the drawn area
			bitmap_width, bitmap_height: INTEGER
			window_width, window_height: INTEGER
			l_background_brush: WEL_BRUSH
			l_rect: WEL_RECT
			theme_drawer: EV_THEME_DRAWER_IMP
			l_back_buffer: WEL_BITMAP
			l_back_buffer_dc: WEL_MEMORY_DC
			l_blend_function: WEL_BLEND_FUNCTION
			l_result: BOOLEAN
		do
			if parent /= Void then
					-- Call expose actions first, any pending invalidations called from 'expose_actions'
					-- will be expunged at the end of this WM_PAINT message.
				if expose_actions_internal /= Void then
					expose_actions_internal.call ([
						invalid_rect.x, invalid_rect.y,
						invalid_rect.width, invalid_rect.height
						])
				end

				theme_drawer := application_imp.theme_drawer

				if parent_imp.background_color_imp /= Void then
					create l_background_brush.make_solid (parent_imp.background_color_imp)
				else
					create l_background_brush.make_solid (wel_background_color)
				end

				l_bitmap := internal_bitmap
				l_bitmap_dc := dc

				bitmap_height := height
				bitmap_width := width
				window_width := ev_width
				window_height := ev_height
				bitmap_left := (window_width - bitmap_width) // 2
				bitmap_top := (window_height - bitmap_height) // 2
				bitmap_right := bitmap_left + bitmap_width
				bitmap_bottom := bitmap_top + bitmap_height

				l_rect := wel_rect
				l_rect.set_rect (0, 0, window_width, window_height)

				if internal_mask_bitmap = Void then
					theme_drawer.draw_widget_background (Current, paint_dc, l_rect, l_background_brush)
					-- We use Alpha blend function instead of bit_blt
					-- Fixed bug#14800
					create l_blend_function.make
					l_result := paint_dc.alpha_blend (bitmap_left, bitmap_top, bitmap_width, bitmap_height, l_bitmap_dc, 0, 0, bitmap_width, bitmap_height, l_blend_function)
					check successed: l_result = True end
					l_blend_function.dispose
				else
					l_mask_bitmap := internal_mask_bitmap
					l_mask_dc := mask_dc
						-- Need to blit to a back buffer to avoid blitting the same pixel twice, which causes flicker.
					create l_back_buffer.make_compatible (l_bitmap_dc, window_width, window_height)
					create l_back_buffer_dc.make_by_dc (l_bitmap_dc)
					l_back_buffer_dc.select_bitmap (l_back_buffer)
					theme_drawer.draw_widget_background (Current, l_back_buffer_dc, l_rect, l_background_brush)
					l_back_buffer_dc.mask_blt (bitmap_left, bitmap_top, bitmap_width, bitmap_height, l_bitmap_dc, 0, 0, l_mask_bitmap, 0, 0,
						{WEL_RASTER_OPERATIONS_CONSTANTS}.maskcopy)

					paint_dc.bit_blt (0, 0, window_width, window_height, l_back_buffer_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.srccopy)

					l_back_buffer_dc.unselect_bitmap
					l_back_buffer_dc.delete
					l_back_buffer.delete
				end
				l_background_brush.delete
			end
		end

	on_size (size_type, a_width, a_height: INTEGER_32)
			-- Wm_size message
		do
				-- We want the widget to fully redraw on resize.
			update_display
			Precursor (size_type, a_width, a_height)
		end

feature {NONE} -- Implementation

	update_display is
			-- Update the screen.
		do
				-- If the bitmap is exposed, then ask for
				-- redrawing it (`invalidate' causes
				-- `paint_bitmap' to be called)
			if parent /= Void then
				invalidate_without_background
			end
		end

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
			-- This has been redefined, as the Precursor updates
			-- the implementation and we no longer need to perform this.
		do
			parented := True
		end

	on_orphaned is
			-- `Current' has just been removed from a container
			-- This has been redefined, as the Precursor updates
			-- the implementation and we no longer need to perform this.
		do
			parented := False
		end

	default_style: INTEGER is
			-- Default style that memories the drawings.
		do
			Result := Ws_child + Ws_visible + Ws_clipchildren
				+ Ws_clipsiblings
		end

	class_style: INTEGER is
   			-- Standard style used to create the window class.
   			-- Can be redefined to return a user-defined style.
   		once
			Result :=
				cs_dblclks |
				Cs_owndc
 		end

 	interface: EV_PIXMAP;
			-- Interface for the bridge pattern.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PIXMAP_IMP_WIDGET


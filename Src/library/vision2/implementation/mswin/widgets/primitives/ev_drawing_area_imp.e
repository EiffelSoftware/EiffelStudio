indexing
	description: "EiffelVision drawing area. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I
		redefine
			interface,
			draw_straight_line
		end

	EV_DRAWABLE_IMP
		redefine
			clear, clear_rectangle, draw_point, draw_text_top_left,
			draw_segment, draw_straight_line, draw_arc,
			draw_pixmap, draw_sub_pixmap, draw_rectangle,
			draw_ellipse, draw_polyline, draw_pie_slice,
			fill_rectangle, fill_ellipse, fill_polygon,
			fill_pie_slice,	initialize, interface, destroy
		end

	EV_PRIMITIVE_IMP
		undefine
			set_background_color,
			set_foreground_color,
			background_color,
			foreground_color
		redefine
			interface, initialize, on_left_button_down, 
			on_middle_button_down, on_right_button_down,
			propagate_syncpaint, destroy
		end

	EV_WEL_CONTROL_WINDOW
		undefine
			on_sys_key_down,
			wel_set_font,
			wel_font
		redefine
			on_paint,
			on_erase_background,
			class_background,
			default_style,
			class_style
		end

	WEL_CS_CONSTANTS
		export
			{NONE} all
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' empty with interface `an_interface'.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
			-- Set up action sequence connections
			-- and `Precursor' initialization.
		do
			wel_make (default_parent, "Drawing area")
			create screen_dc.make (Current)
			internal_paint_dc := screen_dc
			internal_paint_dc.get
			Precursor {EV_DRAWABLE_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			internal_paint_dc.release
		end	

feature -- Access

	dc: WEL_DC is
			-- The device context of the control.
		do
			Result := internal_paint_dc
		end

feature {NONE} -- Implementation

	propagate_syncpaint is
			-- Propagate `wm_syncpaint' message recevived by `top_level_window_imp' to
			-- children. No children, but must force `Current' to re-draw. See
			-- "WM_SYNCPAINT" in MSDN for more information.
		do
			invalidate
		end

	in_paint: BOOLEAN
			-- Are we inside an onPaint event?

	release_dc is
			-- Release the dc if not already released
		do
			if internal_paint_dc.exists then
				internal_paint_dc.release
			end

			internal_initialized_font := False
			internal_initialized_text_color := False
		end

	get_dc is
			-- Get the dc if not already get.
		do
			if not internal_paint_dc.exists then
				internal_paint_dc.get
				internal_paint_dc.set_background_transparent
				if internal_pen /= Void then
					internal_paint_dc.select_pen (internal_pen)
				else
					internal_paint_dc.select_pen (empty_pen)
				end

				if internal_brush /= Void then
					internal_paint_dc.select_brush (internal_brush)
				else
					internal_paint_dc.select_brush (empty_brush)
				end
			end
		end

	to_be_cleared: BOOLEAN
			-- Should the area be cleared?

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
			if to_be_cleared then
				to_be_cleared := False
				paint_dc.fill_rect(invalid_rect, our_background_brush)
			end

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
			internal_paint_dc := paint_dc
			in_paint := True
			
				-- Initialise the device for painting.
			dc.set_background_transparent
			internal_initialized_pen := False
			internal_initialized_background_brush := False
			internal_initialized_brush := False
			internal_initialized_text_color := False

				-- Call registered onPaint actions
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([
					invalid_rect.x,
					invalid_rect.y,
					invalid_rect.width,
					invalid_rect.height
					])
			end

				-- Switch back the dc from paint_dc to screen_dc.
			internal_paint_dc := screen_dc
			in_paint := False
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

	clear_and_redraw_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Redraw the rectangle at (`x1',`y1') with width `a_width' and
			-- height `a_height'.
		local
			wel_rect: WEL_RECT
		do
				-- Set the rectangle to be cleared.
			to_be_cleared := True

				-- Ask windows to redraw the rectangle
				-- Windows will then call on_background_erase and
				-- then on_paint.
			create wel_rect.make(x1, y1, x1 + a_width, y1 + a_height)
			invalidate_rect(wel_rect, True)
		end

	clear_and_redraw is
			-- Redraw the application screen
		do
				-- Set the rectangle to be cleared.
			to_be_cleared := True

				-- Ask windows to redraw the rectangle
				-- Windows will then call on_background_erase and
				-- then on_paint.
			invalidate
		end

	redraw_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Redraw the rectangle at (`x1',`y1') with width
			-- `a_width' and height and `a_height'.
		local
			wel_rect: WEL_RECT
		do
				-- Ask windows to redraw the rectangle
				-- Windows will then call on_paint.
			create wel_rect.make(x1, y1, x1 + a_width, y1 + a_height)
			invalidate_rect(wel_rect, False)
		end

	redraw is
			-- Redraw the application screen
		do
				-- Ask windows to redraw the entire window
				-- Windows will call on_erase_background (which
				-- will do nothing since to_be_cleared = False)
				-- and then on_paint.
			invalidate
		end

	flush is
			-- Update immediately the screen if needed.
		do
			update
		end

	default_style: INTEGER is
			-- Default style that memories the drawings.
		do
			Result := Ws_child + Ws_visible
		end

	class_style: INTEGER is
   			-- Standard style used to create the window class.
   			-- Can be redefined to return a user-defined style.
   			-- (from WEL_FRAME_WINDOW).
   		once
			Result := 
				cs_hredraw + 
				cs_vredraw + 
				cs_dblclks + 
				Cs_owndc + 
				Cs_savebits
 		end

feature -- Commands.

	destroy is
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			{EV_DRAWABLE_IMP} Precursor
			{EV_PRIMITIVE_IMP} Precursor
		end

feature {NONE} -- Feature that should be directly implemented by externals.

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

feature -- Drawing primitives

	clear is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor
				release_dc
			else
				Precursor
			end
		end

	clear_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (x1, y1, a_width, a_height)
				release_dc
			else
				Precursor (x1, y1, a_width, a_height)
			end
		end

	draw_point (a_x, a_y: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y)
				release_dc
			else
				Precursor (a_x, a_y)
			end
		end

	draw_text_top_left (a_x, a_y: INTEGER; a_text: STRING) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y, a_text)
				release_dc
			else
				Precursor (a_x, a_y, a_text)
			end
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (x1, y1, x2, y2)
				release_dc
			else
				Precursor (x1, y1, x2, y2)
			end
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (x1, y1, x2, y2)
				release_dc
			else
				Precursor (x1, y1, x2, y2)
			end
		end

	draw_arc (
		a_x, 
		a_y,
		a_vertical_radius,
		a_horizontal_radius: INTEGER;
		a_start_angle,
		an_aperture: REAL) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (
					a_x,
					a_y,
					a_vertical_radius,
					a_horizontal_radius,
					a_start_angle,
					an_aperture
				)
				release_dc
			else
				Precursor (
					a_x,
					a_y,
					a_vertical_radius,
					a_horizontal_radius,
					a_start_angle,
					an_aperture
				)
			end
		end

	draw_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y, a_pixmap)
				release_dc
			else
				Precursor (a_x, a_y, a_pixmap)
			end
		end

	draw_sub_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y, a_pixmap, area)
				release_dc
			else
				Precursor (a_x, a_y, a_pixmap, area)
			end
		end

	draw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y, a_width, a_height)
				release_dc
			else
				Precursor (a_x, a_y, a_width, a_height)
			end
		end

	draw_ellipse (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
				release_dc
			else
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			end
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (points, is_closed)
				release_dc
			else
				Precursor (points, is_closed)
			end
		end

	draw_pie_slice (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER;
				   	a_start_angle, an_aperture: REAL) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius,
							a_start_angle, an_aperture)
				release_dc
			else
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius,
							a_start_angle, an_aperture)
			end
		end

	fill_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y, a_width, a_height)
				release_dc
			else
				Precursor (a_x, a_y, a_width, a_height)
			end
		end

	fill_ellipse (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
				release_dc
			else
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			end
		end

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (points)
				release_dc
			else
				Precursor (points)
			end
		end

	fill_pie_slice (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER;
				   	a_start_angle, an_aperture: REAL) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				get_dc
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius, 
							a_start_angle, an_aperture)
				release_dc
			else
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius,
							a_start_angle, an_aperture)
			end
		end

feature {NONE} -- Implementation

	interface: EV_DRAWING_AREA

feature {EV_DRAWABLE_IMP} -- Internal datas.

	internal_paint_dc: WEL_DC
			-- dc we use when painting

	screen_dc: WEL_CLIENT_DC
			-- dc we use when painting outside a WM_PAINT message

end -- class EV_DRAWING_AREA_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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


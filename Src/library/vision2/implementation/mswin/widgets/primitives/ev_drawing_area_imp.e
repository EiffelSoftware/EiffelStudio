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
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			clear,
			clear_rectangle,
			draw_point,
			draw_text,
			draw_segment,
			draw_straight_line,
			draw_arc,
			draw_pixmap,
			draw_rectangle,
			draw_ellipse,
			draw_polyline,
			draw_pie_slice,
			fill_rectangle,
			fill_ellipse,
			fill_polygon,
			fill_pie_slice,
			initialize,
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_background_color,
			set_foreground_color,
			background_color,
			foreground_color
		redefine
			interface,
			initialize
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_window_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			destroy_item as wel_destroy_item,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize
		undefine
			window_process_message,
			set_width,
			set_height,
			remove_command,
			on_left_button_down,
			on_mouse_move,
			on_left_button_up,
			on_right_button_down,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_key_down,
			on_key_up,
			on_kill_focus,
			on_set_focus,
			on_set_cursor,
			show,
			hide
		redefine
			on_paint,
			on_erase_background,
			class_background,
			default_style,
			class_style,
			on_size
		end

	WEL_CS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
		end

	initialize is
			-- Set up action sequence connections
			-- and `Precursor' initialization.
		do
			wel_make (default_parent, "Drawing area")
			create screen_dc.make (Current)
			internal_paint_dc := screen_dc
			internal_paint_dc.get
			{EV_DRAWABLE_IMP} Precursor
			{EV_PRIMITIVE_IMP} Precursor
			internal_paint_dc.release
		end	

feature -- Access

	dc: WEL_DC is
			-- The device context of the control.
		do
			Result := internal_paint_dc
		end

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

feature {NONE} -- Implementation

	in_paint: BOOLEAN
			-- Are we inside an onPaint event?

	to_be_cleared: BOOLEAN
			-- Should the area be cleared?

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
			dc.set_background_opaque
			dc.set_background_transparent
			set_drawing_mode (Ev_drawing_mode_copy)
			set_line_width (1)
			reset_pen
			reset_brush

				-- Call registered onPaint actions
			interface.expose_actions.call ([
				invalid_rect.x,
				invalid_rect.y,
				invalid_rect.width,
				invalid_rect.height
				])

				-- Switch back the dc fron paint_dc to screen_dc.
			internal_paint_dc := screen_dc
			in_paint := False
		end

	on_size (size_type, a_width, a_height: INTEGER)is
			-- Wm_size message.
		do
			interface.resize_actions.call ([
				x_position,
				y_position,
				a_width,
				a_height
				])
		end

	clear_and_redraw_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Redraw the rectangle (`x1',`y1') - (`x2', `y2')
		local
			wel_rect: WEL_RECT
		do
				-- Set the rectangle to be cleared.
			to_be_cleared := True

				-- Ask windows to redraw the rectangle
				-- Windows will then call on_background_erase and
				-- then on_paint.
			create wel_rect.make(x1, y1, x2 + 1, y2 + 1)
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

	redraw_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Redraw the rectangle (`x1',`y1') - (`x2', `y2')
		local
			wel_rect: WEL_RECT
		do
				-- Ask windows to redraw the rectangle
				-- Windows will then call on_paint.
			create wel_rect.make(x1, y1, x2 + 1, y2 + 1)
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
			-- Update immediately the screen if needed
		do
			--| for better performance, we can't use a rename in the
			--| inheritance clause instead.
			--| Not done currently because that make the compiler
			--| 4.6.010 crashing.
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
   			-- (from WEL_FRAME_WINDOW)
   		once
			Result := 
				cs_hredraw + 
				cs_vredraw + 
				cs_dblclks + 
				Cs_owndc + 
				Cs_savebits
 		end

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

feature -- Drawing primitives

	clear is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor
				dc.release
			else
				Precursor
			end
		end

	clear_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (x1, y1, x2, y2)
				dc.release
			else
				Precursor (x1, y1, x2, y2)
			end
		end

	draw_point (a_x, a_y: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (a_x, a_y)
				dc.release
			else
				Precursor (a_x, a_y)
			end
		end

	draw_text (a_x, a_y: INTEGER; a_text: STRING) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (a_x, a_y, a_text)
				dc.release
			else
				Precursor (a_x, a_y, a_text)
			end
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (x1, y2, x2, y2)
				dc.release
			else
				Precursor (x1, y2, x2, y2)
			end
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (x1, y1, x2, y2)
				dc.release
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
				dc.get
				Precursor (
					a_x,
					a_y,
					a_vertical_radius,
					a_horizontal_radius,
					a_start_angle,
					an_aperture
				)
				dc.release
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
				dc.get
				Precursor (a_x, a_y, a_pixmap)
				dc.release
			else
				Precursor (a_x, a_y, a_pixmap)
			end
		end

	draw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (a_x, a_y, a_width, a_height)
				dc.release
			else
				Precursor (a_x, a_y, a_width, a_height)
			end
		end

	draw_ellipse (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
				dc.release
			else
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			end
		end

	draw_polyline (points: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (points, is_closed)
				dc.release
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
				dc.get
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius,
							a_start_angle, an_aperture)
				dc.release
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
				dc.get
				Precursor (a_x, a_y, a_width, a_height)
				dc.release
			else
				Precursor (a_x, a_y, a_width, a_height)
			end
		end

	fill_ellipse (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
				dc.release
			else
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			end
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
			-- Lock the device context, call precursor
			-- and release the device context.
		do
			if not in_paint then
				dc.get
				Precursor (points)
				dc.release
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
				dc.get
				Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius, 
							a_start_angle, an_aperture)
				dc.release
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.38  2000/03/21 02:34:11  brendel
--| Removed on_accelerator_command from undefine clause.
--|
--| Revision 1.37  2000/03/14 03:02:56  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.36.2.2  2000/03/11 00:19:20  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.36.2.1  2000/03/09 21:39:48  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.36  2000/03/03 03:57:30  pichery
--| added feature `flush'
--|
--| Revision 1.35  2000/02/25 01:08:20  pichery
--| Added support for resize_actions to Drawing areas.
--|
--| Revision 1.34  2000/02/24 05:02:34  pichery
--| Fixed a bug: The Cs_owndc was set in the Windows Style instead of in the
--| Class Style....basically it was previously not taken into account by
--|windows!
--|
--| Revision 1.33  2000/02/23 04:53:04  pichery
--| fixed a postcondition violation when executing dc.get (we can only call "dc"
--| when the internal_dc has been allocated by windows, that is after the
--| execution of internal_dc.get)
--|
--| Revision 1.32  2000/02/22 18:21:01  pichery
--| added 4 times the same small hack with `wel_parent' in order to
--| avoid a Segmentation Violation with EiffelBench 4.6.008
--|
--| Revision 1.31  2000/02/22 01:56:15  pichery
--| added the possibility to draw on the drawing area outside onPaint events.
--|
--| Revision 1.30  2000/02/20 20:29:27  pichery
--| created a factory that build WEL objects (pens & brushes). This factory
--| keeps created objects into an hashtable in order to avoid multiple object
--| creation for the same pen or brush.
--| factory is here used to retrieve pens and brushes in drawing areas
--|
--| Revision 1.29  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.28  2000/02/16 18:08:52  pichery
--| implemented the newly added features: redraw_rectangle, clear_and_redraw, 
--| clear_and_redraw_rectangle
--|
--| Revision 1.26.10.11  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.26.10.10  2000/01/27 19:30:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.26.10.9  2000/01/20 18:29:28  king
--| Formatting.
--|
--| Revision 1.26.10.8  2000/01/20 01:53:12  king
--| Cleanup of unused code.
--|
--| Revision 1.26.10.7  2000/01/19 17:56:28  king
--| Changed to comply with EV_DRAWABLE.
--|
--| Revision 1.26.10.6  2000/01/18 17:22:34  rogers
--| Added the call to expose_actions in on_paint.
--|
--| Revision 1.26.10.5  2000/01/18 01:29:35  king
--| Removed commented out stuff.
--| Changed implementation of colors.
--|
--| Revision 1.26.10.4  1999/12/17 00:41:32  rogers
--| Altered to fit in with the review branch. Altered to compile, as last CVS
--| commit of these files would not compile at all.
--|
--| Revision 1.26.10.3  1999/12/08 17:34:24  brendel
--| Commented out old inheritance directives.
--| Made old event system obsolete.
--| Added `interface'.
--| Added `initialize'.
--| Removed call to initialize in `make'.
--| Commented out all pixmapable features since drawing area is not pixmapable
--| anymore.
--| Improved indexing clause. Moved internal `note' to comment in `make'.
--| Commmented out color setting routines, since that is handled in
--| EV_DRAWING_AREA
--| Needs implementation of new events!
--|
--| Revision 1.26.10.2  1999/12/07 23:40:07  rogers
--| Alerations to fit in with the new ii.
--|
--| Revision 1.26.10.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.26.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

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

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.47  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.46  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.45  2001/07/08 19:22:58  pichery
--| Cosmetics
--|
--| Revision 1.44  2001/06/14 18:26:16  rogers
--| Renamed EV_COORDINATES to EV_COORDINATE.
--|
--| Revision 1.43  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.26.8.20  2001/05/11 21:50:29  rogers
--| Clear_and_redraw_rectangle and redraw_rectanlge now both use width and
--| height instead of absolute coordinates.
--|
--| Revision 1.26.8.19  2001/05/07 20:08:13  rogers
--| Updated argument names for `clear_rectangle'.
--|
--| Revision 1.26.8.18  2001/03/14 19:18:41  rogers
--| Added propagate_syncpaint which invalidates `Current'.
--|
--| Revision 1.26.8.17  2000/12/06 15:45:32  pichery
--| Added 2 undefine clauses since `font' and `set_font' have been
--| added to WEL_CONTROL_WINDOW
--|
--| Revision 1.26.8.16  2000/11/28 00:24:46  gauthier
--| Added redefinition of `draw_sub_pixmap'.
--|
--| Revision 1.26.8.15  2000/11/06 17:59:14  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.26.8.14  2000/10/16 14:42:51  pichery
--| Cosmetics
--|
--| Revision 1.26.8.13  2000/09/13 22:10:54  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.26.8.12  2000/08/16 18:20:36  brendel
--| draw_text -> draw_text_top_left.
--|
--| Revision 1.26.8.11  2000/08/11 18:51:43  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.26.8.10  2000/08/08 02:30:32  manus
--| Use of `EV_WEL_CONTROL_WINDOW' instead of `WEL_CONTROL_WINDOW' for
--| inheritance simplification.
--|
--| Revision 1.26.8.9  2000/08/04 20:27:38  rogers
--| All action sequence calls through the interface have been replaced with
--| calls to the internal action sequences.
--|
--| Revision 1.26.8.8  2000/07/24 23:14:43  rogers
--| Now inherits EV_DRAWING_AREA_ACTION_SREQUENCES_IMP.
--|
--| Revision 1.26.8.7  2000/07/13 17:49:47  gauthier
--| Fixed precursor call in draw_segment.
--|
--| Revision 1.26.8.6  2000/07/12 16:12:34  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.26.8.5  2000/06/13 21:47:40  rogers
--| Removed FIXME NOT_REVIEWED and wel_window_parent fix. Comments, formatting.
--|
--| Revision 1.26.8.4  2000/06/13 18:37:11  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.26.8.3  2000/06/09 20:57:32  manus
--| Removed useless undefinition of `on_size'
--|
--| Revision 1.26.8.2  2000/05/03 22:35:04  brendel
--| Fixed resize_actions.
--|
--| Revision 1.26.8.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.41  2000/04/13 23:37:00  pichery
--| Fixed a small bug. The brush and the pen were not correctly
--| initialized after a `get_dc' or a `release_dc'
--|
--| Revision 1.40  2000/04/13 00:22:30  pichery
--| - Changed the get and release of the dc.
--| - Fixed bug that reseted the drawing area when
--|   on_paint was called
--| - Cosmetics
--|
--| Revision 1.39  2000/03/25 01:27:41  rogers
--| Redefined on_left_button_down, on_middle_button_down and
--| on_right_button_down to set the focus to `Current'.
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

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
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			destroy_item as wel_destroy_item,
			item as wel_item,
			move as move_to,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height
		undefine
			window_process_message,
			set_width,
			set_height,
			remove_command,
			background_brush,
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
			on_accelerator_command,
			show,
			hide
		redefine
			on_paint,
			on_erase_background,
			class_background,
			background_brush,
			default_style
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
			screen_dc.get
			{EV_DRAWABLE_IMP} Precursor
			{EV_PRIMITIVE_IMP} Precursor
			screen_dc.release
			internal_paint_dc := Void
		end	

feature -- Access

	dc: WEL_DC is
			-- The device context of the control.
		do
			Result := internal_paint_dc
		end

	internal_paint_dc: WEL_DC
			-- dc we use when painting on a WM_PAINT message

	screen_dc: WEL_CLIENT_DC
			-- dc we use when painting outside a WM_PAINT message

feature {NONE} -- Implementation

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
				paint_dc.fill_rect(invalid_rect, background_brush)
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
			internal_paint_dc := paint_dc
				-- Initialise the device for painting.
			dc.set_background_opaque
			dc.set_background_transparent
			set_drawing_mode (Ev_drawing_mode_copy)
			set_line_width (1)
			reset_pen
			reset_brush

			interface.expose_actions.call ([invalid_rect.x, invalid_rect.y, invalid_rect.width, invalid_rect.height])
			internal_paint_dc := Void
		end

	clear_and_redraw_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Redraw the rectangle (`x1',`y1') - (`x2', `y2')
		local
			wel_rect: WEL_RECT
		do
			to_be_cleared := True
			create wel_rect.make(x1, y1, x2 + 1, y2 + 1)
			invalidate_rect(wel_rect, True)
		end

	clear_and_redraw is
			-- Redraw the application screen
		do
			to_be_cleared := True
			invalidate
		end

	redraw_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Redraw the rectangle (`x1',`y1') - (`x2', `y2')
		local
			wel_rect: WEL_RECT
		do
			create wel_rect.make(x1, y1, x2 + 1, y2 + 1)
			invalidate_rect(wel_rect, False)
		end

	redraw is
			-- Redraw the application screen
		do
			invalidate
		end

	default_style: INTEGER is
			-- Default style that memories the drawings.
		do
			Result := Ws_child + Ws_visible + Cs_owndc
		end

	to_be_cleared: BOOLEAN
			-- Should the area be cleared?

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

feature {NONE} -- Implementation

	interface: EV_DRAWING_AREA

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
--| Revision 1.29  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.28  2000/02/16 18:08:52  pichery
--| implemented the newly added features: redraw_rectangle, clear_and_redraw, clear_and_redraw_rectangle
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
--| Altered to fit in with the review branch. Altered to compile, as last CVS commit of these files would not compile at all.
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
--| Commmented out color setting routines, since that is handled in EV_DRAWING_AREA
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

--| FIXME Not for release
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
			screen_dc.get
			{EV_DRAWABLE_IMP} Precursor
			{EV_PRIMITIVE_IMP} Precursor
		end	

feature -- Access

	dc: WEL_DC is
			-- The device context of the control.
		do
			Result := screen_dc
		end

	screen_dc: WEL_CLIENT_DC

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			interface.expose_actions.call ([invalid_rect.x, invalid_rect.y, invalid_rect.width, invalid_rect.height])
		end

	default_style: INTEGER is
			-- Default style that memories the drawings.
		do
			Result := Ws_child + Ws_visible + Cs_owndc
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
--| Revision 1.27  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
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

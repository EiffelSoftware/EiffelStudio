indexing 
	description: "EiffelVision horizontal separator. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_SEPARATOR_IMP

inherit
	EV_SEPARATOR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_minimum_size
		redefine
			interface
		end

	EV_SYSTEM_PEN_IMP

	EV_WEL_CONTROL_WINDOW
		undefine
			on_sys_key_down
		redefine
			default_style,
			background_brush,
			on_erase_background
		end

feature {NONE} -- Initialization

 	make (an_interface: like interface) is
 			-- Make `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "EV_SEPARATOR")
 		end

feature {NONE} -- WEL Implementation

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background.
		do
			if exists then
				create Result.make_solid (wel_background_color)
			end
		end

	default_style: INTEGER is
			-- Default style of `Current'.
		do
			Result := Ws_child + Ws_visible
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (1)
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
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_SEPARATOR

end -- class EV_SEPARATOR_IMP

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
--| Revision 1.21  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.20  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.19  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.12.8.13  2000/11/06 17:56:13  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.12.8.12  2000/10/27 02:39:05  manus
--| Fixed bad inheritance merge on `interface'.
--| Redefined `background_brush' to reflect new way of getting color throug `wel_background_color'.
--|
--| Revision 1.12.8.11  2000/09/08 19:36:50  manus
--| Removed `is_raised' and `is_flat' from the implementation since they have been removed from
--| the interface.
--|
--| Revision 1.12.8.10  2000/08/11 18:45:38  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.12.8.9  2000/08/08 02:40:56  manus
--| Use of `EV_WEL_CONTROL_WINDOW' instead of `WEL_CONTROL_WINDOW' for
--| inheritance simplification
--|
--| Revision 1.12.8.8  2000/07/12 16:08:12  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.12.8.7  2000/06/29 23:48:22  manus
--| Redefined `on_erase_background' so that it doesn't do anything and
--| therefore we avoid a nasty flickering on Windows.
--|
--| Revision 1.12.8.6  2000/06/22 19:05:19  pichery
--| - Added the style `is_flat'
--|
--| Revision 1.12.8.5  2000/06/19 19:23:05  rogers
--| Removed FIXM NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.12.8.4  2000/06/13 18:35:15  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.12.8.3  2000/05/05 23:34:02  brendel
--| Added is_raised, enable_raised and disable_raised.
--|
--| Revision 1.12.8.2  2000/05/03 22:35:05  brendel
--| Fixed resize_actions.
--|
--| Revision 1.12.8.1  2000/05/03 19:09:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.16  2000/03/21 02:34:12  brendel
--| Removed on_accelerator_command from undefine clause.
--|
--| Revision 1.15  2000/03/14 20:08:29  brendel
--| Renamed some features from WEL in compliance with rest of window _IMP's.
--|
--| Revision 1.14  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.13  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.10.3  2000/01/27 19:30:29  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.10.2  2000/01/11 20:03:34  rogers
--| Modified to comply with the major Vision2 changes. See diff for
--| redefinitions, make now takes an interface.
--|
--| Revision 1.12.10.1  1999/11/24 17:30:34  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

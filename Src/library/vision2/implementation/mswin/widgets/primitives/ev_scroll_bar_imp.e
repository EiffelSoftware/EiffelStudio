indexing
	description:
		"Eiffel Vision scrollbar. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR_IMP

inherit
	EV_SCROLL_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			on_scroll
		redefine
			interface,
			wel_background_color,
			set_leap,
			set_range
		end

	WEL_SCROLL_BAR
		rename
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			position as value,
			set_position as wel_set_value,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			line as step,
			page as leap,
			set_line as wel_set_step,
			set_page as wel_set_leap,
			width as wel_width,
			height as wel_height,
			enabled as is_sensitive,
			item as wel_item,
			set_range as wel_set_range,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			x as x_position,
			y as y_position,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			wel_foreground_color,
			wel_background_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			default_style,
			wel_set_range
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_visible + Ws_childwindow
		end

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
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

	wel_background_color: WEL_COLOR_REF is
		do
			Result := background_color_imp
			if Result = Void then
				create Result.make_system (Color_scrollbar)
			end
		end

feature {EV_ANY_I} -- Implementation

	set_leap (a_leap: INTEGER) is
			-- Assign `a_leap' to `leap'.
		do
				--| Adjust the range so that the value_range.upper can actually
				--| be achieved. When scroll bars are proportional in WEL, only
				--| the maximum value - leap can be acheived. Julian
			wel_set_range (value_range.lower, value_range.upper + a_leap - 1)
			Precursor (a_leap)
		end
		
	wel_set_range (a_minimum, a_maximum: INTEGER) is
			-- Set `minimum' and `maximum' with
			-- `a_minimum' and `a_maximum'
		local
			must_adjust: BOOLEAN
			adjusted_value: INTEGER
		do
				--| This has been redefined to fic the following bug:
				--| run the vision2 Gauges sample, without redefining this feature,
				--| and before doing anythign else, click on the right hand arrow of
				--| the horizontal scroll bar.
				--| This redefinition ensures that if the range of `Current' changes, the
				--| `value' remains valid.
			if value < a_minimum then
				must_adjust := True
				adjusted_value := a_minimum
			elseif value > a_maximum then
				must_adjust := True
				adjusted_value := a_maximum
			end
			
			scroll_info_struct.set_mask (Sif_range)
			scroll_info_struct.set_minimum (a_minimum)
			scroll_info_struct.set_maximum (a_maximum)
			cwin_set_scroll_info (wel_item, Sb_ctl, scroll_info_struct.item, True)
			
				-- If previous `value' is now out of range then
				-- assign `adjusted_value' to `value'.
			if must_adjust then
				scroll_info_struct.set_mask (Sif_pos)
				scroll_info_struct.set_position (adjusted_value)
				cwin_set_scroll_info (wel_item, Sb_ctl, scroll_info_struct.item, True)
			end
		end

	set_range is
		do
				--| Adjust the range so that the value_range.upper can actually
				--| be achieved. When scroll bars are proportional in WEL, only
				--| the maximum value - leap can be acheived. Julian
			wel_set_range (value_range.lower, value_range.upper + leap - 1)
		end

	interface: EV_SCROLL_BAR

end -- class EV_RANGE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.11  2001/07/10 16:57:40  rogers
--| Redefined `wel_set_range' to adjust `value' if necessary. This fixes a bug
--| exhibited in the vision2 gauges examples, see comment of `wel_set_range'
--| for more information.
--|
--| Revision 1.10  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.8.14  2001/01/26 23:20:46  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.3.8.13  2001/01/09 19:12:41  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.3.8.12  2000/12/08 19:09:24  rogers
--| Redefined set_leap and set_range. This allows the full range of values from
--| the interface to be acheived by the scroll bar. This is performed by
--| modifying the actual range within WEL whenever the leap or the range
--| changes within Vision.
--|
--| Revision 1.3.8.11  2000/11/14 18:23:19  rogers
--| Renamed has_capture inherited from WEL as wel_has_capture.
--|
--| Revision 1.3.8.10  2000/11/06 17:56:38  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.3.8.9  2000/10/27 02:43:09  manus
--| Removed definition of `wel_foreground_color' and use the one inherited.
--| Defined `wel_background_color' to return by default `Color_scrollbar' but our experience shows
--| that it is not the correct color. Anyway, it is not a problem at the moment, because it is not
--| used internally by vision2.
--|
--| Revision 1.3.8.8  2000/10/11 00:01:49  raphaels
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.3.8.7  2000/08/11 18:45:58  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.3.8.6  2000/08/08 02:41:07  manus
--| Updated inheritance with new WEL messages handling
--|
--| Revision 1.3.8.5  2000/07/12 16:08:42  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.3.8.4  2000/06/13 18:35:34  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.3.8.3  2000/06/11 02:34:54  manus
--| Removed the hack of `wel_parent' that was necessary because of a bug in the compiler.
--| Redefine `wel_background_color' and `wel_foregroung_color' to return respectively
--| `background_color_imp' and `foreground_color_imp', otherwise the color setting was not
--| working as it should.
--| Changed the default style to remove the `Ws_tabstop' and `Ws_group' because it
--| does not look nice on Windows to have those style.
--|
--| Revision 1.3.8.2  2000/05/03 22:35:04  brendel
--| Fixed resize_actions.
--|
--| Revision 1.3.8.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/03/21 23:39:01  brendel
--| Modified inheritance clause in compliance with EV_SIZEABLE_IMP.
--|
--| Revision 1.7  2000/03/07 00:08:38  brendel
--| Removed user_scroll_bar_width
--|
--| Revision 1.6  2000/02/22 18:21:01  pichery
--| added 4 times the same small hack with `wel_parent' in order to
--| avoid a Segmentation Violation with EiffelBench 4.6.008
--|
--| Revision 1.5  2000/02/15 03:20:32  brendel
--| Changed order of initialization. All gauges are now initialized in
--| EV_GAUGE_IMP with values: min: 1, max: 100, step: 1, leap: 10, value: 1.
--| Clean-up.
--| Released.
--|
--| Revision 1.4  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.5  2000/02/03 17:23:19  brendel
--| Removed leap-features since they are now defined in EV_GAUGE.
--|
--| Revision 1.3.10.4  2000/02/01 03:36:29  brendel
--| Cosmetics.
--| Added redefine of on_scroll to generate events.
--|
--| Revision 1.3.10.3  2000/01/27 19:30:29  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.2  2000/01/06 20:36:41  rogers
--| Now works with the major changes in Vision2. The interface has been added.
--| A lot of renaming has been done from ancestors, to fit in with changes.
--| See the diff.
--|
--| Revision 1.3.10.1  1999/11/24 17:30:34  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

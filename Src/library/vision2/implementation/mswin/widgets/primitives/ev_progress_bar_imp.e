indexing 
	description:
		"Eiffel Vision progress bar. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface
		end

	WEL_PROGRESS_BAR
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			position as value,
			shown as is_displayed,
			set_position as wel_set_value,
			height as wel_height,
			width as wel_width,
			enabled as is_sensitive,
			item as wel_item,
			set_step as wel_set_step,
			set_range as wel_set_range,
			x as x_position,
			y as y_position,
			move as wel_move,
			move_and_resize as wel_move_and_resize,
			resize as wel_resize,
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
			default_style,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			wel_set_step
		end

	WEL_PBS_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_VERSION
		export
			{NONE} all
		end


feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current'.
		do
			base_make (an_interface)
			wel_make (default_parent, 0, 0, 0, 0, -1)
		end

feature -- Access

	step: INTEGER
			-- Step value of `Current'.

	leap: INTEGER
			-- Leap value of `Current'.

feature -- Status report

	is_segmented: BOOLEAN is
			-- Is display segmented?
		do
			Result := not flag_set (style, Pbs_smooth)
		end

feature -- Status setting

	enable_segmentation is
			-- Display `Current' with segments.
			-- Only works with Win95+IE3 or above.
		local
			new_style: INTEGER
				-- The new style of `Current'.
		do
			if not is_segmented then
				-- No need to enable segmentation if already segmented.
				if comctl32_version >= version_470 then
					-- Pbs_smooth is only available starting with
					-- Common Controls version 4.70 (Shipped with IE3).
					-- If we have an older version, we do nothing.
					new_style := clear_flag (style, Pbs_smooth)
						-- Remove `Pbs_smooth' from the style of `Current'.
					recreate_current (new_style)	
				end
			end
		end

	disable_segmentation is
			-- Display `Current' without segments.
			-- Only works with Win95+IE3 or above.
		local
				new_style: INTEGER
					-- The new style of `Current'.
		do
			if is_segmented then
				-- No need to disable segmentation if not already segmented.
				if comctl32_version >= version_470 then
					-- Pbs_smooth is only available starting with
					-- Common Controls version 4.70 (Shipped with IE3).
					-- If we have an older version, we do nothing.
					new_style := set_flag (style, Pbs_smooth)
						-- Add the style `Pbs_smooth' to `Current'.
					recreate_current (new_style)
				end
			end
		end

	recreate_current (a_new_style: INTEGER) is
			-- Re create `Current' with `a_new_style'.
		local
			wel_imp: WEL_WINDOW
			old_x, old_y, old_height, old_width, old_step, old_leap, old_value,
			old_minimum, old_maximum: INTEGER
				-- As we have to destroy the WEL control, we must store
				-- all the attributes within these variables so the control
				-- can be completely restored.
		do
			wel_imp ?= parent_imp
			old_x := x_position
			old_y := y_position
			old_width := width
			old_height := height
			old_value := value
			old_step := step
			old_leap := leap
			old_minimum := value_range.lower
			old_maximum := value_range.upper
				-- All attributes now stored.

			wel_destroy
				-- Destroy the actual control.
			internal_window_make (wel_imp, Void, a_new_style, old_x, old_y,
				old_width, old_height, -1, default_pointer)
				-- Create a new control.

			value_range.resize (old_minimum, old_maximum)
			set_value (old_value)
			wel_set_leap (old_leap)
			wel_set_step (old_step)
				-- Previous attributes have now been restored.
		end

	wel_set_step (a_step: INTEGER) is
			-- Set `step ' to `a_step'.
		do
			Precursor (a_step)
			step := a_step
		end

feature {NONE} -- Implementation

	wel_set_leap (a_leap: INTEGER) is
		do
			leap := a_leap
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

feature {EV_ANY_I} -- Implementation

	interface: EV_PROGRESS_BAR

end -- class EV_PROGRESS_BAR_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.18  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.10.8.17  2001/01/26 23:22:09  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.10.8.16  2001/01/09 19:14:14  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.10.8.15  2000/11/14 18:29:07  rogers
--| Renamed has_capture inherited from WEL as wel_has_capture.
--|
--| Revision 1.10.8.14  2000/11/06 17:57:23  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.10.8.13  2000/10/11 23:37:31  raphaels
--| Added `on_desactivate' in list of undefined features from WEL.
--|
--| Revision 1.10.8.12  2000/09/13 19:47:51  rogers
--| Fixed recreate_current so that it uses value_range from interface change.
--|
--| Revision 1.10.8.11  2000/09/13 19:26:39  rogers
--| Added temporary fixme for compilation.
--|
--| Revision 1.10.8.10  2000/08/11 18:46:41  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.10.8.9  2000/08/08 02:40:20  manus
--| Updated inheritance with new WEL messages handling
--|
--| Revision 1.10.8.8  2000/07/12 16:09:39  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.10.8.7  2000/06/13 18:36:18  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.10.8.6  2000/05/03 23:58:35  rogers
--| Comments, formatting.
--|
--| Revision 1.10.8.3  2000/05/03 22:35:04  brendel
--| Fixed resize_actions.
--|
--| Revision 1.10.8.2  2000/05/03 22:20:03  pichery
--| - Cosmetics / Optimization with local variables
--| - Replaced calls to `width' to calls to `wel_width'
--|   and same for `height'.
--| - Protected feature `enable_segmentation' and
--| `disable_segmentation' against misuse of some
--| flags not defined on all Windows platforms.
--|
--| Revision 1.10.8.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/04/13 18:18:54  brendel
--| Removed proportion and set_proportion.
--|
--| Revision 1.14  2000/03/17 20:51:33  rogers
--| renamed
--| 	x -> x_position,
--| 	y -> y_position,
--| 	move -> wel_move,
--| 	move_and_resize -> wel_move_and_Resize,
--| 	resize -> wel_resize
--| from
--| 	WEL_PROGRESS_BAR
--|
--| Changed any references accordingly.
--|
--| Revision 1.13  2000/02/15 03:20:32  brendel
--| Changed order of initialization. All gauges are now initialized in
--| EV_GAUGE_IMP with values: min: 1, max: 100, step: 1, leap: 10, value: 1.
--| Clean-up.
--| Released.
--|
--| Revision 1.12  2000/02/14 22:30:34  brendel
--| Changed to comply with signature change of `set_range' in EV_GAUGE.
--| Now takes INTEGER_INTERVAL instead of 2 integers.
--|
--| Revision 1.11  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.10.9  2000/02/10 20:07:33  rogers
--| Implemented proportion, added calling of change_actions from within on
--| scroll.
--| Revision 1.10.10.8  2000/02/09 00:14:28  rogers
--| Set initial value, and leap value within initialize.
--|
--| Revision 1.10.10.7  2000/02/03 17:22:19  brendel
--| Removed leap-features since they are now defined in EV_GAUGE.
--|
--| Revision 1.10.10.6  2000/02/01 03:35:30  brendel
--| Implemented to comply with new interface.
--|
--| Revision 1.10.10.5  2000/01/27 19:30:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.10.4  2000/01/18 23:36:23  rogers
--| In set_proportion, the call to set_value, takes the same sum as before
--| except the result is now truncated_to_integer.
--|
--| Revision 1.10.10.3  2000/01/17 19:08:01  oconnor
--| changed percentage to proportion
--|
--| Revision 1.10.10.2  2000/01/10 18:40:44  rogers
--| Changed to fit in with the major Vision2 changes. Make now takes an
--| interface, make_with_range no longer takes a parent. See diff for
--| redefinitions. Added interface.
--|
--| Revision 1.10.10.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

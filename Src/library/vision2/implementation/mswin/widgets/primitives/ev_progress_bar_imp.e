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
			resize as wel_resize
		undefine
			window_process_message,
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_set_cursor,
			default_style,
			show,
			hide
		redefine
			wel_set_step
		end

	WEL_PBS_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create progress bar.
		do
			base_make (an_interface)
			wel_make (default_parent, 0, 0, 0, 0, -1)
		end

feature -- Access

	step: INTEGER
			-- Step value.

	leap: INTEGER
			-- Leap value.

feature -- Status report

	is_segmented: BOOLEAN is
			-- Is display segmented?
		do
			Result := not flag_set (style, Pbs_smooth)
		end

feature -- Status setting

	enable_segmentation is
			-- Display bar divided into segments.
		local
			wel_imp: WEL_WINDOW
			new_style: INTEGER
			tx, ty, tw, th: INTEGER
		do
			check
				to_be_implemented: False
			end

			new_style := clear_flag (style, Pbs_smooth)

			wel_imp ?= parent_imp
			tx := x_position
			ty := y_position
			tw := width
			th := height
			--| FIXME wel_destroy
			--| FIXME internal_window_make (wel_imp, Void,
			--| FIXME 	new_style, tx, ty, tw, th, -1, default_pointer)
		end

	disable_segmentation is
			-- Display bar without segments.
		local
			wel_imp: WEL_WINDOW
			new_style: INTEGER
			tx, ty, tw, th: INTEGER
		do
			check
				to_be_implemented: False
			end

			new_style := set_flag (style, Pbs_smooth)

			wel_imp ?= parent_imp
			tx := x_position
			ty := y_position
			tw := width
			th := height
			--| FIXME wel_destroy
			--| FIXME internal_window_make (wel_imp, Void,
			--| FIXME 	new_style, tx, ty, tw, th, -1, default_pointer)
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
--| Implemented proportion, added calling of change_actions from within on scroll.
--|
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
--| In set_proportion, the call to set_value, takes the same sum as before except the result is now truncated_to_integer.
--|
--| Revision 1.10.10.3  2000/01/17 19:08:01  oconnor
--| changed percentage to proportion
--|
--| Revision 1.10.10.2  2000/01/10 18:40:44  rogers
--| Chnaged to fit in with the major Vision2 changes. Make now takes an interface, make_with_range no longer takes a parent. See diff for redefinitions. Added interface.
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

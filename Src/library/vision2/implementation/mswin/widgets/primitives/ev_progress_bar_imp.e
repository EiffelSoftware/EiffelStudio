--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision Progress bar."
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
			initialize,
			interface,
			set_step
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
			move as move_to,
			enabled as is_sensitive,
			item as wel_item,
			set_step as wel_set_step,
			set_range as wel_set_range
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
		end

	WEL_PBS_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a progress bar with `par' as parent.
		do
			base_make (an_interface)
			wel_make (default_parent, 0, 0, 0, 0, -1)
		end

	initialize is
			-- Initialize the progresss bar.
		do
			{EV_GAUGE_IMP} Precursor
			set_step (10)
			set_value (1)
			set_leap (10)
			set_range (1, 100)
		end

feature -- Access

	step: INTEGER
			-- Step value.

	leap: INTEGER
			-- Leap value.

	proportion: REAL is
			-- Proportion of bar filled. Range: [0,1].
		do
			Result := (value - minimum) / (maximum - minimum)
		end

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
			new_style := clear_flag (style, Pbs_smooth)

			wel_imp ?= parent_imp
			tx := x
			ty := y
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
			new_style := set_flag (style, Pbs_smooth)

			wel_imp ?= parent_imp
			tx := x
			ty := y
			tw := width
			th := height
			--| FIXME wel_destroy
			--| FIXME internal_window_make (wel_imp, Void,
			--| FIXME 	new_style, tx, ty, tw, th, -1, default_pointer)
		end

	set_step (a_step: INTEGER) is
			-- Set `step ' to `a_step'.
		do
			wel_set_step (a_step)
			step := a_step
		end

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
		do
			leap := a_leap
		end

	set_proportion (a_proportion: REAL) is
			-- Display bar with `a_proportion' filled.
		do
			set_value ((minimum + a_proportion * (maximum - minimum)).truncated_to_integer)
		end

feature {NONE} -- WEL implementation

	on_scroll (scroll_code, pos: INTEGER) is
			-- Call change action events when `value' changes.
		do
			interface.change_actions.call ([])
		end

feature {NONE} -- Feature that should be directly implemented by externals

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

indexing 
	description: "EiffelVision Progress bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I

	EV_GAUGE_IMP
		redefine
			on_key_down
		end

	WEL_PROGRESS_BAR
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			position as value,
			set_position as set_value
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
			on_key_up,
			on_set_cursor,
			default_style
		redefine
			on_key_down,
			set_step
		end

	WEL_PBS_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make is
			-- Create a progress bar with `par' as parent.
		do
			wel_make (default_parent, 0, 0, 0, 0, -1)
			step := 10
			set_range (0, 100)
		end

	make_with_range (min: INTEGER; max: INTEGER) is
			-- Create a spin-button with `min' as minimum, `max' as maximum
			-- and `par' as parent.
		do
			wel_make (default_parent, 0, 0, 0, 0, -1)
			step := 10
			set_range (min, max)
		end

feature -- Access

	step: INTEGER
			-- Current step of the progress bar.

feature -- Status report

	is_segmented: BOOLEAN is
			-- Is the mode in segmented mode?
		do
			Result := not flag_set (style, Pbs_smooth)
		end

feature -- Status setting

	set_segmented (flag: BOOLEAN) is
			-- Set the bar in segmented mode if True and in
			-- continuous mode otherwise.
		local
			wel_imp: WEL_WINDOW
			new_style: INTEGER
			tx, ty, tw, th: INTEGER
		do
			if flag then
				new_style := clear_flag (style, Pbs_smooth)
			else
				new_style := set_flag (style, Pbs_smooth)
			end
			wel_imp ?= parent_imp
			tx := x
			ty := y
			tw := width
			th := height
			wel_destroy
			internal_window_make (wel_imp, Void,
				new_style, tx, ty, tw, th, -1, default_pointer)
		end

	set_percentage (val: INTEGER) is
			-- Make `val' the new percentage filled by the
			-- progress bar.
		do
			set_value (minimum + val * (maximum - minimum) // 100)
		end

feature -- Element change

	set_step (val: INTEGER) is
			-- Set the step increment with `step'.
		do
			step := val
			cwin_send_message (item, Pbm_setstep, val, 0)
		end

feature {NONE} -- WEL implementation

	on_scroll (scroll_code, pos: INTEGER) is
			-- Do nothing here.
		do
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_KEY_EVENT_DATA
		do
			if has_command (Cmd_key_press) then
				data := get_key_data (virtual_key, key_data)
				execute_command (Cmd_key_press, data)
			end
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
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

indexing
	description: "Information about message Wm_syscommand which is sent %
		%when the user chooses a command from the System menu (also %
		%known as Control menu) or when the user chooses the Maximize %
		%button or Minimize button."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SYSTEM_COMMAND_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

	WEL_SC_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Access

	type: INTEGER is
			-- Type of system command requested.
			-- See class WEL_SC_CONSTANTS for different values.
		do
			Result := w_param
		end

	x: INTEGER is
			-- Horizontal position in screen coordinates
		do
			Result := cwin_lo_word (l_param)
		end

	y: INTEGER is
			-- Vertical position in screen coordinates
		do
			Result := cwin_hi_word (l_param)
		end

feature -- Status report

	is_close: BOOLEAN is
			-- Is the command type "Close"?
		do
			Result := type = Sc_close
		end

	is_size: BOOLEAN is
			-- Is the command type "Size"?
		do
			Result := type = Sc_size
		end

	is_move: BOOLEAN is
			-- Is the command type "Move"?
		do
			Result := type = Sc_move
		end

	is_minimize: BOOLEAN is
			-- Is the command type "Minimize"?
		do
			Result := type = Sc_minimize
		end

	is_maximize: BOOLEAN is
			-- Is the command type "Maximize"?
		do
			Result := type = Sc_maximize
		end

	is_next_window: BOOLEAN is
			-- Is the command type "Next window"?
		do
			Result := type = Sc_nextwindow
		end

	is_previous_window: BOOLEAN is
			-- Is the command type "Previous window"?
		do
			Result := type = Sc_prevwindow
		end

	is_vertical_scroll: BOOLEAN is
			-- Is the command type "Vertical scroll"?
		do
			Result := type = Sc_vscroll
		end

	is_horizontal_scroll: BOOLEAN is
			-- Is the command type "Horizontal scroll"?
		do
			Result := type = Sc_hscroll
		end

	is_mouse_menu: BOOLEAN is
			-- Is the command type "Mouse menu"?
		do
			Result := type = Sc_mousemenu
		end

	is_key_menu: BOOLEAN is
			-- Is the command type "Key menu"?
		do
			Result := type = Sc_keymenu
		end

	is_arrange: BOOLEAN is
			-- Is the command type "Arrange"?
		do
			Result := type = Sc_arrange
		end

	is_restore: BOOLEAN is
			-- Is the command type "Restore"?
		do
			Result := type = Sc_restore
		end

	is_task_list: BOOLEAN is
			-- Is the command type "Task list"?
		do
			Result := type = Sc_tasklist
		end

	is_screen_save: BOOLEAN is
			-- Is the command type "Screen save"?
		do
			Result := type = Sc_screensave
		end

	is_hot_key: BOOLEAN is
			-- Is the command type "Hot key"?
		do
			Result := type = Sc_hotkey
		end

end -- class WEL_SYSTEM_COMMAND_MESSAGE


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


note
	description: "Information about message Wm_syscommand which is sent %
		%when the user chooses a command from the System menu (also %
		%known as Control menu) or when the user chooses the Maximize %
		%button or Minimize button."
	legal: "See notice at end of class."
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

create
	make

feature -- Access

	type: INTEGER
			-- Type of system command requested.
			-- See class WEL_SC_CONSTANTS for different values.
		do
			Result := w_param.to_integer_32
		end

	x: INTEGER
			-- Horizontal position in screen coordinates
		do
			Result := cwin_lo_word (l_param)
		end

	y: INTEGER
			-- Vertical position in screen coordinates
		do
			Result := cwin_hi_word (l_param)
		end

feature -- Status report

	is_close: BOOLEAN
			-- Is the command type "Close"?
		do
			Result := type = Sc_close
		end

	is_size: BOOLEAN
			-- Is the command type "Size"?
		do
			Result := type = Sc_size
		end

	is_move: BOOLEAN
			-- Is the command type "Move"?
		do
			Result := type = Sc_move
		end

	is_minimize: BOOLEAN
			-- Is the command type "Minimize"?
		do
			Result := type = Sc_minimize
		end

	is_maximize: BOOLEAN
			-- Is the command type "Maximize"?
		do
			Result := type = Sc_maximize
		end

	is_next_window: BOOLEAN
			-- Is the command type "Next window"?
		do
			Result := type = Sc_nextwindow
		end

	is_previous_window: BOOLEAN
			-- Is the command type "Previous window"?
		do
			Result := type = Sc_prevwindow
		end

	is_vertical_scroll: BOOLEAN
			-- Is the command type "Vertical scroll"?
		do
			Result := type = Sc_vscroll
		end

	is_horizontal_scroll: BOOLEAN
			-- Is the command type "Horizontal scroll"?
		do
			Result := type = Sc_hscroll
		end

	is_mouse_menu: BOOLEAN
			-- Is the command type "Mouse menu"?
		do
			Result := type = Sc_mousemenu
		end

	is_key_menu: BOOLEAN
			-- Is the command type "Key menu"?
		do
			Result := type = Sc_keymenu
		end

	is_arrange: BOOLEAN
			-- Is the command type "Arrange"?
		do
			Result := type = Sc_arrange
		end

	is_restore: BOOLEAN
			-- Is the command type "Restore"?
		do
			Result := type = Sc_restore
		end

	is_task_list: BOOLEAN
			-- Is the command type "Task list"?
		do
			Result := type = Sc_tasklist
		end

	is_screen_save: BOOLEAN
			-- Is the command type "Screen save"?
		do
			Result := type = Sc_screensave
		end

	is_hot_key: BOOLEAN
			-- Is the command type "Hot key"?
		do
			Result := type = Sc_hotkey
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_SYSTEM_COMMAND_MESSAGE


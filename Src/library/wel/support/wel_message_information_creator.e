indexing
	description: "This class creates a message information object %
		%corresponding to a given message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MESSAGE_INFORMATION_CREATOR

inherit
	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make (window: WEL_WINDOW; message, wparam, lparam: INTEGER) is
			-- Make `message_information' corresponding to
			-- `message' by using `wparam' and `lparam'.
		require
			window_not_void: window /= Void
			positive_message: message >= 0
		do
			if message = Wm_size then
				!WEL_SIZE_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_move then
				!WEL_MOVE_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_command then
				!WEL_COMMAND_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_syscommand then
				!WEL_SYSTEM_COMMAND_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_timer then
				!WEL_TIMER_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_showwindow then
				!WEL_SHOW_WINDOW_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_menuselect then
				!WEL_MENU_SELECT_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_windowposchanged or
				message = Wm_windowposchanging then
				!WEL_WINDOW_POSITION_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_notify then
				!WEL_NOTIFY_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_char or
				message = Wm_syschar or
				message = Wm_keydown or
				message = Wm_keyup or
				message = Wm_syskeydown or
				message = Wm_syskeyup then
				!WEL_KEY_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			elseif message = Wm_mousemove or
				message = Wm_lbuttondown or
				message = Wm_mbuttondown or
				message = Wm_rbuttondown or
				message = Wm_lbuttonup or
				message = Wm_mbuttonup or
				message = Wm_rbuttonup or
				message = Wm_lbuttondblclk or
				message = Wm_mbuttondblclk or
				message = Wm_rbuttondblclk then
				!WEL_MOUSE_MESSAGE! message_information.make (
					window, message, wparam, lparam)
			else 
				-- `message' is not handled by WEL.
				-- Let's create a generic message object.
				create message_information.make (window,
					message, wparam, lparam)
			end
		end

feature -- Access

	message_information: WEL_MESSAGE_INFORMATION
			-- Information about `message'.

end -- class WEL_MESSAGE_INFORMATION_CREATOR

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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


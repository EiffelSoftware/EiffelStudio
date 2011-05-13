note
	description: "Contains message information about thread's message %
		%queue."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MSG

inherit
	WEL_STRUCTURE

	WEL_PM_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_WM_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature -- Access

	hwnd: POINTER
			-- Window which has received the message
		do
			Result := cwel_msg_get_hwnd (item)
		end

	message: INTEGER
			-- Message identifier
		do
			Result := cwel_msg_get_message (item)
		end

	wparam: POINTER
			-- Additional information about `message'
		do
			Result := cwel_msg_get_wparam (item)
		end

	lparam: POINTER
			-- Additional information about `message'
		do
			Result := cwel_msg_get_lparam (item)
		end

feature -- Element change

	set_hwnd (a_hwnd: POINTER)
			-- Set `hwnd' with `a_hwnd'.
		do
			cwel_msg_set_hwnd (item, a_hwnd)
		ensure
			hwnd_set: hwnd = a_hwnd
		end

	set_message (a_message: INTEGER)
			-- Set `message' with `a_message'.
		do
			cwel_msg_set_message (item, a_message)
		ensure
			message_set: message = a_message
		end

	set_wparam (a_wparam: POINTER)
			-- Set `wparam' with `a_wparam'.
		do
			cwel_msg_set_wparam (item, a_wparam)
		ensure
			wparam_set: wparam = a_wparam
		end

	set_lparam (a_lparam: POINTER)
			-- Set `lparam' with `a_lparam'.
		do
			cwel_msg_set_lparam (item, a_lparam)
		ensure
			lparam_set: lparam = a_lparam
		end

feature -- Status report

	user_generated: BOOLEAN
			-- Is `Current' the result of a user-generated action, ie: mouse move or button click?
		do
			Result := True
			inspect
				cwel_msg_get_message (item)
			when wm_mousemove  then
			when wm_mousewheel then
			when wm_lbuttondown then
			when wm_lbuttonup then
			when wm_lbuttondblclk then
			when wm_mbuttondown then
			when wm_mbuttonup then
			when wm_mbuttondblclk then
			when wm_rbuttondown then
			when wm_rbuttonup then
			when wm_rbuttondblclk then
			when wm_keydown then
			when wm_keyup then
			when wm_syskeydown then
			when wm_syskeyup then
			else
				Result := False
			end
		end

	last_boolean_result: BOOLEAN
			-- Last result of `get', `get_all', `translate',
			-- `translate_accelerator', `dispatch', and
			-- `peek_result' routines.

	dispatch_result: INTEGER
			-- Last result of `dispatch' routine.

	quit: BOOLEAN
			-- Is `message' equal to `Wm_quit'?
		do
			--| We call directly the macro instead of `message'.
			Result := cwel_msg_get_message (item) = Wm_quit
		end

feature -- Basic operations

	get_all
			-- Get all messages.
		do
			last_boolean_result := cwin_get_message (item,
				default_pointer, 0, 0)
		end

	peek_input_messages
			-- Peek all mouse and keyboard messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_qs_input | Pm_remove)
		end

	peek_sent_messages
			-- Peek all posted messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_qs_sendmessage | Pm_remove)
		end

	peek_posted_messages
			-- Peek all posted messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_qs_postmessage | Pm_remove)
		end

	peek_paint_messages
			-- Peek all paint messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_qs_paint | Pm_remove)
		end

	peek_input_messages_noremove
			-- Peek all mouse and keyboard messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_qs_input)
		end

	peek_sent_messages_noremove
			-- Peek all posted messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_qs_sendmessage)
		end

	peek_posted_messages_noremove
			-- Peek all posted messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_qs_postmessage)
		end

	peek_paint_messages_noremove
			-- Peek all paint messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_qs_paint)
		end

	peek_all
			-- Peek all messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_remove)
		end

	peek_all_noremove
			-- Peek all messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_noremove)
		end

	dispatch
			-- Dispatch the message to a window procedure
		do
			dispatch_result := cwin_dispatch_message (item)
		end

	translate
			-- Translate virtual-key messages
			-- into character messages.
		do
			last_boolean_result := cwin_translate_message (item)
		end

	translate_accelerator (window: WEL_WINDOW;
			accelerators: WEL_ACCELERATORS)
			-- Process accelerator keys for menu commands
		require
			window_not_void: window /= Void
			window_exists: window.exists
			accelerators_not_void: accelerators /= Void
			accelerators_exists: accelerators.exists
		do
			last_boolean_result :=
				cwin_translate_accelerator (window.item,
				accelerators.item, item)
		end

	translate_mdi_accelarator (window: WEL_WINDOW)
			-- Process accelerator keys for system menu commands
			-- of MDI interface child windows.
		require
			window_not_void: window /= Void
			window_exists: window.exists
		do
			last_boolean_result :=
				cwin_translate_mdi_sys_accel (window.item, item)
		end

	wait
			-- Wait for a message.
		do
			last_boolean_result := cwin_wait_message
		end

	is_dialog_message (dialog: WEL_MODELESS_DIALOG)
			-- Determines whether a message is intended for
			-- `dialog' and, if it is, processes the message.
		require
			dialog_not_void: dialog /= Void
			dialog_exists: dialog.exists
		do
			last_boolean_result :=
				cwin_is_dialog_message (dialog.item, item)
		end

	process_dialog_message (dialog: POINTER)
			-- Process a dialog message for `dialog'.
		do
			last_boolean_result :=
				cwin_is_dialog_message (dialog, item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_msg
		end

feature {NONE} -- Externals

	c_size_of_msg: INTEGER
		external
			"C [macro <msg.h>]"
		alias
			"sizeof (MSG)"
		end

	cwin_get_message (ptr, a_hwnd: POINTER;
			first_msg, last_msg: INTEGER): BOOLEAN
			-- SDK GetMessage
		external
			"C [macro <wel.h>] (MSG *, HWND, UINT, UINT):%
				%EIF_BOOLEAN"
		alias
			"GetMessage"
		end

	cwin_peek_message (ptr, a_hwnd: POINTER;
			first_msg, last_msg, flags: INTEGER): BOOLEAN
			-- SDK PeekMessage
		external
			"C [macro <wel.h>] (MSG *, HWND, UINT, UINT, UINT):%
				%EIF_BOOLEAN"
		alias
			"PeekMessage"
		end

	cwin_translate_message (ptr: POINTER): BOOLEAN
			-- SDK TranslateMessage
		external
			"C [macro <wel.h>] (MSG *): EIF_BOOLEAN"
		alias
			"TranslateMessage"
		end

	cwin_translate_accelerator (a_hwnd, haccel, ptr: POINTER): BOOLEAN
			-- SDK TranslateAccelerator
		external
			"C [macro <wel.h>] (HWND, HACCEL, MSG *): EIF_BOOLEAN"
		alias
			"TranslateAccelerator"
		end

	cwin_translate_mdi_sys_accel (a_hwnd, ptr: POINTER): BOOLEAN
			-- SDK TranslateMDISysAccel
		external
			"C [macro <wel.h>] (HWND, MSG *): EIF_BOOLEAN"
		alias
			"TranslateMDISysAccel"
		end

	cwin_dispatch_message (ptr: POINTER): INTEGER
			-- SDK DispatchMessage
		external
			"C [macro <wel.h>] (MSG *): EIF_INTEGER"
		alias
			"DispatchMessage"
		end

	cwin_is_dialog_message (hwindow, ptr: POINTER): BOOLEAN
			-- SDK IsDialogMessage
		external
			"C [macro <wel.h>] (HWND, MSG *): EIF_BOOLEAN"
		alias
			"IsDialogMessage"
		end

	cwin_wait_message: BOOLEAN
			-- SDK WaitMessage
		external
			"C blocking macro use <wel.h>"
		alias
			"WaitMessage ()"
		end

	cwel_msg_set_hwnd (ptr: POINTER; value: POINTER)
		external
			"C [macro <msg.h>]"
		end

	cwel_msg_set_message (ptr: POINTER; value: INTEGER)
		external
			"C [macro <msg.h>]"
		end

	cwel_msg_set_lparam (ptr: POINTER; value: POINTER)
		external
			"C [macro <msg.h>]"
		end

	cwel_msg_set_wparam (ptr: POINTER; value: POINTER)
		external
			"C [macro <msg.h>]"
		end

	cwel_msg_get_hwnd (ptr: POINTER): POINTER
		external
			"C [macro <msg.h>] (MSG*): EIF_POINTER"
		end

	cwel_msg_get_message (ptr: POINTER): INTEGER
		external
			"C [macro <msg.h>]"
		end

	cwel_msg_get_wparam (ptr: POINTER): POINTER
		external
			"C [macro <msg.h>]"
		end

	cwel_msg_get_lparam (ptr: POINTER): POINTER
		external
			"C [macro <msg.h>]"
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

end

indexing
	description: "Contains message information about thread's message %
		%queue."
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
		end

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Access

	hwnd: POINTER is
			-- Window which has received the message
		do
			Result := cwel_msg_get_hwnd (item)
		end

	message: INTEGER is
			-- Message identifier
		do
			Result := cwel_msg_get_message (item)
		end

	wparam: INTEGER is
			-- Additional information about `message'
		do
			Result := cwel_msg_get_wparam (item)
		end

	lparam: INTEGER is
			-- Additional information about `message'
		do
			Result := cwel_msg_get_lparam (item)
		end

feature -- Status report

	last_boolean_result: BOOLEAN
			-- Last result of `get', `get_all', `translate',
			-- `translate_accelerator', `dispatch', and
			-- `peek_result' routines.

	dispatch_result: INTEGER
			-- Last result of `dispatch' routine.

	quit: BOOLEAN is
			-- Is `message' equal to `Wm_quit'?
		do
			--| We call directly the macro instead of `message'.
			Result := cwel_msg_get_message (item) = Wm_quit
		end

feature -- Basic operations

	get_all is
			-- Get all messages.
		do
			last_boolean_result := cwin_get_message (item,
				default_pointer, 0, 0)
		end

	peek_all is
			-- Peek all messages.
		do
			last_boolean_result := cwin_peek_message (item,
				default_pointer, 0, 0, Pm_remove)
		end

	dispatch is
			-- Dispatch the message to a window procedure
		do
			dispatch_result := cwin_dispatch_message (item)
		end

	translate is
			-- Translate virtual-key messages
			-- into character messages.
		do
			last_boolean_result := cwin_translate_message (item)
		end

	translate_accelerator (window: WEL_WINDOW;
			accelerators: WEL_ACCELERATORS) is
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

	translate_mdi_accelarator (window: WEL_WINDOW) is
			-- Process accelerator keys for system menu commands
			-- of MDI interface child windows.
		require
			window_not_void: window /= Void
			window_exists: window.exists
		do
			last_boolean_result :=
				cwin_translate_mdi_sys_accel (window.item, item)
		end

	wait is
			-- Wait for a message.
		do
			last_boolean_result := cwin_wait_message
		end

	is_dialog_message (dialog: WEL_MODELESS_DIALOG) is
			-- Determines whether a message is intended for
			-- `dialog' and, if it is, processes the message.
		require
			dialog_not_void: dialog /= Void
			dialog_exists: dialog.exists
		do
			last_boolean_result :=
				cwin_is_dialog_message (dialog.item, item)
		end

	process_dialog_message (dialog: POINTER) is
			-- Process a dialog message for `dialog'.
		do
			last_boolean_result :=
				cwin_is_dialog_message (dialog, item)
		end

feature {WEL_STRUCTURE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_msg
		end

feature {NONE} -- Externals

	c_size_of_msg: INTEGER is
		external
			"C [macro <msg.h>]"
		alias
			"sizeof (MSG)"
		end

	cwin_get_message (ptr, a_hwnd: POINTER;
			first_msg, last_msg: INTEGER): BOOLEAN is
			-- SDK GetMessage
		external
			"C [macro <wel.h>] (MSG *, HWND, UINT, UINT):%
				%EIF_BOOLEAN"
		alias
			"GetMessage"
		end

	cwin_peek_message (ptr, a_hwnd: POINTER;
			first_msg, last_msg, flags: INTEGER): BOOLEAN is
			-- SDK PeekMessage
		external
			"C [macro <wel.h>] (MSG *, HWND, UINT, UINT, UINT):%
				%EIF_BOOLEAN"
		alias
			"PeekMessage"
		end

	cwin_translate_message (ptr: POINTER): BOOLEAN is
			-- SDK TranslateMessage
		external
			"C [macro <wel.h>] (MSG *): EIF_BOOLEAN"
		alias
			"TranslateMessage"
		end

	cwin_translate_accelerator (a_hwnd, haccel, ptr: POINTER): BOOLEAN is
			-- SDK TranslateAccelerator
		external
			"C [macro <wel.h>] (HWND, HACCEL, MSG *): EIF_BOOLEAN"
		alias
			"TranslateAccelerator"
		end

	cwin_translate_mdi_sys_accel (a_hwnd, ptr: POINTER): BOOLEAN is
			-- SDK TranslateMDISysAccel
		external
			"C [macro <wel.h>] (HWND, MSG *): EIF_BOOLEAN"
		alias
			"TranslateMDISysAccel"
		end

	cwin_dispatch_message (ptr: POINTER): INTEGER is
			-- SDK DispatchMessage
		external
			"C [macro <wel.h>] (MSG *): EIF_INTEGER"
		alias
			"DispatchMessage"
		end

	cwin_is_dialog_message (hwindow, ptr: POINTER): BOOLEAN is
			-- SDK IsDialogMessage
		external
			"C [macro <wel.h>] (HWND, MSG *): EIF_BOOLEAN"
		alias
			"IsDialogMessage"
		end

	cwin_wait_message: BOOLEAN is
			-- SDK WaitMessage
		external
			"C"
		alias
			"cwel_wait_message"
		end

	cwel_msg_get_hwnd (ptr: POINTER): POINTER is
		external
			"C [macro <msg.h>]"
		end

	cwel_msg_get_message (ptr: POINTER): INTEGER is
		external
			"C [macro <msg.h>]"
		end

	cwel_msg_get_wparam (ptr: POINTER): INTEGER is
		external
			"C [macro <msg.h>]"
		end

	cwel_msg_get_lparam (ptr: POINTER): INTEGER is
		external
			"C [macro <msg.h>]"
		end

end -- class WEL_MSG

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

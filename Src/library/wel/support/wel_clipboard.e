note
	description: "Class that handles Windows Clipboard operations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIPBOARD

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			create last_string.make_empty
		end

feature -- Access

	clipboard_open: BOOLEAN
		-- Is clipboard open?

	last_string: STRING_32
			-- Text retrieved from Clipboard
			-- Only valid after a successfull call to
			-- `retrieve_clipboard_text'

	is_clipboard_format_available (format: INTEGER): BOOLEAN
		do
			Result :=  cwel_is_clipboard_format_available (format)
		end

feature -- Element Change

	retrieve_clipboard_text
			-- Retrieves text from the clipboard
		require
			clipboard_open: clipboard_open
			text_available: is_clipboard_format_available ({WEL_CLIPBOARD_CONSTANTS}.Cf_unicodetext)
		local
			shared_string: WEL_SHARED_MEMORY_STRING
			shared_memory_handle: POINTER
			l_string: ?like last_string
		do
			shared_memory_handle := cwel_get_clipboard_data ({WEL_CLIPBOARD_CONSTANTS}.Cf_unicodetext)
			if shared_memory_handle /= default_pointer then
				create shared_string.make_from_handle (shared_memory_handle)
				shared_string.retrieve_string
				l_string := shared_string.last_string
					-- Per postcondition of `shared_string.last_string'.
				check l_string_attached: l_string /= Void end
				last_string := l_string
			else
				last_string := ""
			end
		ensure
			last_string_not_void: last_string /= Void
		end

	set_clipboard_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to the clipboard
		require
			clipboard_open: clipboard_open
			a_text_not_void: a_text /= Void
		local
			shared_string: WEL_SHARED_MEMORY_STRING
		do
			create shared_string.make_from_string (a_text)
			cwel_set_clipboard_data ({WEL_CLIPBOARD_CONSTANTS}.Cf_unicodetext, shared_string.handle)
		end

	open_clipboard (window: ?WEL_WINDOW)
			-- Open clipboard for `window'. If `Void',
			-- clipboard is opened to the current task.
		require
			window_exists: window /= Void implies window.exists
		do
			if window /= Void then
				clipboard_open := cwel_open_clipboard (window.item)
			else
				clipboard_open := cwel_open_clipboard (default_pointer)
			end
		end

	close_clipboard
			-- Close clipboard.
		require
			clipboard_open: clipboard_open
		local
			b_result: BOOLEAN
		do
			b_result := cwel_close_clipboard
			check
				clipboard_closed: b_result
			end
		end

	empty_clipboard
			-- Empty clipboard.
		require
			clipboard_open: clipboard_open
		local
			b_result: BOOLEAN
		do
			b_result := cwel_empty_clipboard
			check
				clipboard_emptied: b_result
			end
		end

feature {NONE} -- Externals

	cwel_empty_clipboard: BOOLEAN
		external
			"C signature (): BOOL use %"wel.h%""
		alias
			"EmptyClipboard"
		end

	cwel_open_clipboard (hwnd_owner: POINTER): BOOLEAN
			-- Opens the clipboard
			-- hwnd_owner is the handle to the window opening the clipboard
		external
			"C signature (HWND): BOOL use %"wel.h%""
		alias
			"OpenClipboard"
		end

	cwel_close_clipboard: BOOLEAN
			-- Closes the clipboard
		external
			"C signature (): BOOL use %"wel.h%""
		alias
			"CloseClipboard"
		end

	cwel_get_clipboard_data (format: INTEGER): POINTER
			-- Gets a shared memory handle which gives access to
			-- the data currently stored in the clipboard.
			-- Format is one of the constants in WEL_CLIPBOARD_CONSTANTS
		external
			"C signature (UINT): HANDLE use %"wel.h%""
		alias
			"GetClipboardData"
		end

	cwel_set_clipboard_data (format: INTEGER; text: POINTER)
			-- Format is one of the constants in WEL_CLIPBOARD_CONSTANTS
		external
			"C signature (UINT, HANDLE) use %"wel.h%""
		alias
			"SetClipboardData"
		end

	cwel_is_clipboard_format_available (format: INTEGER): BOOLEAN
			-- Determines whether the clipboard contains data in the specified format.
		external
			"C signature (UINT): BOOL use %"wel.h%""
		alias
			"IsClipboardFormatAvailable"
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




end -- class WEL_CLIPBOARD


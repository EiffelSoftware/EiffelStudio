indexing
	description: "Class that handles Windows Clipboard operations"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIPBOARD
inherit
	WEL_CLIPBOARD_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	clipboard_open: BOOLEAN
		-- Is clipboard open?

	last_string: STRING
			-- Text retrieved from Clipboard
			-- Only valid after a successfull call to
			-- `retrieve_clipboard_text'

	is_clipboard_format_available (format: INTEGER): BOOLEAN is
		do
			Result :=  cwel_is_clipboard_format_available (format)
		end

feature -- Element Change

	retrieve_clipboard_text is
			-- Retrieves text from the clipboard
		require
			clipboard_open: clipboard_open
			text_available: is_clipboard_format_available (Cf_text)
		local
			shared_string: WEL_SHARED_MEMORY_STRING
			shared_memory_handle: POINTER
		do
			shared_memory_handle := cwel_get_clipboard_data (Cf_text)
			create shared_string.make_from_handle (shared_memory_handle)
			shared_string.retrieve_string
			last_string := shared_string.last_string
		end

	set_clipboard_text (a_text: STRING) is
			-- Assign `a_text' to the clipboard
		require
			clipboard_open: clipboard_open
		local
			shared_string: WEL_SHARED_MEMORY_STRING
		do
			create shared_string.make_from_string (a_text)
			cwel_set_clipboard_data (Cf_text, shared_string.handle)
		end

	open_clipboard (window: WEL_WINDOW) is
		require
			window_exists: window /= Void and then window.exists
		do
			clipboard_open := cwel_open_clipboard (window.item)
		end

	close_clipboard is
			-- Close clipboard.
		local
			b_result: BOOLEAN
		do
			b_result := cwel_close_clipboard
			check
				clipboard_closed: b_result /= Void
			end
		end	

	empty_clipboard is
			-- Empty clipboard.
		local
			b_result: BOOLEAN
		do
			b_result := cwel_empty_clipboard
			check
				clipboard_emptied: b_Result /= Void	
			end
		end


feature {NONE} -- Externals

	cwel_empty_clipboard: BOOLEAN is
		external
			"C | %"wel.h%""
		alias
			"EmptyClipboard"
		end

	cwel_open_clipboard (hwnd_owner: POINTER): BOOLEAN is
			-- Opens the clipboard
			-- hwnd_owner is the handle to the window opening the clipboard
		external
			"C | %"wel.h%""
		alias
			"OpenClipboard"
		end

	cwel_close_clipboard: BOOLEAN is
			-- Closes the clipboard
		external
			"C | %"wel.h%""
		alias
			"CloseClipboard"
		end

	cwel_get_clipboard_data (format: INTEGER): POINTER is
			-- Gets a shared memory handle which gives access to
			-- the data currently stored in the clipboard.
			-- Format is one of the constants in WEL_CLIPBOARD_CONSTANTS
		external
			"C | %"wel.h%""
		alias
			"GetClipboardData"
		end

	cwel_set_clipboard_data (format: INTEGER; text: POINTER) is
			-- Format is one of the constants in WEL_CLIPBOARD_CONSTANTS
		external
			"C | %"wel.h%""
		alias
			"SetClipboardData"
		end

	cwel_is_clipboard_format_available (format: INTEGER): BOOLEAN is
			-- Determines whether the clipboard contains data in the specified format. 
		external
			"C | %"wel.h%""
		alias
			"IsClipboardFormatAvailable"
		end
	
end -- class WEL_CLIPBOARD


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


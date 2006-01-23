indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NOTIFY_ICON_DATA

inherit
	WEL_STRUCTURE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Allocate `item' and initialize `cbSize' field.
		do
			Precursor {WEL_STRUCTURE}
			c_set_cbsize (item, structure_size)
		end

feature -- Access

	window: WEL_WINDOW
			-- Associated window processing messages for Current.

	icon: WEL_ICON
			-- Associated icon displayed in taskbar.

	tooltip_text: STRING is
			-- Associated tooltip if any.
		require
			valid_flags: (uflags & {WEL_NIF_CONSTANTS}.nif_icon) = {WEL_NIF_CONSTANTS}.nif_icon
		local
			l_str: WEL_STRING
		do
			create l_str.share_from_pointer_and_count (c_sztip (item), tooltip_text_size)
			Result := l_str.string
		ensure
			tooltip_text_not_void: Result /= Void
		end

	uflags: INTEGER is
			-- Flags that indicate which of the other members contain valid data.
			-- This member can be a combination of the following:
			-- NIF_ICON: `icon' is valid.
			-- NIF_MESSAGE: `callback_message' is valid.
			-- NIF_TIP: `tooltip_text' is valid.
			-- NIF_STATE: The dwState and dwStateMask members are valid.
			-- NIF_INFO: Use a balloon ToolTip instead of a standard ToolTip.
			--           The szInfo, uTimeout, szInfoTitle, and dwInfoFlags members are valid.
			-- NIF_GUID: Reserved.
		do
			Result := c_uflags (item)
		end

	callback_message: INTEGER is
		do
			Result := c_ucallback_message (item)
		end

feature -- Settings

	set_window (a_window: WEL_WINDOW) is
			-- Set `window' with `a_window'.
		do
			window := a_window
			if a_window = Void then
				c_set_hwnd (item, default_pointer)
			else
				c_set_hwnd (item, a_window.item)
			end
		ensure
			window_set: window = a_window
		end

	set_icon (a_icon: WEL_ICON) is
			-- Set `icon' with `a_icon'.
		do
			icon := a_icon
			if a_icon = Void then
				c_set_icon (item, default_pointer)
			else
				c_set_icon (item, a_icon.item)
			end
		ensure
			icon_set: icon = a_icon
		end

	set_tooltip_text (a_str: STRING) is
			-- Set `a_str' as `tooltip_text'.
		require
			valid_size: a_str /= Void implies a_str.count < tooltip_text_size
		local
			l_str: WEL_STRING
		do
			create l_str.share_from_pointer_and_count (c_sztip (item), 64)
			if a_str = Void then
				l_str.set_count (0)
			else
				l_str.set_string (a_str)
			end
		ensure
			tooltip_text_set: equal (a_str, tooltip_text)
		end

	set_uflags (a_uflags: INTEGER) is
			-- Set `uflags' with `a_uflags'.
		do
			c_set_uflags (item, a_uflags)
		ensure
			flags_set: uflags = a_uflags
		end

	set_callback_message (a_id: INTEGER) is
			-- Set `callback_message' with `a_id'.
		do
			c_set_ucallback_message (item, a_id)
		ensure
			callback_message_set: callback_message = a_id
		end

feature -- Sizing

	structure_size: INTEGER is
			-- Size of NOTIFYICONDATA structure
		external
			"C inline use <shellapi.h>"
		alias
			"sizeof(NOTIFYICONDATA)"
		end

	tooltip_text_size: INTEGER is
			-- Size of tooltip text.
		do
			Result := c_sztip_size (item)
		ensure
			tooltip_text_size_non_negative: Result >= 0
		end

feature {NONE} -- Implementation: Access

	c_ucallback_message (a_ptr: POINTER): INTEGER is
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->uCallbackMessage"
		end

	c_uflags (a_ptr: POINTER): INTEGER is
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->uFlags"
		end

	c_sztip_size (a_ptr: POINTER): INTEGER is
		external
			"C inline use <shellapi.h>"
		alias
			"sizeof(((NOTIFYICONDATA *) $a_ptr)->szTip)"
		end

	c_sztip (a_ptr: POINTER): POINTER is
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->szTip"
		end

feature {NONE} -- Implementation: Settings

	c_set_cbsize (a_ptr: POINTER; a_size: INTEGER) is
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->cbSize = $a_size"
		end

	c_set_hwnd (a_ptr: POINTER; a_hwnd: POINTER) is
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->hWnd = $a_hwnd"
		end

	c_set_icon (a_ptr: POINTER; a_icon: POINTER) is
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->hIcon = $a_icon"
		end

	c_set_uflags (a_ptr: POINTER; a_flags: INTEGER) is
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->uFlags = $a_flags"
		end

	c_set_ucallback_message (a_ptr: POINTER; a_id: INTEGER) is
		external
			"C inline use <shellapi.h>"
		alias
			"((NOTIFYICONDATA *) $a_ptr)->uCallbackMessage = $a_id"
		end

indexing
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

indexing
	description: "Window manager which is able to retrieve an Eiffel %
		%object from a HWND."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_MANAGER

feature -- Access

	windows: HASH_TABLE [WEL_WINDOW, POINTER] is
			-- Contains all the windows created by the application.
		once
			!! Result.make (Table_size)
		ensure
			result_not_void: Result /= Void
		end

feature -- Basic operations

	register_window (window: WEL_WINDOW) is
			-- Register `window' in the window manager.
		require
			window_not_void: window /= Void
			unregistered: not registered (window)
		do
			windows.put (window, window.item)
		ensure
			registered: registered (window)
		end

	unregister_window (window: WEL_WINDOW) is
			-- Unregister `window' from the window manager.
		require
			window_not_void: window /= Void
			registered: registered (window)
		do
			windows.remove (window.item)
		ensure
			unregistered: not registered (window)
		end

feature -- Status report

	registered (window: WEL_WINDOW): BOOLEAN is
			-- Is `window' registered?
		require
			window_not_void: window /= Void
		do
			Result := windows.has_item (window)
		end

feature {NONE} -- Implementation

	Table_size: INTEGER is 100
			-- Initial hash table size

end -- class WEL_WINDOW_MANAGER

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

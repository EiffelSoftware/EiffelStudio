indexing
	description: "Window manager which is able to retrieve an Eiffel %
		%object from a HWND."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_MANAGER

inherit
	WEL_WINDOWS_ROUTINES

feature -- Basic operations

	register_window (window: WEL_WINDOW) is
			-- Register `window' in the window manager.
		require
			window_not_void: window /= Void
			unregistered: not registered (window)
		do
			window.register_current_window
		ensure
			registered: registered (window)
		end

feature -- Status report

	registered (window: WEL_WINDOW): BOOLEAN is
			-- Is `window' registered?
		require
			window_not_void: window /= Void
		do
			Result := eif_id_object (window.internal_data) /= Void
		end

feature {WEL_DISPATCHER} -- Dialog creation

	new_dialog: WEL_DIALOG is
			-- Dialog which will be created after receiving WM_INITDIALOG message.
		do
			Result := new_dialog_cell.item
		end

feature {NONE} -- Implementation

	new_dialog_cell: CELL [WEL_DIALOG] is
			-- Save dialog that is going to be created
		once
			create Result.put (Void)
		end

	cwin_set_window_long (hwnd: POINTER; offset, value: INTEGER) is
			-- SDK SetWindowLong
		external
			"C [macro %"wel.h%"] (HWND, int, LONG)"
		alias
			"SetWindowLong"
		end

	eif_object_id_free (an_id: INTEGER) is
			-- Free the entry `an_id'
		external
			"C | %"eif_object_id.h%""
		end

end -- class WEL_WINDOW_MANAGER

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


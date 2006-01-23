indexing
	description: "Window manager which is able to retrieve an Eiffel %
		%object from a HWND."
	legal: "See notice at end of class."
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
		local
			l_data, null: POINTER
		do
				-- Default is `Result := False'.
			if window.exists then
				l_data := window.internal_data
				if l_data /= null then
					Result := eif_id_object (
						{WEL_INTERNAL_DATA}.object_id (l_data)) /= Void
				end
			end
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




end -- class WEL_WINDOW_MANAGER


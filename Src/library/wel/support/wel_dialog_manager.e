indexing
	description: "To perform a proper handling of dialog initialization."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DIALOG_MANAGER

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


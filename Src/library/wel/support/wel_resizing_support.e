note
	description: "[
			With deep nested windows, sometime a resizing event is not propagated to the children.
			When this happens, we send a special message to `silly_window' which will repeat the operation
			a second time at the next iteration of the event loop. Technically it ends up delaying the 
			resizing operation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RESIZING_SUPPORT

feature -- Access

	silly_window: WEL_SILLY_WINDOW
			-- Window that receives some private messages for WEL to work properly.
		do
			Result := silly_window_cell.item
		end

	wm_set_window_pos_msg: INTEGER = 1025
			-- Our own messaging

feature {NONE} -- Implementation

	silly_window_cell: CELL [WEL_SILLY_WINDOW]
		once
			create Result.put (create {WEL_SILLY_WINDOW}.make_top ("WEL Silly Window"))
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

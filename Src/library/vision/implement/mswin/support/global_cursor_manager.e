indexing
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	GLOBAL_CURSOR_MANAGER

inherit
	G_ANY_I

feature -- Access

	global_cursor : SCREEN_CURSOR is
			-- Cursor for all windows
		do
			Result := cursor_holder.item
		end

	global_cursor_windows: SCREEN_CURSOR_IMP is
		local
			gc: SCREEN_CURSOR
		do
			gc := cursor_holder.item
			if gc /= Void then
				Result ?= gc.implementation
			end
		end

feature -- Status setting

	restore_cursors is
			-- Restore cursor of each window
		local
			wc : WEL_CURSOR
		do
			if cursor_holder.item /= Void then
				wc ?= cursor_holder.item.implementation
				if wc.previous_cursor /= Void then
					wc.restore_previous
				end
				cursor_holder.put (Void) 
			end
		end

	set_global_cursor (c: SCREEN_CURSOR) is
			-- Set cursor for all windows
		local
			wc: WEL_CURSOR
		do
			cursor_holder.put (c)
			wc ?= c.implementation
			wc.set 
		end

feature {NONE} -- Implementation

	cursor_holder: CELL [SCREEN_CURSOR] is
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




end -- class GLOBAL_CURSOR_MANAGER


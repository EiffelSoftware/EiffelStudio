indexing
	description: 
		"EiffelVision dynamic list. Implementation interface."
	status: "See notice at end of class"
	keywords: "dynamic list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST_I [G]

inherit

	EV_ANY_I

feature -- Access

	item: G is
			-- Current item
		deferred
		end

	index: INTEGER is
			-- Index of current position
		deferred
		end

	cursor: CURSOR is
			-- Current cursor position
		deferred
		end
	
feature -- Measurement

	count: INTEGER is
			-- Number of items
		deferred
		end

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		deferred
		end

feature -- Cursor movement

	back is
			-- Move to previous item.
		deferred
		end

	forth is
			-- Move cursor to next position.
		deferred
		end


	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		deferred
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		deferred
		end

feature -- Element change

	extend (v: like item) is
			-- If add `v' to end.
			-- Do not move cursor.
		require
			v_not_void: v /= Void
		deferred
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		require
			v_not_void: v /= Void
		deferred
		end

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		require
			v_not_void: v /= Void
		deferred
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		require
			v_not_void: v /= Void
		deferred
		end

feature -- Removal

	prune (v: like item) is
			-- Remove `v' if present.
		require
			v_not_void: v /= Void
		deferred
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		deferred
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		deferred
		end


	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		deferred
		end

end -- class EV_DYNAMIC_LIST

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

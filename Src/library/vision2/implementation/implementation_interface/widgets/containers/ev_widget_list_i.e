indexing
	description: 
		"EiffelVision widget list. Implementation interface."
	status: "See notice at end of class"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_WIDGET_LIST_I

inherit
	EV_CONTAINER_I
		redefine
			interface
		end

feature -- Access

	item: EV_WIDGET is
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

feature {EV_ANY_I} -- implementation

	interface: EV_WIDGET_LIST

end -- class WIDGET_LIST

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.10  2000/02/08 09:36:57  oconnor
--| emoved inheritance of EV_DYNAMIC_LIST
--| This created more problems than it solved.
--| Most preconditions and invaraints require somthing better that G
--| as the item type and there with ireconsilable noconformities involving like
--|
--| Revision 1.1.4.9  2000/02/07 19:01:37  king
--| Converted to new ev_dynamic_list structure
--|
--| Revision 1.1.4.8  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.1.4.7  2000/01/27 19:30:02  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.6  2000/01/17 19:22:43  oconnor
--| inherit from EV_CONTAINER_I instead of EV_INVISIBLE_CONTAINER_I
--|
--| Revision 1.1.4.5  2000/01/17 18:02:41  oconnor
--| added preconditions to prevent insertion of Void items
--|
--| Revision 1.1.4.4  1999/12/17 18:21:02  rogers
--| Now inherits from EV_INVISIBLE_CONTAINER_I instead of EV_CONTAINER_I.
--|
--| Revision 1.1.4.3  1999/12/15 17:03:41  oconnor
--| formatting
--|
--| Revision 1.1.4.2  1999/11/30 22:48:43  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.1.4.1  1999/11/24 17:30:11  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.2.3  1999/11/17 01:57:02  oconnor
--| added move and prune removed full
--|
--| Revision 1.1.2.2  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.1.2.1  1999/11/05 18:24:32  oconnor
--| initial
--|
--| Revision 1.1.2.1  1999/11/05 18:02:35  oconnor
--| initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

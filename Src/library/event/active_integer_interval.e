indexing
	description:
		"Contiguous integer interval that calls an action sequence%N%
		%when it changes."
	status: "See notice at end of class"
	keywords: "event, action, linked, list"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVE_INTEGER_INTERVAL

inherit
	INTEGER_INTERVAL
		redefine
			extend, put,
			resize,
			copy,
			adapt
		end

create
	make

feature -- Initialization

	adapt (other: INTEGER_INTERVAL) is
			-- Reset to be the same interval as `other'.
		do
			Precursor (other)
			on_change
		end

feature -- Element change
	
	extend (v: INTEGER) is
			-- Make sure that interval goes all the way
			-- to `v' (up or down).
		do
			Precursor (v)
			on_change
		end

	put (v: INTEGER) is
			-- Make sure that interval goes all the way
			-- to `v' (up or down).
		do
			Precursor (v)
			on_change
		end

feature -- Resizing

	resize (minindex, maxindex: INTEGER) is
			-- Rearrange interval to go from at most
			-- `minindex' to at least `maxindex',
			-- encompassing previous bounds.
		do	 
			Precursor (minindex, maxindex)
			on_change
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reset to be the same interval as `other'.
		do
			Precursor (other)
			on_change
		end

feature -- Event handling

	change_actions: ACTION_SEQUENCE [TUPLE []] is
			-- Actions performed when interval changes.
		do
			if opo_change_actions = Void then
				create opo_change_actions.make
			end
			Result := opo_change_actions
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	on_change is
			-- Called when interval changes.
		do
			if opo_change_actions /= Void then
				opo_change_actions.call (Void)
			end
		end

	opo_change_actions: ACTION_SEQUENCE [TUPLE []]
			-- Once per object implementation for `change_actions'

end -- class ACTIVE_LIST

--!-----------------------------------------------------------------------------
--! EiffelEvent: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.1  2000/09/13 17:14:56  oconnor
--| initial
--|
--| Revision 1.7  2000/07/24 22:42:44  oconnor
--| updated for modified action_sequence
--|
--| Revision 1.6  2000/06/15 22:52:05  pichery
--| Removed `on_item_already_xxxx',
--| now `on_item_xxxx' is executed after the
--| operation has been done.
--|
--| Revision 1.5  2000/06/15 03:30:37  pichery
--| Added 2 new actions: These actions are called
--| once the items are added/removed. The other
--| actions are now called BEFORE the items are
--| added/removed.
--|
--| Revision 1.4  2000/03/23 16:42:58  brendel
--| Now inherits new class INTERACTIVE_LIST.
--|
--| Revision 1.3  2000/01/25 18:19:29  oconnor
--| added keywords and Contract support feature heading
--|
--| Revision 1.2  2000/01/25 16:55:08  brendel
--| Minor bug fixes.
--|
--| Revision 1.1  2000/01/25 16:27:40  brendel
--| Initial.
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

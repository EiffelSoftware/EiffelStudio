--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" A common type for radio components : tool-bar%
		% radio buttons, menu radio items..."
	note: " G is the type of the radio widget, H the type of%
		% its implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RADIO_IMP [G -> EV_ANY]

inherit
	EV_ANY_I

feature -- Access

	group: EV_RADIO_GROUP_IMP
			-- Current group of the item

feature -- Status report

	is_peer (peer: G): BOOLEAN is
			-- Is this item in same group as peer?
		local
			peer_imp: like Current
		do
			peer_imp ?= peer.implementation
			check
				valid_cast: peer_imp /= Void
			end
			Result := group.has (peer_imp)
		end

	is_selected: BOOLEAN is
			-- Is the current item selected?
		deferred
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the current button if `flag', deselect it
			-- otherwise.
		deferred
		end

feature -- Element change

	set_group (grp: like group) is
			-- Make `a_group' the current group and add the 
			-- item to it.
		do
			grp.add_item (Current)
			if is_selected then
				grp.set_selection_at (Current)
			end
			group := grp
		end

	set_peer (peer: G) is
			-- Put in same group as peer.
		local
			grp: EV_RADIO_GROUP_IMP
			peer_imp: like Current
		do
			peer_imp ?= peer.implementation
			check
				valid_cast: peer_imp /= Void
			end
			if peer_imp.group /= Void then
				set_group (peer_imp.group)
			else
				!! grp.make
				set_group (grp)
				peer_imp.set_group (grp)
			end
		end

feature {EV_RADIO_GROUP_IMP} -- Implementation

	on_unselect is
			-- Called when the item is unselected.
		deferred
		end

end -- class EV_RADIO_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.3  2000/01/27 19:30:16  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.2  2000/01/21 20:37:09  rogers
--| Now inherits EV_ANY_I
--|
--| Revision 1.1.10.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

indexing	
	description: "Eiffel Vision radio peer. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_RADIO_PEER_IMP

inherit
	EV_RADIO_PEER_I
	
feature -- Status report

	peers: LINKED_LIST [like interface] is
			-- List of all radio items in the group `Current' is in.
		local
			cur: CURSOR
		do
			create Result.make
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					Result.extend (radio_group.item.interface)
					radio_group.forth
				end
				radio_group.go_to (cur)
			else
					--| `radio_group' is void when `Current' is not parented in a container.
				check
					-- This item should be selected as enforced by
					-- other contracts.
					is_selected: is_selected
				end
				Result.extend (interface)
			end
		end

	selected_peer: like interface is
			-- Radio item that is currently selected.
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off or else Result /= Void
				loop
					if radio_group.item.is_selected then
						Result := radio_group.item.interface
					end
					radio_group.forth
				end
				radio_group.go_to (cur)
			else
					--| `radio_group' is void when `Current' is not parented in a container.
				check
					-- This item should be selected as enforced by
					-- other contracts.
					is_selected: is_selected
				end
				Result := interface
			end
		end

feature {EV_ANY_I} -- Implementation

	radio_group: LINKED_LIST [like Current]
			-- List this radio peer is in.
			-- This reference is shared with the other peers in the group.

	set_radio_group (a_list: like radio_group) is
			-- Remove `Current' from `radio_group'.
			-- Set `radio_group' to `a_list'.
			-- Extend `Current' in `a_list'.
		require
			a_list_not_void: a_list /= Void
			a_list_not_has_current: not a_list.has (Current)
		do
			if radio_group /= Void then
				remove_from_radio_group
			end
			radio_group := a_list
			if radio_group.is_empty then
				enable_select
			end
			radio_group.extend (Current)
		ensure
			assigned: radio_group = a_list
			in_it: radio_group.has (Current)
		end

	remove_from_radio_group is
			-- Remove `Current' from `radio_group'.
			-- Set `radio_group' to `Void'.
		require
			radio_group_not_void: radio_group /= Void
		do
			radio_group.start
			radio_group.prune (Current)
			check
				removed: not radio_group.has (Current)
			end
			if is_selected and then not radio_group.is_empty then
				radio_group.first.enable_select
			end
			radio_group := Void
		ensure
			void: radio_group = Void
		end
		
invariant
	
	peers_not_void: peers /= Void

end -- class EV_RADIO_PEER

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.4  2001/07/10 17:01:03  rogers
--| Added comments and new invariant, "peers_not_void".
--|
--| Revision 1.3  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.6.3  2000/11/29 00:45:14  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.2.6.2  2000/08/03 16:36:52  rogers
--| Formatting to 80 columns.
--|
--| Revision 1.2.6.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.2  2000/02/25 02:18:32  brendel
--| Implemented.
--|
--| Revision 1.1  2000/02/24 20:27:22  brendel
--| Initial revision. Needed for rearranged radio-item inheritance structure.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------



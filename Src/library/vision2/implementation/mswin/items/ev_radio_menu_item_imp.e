indexing	
	description: "Eiffel Vision radio menu item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		undefine
			parent
		redefine
			interface
		end

	EV_SELECT_MENU_ITEM_IMP
		redefine
			enable_select,
			interface,
			on_activate,
			is_selected
		end

create
	make

feature -- Status report

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		do
			if parent_imp = Void then
				--| If a radio menu item does not have a parent, it must appear
				--| to be checked to satisfy radio grouping contracts.
				--| (an unparented radio item is checked, or in other words: has
				--| its own group and a group always has 1 selected item)
				Result := True
			else
				Result := parent_imp.item_checked (id)	
			end
		end

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
				check
					-- This item should be selected as enforced by other contracts.
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
				check
					-- This item should be selected as enforced by other contracts.
					is_selected: is_selected
				end
				Result := interface
			end
		end

feature -- Status setting
	
	enable_select is
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					parent_imp.uncheck_item (radio_group.item.id)
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			Precursor
		end

feature {EV_ANY_I} -- Implementation

	radio_group: LINKED_LIST [like Current]

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
			if radio_group.empty then
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
			if is_selected and then not radio_group.empty then
				radio_group.first.enable_select
			end
			radio_group := Void
		ensure
			void: radio_group = Void
		end

	interface: EV_RADIO_MENU_ITEM

feature {NONE} -- Implementation

	on_activate is
		do
			enable_select
			Precursor
		end

end -- class EV_RADIO_MENU_ITEM_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.16  2000/02/24 20:36:47  brendel
--| Changed to comply with new inheritance structure. Invariants have been
--| moved from this file to EV_RADIO_PEER.
--|
--| Revision 1.15  2000/02/24 16:50:58  brendel
--| Made `toggle' inapplicable.
--| Added redefine of `on_activate', since toggle cannot be called anymore.
--|
--| Revision 1.14  2000/02/24 01:45:59  brendel
--| Improved contracts.
--| Fully implemented.
--|
--| Revision 1.13  2000/02/23 02:16:35  brendel
--| Revised. Implemented.
--|
--| Revision 1.12  2000/02/22 20:14:46  brendel
--| Commented out old implementation.
--|
--| Revision 1.11  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.2  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

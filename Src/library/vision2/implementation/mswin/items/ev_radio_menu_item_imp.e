indexing	
	description: "Eiffel Vision radio menu item. Implementation interface."
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

	EV_CHECK_MENU_ITEM_IMP
		redefine
			disable_select,
			enable_select,
			toggle,
			interface
		end

create
	make

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
			end
		end

feature -- Status setting
	
	enable_select is
		local
			cur: CURSOR
		do
			is_in_transitional_state := True
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
			is_in_transitional_state := True
		end

	disable_select is
		do
			check
				inapplicable_for_radio_items: False
			end
		end

	toggle is
			-- Change the checked state of the menu-item.
		do
			enable_select
		end

feature -- Contract support

	is_in_transitional_state: BOOLEAN
			-- When `True', `radio_group_selected_count' might be zero.

	radio_group_selected_count: INTEGER is
			-- Number of selected radio items in `radio_group'.
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
					if radio_group.item.is_selected then
						Result := Result + 1
					end
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
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

invariant
	radio_group_not_void_implies_has_current:
		radio_group /= Void implies radio_group.has (Current)
	radio_group_not_void_implies_one_selected:
		(radio_group /= Void and not is_in_transitional_state) implies
			radio_group_selected_count = 1

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

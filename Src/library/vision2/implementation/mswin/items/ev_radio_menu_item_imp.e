indexing	
	description: 
		"Eiffel Vision radio menu item. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		redefine
			interface
		end

	EV_CHECK_MENU_ITEM_IMP
		redefine
			on_activate,
			interface
		end

create
	make

feature -- Access

	radio_group: LINKED_LIST [like Current]

feature -- Status setting

	set_radio_group (a_list: like radio_group) is
			-- Remove `Current' from `radio_group'.
			-- Set `radio_group' to `a_list'.
			-- Extend `Current' in `a_list'.
		do
			if radio_group /= Void then
				radio_group.search (Current)
				radio_group.remove
			end
			radio_group := a_list
			radio_group.extend (Current)
		end

feature {NONE} -- Implementation

	on_activate is
		do
			if not is_selected then
				enable_select
				if radio_group /= Void then
					from
						radio_group.start
					until
						radio_group.off
					loop
						if radio_group.item /= Current then
							if radio_group.item.is_selected then
								radio_group.item.disable_select
							end
						end
						radio_group.forth
					end
				end
			end
			interface.press_actions.call ([])
		end

	interface: EV_RADIO_MENU_ITEM

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

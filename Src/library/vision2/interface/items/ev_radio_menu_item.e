indexing	
	description: "Eiffel Vision radio menu item."
	status: "See notice at end of class"
	keywords: "radio, item, menu, check, select, unselect"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_RADIO_MENU_ITEM

inherit
	EV_CHECK_MENU_ITEM
		export
			{NONE} disable_select
		redefine
			implementation,
			create_implementation,
			disable_select
		end
	
create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	create_implementation is
		do
			create {EV_RADIO_MENU_ITEM_IMP} implementation.make (Current)
		end

feature -- Status report

	peers: LINKED_LIST [like Current] is
			-- List of all radio items in the group `Current' is in.
		do
			Result := implementation.peers
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.peers)
			different_list_every_time: Result /= peers
			not_empty_implies_has_current:
				not Result.empty implies Result.has (Current)
		end

feature -- Inapplicable

	disable_select is
			-- Inapplicable for radio items.
		do
			check
				inapplicable: False
			end
		end

feature {NONE} -- Implementation

	implementation: EV_RADIO_MENU_ITEM_I
			-- Platform dependent access.

end -- class EV_RADIO_MENU_ITEM

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/02/24 01:32:17  brendel
--| Added feature `peers' which lets the user look in the list of radio-items
--| associated with the current item.
--| Redefined `disable_select', because it is not applicable to radio items.
--|
--| Revision 1.12  2000/02/22 19:54:44  brendel
--| Reworked interface.
--| Basically removed everything since radiobuttons are now automatically
--| grouped in menu's separated by separators.
--|
--| Revision 1.11  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.2  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.3  1999/11/04 23:10:51  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.9.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision menu container, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MENU_HOLDER_IMP

inherit
	EV_MENU_HOLDER_I
		redefine
			interface
		select
			interface
		end
		-- Inheriting from widget, because menu and menu bar
		-- are widgets in gtk, although it is not a widget in
		-- EiffelVision. This is just for implementation
		-- reasons.

	EV_CONTAINER_IMP
		rename
			interface as container_interface
		undefine
			initialize
		end

	--EV_GTK_ITEMS_EXTERNALS

feature -- Access
 
	item: EV_WIDGET is
			-- Current item
		do
			check false end
			-- FIXME
		end

 	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
 			-- List of the children.

feature -- Element change	

	extend (an_item: like item) is
		do
			replace (an_item)
		end
	
	add_menu (menu_imp: EV_MENU) is
			-- Add `menu_imp' in the container.
		deferred
		end

	remove_menu (menu_imp: EV_MENU) is
			-- Remove `menu_imp' from the container.
		deferred
		end

feature -- Implementation

	interface: EV_MENU_HOLDER

end -- class EV_MENU_HOLDER_IMP


 --!----------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.6  2000/02/08 09:31:57  oconnor
--| added extend
--|
--| Revision 1.4.6.5  2000/02/04 04:53:00  oconnor
--| released
--|
--| Revision 1.4.6.4  2000/02/02 00:06:44  oconnor
--| hacking menus
--|
--| Revision 1.4.6.3  2000/01/27 19:29:38  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.2  1999/12/01 01:02:32  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.4.6.1  1999/11/24 17:29:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.4  1999/11/23 23:00:16  oconnor
--| undefine initialize on repeated inherit
--|
--| Revision 1.4.2.3  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.4.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

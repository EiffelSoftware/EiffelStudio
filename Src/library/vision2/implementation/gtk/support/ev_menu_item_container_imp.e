--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision invisible container, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_HOLDER_IMP
	
inherit
	EV_MENU_ITEM_HOLDER_I
		redefine
			interface
--		select
--			interface
		end
		-- Inheriting from widget, because menu and menu bar
		-- are widgets in gtk, although it is not a widget in
		-- EiffelVision. This is just for implementation
		-- reasons.

--	EV_CONTAINER_IMP 
--		rename
--			interface as container_interface
--		end

--	EV_WIDGET_IMP
--		rename
--			interface as widget_interface
--		end

	EV_ITEM_LIST_IMP [EV_MENU_ITEM]
		redefine
			interface
		end

feature -- Access
 
--	item: EV_ITEM is
--			-- Current item
--		do
----			check false end
--			-- FIXME
--		end

 	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
 			-- List of the children.

feature -- Element change
	
	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		deferred
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add `item_imp' into container.
		deferred
		end

feature -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			C.gtk_menu_reorder_child (a_container, a_child, a_position)
		end

	list_widget: POINTER is
		do
			Result := c_object
		end

	interface: EV_MENU_ITEM_HOLDER

end -- class EV_MENU_ITEM_HOLDER_IMP

--!----------------------------------------------------------------
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.16  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.6.7  2000/02/04 04:53:00  oconnor
--| released
--|
--| Revision 1.15.6.6  2000/02/02 00:06:44  oconnor
--| hacking menus
--|
--| Revision 1.15.6.5  2000/01/27 19:29:38  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.6.4  1999/12/04 18:59:16  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.15.6.3  1999/12/01 01:02:32  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.15.6.2  1999/11/30 22:59:46  oconnor
--| rename EV_ITEM_HOLDER_IMP to EV_ITEM_LIST_IMP
--|
--| Revision 1.15.6.1  1999/11/24 17:29:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.2.3  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.15.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

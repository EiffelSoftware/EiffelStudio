indexing
    description:
        "EiffelVision list item holder, implementation."
    status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

deferred class
	EV_LIST_ITEM_HOLDER_IMP

inherit
	EV_ITEM_HOLDER_IMP

feature {EV_LIST_ITEM_HOLDER_IMP, EV_LIST_ITEM_IMP} -- Implementation

 	ev_children: ARRAYED_LIST [EV_LIST_ITEM_IMP] is
 			-- List of the children.
		deferred
		end
 
	list_widget: POINTER
			-- Pointer to the gtk_list.
			-- We need this pointer because the EiffelVision2
			-- EV_LIST_ITEM_HOLDER are often composed by
			-- several Gtk object.
			-- ex: EV_LIST = GtkScrolledWindow + GtkList
			--  `widget' would point to the 1st object
			-- and `list_widget' to the 2nd.
	widget: POINTER is
			-- Pointer to the Gtk object,
			-- we need it for class EV_LIST_ITEM_IMP
			-- to access to this pointer in several features.
		deferred
		end

end -- class EV_LIST_ITEM_HOLDER_IMP

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

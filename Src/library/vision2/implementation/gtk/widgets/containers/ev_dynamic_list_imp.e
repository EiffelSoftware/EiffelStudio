indexing
	description:
		"Eiffel Vision dynamic list. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST_IMP [G -> EV_ANY]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

feature -- Access

	i_th (i: INTEGER): G is
			-- Item at `i'-th position.
		local
			child: POINTER
			imp: EV_ANY_IMP
		do
			child := C.g_list_nth_data (
				C.gtk_container_children (list_widget),
				i - 1)
			check
				child_not_void: child /= Default_pointer
			end
			imp := eif_object_from_c (child)
			check
				imp_not_void: imp /= Void
			end
			Result := imp_to_int (imp)
			check
				Result_not_void: Result /= Void
			end
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			if list_widget /= Default_pointer then
				Result := C.g_list_length (C.gtk_container_children (list_widget))
			end
		end

feature {NONE} -- Implementation

	--| FIXME VB: I would like to have all EV_DYNAMIC_LIST
	--| objects to only use insert_i_th and remove_i_th.
	--| gtk_reorder_child may only call once C function.
	--| add_to_container will be removed.

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		deferred
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
			--| Do nothing more than calling gtk-reorder.
		deferred
		end

	list_widget: POINTER is
			-- GtkWidget that holds the list.
		do
			Result := c_object
		end

feature -- Event handling

	new_item_actions: ACTION_SEQUENCE [TUPLE [G]] is
			-- Actions to be performed after an item is added.
		deferred
		end
			
	remove_item_actions: ACTION_SEQUENCE [TUPLE [G]] is
			-- Actions to be performed before an item is removed.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_DYNAMIC_LIST [G]

invariant
--| FIXME EV_TREE_ITEM_IMP has no list_widget when it has no
--| children. Remove invariant from here?
--	list_widget_not_void:
--		is_useable implies list_widget /= Default_pointer

end -- class EV_DYNAMIC_LIST_IMP

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
--| Revision 1.7  2000/05/02 17:30:52  king
--| Made *_i_th deferred, added deferred *_item_actions
--|
--| Revision 1.6  2000/04/12 18:51:59  oconnor
--| formatting
--|
--| Revision 1.5  2000/04/12 18:51:34  brendel
--| Removed invariant. Should be put in individual classes where is does
--| apply?
--|
--| Revision 1.4  2000/04/06 20:24:51  brendel
--| Changed list_widget from attribute to function.
--|
--| Revision 1.3  2000/04/06 02:06:23  brendel
--| Added invariant.
--|
--| Revision 1.2  2000/04/05 21:16:09  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.1.2.1  2000/04/05 19:29:26  brendel
--| Initial.
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

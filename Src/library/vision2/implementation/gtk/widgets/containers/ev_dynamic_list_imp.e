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
		local
			v_imp: EV_ANY_IMP
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			C.gtk_container_add (list_widget, v_imp.c_object)
			if i <= count then
				gtk_reorder_child (list_widget, v_imp.c_object, i - 1)
			end
		--	new_item_actions.call ([v])
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			p: POINTER
			v_imp: EV_WIDGET_IMP
		do
			p := C.g_list_nth_data (
				C.gtk_container_children (list_widget),
				i - 1)
			v_imp ?= eif_object_from_c (p)
			check
				v_imp_not_void: v_imp /= Void
			end
		--	remove_item_actions.call ([v_imp.interface])
			--| FIXME VB To be checked by Sam.
			--| ref comes from item list and not in widget list?
			--| Is it necessary?
			C.gtk_widget_ref (p)
			C.gtk_container_remove (list_widget, p)
			C.set_gtk_widget_struct_parent (p, Default_pointer)
			--v_imp.set_parent_imp (Void)
			C.gtk_widget_unref (p)
		end

feature {EV_ANY_I} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
			--| Do nothing more than calling gtk-reorder.
		deferred
		end

	list_widget: POINTER
			-- GtkWidget that holds the list.

feature {NONE} -- Implementation

	interface: EV_DYNAMIC_LIST [G]

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
--| Revision 1.2  2000/04/05 21:16:09  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.1.2.1  2000/04/05 19:29:26  brendel
--| Initial.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

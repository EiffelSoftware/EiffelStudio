indexing
	description:
		"Eiffel Vision dynamic list. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST_IMP [G -> EV_CONTAINABLE]

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
			a_child_list: POINTER
		do
			a_child_list := C.gtk_container_children (list_widget)
			child := C.g_list_nth_data (
				a_child_list,
				i - 1)
			check
				child_not_void: child /= NULL
			end
			C.g_list_free (a_child_list)
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
		local
			a_child_list: POINTER
		do
			if list_widget /= NULL and then not is_destroyed then
				a_child_list := C.gtk_container_children (list_widget)
				if a_child_list /= NULL then
					Result := C.g_list_length (a_child_list)
					C.g_list_free (a_child_list)
				end
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

	on_new_item (an_item: G) is
			-- Called after `an_item' is added.
		deferred
		end

	on_removed_item (an_item: G) is
			-- Called just before `an_item' is removed.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_DYNAMIC_LIST [G]

invariant
--| FIXME EV_TREE_ITEM_IMP has no list_widget when it has no
--| children. Remove invariant from here?
--	list_widget_not_void:
--		is_useable implies list_widget /= NULL

end -- class EV_DYNAMIC_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


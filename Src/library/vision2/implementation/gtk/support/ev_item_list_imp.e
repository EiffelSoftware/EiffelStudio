indexing
	description:
		"Eiffel Vision item list. GTK+ implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


deferred class
	EV_ITEM_LIST_IMP [G -> EV_ITEM]

inherit
	EV_ITEM_LIST_I [G]
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

	EV_DYNAMIC_LIST_IMP [G]
		redefine
			interface
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= v.implementation
			check
				imp_not_void: v_imp /= Void
			end
			add_to_container (v, v_imp)
			child_array.go_i_th (i)
			child_array.put_left (v)
			if i < count then
				reorder_child (v, v_imp, i)
			end
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			imp: EV_ITEM_IMP
			item_ptr: POINTER
		do			
			child_array.go_i_th (i)
			imp ?= child_array.i_th (i).implementation

			item_ptr := imp.c_object
			C.gtk_object_ref (item_ptr)
			C.gtk_container_remove (list_widget, item_ptr)
			child_array.remove
			imp.set_item_parent_imp (Void)
		end

feature {NONE} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
			--| Do nothing more than calling gtk-reorder.
		deferred
		end

feature {NONE} -- Obsolete

	add_to_container (v: EV_ITEM; v_imp: EV_ITEM_IMP) is
			-- Add `v' to end of list.
		do
			C.gtk_container_add (list_widget, v_imp.c_object)
			v_imp.set_item_parent_imp (Current)
		end

	reorder_child (v: EV_ITEM; v_imp: EV_ITEM_IMP; a_position: INTEGER) is
			-- Move `v' to `a_position'.
		do
			gtk_reorder_child (list_widget, v_imp.c_object, a_position - 1)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_LIST [G]
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

end -- class EV_ITEM_LIST_IMP

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


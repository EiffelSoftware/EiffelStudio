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

	--| FIXME VB: I would like to have all EV_ITEM_LIST_IMP
	--| objects to only use insert_i_th and remove_i_th.
	--| gtk_reorder_child may only call once C function.
	--| add_to_container will be removed.
	--| When that is done remove insert_i_th and remove_i_th.

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			--imp: EV_ANY_I
		do
			add_to_container (v)
			if i < count then
				reorder_child (v, i)
			end

		--	imp ?= v.implementation
		--	check
		--		imp_not_void: imp /= Void
		--	end
			on_new_item (v)
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			p: POINTER
			--w_imp: EV_WIDGET_IMP
		do
			p := C.g_list_nth_data (
				C.gtk_container_children (list_widget),
				i - 1)

		--	w_imp ?= eif_object_from_c (p)
		--	check
		--		w_imp_not_void: w_imp /= Void
		--	end
		--	remove_item_actions.call ([w_imp])

			C.gtk_widget_ref (p)
			C.gtk_container_remove (list_widget, p)
			C.gtk_widget_unref (p)
		end

feature {NONE} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
			--| Do nothing more than calling gtk-reorder.
		deferred
		end

feature {NONE} -- Obsolete

	add_to_container (v: like item) is
			-- Add `v' to end of list.
			--| FIXME VB Will be obsolete
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			C.gtk_container_add (list_widget, v_imp.c_object)
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position'.
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			gtk_reorder_child (list_widget, v_imp.c_object, a_position - 1)
		end

feature -- Event handling

	on_new_item (an_item: G) is
			-- Called after `an_item' is added.
		do
		end

	on_removed_item (an_item: G) is
			-- Called just before `an_item' is removed.
		do
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


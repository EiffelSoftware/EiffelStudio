indexing
	description: "Eiffel Vision widget list. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_WIDGET_LIST_IMP
	
inherit
	EV_WIDGET_LIST_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			replace
		redefine
			interface,
			initialize
		end

	EV_DYNAMIC_LIST_IMP [EV_WIDGET]
		undefine
			destroy
		redefine
			interface,
			list_widget,
			initialize
		end
		
feature {NONE} -- Initialization

	initialize is
			-- 
		do
			{EV_CONTAINER_IMP} Precursor
			{EV_DYNAMIC_LIST_IMP} Precursor
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_ANY_IMP
			a_c_object: POINTER
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			a_c_object := v_imp.c_object
			C.gtk_container_add (list_widget, a_c_object)
			if i < count then
				gtk_reorder_child (list_widget, a_c_object, i - 1)
			end
			child_array.go_i_th (i)
			child_array.put_left (v)
			update_child_requisition (a_c_object)
			on_new_item (v)
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			p: POINTER
			v_imp: EV_WIDGET_IMP
			a_child_list: POINTER
		do
			a_child_list := C.gtk_container_children (list_widget)
			p := C.g_list_nth_data (
				a_child_list,
				i - 1)
			v_imp ?= eif_object_from_c (p)
			C.g_list_free (a_child_list)
			check
				v_imp_not_void: v_imp /= Void
			end
			on_removed_item (v_imp.interface)
			--| FIXME VB To be checked by Sam.
			--| ref comes from item list and not in widget list?
			--| Is it necessary?
			C.gtk_object_ref (p)
			C.gtk_container_remove (list_widget, p)
			C.set_gtk_widget_struct_parent (p, NULL)
			C.gtk_object_unref (p)
			
			child_array.go_i_th (i)
			child_array.remove
		end
	
--| FIXME Direct implementation of extend.
--| This is faster than the cutrrent implementation but propper
--| benchmarks should be done prior to its inclusion. - Sam
--|	extend (v: EV_WIDGET) is
--|			-- Add `v' to end. Do not move cursor.
--|		local
--|			v_imp: EV_ANY_IMP
--|		do
--|			v_imp ?= v.implementation
--|			if index > count then
--|				index := index + 1
--|			end
--|			check
--|				v_imp_not_void: v_imp /= Void
--|			end
--|			C.gtk_container_add (list_widget, v_imp.c_object)
--|			on_new_item (v)
--|		end

feature {NONE} -- Implementation

	list_widget: POINTER is
			-- Pointer to the actual widget list container.
		do
			Result := container_widget
		end

	interface: EV_WIDGET_LIST
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_WIDGET_LIST_IMP

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


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
			-- Initialize `Current'
		do
			Precursor {EV_CONTAINER_IMP}
			Precursor {EV_DYNAMIC_LIST_IMP}
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_WIDGET_IMP
			a_c_object: POINTER
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			a_c_object := v_imp.c_object
			feature {EV_GTK_EXTERNALS}.gtk_container_add (list_widget, a_c_object)

			child_array.go_i_th (i)
			child_array.put_left (v)
			if i < count then
				gtk_reorder_child (list_widget, a_c_object, i - 1)
			end			
			on_new_item (v_imp)
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			v_imp: EV_WIDGET_IMP
			a_child: POINTER
			a_index: INTEGER
		do
			a_index := index
				-- Store the index in case it is changed as a result of an event on the pass back to gtk
			v_imp ?= i_th (i).implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			child_array.go_i_th (i)
			child_array.remove
			on_removed_item (v_imp)
			a_child := v_imp.c_object
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (a_child)
			feature {EV_GTK_EXTERNALS}.gtk_container_remove (list_widget, a_child)
			feature {EV_GTK_EXTERNALS}.set_gtk_widget_struct_parent (a_child, NULL)
			index := a_index
				-- The call to gtk_container_remove might indirectly fire an event which changes the index so we reset just to make sure
		end

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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


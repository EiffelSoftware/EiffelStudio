indexing
	description: "EiffelVision list item list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface,
			wipe_out
		end

	EV_PRIMITIVE_IMP
		redefine
			initialize,
			interface,
			make
		end

	EV_ITEM_LIST_IMP [EV_LIST_ITEM]
		undefine
			destroy
		redefine
			interface,
			--add_to_container,
			insert_i_th,
			remove_i_th,
			initialize
		end
	
	EV_LIST_ITEM_LIST_ACTION_SEQUENCES_IMP
	
	EV_KEY_CONSTANTS
	
	EV_PND_DEFERRED_ITEM_PARENT

feature {NONE} -- Initialization

	initialize is
			-- Set up `Current'
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			initialize_pixmaps
			initialize_model
		end

	initialize_model is
			-- Create our data model for `Current'
		local
			a_type_array: ARRAY [INTEGER]
			a_type_array_c: ANY
		do
			create a_type_array.make (0, 1)
			a_type_array.put (feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_type_pixbuf, 0)
			a_type_array.put (feature {EV_GTK_DEPENDENT_EXTERNALS}.g_type_string, 1)
			a_type_array_c := a_type_array.to_c
			list_store := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_newv (2, $a_type_array_c)			
		end

feature -- Access

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- `Result is all items currently selected in `Current'.
		deferred
		end

feature -- Status report

	row_from_y_coord (a_y: INTEGER): EV_PND_DEFERRED_ITEM is
			-- Retrieve the Current row from `a_y' coordinate
			-- (export status {EV_ANY_I})
		do
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at one based index, `an_index'.
		deferred
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at one based index, `an_index'.
		deferred
		end

feature -- Insertion

	set_text_on_position (a_row: INTEGER; a_text: STRING) is
			-- Set cell text at (a_column, a_row) to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
			str_value: POINTER
			a_list_item_imp: EV_LIST_ITEM_IMP
		do
			create a_cs.make (a_text)
			str_value := feature {EV_GTK_DEPENDENT_EXTERNALS}.c_g_value_struct_allocate
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_value_init_string (str_value)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_value_set_string (str_value, a_cs.item)
			
			a_list_item_imp ?= child_array.i_th (a_row).implementation
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_value (list_store, a_list_item_imp.list_iter.item, 1, str_value)
			str_value.memory_free
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			pixmap_imp: EV_PIXMAP_IMP
			a_list_item_imp: EV_LIST_ITEM_IMP
			a_pixbuf: POINTER
		do
			pixmap_imp ?= a_pixmap.implementation
			a_pixbuf := pixmap_imp.pixbuf_from_drawable_with_size (pixmaps_width, pixmaps_height)
			a_list_item_imp ?= child_array.i_th (a_row).implementation
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_pixbuf (list_store, a_list_item_imp.list_iter.item, 0, a_pixbuf)
		end

	remove_row_pixmap (a_row: INTEGER) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			a_list_item_imp: EV_LIST_ITEM_IMP
		do
			a_list_item_imp ?= child_array.i_th (a_row).implementation
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_pixbuf (list_store, a_list_item_imp.list_iter.item, 0, NULL)
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_LIST_ITEM_IMP
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			
			child_array.go_i_th (i)
			child_array.put_left (v)	

				-- Add row to model
			create a_tree_iter.make
			item_imp.set_list_iter (a_tree_iter)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_insert (list_store, a_tree_iter.item, i - 1)
			set_text_on_position (i, v.text)
			
			if v.pixmap /= Void then
				set_row_pixmap (i, v.pixmap)
			end
			
			if item_imp.is_transport_enabled then
			--	update_pnd_connection (True)
			end
	
	
		end
		
feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_IMP} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check do_not_call: False end
		end

	interface: EV_LIST_ITEM_LIST
	
	list_store: POINTER
		-- Pointer to the model which holds all of the column data

feature {NONE} -- Implementation

	remove_i_th (an_index: INTEGER) is
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			clear_selection
			item_imp ?= (child_array @ (an_index)).implementation
			item_imp.set_parent_imp (Void)
			feature {EV_GTK_EXTERNALS}.gtk_list_store_remove (list_store, item_imp.list_iter.item)
			-- remove the row from the `ev_children'
			child_array.go_i_th (an_index)
			child_array.remove
			--update_pnd_status
		end

end -- class EV_LIST_ITEM_LIST_IMP

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


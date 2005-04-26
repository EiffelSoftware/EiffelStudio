indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_IMP

inherit
	EV_HEADER_I
		redefine
			interface
		end
		
	EV_ITEM_LIST_IMP [EV_HEADER_ITEM]
		redefine
			interface,
			initialize
		end
	
	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			destroy,
			needs_event_box
		end
		
	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_HEADER_ACTION_SEQUENCES_IMP

create
	make

feature -- Initialization

	needs_event_box: BOOLEAN is True

	make (an_interface: like interface) is
			-- Create an empty Tree.
		local
			a_tree_view: POINTER
		do
			base_make (an_interface)
			a_tree_view := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_new
			set_c_object (a_tree_view)
		end

	initialize is
			-- Initialize `Current'
		local
			dummy_imp: EV_HEADER_ITEM_IMP
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_headers_visible (visual_widget, True)
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			
				-- Add our dummy column to the end to match Windows implementation
			create dummy_item
			dummy_imp ?= dummy_item.implementation
			 {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_clickable (dummy_imp.c_object, False)
			resize_model (100)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_insert_column (visual_widget, dummy_imp.c_object, 0)
			
			set_pixmaps_size (16, 16)
			is_initialized := True
		end

	dummy_item: EV_HEADER_ITEM

	resize_model  (a_columns: INTEGER) is
			-- Resize the data model to match the number of columns
		local
			a_type_array: MANAGED_POINTER
			i: INTEGER
			list_store: POINTER
		do		
			create a_type_array.make ((a_columns) * {EV_GTK_DEPENDENT_EXTERNALS}.sizeof_gtype)
			from
				i := 1
			until
				i > a_columns
			loop
				{EV_GTK_DEPENDENT_EXTERNALS}.add_g_type_string (a_type_array.item, (i - 1)  * {EV_GTK_DEPENDENT_EXTERNALS}.sizeof_gtype)
				i := i + 1
			end

			list_store :=  {EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_newv (a_columns, a_type_array.item)
			
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_model (visual_widget, list_store)
			model_count := a_columns
		end

feature
	
	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_HEADER_ITEM_IMP
		do
			if count + 2 > model_count then
				resize_model (count + 2)
					-- We are taking the dummy right column in to account
			end
			item_imp ?= v.implementation
			child_array.go_i_th (i)
			child_array.put_left (v)
			item_imp.set_parent_imp (Current)
			 {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_insert_column (visual_widget, item_imp.c_object, i - 1)
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item a`a_position'
		local
			item_imp: EV_HEADER_ITEM_IMP
		do
			child_array.go_i_th (a_position)
			item_imp ?=item.implementation
			item_imp.set_parent_imp (Void)
			{EV_GTK_DEPENDENT_EXTERNALS}.object_ref (item_imp.c_object)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_remove_column (visual_widget, item_imp.c_object)
			child_array.remove
		end

feature {NONE} -- Implementation

	model_count: INTEGER
		-- Number of cells available in model

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Implement me
		end

	destroy is
			-- 
		do
			Precursor {EV_PRIMITIVE_IMP}
		end

	interface: EV_HEADER

end

indexing
	description: "Eiffel Vision checkable list. Gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_CHECKABLE_LIST_IMP
	
inherit
	EV_CHECKABLE_LIST_I
		undefine
			wipe_out,
			selected_items,
			call_pebble_function,
			disable_default_key_processing
		redefine
			interface
		end
	
	EV_LIST_IMP
		redefine
			interface,
			initialize,
			initialize_model
		end

	EV_GTK_TREE_VIEW
		
	EV_CHECKABLE_LIST_ACTION_SEQUENCES_IMP
	
create
	make

feature -- Initialization

	initialize is
			-- Setup `Current'
		local
			a_column, a_cell_renderer: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
		do
			Precursor {EV_LIST_IMP}
			a_column := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, 0)
			
			a_cell_renderer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_toggle_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_pack_start (a_column, a_cell_renderer, False)				
			a_gtk_c_str :=  "active"
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, boolean_tree_model_column)
			
			real_signal_connect (a_cell_renderer, "toggled", agent (app_implementation.gtk_marshal).boolean_cell_renderer_toggle_intermediary (internal_id, ?, ?), Void)
		end

	boolean_tree_model_column: INTEGER is 2

	on_tree_path_toggle (a_tree_path_str: POINTER) is
			-- 
		local
			a_tree_path, a_int_ptr: POINTER
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
			a_success: BOOLEAN
			mp: MANAGED_POINTER
			a_list_item: EV_LIST_ITEM
			a_selected: BOOLEAN
			a_gvalue: POINTER
		do
			create a_tree_iter.make
			a_tree_path := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_new_from_string (a_tree_path_str)
			a_success := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_iter (list_store, a_tree_iter.item, a_tree_path)
			if a_success then
				a_int_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_indices (a_tree_path)
				create mp.share_from_pointer (a_int_ptr, App_implementation.integer_bytes)
				a_list_item := child_array @ (mp.read_integer_32 (0) + 1)
				a_gvalue := {EV_GTK_DEPENDENT_EXTERNALS}.c_g_value_struct_allocate
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_value (list_store, a_tree_iter.item, boolean_tree_model_column,  a_gvalue)
				a_selected := {EV_GTK_DEPENDENT_EXTERNALS}.g_value_get_boolean (a_gvalue)
					-- Toggle the currently selected value
				{EV_GTK_DEPENDENT_EXTERNALS}.g_value_set_boolean (a_gvalue, not a_selected)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_value (list_store, a_tree_iter.item, boolean_tree_model_column,  a_gvalue)
				
				if a_selected then
						-- We are toggling so `a_selected' is status before toggle
					if uncheck_actions_internal /= Void then
						uncheck_actions_internal.call ([a_list_item])
					end
				else
					if check_actions_internal /= Void then
						check_actions_internal.call ([a_list_item])
					end
				end
				
				a_gvalue.memory_free
			end
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_tree_path)
		end

	initialize_model is
			-- Create our data model for `Current'
		local
			a_type_array: MANAGED_POINTER 
		do
			create a_type_array.make (3 * {EV_GTK_DEPENDENT_EXTERNALS}.sizeof_gtype)
			{EV_GTK_DEPENDENT_EXTERNALS}.add_gdk_type_pixbuf (a_type_array.item, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.add_g_type_string (a_type_array.item, 1 * {EV_GTK_DEPENDENT_EXTERNALS}.sizeof_gtype)
			{EV_GTK_DEPENDENT_EXTERNALS}.add_g_type_boolean (a_type_array.item, 2 * {EV_GTK_DEPENDENT_EXTERNALS}.sizeof_gtype)
			list_store := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_newv (3, a_type_array.item)			end

feature -- Access

	is_item_checked (list_item: EV_LIST_ITEM): BOOLEAN is
			--
		local
			item_imp: EV_LIST_ITEM_IMP
			a_gvalue: POINTER
		do
			item_imp ?= list_item.implementation
			a_gvalue := {EV_GTK_DEPENDENT_EXTERNALS}.c_g_value_struct_allocate
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_value (list_store, item_imp.list_iter.item, boolean_tree_model_column,  a_gvalue)
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.g_value_get_boolean (a_gvalue)
			a_gvalue.memory_free
		end

feature -- Status setting

	check_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		local
			item_imp: EV_LIST_ITEM_IMP
			a_gvalue: POINTER
		do
			item_imp ?= list_item.implementation
			a_gvalue := {EV_GTK_DEPENDENT_EXTERNALS}.c_g_value_struct_allocate
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_value (list_store, item_imp.list_iter.item, boolean_tree_model_column,  a_gvalue)
			{EV_GTK_DEPENDENT_EXTERNALS}.g_value_set_boolean (a_gvalue, True)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_value (list_store, item_imp.list_iter.item, boolean_tree_model_column, a_gvalue)
			a_gvalue.memory_free
			if check_actions_internal /= Void then
				check_actions_internal.call ([list_item])
			end
		end

	uncheck_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		local
			item_imp: EV_LIST_ITEM_IMP
			a_gvalue: POINTER
		do
			item_imp ?= list_item.implementation
			a_gvalue := {EV_GTK_DEPENDENT_EXTERNALS}.c_g_value_struct_allocate
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_value (list_store, item_imp.list_iter.item, boolean_tree_model_column,  a_gvalue)
			{EV_GTK_DEPENDENT_EXTERNALS}.g_value_set_boolean (a_gvalue, False)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_value (list_store, item_imp.list_iter.item, boolean_tree_model_column, a_gvalue)
			a_gvalue.memory_free
			if uncheck_actions_internal /= Void then
				uncheck_actions_internal.call ([list_item])
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_LIST;
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_CHECKABLE_LIST_IMP


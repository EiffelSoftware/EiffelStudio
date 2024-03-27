note
	description:
		"[
			A tree which displays a check box to left
			hand side of each item contained. MsWindows implementation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_TREE_IMP

inherit
	EV_CHECKABLE_TREE_I
		undefine
			make,
			call_pebble_function,
			reset_pebble_function,
			wipe_out,
			append
		redefine
			interface
		end

	EV_TREE_IMP
		redefine
			interface,
			make,
			initialize_model
		end

	EV_GTK_TREE_VIEW

create
	make

feature {NONE} -- Initialization

	make
			-- Setup `Current'
		local
			a_column, a_cell_renderer: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
		do
			Precursor {EV_TREE_IMP}
			a_column := {GTK2}.gtk_tree_view_get_column (tree_view, 0)

			a_cell_renderer := {GTK2}.gtk_cell_renderer_toggle_new
			{GTK2}.gtk_tree_view_column_pack_start (a_column, a_cell_renderer, False)
			a_gtk_c_str :=  "active"
			{GTK2}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, boolean_tree_model_column)

			real_signal_connect (a_cell_renderer, "toggled", agent (app_implementation.gtk_marshal).boolean_cell_renderer_toggle_intermediary (internal_id, ?, ?))
		end

	boolean_tree_model_column: INTEGER = 2

	on_tree_path_toggle (a_tree_path_str: POINTER)
			--
		local
			a_tree_path, a_int_ptr: POINTER
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
			a_success: BOOLEAN
			mp: MANAGED_POINTER
			a_tree_item: EV_TREE_NODE
			a_selected: BOOLEAN
			a_gvalue: POINTER
		do
			create a_tree_iter.make
			a_tree_path := {GTK2}.gtk_tree_path_new_from_string (a_tree_path_str)
			a_success := {GTK2}.gtk_tree_model_get_iter (tree_store, a_tree_iter.item, a_tree_path)
			if a_success then
				a_int_ptr := {GTK2}.gtk_tree_path_get_indices (a_tree_path)
				create mp.share_from_pointer (a_int_ptr, {PLATFORM}.integer_32_bytes)
				a_tree_item := child_array @ (mp.read_integer_32 (0) + 1)
				a_gvalue := {GTK2}.c_g_value_struct_allocate
				{GTK2}.gtk_tree_model_get_value (tree_store, a_tree_iter.item, boolean_tree_model_column,  a_gvalue)
				a_selected := {GTK2}.g_value_get_boolean (a_gvalue)
					-- Toggle the currently selected value
				{GTK2}.g_value_set_boolean (a_gvalue, not a_selected)
				{GTK2}.gtk_tree_store_set_value (tree_store, a_tree_iter.item, boolean_tree_model_column,  a_gvalue)

				if a_selected then
						-- We are toggling so `a_selected' is status before toggle
					if uncheck_actions_internal /= Void then
						uncheck_actions_internal.call ([a_tree_item])
					end
				else
					if check_actions_internal /= Void then
						check_actions_internal.call ([a_tree_item])
					end
				end

				a_gvalue.memory_free
			end
			{GTK2}.gtk_tree_path_free (a_tree_path)
		end

	initialize_model
			-- Create our data model for `Current'
		local
			a_type_array: MANAGED_POINTER
		do
			create a_type_array.make (3 * {GOBJECT}.sizeof_gtype)
			{GDK}.add_gdk_type_pixbuf (a_type_array.item, 0)
			{GOBJECT}.add_g_type_string (a_type_array.item, 1 * {GOBJECT}.sizeof_gtype)
			{GOBJECT}.add_g_type_boolean (a_type_array.item, 2 * {GOBJECT}.sizeof_gtype)
			tree_store := {GTK2}.gtk_tree_store_newv (3, a_type_array.item)
		end

feature -- Access

	is_item_checked (list_item: EV_TREE_NODE): BOOLEAN
			--
		local
			item_imp: detachable EV_TREE_NODE_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
			a_gvalue: POINTER
		do
			item_imp ?= list_item.implementation
			check item_imp /= Void then end
			l_list_iter := item_imp.list_iter
			check l_list_iter /= Void then end
			a_gvalue := {GTK2}.c_g_value_struct_allocate
			{GTK2}.gtk_tree_model_get_value (tree_store, l_list_iter.item, boolean_tree_model_column,  a_gvalue)
			Result := {GTK2}.g_value_get_boolean (a_gvalue)
			a_gvalue.memory_free
		end

feature -- Status setting

	check_item (tree_item: EV_TREE_NODE)
			-- Ensure check associated with `tree_item' is
			-- checked.
		local
			item_imp: detachable EV_TREE_NODE_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
			a_gvalue: POINTER
		do
			item_imp ?= tree_item.implementation
			check item_imp /= Void then end
			l_list_iter := item_imp.list_iter
			check l_list_iter /= Void then end
			a_gvalue := {GTK2}.c_g_value_struct_allocate
			{GTK2}.gtk_tree_model_get_value (tree_store, l_list_iter.item, boolean_tree_model_column,  a_gvalue)
			{GTK2}.g_value_set_boolean (a_gvalue, True)
			{GTK2}.gtk_tree_store_set_value (tree_store, l_list_iter.item, boolean_tree_model_column, a_gvalue)
			a_gvalue.memory_free
			if check_actions_internal /= Void then
				check_actions_internal.call ([tree_item])
			end
		end

	uncheck_item (tree_item: EV_TREE_NODE)
			-- Ensure check associated with `tree_item' is
			-- unchecked.
		local
			item_imp: detachable EV_TREE_NODE_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
			a_gvalue: POINTER
		do
			item_imp ?= tree_item.implementation
			check item_imp /= Void then end
			l_list_iter := item_imp.list_iter
			check l_list_iter /= Void then end
			a_gvalue := {GTK2}.c_g_value_struct_allocate
			{GTK2}.gtk_tree_model_get_value (tree_store, l_list_iter.item, boolean_tree_model_column,  a_gvalue)
			{GTK2}.g_value_set_boolean (a_gvalue, False)
			{GTK2}.gtk_tree_store_set_value (tree_store, l_list_iter.item, boolean_tree_model_column, a_gvalue)
			a_gvalue.memory_free
			if uncheck_actions_internal /= Void then
				uncheck_actions_internal.call ([tree_item])
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CHECKABLE_TREE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_CHECKABLE_TREE_IMP

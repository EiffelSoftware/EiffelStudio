note
	description: "EiffelVision list, gtk implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_IMP

inherit
	EV_LIST_I
		undefine
			wipe_out,
			selected_items,
			call_pebble_function,
			reset_pebble_function
		redefine
			interface,
			disable_default_key_processing
		end

	EV_LIST_ITEM_LIST_IMP
		redefine
			interface,
			visual_widget,
			make,
			item_from_coords,
			on_mouse_button_event,
			row_height,
			call_selection_action_sequences,
			needs_event_box
		end

create
	make

feature -- Initialize

	old_make (an_interface: attached like interface)
			-- Create a list widget with `par' as parent.
			-- By default, a list allow only one selection.
		do
			assign_interface (an_interface)
		end

	scrollable_area: POINTER
		-- Scrollable area used for `Current'

	make
			-- Initialize the list.
		local
			a_column, a_cell_renderer: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
			a_selection: POINTER
		do
			scrollable_area := {GTK}.gtk_scrolled_window_new (default_pointer, default_pointer)
			{GTK2}.gtk_scrolled_window_set_shadow_type (scrollable_area, {GTK}.gtk_shadow_in_enum)
			set_c_object (scrollable_area)

			tree_view := {GTK2}.gtk_tree_view_new
			{GTK}.gtk_container_add (scrollable_area, tree_view)
			Precursor {EV_LIST_ITEM_LIST_IMP}
			{GTK2}.gtk_tree_view_set_model (tree_view, list_store)
			{GTK}.gtk_scrolled_window_set_policy (
				scrollable_area,
				{GTK}.GTK_POLICY_AUTOMATIC_ENUM,
				{GTK}.GTK_POLICY_AUTOMATIC_ENUM
			)

			{GTK}.gtk_widget_show (tree_view)

			{GTK2}.gtk_tree_view_set_headers_visible (tree_view, False)

			a_column := {GTK2}.gtk_tree_view_column_new
			{GTK2}.gtk_tree_view_column_set_resizable (a_column, True)

			a_cell_renderer := {GTK2}.gtk_cell_renderer_text_new
			{GTK2}.gtk_tree_view_column_pack_end (a_column, a_cell_renderer, True)
			a_gtk_c_str := "text"
			{GTK2}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 1)


			a_cell_renderer := {GTK2}.gtk_cell_renderer_pixbuf_new
			{GTK2}.gtk_tree_view_column_pack_end (a_column, a_cell_renderer, False)
			a_gtk_c_str := "pixbuf"
			{GTK2}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 0)


			{GTK2}.gtk_tree_view_insert_column (tree_view, a_column, 1)

			previous_selection := selected_items

			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			real_signal_connect (a_selection,
						{EV_GTK_EVENT_STRINGS}.changed_event_name,
						agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id))
			initialize_pixmaps
		end

	needs_event_box: BOOLEAN = True
		-- Give event box to Current.

feature -- Access

	selected_item: detachable EV_LIST_ITEM
			-- Item which is currently selected, for a multiple
			-- selection.
		local
			a_selection: POINTER
			a_tree_path_list: POINTER
			a_model: POINTER
			a_tree_path: POINTER
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			a_tree_path_list := {GTK2}.gtk_tree_selection_get_selected_rows (a_selection, $a_model)

			if a_tree_path_list /= default_pointer then
					a_tree_path := {GLIB}.glist_struct_data (a_tree_path_list)
					a_int_ptr := {GTK2}.gtk_tree_path_get_indices (a_tree_path)
					create mp.share_from_pointer (a_int_ptr, {PLATFORM}.integer_32_bytes)
					Result := (child_array [mp.read_integer_32 (0) + 1])
					{GTK2}.gtk_tree_path_list_free_contents (a_tree_path_list)
					{GLIB}.g_list_free (a_tree_path_list)
			end
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than
			-- `selected_items' for a single selection list.
		local
			a_selection: POINTER
			a_tree_path_list: POINTER
			a_model: POINTER
			a_tree_path: POINTER
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
		do
			create Result.make (0)
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			a_tree_path_list := {GTK2}.gtk_tree_selection_get_selected_rows (a_selection, $a_model)
			if a_tree_path_list /= default_pointer then
				from
				until
					a_tree_path_list = default_pointer
				loop
					a_tree_path := {GLIB}.glist_struct_data (a_tree_path_list)
					a_int_ptr := {GTK2}.gtk_tree_path_get_indices (a_tree_path)
					create mp.share_from_pointer (a_int_ptr, {PLATFORM}.integer_32_bytes)
					Result.extend ((child_array [mp.read_integer_32 (0) + 1]))
					a_tree_path_list := {GLIB}.glist_struct_next (a_tree_path_list)
				end
				{GTK2}.gtk_tree_path_list_free_contents (a_tree_path_list)
				{GLIB}.g_list_free (a_tree_path_list)
			end
		end

feature -- Status Report

	multiple_selection_enabled: BOOLEAN
			-- True if the user can choose several items
			-- False otherwise.
		local
			a_selection: POINTER
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			Result := {GTK2}.gtk_tree_selection_get_mode (a_selection) = {GTK}.gtk_selection_multiple_enum
		end

feature -- Status setting

	ensure_item_visible (an_item: EV_LIST_ITEM)
			-- Ensure item `an_index' is visible in `Current'.
		local
			list_item_imp: detachable EV_LIST_ITEM_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
			a_path: POINTER
		do
			list_item_imp ?= an_item.implementation
			check list_item_imp /= Void then end
			l_list_iter := list_item_imp.list_iter
			check l_list_iter /= Void then end
			a_path := {GTK2}.gtk_tree_model_get_path (list_store, l_list_iter.item)
			{GTK2}.gtk_tree_view_scroll_to_cell (tree_view, a_path, default_pointer, False, 0, 0)
			{GTK2}.gtk_tree_path_free (a_path)
		end

	enable_multiple_selection
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		local
			a_selection: POINTER
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			{GTK2}.gtk_tree_selection_set_mode (a_selection, {GTK}.gtk_selection_multiple_enum)
		end

	disable_multiple_selection
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
		local
			a_selection: POINTER
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			{GTK2}.gtk_tree_selection_set_mode (a_selection, {GTK}.gtk_selection_single_enum)
		end

	select_item (an_index: INTEGER)
			-- Select an item at the one-based `index' of the list.
		local
			a_selection: POINTER
			a_item_imp: detachable EV_LIST_ITEM_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			a_item_imp ?= (child_array @ an_index).implementation
			check a_item_imp /= Void then end
			l_list_iter := a_item_imp.list_iter
			check l_list_iter /= Void then end
			{GTK2}.gtk_tree_selection_select_iter (a_selection, l_list_iter.item)
		end

	deselect_item (an_index: INTEGER)
			-- Unselect the item at the one-based `index'.
		local
			a_selection: POINTER
			a_item_imp: detachable EV_LIST_ITEM_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			a_item_imp ?= (child_array @ an_index).implementation
			check a_item_imp /= Void then end
			l_list_iter := a_item_imp.list_iter
			check l_list_iter /= Void then end
			{GTK2}.gtk_tree_selection_unselect_iter (a_selection, l_list_iter.item)
		end

	clear_selection
			-- Clear the selection of the list.
		local
			a_selection: POINTER
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			{GTK2}.gtk_tree_selection_unselect_all (a_selection)
		end

feature -- PND

	row_index_from_coords (a_x, a_y: INTEGER): INTEGER
			-- Returns the row index at relative coordinate `a_y'.
		local
			a_tree_path, a_tree_column: POINTER
			a_success: BOOLEAN
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
		do
			a_success := {GTK2}.gtk_tree_view_get_path_at_pos (tree_view, 1, a_y, $a_tree_path, $a_tree_column, default_pointer, default_pointer)
			if a_success then
				a_int_ptr := {GTK2}.gtk_tree_path_get_indices (a_tree_path)
				create mp.share_from_pointer (a_int_ptr, {PLATFORM}.integer_32_bytes)
				Result := mp.read_integer_32 (0) + 1
				{GTK2}.gtk_tree_path_free (a_tree_path)
			end
		end

	item_from_coords (a_x, a_y: INTEGER): detachable EV_PND_DEFERRED_ITEM
			-- Returns the row at relative coordinate `a_y'
		local
			a_row_index: INTEGER
		do
			a_row_index := row_index_from_coords (a_x, a_y)
			if a_row_index > 0 then
				Result ?= i_th (a_row_index).implementation
			end
		end

	on_mouse_button_event (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Initialize a pick and drop transport.
		local
			a_row_index: INTEGER
		do
			a_row_index := row_index_from_coords (a_x, a_y)
			if a_row_index > 0 then
				pnd_row_imp ?= i_th (a_row_index).implementation
				if attached pnd_row_imp as l_pnd_row_imp and then not (l_pnd_row_imp.able_to_transport (a_button) or l_pnd_row_imp.mode_is_configurable_target_menu) then
					pnd_row_imp := Void
				end
			else
				pnd_row_imp := Void
			end
			Precursor {EV_LIST_ITEM_LIST_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	row_height: INTEGER
			-- Height of rows in `Current'
			-- (export status {NONE})
		local
			a_column_ptr, a_cell_rend_list, a_cell_rend: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
			a_vert_sep: INTEGER
		do
			a_column_ptr := {GTK2}.gtk_tree_view_get_column (tree_view, 0)
			a_cell_rend_list := {GTK}.gtk_cell_layout_get_cells (a_column_ptr)
			a_cell_rend := {GLIB}.g_list_nth_data (a_cell_rend_list, 0)
			{GTK2}.gtk_cell_renderer_get_fixed_size (a_cell_rend, default_pointer, $Result)
			a_gtk_c_str := once "vertical-separator"
			{GTK2}.gtk_widget_style_get_integer (tree_view, a_gtk_c_str.item, $a_vert_sep)
			Result := Result + a_vert_sep
		end

feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER
		do
			Result := tree_view
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST note option: stable attribute end;

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	previous_selection: ARRAYED_LIST [EV_LIST_ITEM]
		-- List of selected items from last selection change

	call_selection_action_sequences
			-- Call appropriate selection and deselection action sequences
		local
			new_selection: ARRAYED_LIST [EV_LIST_ITEM]
			newly_selected_items: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			an_item: detachable EV_LIST_ITEM_IMP
		do
			new_selection := selected_items
			create newly_selected_items.make (0)
			from
				new_selection.start
			until
				new_selection.off
			loop
				if not previous_selection.has (new_selection.item) then
					an_item ?= new_selection.item.implementation
					check an_item /= Void end
					if an_item /= Void then
						newly_selected_items.extend (an_item)
					end
				end
				previous_selection.prune_all (new_selection.item)
				new_selection.forth
			end
			from
				previous_selection.start
			until
				previous_selection.off
			loop
				an_item ?= previous_selection.item.implementation
				check an_item /= Void end
				if an_item /= Void then
					if an_item.deselect_actions_internal /= Void then
						an_item.deselect_actions.call (Void)
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call ([an_item.attached_interface])
					end
				end
				previous_selection.forth
			end
			from
				newly_selected_items.start
			until
				newly_selected_items.off
			loop
				if newly_selected_items.item.select_actions_internal /= Void then
					newly_selected_items.item.select_actions.call (Void)
				end
				if select_actions_internal /= Void then
					select_actions_internal.call ([newly_selected_items.item.attached_interface])
				end
				newly_selected_items.forth
			end
			previous_selection := new_selection
		end

feature {NONE} -- Implementation

	disable_default_key_processing
			-- Ensure default key processing is not performed.
		do
			Precursor {EV_LIST_I}
			{GTK2}.gtk_tree_view_set_enable_search (tree_view, False)
		end

	tree_view: POINTER
		-- Pointer to the view widget used to display the model within `Current'

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end

	vertical_adjustment_struct: POINTER
			-- Pointer to vertical adjustment struct use in the scrollbar.
		do
			Result := {GTK}.gtk_scrolled_window_get_vadjustment (scrollable_area)
		end

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

end -- class EV_LIST_IMP

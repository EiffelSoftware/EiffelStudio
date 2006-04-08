indexing
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
			call_pebble_function
		redefine
			interface,
			disable_default_key_processing
		end

	EV_LIST_ITEM_LIST_IMP
		redefine
			interface,
			visual_widget,
			initialize,
			row_from_y_coord,
			on_mouse_button_event,
			row_height
		end

create
	make

feature -- Initialize

	make (an_interface: like interface) is
			-- Create a list widget with `par' as parent.
			-- By default, a list allow only one selection.
		do
			base_make (an_interface)
			scrollable_area := {EV_GTK_EXTERNALS}.gtk_scrolled_window_new (NULL, NULL)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_scrolled_window_set_shadow_type (scrollable_area, {EV_GTK_EXTERNALS}.gtk_shadow_in_enum)
			set_c_object (scrollable_area)

			tree_view := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_new
			{EV_GTK_EXTERNALS}.gtk_container_add (scrollable_area, tree_view)
		end

	scrollable_area: POINTER
		-- Scrollable area used for `Current'

	initialize is
			-- Initialize the list.
		local
			a_column, a_cell_renderer: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
			a_selection: POINTER
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_model (tree_view, list_store)
			{EV_GTK_EXTERNALS}.gtk_scrolled_window_set_policy (
				scrollable_area,
				{EV_GTK_EXTERNALS}.GTK_POLICY_AUTOMATIC_ENUM,
				{EV_GTK_EXTERNALS}.GTK_POLICY_AUTOMATIC_ENUM
			)

			{EV_GTK_EXTERNALS}.gtk_widget_show (tree_view)

			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_headers_visible (tree_view, False)

			a_column := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_resizable (a_column, True)

			a_cell_renderer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_text_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_pack_end (a_column, a_cell_renderer, True)
			a_gtk_c_str := "text"
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 1)


			a_cell_renderer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_pixbuf_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_pack_end (a_column, a_cell_renderer, False)
			a_gtk_c_str := "pixbuf"
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 0)


			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_insert_column (tree_view, a_column, 1)

			previous_selection := selected_items

			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			real_signal_connect (a_selection, "changed", agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id), Void)
			initialize_pixmaps
		end

feature -- Access

	selected_item: EV_LIST_ITEM is
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
			a_selection := {EV_GTK_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			a_tree_path_list := {EV_GTK_EXTERNALS}.gtk_tree_selection_get_selected_rows (a_selection, $a_model)

			if a_tree_path_list /= NULL then
					a_tree_path := {EV_GTK_EXTERNALS}.glist_struct_data (a_tree_path_list)
					a_int_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_indices (a_tree_path)
					create mp.share_from_pointer (a_int_ptr, App_implementation.integer_bytes)
					Result := (child_array @ (mp.read_integer_32 (0) + 1))
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_list_free_contents (a_tree_path_list)
					{EV_GTK_EXTERNALS}.g_list_free (a_tree_path_list)
			end
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
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
			a_selection := {EV_GTK_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			a_tree_path_list := {EV_GTK_EXTERNALS}.gtk_tree_selection_get_selected_rows (a_selection, $a_model)
			if a_tree_path_list /= NULL then
				from
				until
					a_tree_path_list = NULL
				loop
					a_tree_path := {EV_GTK_EXTERNALS}.glist_struct_data (a_tree_path_list)
					a_int_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_indices (a_tree_path)
					create mp.share_from_pointer (a_int_ptr, App_implementation.integer_bytes)
					Result.extend ((child_array @ (mp.read_integer_32 (0) + 1)))
					a_tree_path_list := {EV_GTK_EXTERNALS}.glist_struct_next (a_tree_path_list)
				end
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_list_free_contents (a_tree_path_list)
				{EV_GTK_EXTERNALS}.g_list_free (a_tree_path_list)
			end
		end

feature -- Status Report

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise.
		local
			a_selection: POINTER
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_get_mode (a_selection) = {EV_GTK_EXTERNALS}.gtk_selection_multiple_enum
		end

feature -- Status setting

	ensure_item_visible (an_item: EV_LIST_ITEM) is
			-- Ensure item `an_index' is visible in `Current'.
		local
			list_item_imp: EV_LIST_ITEM_IMP
			a_path: POINTER
		do
			list_item_imp ?= an_item.implementation
			a_path := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_path (list_store, list_item_imp.list_iter.item)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_scroll_to_cell (tree_view, a_path, NULL, False, 0, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_path)
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		local
			a_selection: POINTER
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_set_mode (a_selection, {EV_GTK_EXTERNALS}.gtk_selection_multiple_enum)
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
		local
			a_selection: POINTER
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_set_mode (a_selection, {EV_GTK_EXTERNALS}.gtk_selection_single_enum)
		end

	select_item (an_index: INTEGER) is
			-- Select an item at the one-based `index' of the list.
		local
			a_selection: POINTER
			a_item_imp: EV_LIST_ITEM_IMP
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			a_item_imp ?= (child_array @ an_index).implementation
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_select_iter (a_selection, a_item_imp.list_iter.item)
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		local
			a_selection: POINTER
			a_item_imp: EV_LIST_ITEM_IMP
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			a_item_imp ?= (child_array @ an_index).implementation
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_unselect_iter (a_selection, a_item_imp.list_iter.item)
		end

	clear_selection is
			-- Clear the selection of the list.
		local
			a_selection: POINTER
		do
			a_selection := {EV_GTK_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			{EV_GTK_EXTERNALS}.gtk_tree_selection_unselect_all (a_selection)
		end

feature -- PND

	row_index_from_y_coord (a_y: INTEGER): INTEGER is
			-- Returns the row index at relative coordinate `a_y'.
		local
			a_tree_path, a_tree_column: POINTER
			a_success: BOOLEAN
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
		do
			a_success := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_path_at_pos (tree_view, 1, a_y, $a_tree_path, $a_tree_column, NULL, NULL)
			if a_success then
				a_int_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_indices (a_tree_path)
				create mp.share_from_pointer (a_int_ptr, App_implementation.integer_bytes)
				Result := mp.read_integer_32 (0) + 1
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_tree_path)
			end
		end

	row_from_y_coord (a_y: INTEGER): EV_PND_DEFERRED_ITEM is
			-- Returns the row at relative coordinate `a_y'
		local
			a_row_index: INTEGER
		do
			a_row_index := row_index_from_y_coord (a_y)
			if a_row_index > 0 then
				Result ?= i_th (a_row_index).implementation
			end
		end

	on_mouse_button_event (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Initialize a pick and drop transport.
		local
			a_row_index: INTEGER
		do
			a_row_index := row_index_from_y_coord (a_y)
			if a_row_index > 0 then
				pnd_row_imp ?= i_th (a_row_index).implementation
				if not pnd_row_imp.able_to_transport (a_button) then
					pnd_row_imp := Void
				end
			end
			if a_type = {EV_GTK_EXTERNALS}.gdk_2button_press_enum then
				print ("List 2 double press%N")
			end
			Precursor {EV_LIST_ITEM_LIST_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	row_height: INTEGER is
			-- Height of rows in `Current'
			-- (export status {NONE})
		local
			a_column_ptr, a_cell_rend_list, a_cell_rend: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
			a_vert_sep: INTEGER
		do
			a_column_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, 0)
			a_cell_rend_list := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_get_cell_renderers (a_column_ptr)
			a_cell_rend := {EV_GTK_EXTERNALS}.g_list_nth_data (a_cell_rend_list, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_get_fixed_size (a_cell_rend, null, $Result)
			a_gtk_c_str := once "vertical-separator"
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_style_get_integer (tree_view, a_gtk_c_str.item, $a_vert_sep)
			Result := Result + a_vert_sep
		end

feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER is
		do
			Result := tree_view
		end

	interface: EV_LIST

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	previous_selection: ARRAYED_LIST [EV_LIST_ITEM]
		-- List of selected items from last selection change

	call_selection_action_sequences is
			-- Call appropriate selection and deselection action sequences
		local
			new_selection: ARRAYED_LIST [EV_LIST_ITEM]
			newly_selected_items: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			an_item: EV_LIST_ITEM_IMP
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
					newly_selected_items.extend (an_item)
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
				if an_item.deselect_actions_internal /= Void then
					an_item.deselect_actions_internal.call (Void)
				end
				if deselect_actions_internal /= Void then
					deselect_actions_internal.call ([an_item.interface])
				end
				previous_selection.forth
			end
			from
				newly_selected_items.start
			until
				newly_selected_items.off
			loop
				if newly_selected_items.item.select_actions_internal /= Void then
					newly_selected_items.item.select_actions_internal.call (Void)
				end
				if select_actions_internal /= Void then
					select_actions_internal.call ([newly_selected_items.item.interface])
				end
				newly_selected_items.forth
			end
			previous_selection := new_selection
		end

feature {NONE} -- Implementation

	disable_default_key_processing is
			-- Ensure default key processing is not performed.
		do
			Precursor {EV_LIST_I}
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_enable_search (tree_view, False)
		end

	tree_view: POINTER
		-- Pointer to the view widget used to display the model within `Current'

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end

	vertical_adjustment_struct: POINTER is
			-- Pointer to vertical adjustment struct use in the scrollbar.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_range_struct_adjustment ({EV_GTK_EXTERNALS}.gtk_scrolled_window_struct_vscrollbar (scrollable_area))
		end

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




end -- class EV_LIST_IMP


indexing
	description:
		"EiffelVision multi-column-list, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_IMP

inherit
	EV_MULTI_COLUMN_LIST_I
		export
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES}
				column_widths, update_column_width
		redefine
			interface,
			initialize,
			call_pebble_function,
			wipe_out,
			pixmaps_size_changed,
			remove_row_pixmap
		end

	EV_PRIMITIVE_IMP
		redefine
			enable_transport,
			disable_transport,
			pre_pick_steps,
			call_pebble_function,
			post_drop_steps,
			start_transport_filter,
			initialize,
			interface,
			destroy,
			able_to_transport,
			ready_for_pnd_menu,
			set_to_drag_and_drop,
			button_press_switch,
			create_pointer_motion_actions,
			visual_widget,
			on_button_release
		end

	EV_ITEM_LIST_IMP [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			i_th,
			count,
			insert_i_th,
			remove_i_th,
			destroy,
			interface,
			wipe_out,
			initialize
		end

	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_IMP
		export
				{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES}
					all
		end

	EV_PND_DEFERRED_ITEM_PARENT

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		do
			base_make (an_interface)
			scrollable_area := {EV_GTK_EXTERNALS}.gtk_scrolled_window_new (NULL, NULL)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_scrolled_window_set_shadow_type (scrollable_area, {EV_GTK_EXTERNALS}.gtk_shadow_in_enum)
			set_c_object (scrollable_area)
			{EV_GTK_EXTERNALS}.gtk_scrolled_window_set_policy (
				scrollable_area,
				{EV_GTK_EXTERNALS}.GTK_POLICY_AUTOMATIC_ENUM,
				{EV_GTK_EXTERNALS}.GTK_POLICY_AUTOMATIC_ENUM
			)
			create ev_children.make (0)
			tree_view := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_new
			{EV_GTK_EXTERNALS}.gtk_container_add (scrollable_area, tree_view)
			{EV_GTK_EXTERNALS}.gtk_widget_show (tree_view)
		end

	initialize is
			-- Initialize `Current'
		local
			l_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_MULTI_COLUMN_LIST_I}
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_enable_search (tree_view, False)
			resize_model_if_needed (25)
				-- Create our model with 25 columns to avoid recomputation each time the column count increases
			create_list (2)

			previous_selection := selected_items
			initialize_pixmaps
			disable_multiple_selection

				-- Needed so that we can query if the mouse button is down for column resize actions
			l_release_actions := pointer_button_release_actions
			connect_selection_actions
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	connect_selection_actions is
			-- Connect the selection signal
		local
			a_selection: POINTER
		do
			if selection_signal_id = 0 then
				a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
				real_signal_connect (a_selection, "changed", agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id), Void)
				selection_signal_id := last_signal_connection_id
			end
		end

	disconnect_selection_actions is
			-- Disconnect the selection signal
		local
			a_selection: POINTER
		do
			if selection_signal_id /= 0 then
				a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
				{EV_GTK_EXTERNALS}.signal_disconnect (a_selection, selection_signal_id)
				selection_signal_id := 0
			end
		end

	selection_signal_id: INTEGER
		-- Signal id used for the selection changed event

feature {NONE} -- Implementation

	call_selection_action_sequences is
			-- Call appropriate selection and deselection action sequences
		local
			new_selection: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			newly_selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			an_item: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			disconnect_selection_actions
			if not mouse_button_pressed then
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
					call_deselect_actions (an_item)
					previous_selection.forth
				end

				from
					newly_selected_items.start
				until
					newly_selected_items.off
				loop
					call_selection_actions (newly_selected_items.item)
					newly_selected_items.forth
				end
				previous_selection := new_selection
			end
			connect_selection_actions
		end

	previous_selection: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		-- Previous selection of `Current'

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Event handling

	button_press_switch (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
			a_row_number: INTEGER
			clicked_row: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			mouse_button_pressed := True
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
			a_row_number := row_index_from_y_coord (a_y)
			if a_row_number > 0 and then a_row_number <= count then
				clicked_row := ev_children @ a_row_number
			else
				clear_selection
					-- This follows the Windows behavior of clearing selection if list is clicked on
			end
			if a_type = {EV_GTK_EXTERNALS}.gDK_BUTTON_PRESS_ENUM then
				if pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
				if
					clicked_row /= Void and then
					clicked_row.pointer_button_press_actions_internal /= Void
				then
					clicked_row.pointer_button_press_actions_internal.call (t)
				end
			elseif a_type = {EV_GTK_EXTERNALS}.gDK_2BUTTON_PRESS_ENUM then
				if pointer_double_press_actions_internal /= Void then
					pointer_double_press_actions_internal.call (t)
				end
				if
					clicked_row /= Void and then
					clicked_row.pointer_double_press_actions_internal /= Void
				then
					clicked_row.pointer_double_press_actions_internal.call (t)
				end
			end
		end

	on_button_release (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Used for pointer button release events
		do
			Precursor {EV_PRIMITIVE_IMP} (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			mouse_button_pressed := False
			call_selection_action_sequences
		end

	mouse_button_pressed: BOOLEAN
		-- Is the mouse button pressed

feature {NONE} -- Implementation

	call_selection_actions (clicked_row: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Call the selections actions for `clicked_row'
		do
			if not previous_selection.has (clicked_row.interface) then
					if clicked_row.select_actions_internal /= Void then
						clicked_row.select_actions_internal.call (void)
					end
					if select_actions_internal /= Void then
						select_actions_internal.call ([clicked_row.interface])
					end
			end
		end

	call_deselect_actions (deselected_row: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Call deselect actions for `deselected_row'
		do
				if deselected_row.deselect_actions_internal /= Void then
					deselected_row.deselect_actions_internal.call (Void)
				end
				if deselect_actions_internal /= Void then
					deselect_actions_internal.call ([deselected_row.interface])
				end
		end

	resize_model_if_needed (a_columns: INTEGER) is
			--
		local
			a_type_array: MANAGED_POINTER
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
			i: INTEGER
		do
			if a_columns > model_column_count - 1 then
				create a_type_array.make ((a_columns + 1) * {EV_GTK_DEPENDENT_EXTERNALS}.sizeof_gtype)
				from
					{EV_GTK_DEPENDENT_EXTERNALS}.add_gdk_type_pixbuf (a_type_array.item, 0)
					i := 1
				until
					i > a_columns
				loop
					{EV_GTK_DEPENDENT_EXTERNALS}.add_g_type_string (a_type_array.item, i * {EV_GTK_DEPENDENT_EXTERNALS}.sizeof_gtype)
					i := i + 1
				end

				list_store := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_newv (a_columns + 1, a_type_array.item)

				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_model (tree_view, list_store)

				from
					ev_children.start
				until
					ev_children.after
				loop
					create a_tree_iter.make
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_insert (list_store, a_tree_iter.item, ev_children.index - 1)
					ev_children.item.set_list_iter (a_tree_iter)
					update_child (ev_children.item, ev_children.index)
					ev_children.forth
				end
			end
		end


	create_list (a_columns: INTEGER) is
			-- Create the clist with `a_columns' columns.
		require
			a_columns_positive: a_columns > 0
		local
			i: INTEGER
			temp_title: STRING
			temp_width: INTEGER
			temp_alignment, default_alignment: EV_TEXT_ALIGNMENT
			temp_alignment_code: INTEGER
			a_gtk_c_str: EV_GTK_C_STRING
			a_cell_renderer: POINTER
			a_column: POINTER
			old_column_count: INTEGER
		do
			old_column_count := column_count
			resize_model_if_needed (a_columns)
			create default_alignment
			from
				i := old_column_count + 1
			until
				i > a_columns
			loop

				a_column := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_new
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_resizable (a_column, True)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_clickable (a_column, True)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_sizing (a_column, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_fixed_enum)

				if i = 1 then
					a_cell_renderer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_pixbuf_new
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_pack_start (a_column, a_cell_renderer, False)
					a_gtk_c_str := once "pixbuf"
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 0)
				end

				a_cell_renderer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_text_new
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_pack_start (a_column, a_cell_renderer, True)
				a_gtk_c_str := once "text"
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, i)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_insert_column (tree_view, a_column, i - 1)


				if column_titles /= Void and then
					column_titles.valid_index (i) and then
						column_titles.i_th (i) /= Void then
					temp_title := column_titles.i_th (i)
				else
					temp_title := once ""
				end

				if column_widths /= Void and then
								column_widths.valid_index (i) then
					temp_width := column_widths.i_th (i)
				else
					temp_width := Default_column_width
				end
				if column_alignments /= Void and then
							column_alignments.valid_index (i) then
						-- Create alignment from alignment code.
					temp_alignment_code := column_alignments.i_th (i)
					create temp_alignment
					if temp_alignment_code = temp_alignment.left_alignment then
						temp_alignment.set_left_alignment
					elseif temp_alignment_code = temp_alignment.center_alignment then
						temp_alignment.set_center_alignment
					else
						temp_alignment.set_right_alignment
					end
				else
					temp_alignment := default_alignment
				end

				column_width_changed (temp_width, i)
				column_title_changed (temp_title, i)

				if i > 1 then
					-- 1st column is always left aligned.
					column_alignment_changed (temp_alignment, i)
				end

				real_signal_connect (a_column, "notify::width", agent (app_implementation.gtk_marshal).mcl_column_resize_callback (object_id, i), Void)
				real_signal_connect (a_column, "clicked", agent (app_implementation.gtk_marshal).mcl_column_click_callback (object_id, i), Void)
				i := i + 1
			end
		end

	list_store: POINTER
		-- Pointer to the Model

	motion_handler (a_x, a_y: INTEGER; a_a, a_b, a_c: DOUBLE; a_d, a_e: INTEGER) is
		local
			t: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
			a_row_number: INTEGER
			a_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			t := [a_x, a_y, a_a, a_b, a_c, a_d, a_e]
			if pointer_motion_actions_internal /= Void then
				pointer_motion_actions_internal.call (t)
			end
			if a_y > 0 and a_x <= width then
				a_row_number := row_index_from_y_coord (a_y)
				if a_row_number > 0 and then a_row_number <= count then
					a_row_imp := ev_children @ a_row_number
					if a_row_imp.pointer_motion_actions_internal /= Void then
						a_row_imp.pointer_motion_actions_internal.call (t)
					end
				end
			end
		end

	pixmaps_size_changed is
			--
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
--			if pixmaps_height > {EV_GTK_EXTERNALS}.gtk_clist_struct_row_height (list_widget) then
--				set_row_height (pixmaps_height)
--			end
		end

feature -- Access

	column_count: INTEGER is
			-- Number of columns in the list.
		local
			col_list: POINTER
		do
			col_list := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_columns (tree_view)
			if col_list /= NULL then
				Result := {EV_GTK_EXTERNALS}.g_list_length (col_list)
				{EV_GTK_EXTERNALS}.g_list_free (col_list)
			end
		end

	model_column_count: INTEGER is
			-- Number of columns in GtkTreeModel
		do
			if list_store /= NULL then
				Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_n_columns (list_store)
			end
		end

	rows, count: INTEGER is
			-- Number of rows in the list.
		do
			Result := ev_children.count
		end

	i_th (i: INTEGER): EV_MULTI_COLUMN_LIST_ROW is
			-- `i_th' row in `Current'
		do
			Result := (ev_children @ i).interface
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Item which is currently selected
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
					Result := ((ev_children @ (mp.read_integer_32 (0) + 1)).interface)
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_list_free_contents (a_tree_path_list)
					{EV_GTK_EXTERNALS}.g_list_free (a_tree_path_list)
			end
		end

	selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
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
					Result.extend ((ev_children @ (mp.read_integer_32 (0) + 1)).interface)
					a_tree_path_list := {EV_GTK_EXTERNALS}.glist_struct_next (a_tree_path_list)
				end
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_list_free_contents (a_tree_path_list)
				{EV_GTK_EXTERNALS}.g_list_free (a_tree_path_list)
			end
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		local
			a_selection: POINTER
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_count_selected_rows (a_selection) > 0
		end

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise.
		local
			a_selection: POINTER
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_get_mode (a_selection) = {EV_GTK_EXTERNALS}.gtk_selection_multiple_enum
		end

	title_shown: BOOLEAN is
			-- True if the title row is shown.
			-- False if the title row is not shown.
		do
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_headers_visible (tree_view)
		end

feature -- Status setting

	destroy is
			-- Destroy screen widget implementation and EV_LIST_ITEM objects.
		do
			wipe_out
			Precursor {EV_PRIMITIVE_IMP}
		end

	show_title_row is
			-- Show the row of the titles.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_headers_visible (tree_view, True)
		end

	hide_title_row is
			-- Hide the row of the titles.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_headers_visible (tree_view, False)
			resize_column_to_content (1)
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS.
		local
			a_selection: POINTER
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_set_mode (a_selection, {EV_GTK_EXTERNALS}.gtk_selection_multiple_enum)
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS.
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
			a_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_select_iter (a_selection, (ev_children @ an_index).list_iter.item)
			if selection_signal_id = 0 then
				a_row_imp := ev_children.i_th (an_index)
				call_selection_actions (a_row_imp)
			end
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		local
			a_selection: POINTER
			a_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			a_selection := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_unselect_iter (a_selection, (ev_children @ an_index).list_iter.item)
			if selection_signal_id = 0 then
				a_row_imp := ev_children.i_th (an_index)
				call_deselect_actions (a_row_imp)
			end
		end

	clear_selection is
			-- Clear the selection of the list.
		local
			a_selection: POINTER
		do
			a_selection := {EV_GTK_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			{EV_GTK_EXTERNALS}.gtk_tree_selection_unselect_all (a_selection)
		end

	resize_column_to_content (a_column: INTEGER) is
			-- Resize column `a_column' to width of its widest text.
		local
			a_column_ptr: POINTER
		do
			a_column_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, a_column - 1)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_sizing (a_column_ptr, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_grow_only_enum)
		end

feature -- Element change

	column_title_changed (a_txt: STRING; a_column: INTEGER) is
			-- Make `a_txt' the title of the column number.
		local
			a_cs: EV_GTK_C_STRING
			a_column_ptr: POINTER
		do
			if a_column > column_count then
				expand_column_count_to (a_column)
			end
			a_column_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, a_column - 1)
			check
				a_column_not_null: a_column_ptr /= default_pointer
			end
			a_cs := a_txt
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_title (a_column_ptr, a_cs.item)
		end

	column_width_changed (value: INTEGER; a_column: INTEGER) is
			-- Make `value' the new width of the column number
			-- `a_column'.
		local
			a_column_ptr: POINTER
		do
			if column_widths /= Void then
				a_column_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, a_column - 1)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_sizing (a_column_ptr, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_fixed_enum)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_fixed_width (a_column_ptr, value.max (1))
			end
		end

	column_alignment_changed (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER) is
			-- Set alignment of `a_column' to corresponding `alignment_code'.
		local
			alignment: REAL
			a_column_ptr, a_cell_rend_list, a_cell_rend: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
			i: INTEGER
		do
			if an_alignment.is_left_aligned then
				alignment := 0
			elseif an_alignment.is_center_aligned then
				alignment := 0.5
			else
				alignment := 1.0
			end

			a_column_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, a_column - 1)
			a_cell_rend_list := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_get_cell_renderers (a_column_ptr)
			from
				i := 0
				a_gtk_c_str := "xalign"
			until
				i = {EV_GTK_EXTERNALS}.g_list_length (a_cell_rend_list)
			loop
				a_cell_rend := {EV_GTK_EXTERNALS}.g_list_nth_data (a_cell_rend_list, i)
				{EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_double (a_cell_rend, a_gtk_c_str.item, alignment)
				i := i + 1
			end

			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_alignment (a_column_ptr, alignment)
			{EV_GTK_EXTERNALS}.g_list_free (a_cell_rend_list)
		end

	set_row_height (value: INTEGER) is
			-- Make `value' the new height of all the rows.
		local
			a_column_ptr, a_cell_rend_list, a_cell_rend: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
			a_vert_sep: INTEGER
		do
			a_column_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, 0)
			a_cell_rend_list := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_get_cell_renderers (a_column_ptr)
			a_cell_rend := {EV_GTK_EXTERNALS}.g_list_nth_data (a_cell_rend_list, 0)

				-- Row height setting has to take the vertical spacing of the tree view in to account
			a_gtk_c_str := "vertical-separator"
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_style_get_integer (tree_view, a_gtk_c_str.item, $a_vert_sep)

			a_gtk_c_str := "height"
			{EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (a_cell_rend, a_gtk_c_str.item, value - a_vert_sep)
			{EV_GTK_EXTERNALS}.g_list_free (a_cell_rend_list)
		end

	wipe_out is
			-- Remove all items.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
				-- Remove all items (GTK part)
			clear_selection
			{EV_GTK_EXTERNALS}.gtk_list_store_clear (list_store)
			from
				ev_children.start
			until
				ev_children.after
			loop
				item_imp := ev_children.item
				item_imp.set_parent_imp (Void)
				ev_children.forth
			end

				-- Renew storage containers.
			ev_children.wipe_out
			child_array.wipe_out
			index := 0

			update_pnd_status
		end

feature -- Implementation

	set_to_drag_and_drop: BOOLEAN is
			-- Set transport mode to drag and drop.
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_drag_and_drop
			else
				Result := mode_is_drag_and_drop
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is list or row able to transport PND data using `a_button'.
		do
			if pnd_row_imp /= Void then
				Result := (pnd_row_imp.mode_is_drag_and_drop and a_button = 1) or
				(pnd_row_imp.mode_is_pick_and_drop and a_button = 3)
			else
				Result := (mode_is_drag_and_drop and a_button = 1) or
				(mode_is_pick_and_drop and a_button = 3)
			end
		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN is
			-- Is list or row able to display PND menu using `a_button'
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_target_menu and then a_button = 3
			else
				Result := mode_is_target_menu and then a_button = 3
			end
		end

	enable_transport is
			-- Enable PND transport to occur
		do
			connect_pnd_callback
		end

	connect_pnd_callback is
			-- Connect Pick event for PND
		do
			check
				button_release_not_connected: button_release_connection_id = 0
			end
			if button_press_connection_id > 0 then
				{EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, button_press_connection_id)
			end
			real_signal_connect (visual_widget,
				once "button-press-event",
				agent (App_implementation.gtk_marshal).mcl_start_transport_filter_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?),
				App_implementation.default_translate)
			button_press_connection_id := last_signal_connection_id
			is_transport_enabled := True
		end

	disable_transport is
			-- Disable PND transport
		do
			Precursor
			update_pnd_status
		end

	update_pnd_status is
			-- Update PND status of list and its children.
		local
			a_enable_flag: BOOLEAN
		do
			from
				ev_children.start
			until
				ev_children.after or else a_enable_flag
			loop
				a_enable_flag := ev_children.item.is_transport_enabled
				ev_children.forth
			end
			update_pnd_connection (a_enable_flag)
		end

	update_pnd_connection (a_enable: BOOLEAN) is
			-- Update the PND connection of `Current' if needed.
		do
			if not is_transport_enabled then
				if a_enable or pebble /= Void then
					connect_pnd_callback
				end
			elseif not a_enable and pebble = Void then
				disable_transport_signals
				is_transport_enabled := False
			end
		end

	start_transport_filter (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		local
			a_row_index: INTEGER
		do
			a_row_index := row_index_from_y_coord (a_y)

			if a_row_index > 0 then
				pnd_row_imp := ev_children.i_th (a_row_index)
				if not pnd_row_imp.able_to_transport (a_button) then
					pnd_row_imp := Void
				end
			end

			if pnd_row_imp /= Void or else pebble /= Void then
				Precursor (
				a_type,
				a_x, a_y, a_button,
				a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y)
			else
				call_press_actions (interface, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			end
		end

	pnd_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: ANY

	temp_pebble_function: FUNCTION [ANY, TUPLE [], ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: EV_CURSOR

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Set `pebble' using `pebble_function' if present.
		do
			temp_pebble := pebble
			temp_pebble_function := pebble_function
			if pnd_row_imp /= Void then
				pebble := pnd_row_imp.pebble
				pebble_function := pnd_row_imp.pebble_function
			end

			if pebble_function /= Void then
				pebble_function.call ([a_x, a_y]);
				pebble := pebble_function.last_result
			end
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Steps to perform before transport initiated.
		do
			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor
			app_implementation.on_pick (pebble)

			if pnd_row_imp /= Void then
				if pnd_row_imp.pick_actions_internal /= Void then
					pnd_row_imp.pick_actions_internal.call ([a_x, a_y])
				end
				accept_cursor := pnd_row_imp.accept_cursor
				deny_cursor := pnd_row_imp.deny_cursor
			else
				if pick_actions_internal /= Void then
					pick_actions_internal.call ([a_x, a_y])
				end
			end

			pointer_x := a_screen_x
			pointer_y := a_screen_y

			if pnd_row_imp = Void then
				if (pick_x = 0 and then pick_y = 0) then
					App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
				else
					if pick_x > width then
						pick_x := width
					end
					if pick_y > height then
						pick_y := height
					end
					App_implementation.set_x_y_origin (pick_x + (a_screen_x - a_x), pick_y + (a_screen_y - a_y))
				end
			else
				if (pnd_row_imp.pick_x = 0 and then pnd_row_imp.pick_y = 0) then
					App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
				else
					if pick_x > width then
						pick_x := width
					end
					if pick_y > row_height then
						pick_y := row_height
					end
					App_implementation.set_x_y_origin (
						pnd_row_imp.pick_x + (a_screen_x - a_x),
						pnd_row_imp.pick_y +
						(a_screen_y - a_y) +
						((ev_children.index_of (pnd_row_imp, 1) - 1) * row_height)
					)
				end
			end
		end

	post_drop_steps (a_button: INTEGER)  is
			-- Steps to perform once an attempted drop has happened.
		do
			if a_button > 0  then
				if pnd_row_imp /= Void and not is_destroyed then
					if pnd_row_imp.mode_is_pick_and_drop then
						signal_emit_stop (event_widget, "button-press-event")
					end
				elseif mode_is_pick_and_drop and not is_destroyed then
						signal_emit_stop (event_widget, "button-press-event")
				end
			end
			App_implementation.set_x_y_origin (0, 0)
			last_pointed_target := Void

			if pebble_function /= Void then
				if pnd_row_imp /= Void then
					pnd_row_imp.set_pebble_void
				else
					temp_pebble := Void
				end
			end

			accept_cursor := temp_accept_cursor
			deny_cursor := temp_deny_cursor
			pebble := temp_pebble
			pebble_function := temp_pebble_function

			temp_pebble := Void
			temp_pebble_function := Void
			temp_accept_cursor := Void
			temp_deny_cursor := Void

			pnd_row_imp := Void
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP} -- Implementation

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
				Result := ev_children @ a_row_index
			end
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP}

	set_text_on_position (a_column, a_row: INTEGER; a_text: STRING) is
			-- Set cell text at (a_column, a_row) to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
			str_value: POINTER
			a_list_iter: POINTER
		do
			--create a_cs.make (a_text)
			a_cs := a_text
				-- Replace when we have UTF16 support
			str_value := g_value_string_struct
			{EV_GTK_DEPENDENT_EXTERNALS}.g_value_unset (str_value)
			{EV_GTK_DEPENDENT_EXTERNALS}.g_value_init_string (str_value)
			{EV_GTK_DEPENDENT_EXTERNALS}.g_value_set_string (str_value, a_cs.item)

			a_list_iter := ev_children.i_th (a_row).list_iter.item
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_value (list_store, a_list_iter, a_column, str_value)
		end

	g_value_string_struct: POINTER is
			-- Optimization for GValue struct access
		once
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.c_g_value_struct_allocate
			{EV_GTK_DEPENDENT_EXTERNALS}.g_value_init_string (Result)
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			pixmap_imp: EV_PIXMAP_IMP
			a_list_iter: POINTER
			a_pixbuf: POINTER
		do
			pixmap_imp ?= a_pixmap.implementation
			a_pixbuf := pixmap_imp.pixbuf_from_drawable_with_size (pixmaps_width, pixmaps_height)
			a_list_iter := ev_children.i_th (a_row).list_iter.item
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_pixbuf (list_store, a_list_iter, 0, a_pixbuf)
			{EV_GTK_EXTERNALS}.object_unref (a_pixbuf)
		end

	remove_row_pixmap (a_row: INTEGER) is
			-- Remove pixmap from `a_row'
		local
			a_list_iter: POINTER
		do
			a_list_iter := ev_children.i_th (a_row).list_iter.item
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_set_pixbuf (list_store, a_list_iter, 0, NULL)
		end

feature {NONE} -- Implementation

	update_child (child: EV_MULTI_COLUMN_LIST_ROW_IMP; a_row: INTEGER) is
			-- Update `child'.
		require
			child_exists: child /= Void
		local
			cur: CURSOR
			txt: STRING
			list: EV_MULTI_COLUMN_LIST_ROW
			column_counter: INTEGER
		do
			list := child.interface
			cur := list.cursor

			if child.pixmap /= Void then
				set_row_pixmap (a_row, child.pixmap)
			end
			from
				column_counter := 1
				list.start
			until
				column_counter > column_count
			loop
					-- Set the text in the cell
				if list.after then
					txt := ""
				else
					txt := list.item
					if txt = Void then
						txt := ""
					end
				end
				set_text_on_position (column_counter, a_row, txt)
					-- Pixmap gets updated when the text does.

					-- Prepare next iteration
				if not list.after then
					list.forth
				end
				column_counter := column_counter + 1
			end
			list.go_to (cur)
		end

	ensure_item_visible (a_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Ensure `a_item' is visible on the screen.
		local
			list_item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			a_path: POINTER
		do
			list_item_imp ?= a_item.implementation
			a_path := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_path (list_store, list_item_imp.list_iter.item)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_scroll_to_cell (tree_view, a_path, NULL, False, 0, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_path)
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)

				-- Make sure list is large enough to fit `item_imp'
			if v.count > column_count then
				create_list (v.count)
			end

				-- update the list of rows of the column list:			
			ev_children.go_i_th (i)
			ev_children.put_left (item_imp)

				-- Add row to model
			create a_tree_iter.make
			item_imp.set_list_iter (a_tree_iter)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_list_store_insert (list_store, a_tree_iter.item, i - 1)
			update_child (item_imp, ev_children.count)

			if item_imp.is_transport_enabled then
				update_pnd_connection (True)
			end

			child_array.go_i_th (i)
			child_array.put_left (v)
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item from list at `a_position'.
			-- Set the items parent to void.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			item_imp := (ev_children @ (a_position))
			item_imp.set_parent_imp (Void)
			{EV_GTK_EXTERNALS}.gtk_list_store_remove (list_store, item_imp.list_iter.item)
			-- remove the row from the `ev_children'
			ev_children.go_i_th (a_position)
			ev_children.remove
			child_array.go_i_th (a_position)
			child_array.remove
			update_pnd_status
		end

	row_height: INTEGER is
			-- Height of rows in `Current'
		local
			a_column_ptr: POINTER
			a_x, a_y, a_width, a_height: INTEGER
		do
			a_column_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_cell_get_size (a_column_ptr, NULL, $a_x, $a_y, $a_width, $a_height)
			Result := a_height
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP} -- Implementation

	expand_column_count_to (a_columns: INTEGER) is
			-- Expand the number of columns to `a_columns'
		do
			create_list (a_columns)
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	tree_view: POINTER
		-- Pointer to the View

feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER is
			-- Pointer to on-screen interactive widget
		do
			Result := tree_view
		end

	scrollable_area: POINTER
		-- Gtk widget used to scroll tree view

	interface: EV_MULTI_COLUMN_LIST

end -- class EV_MULTI_COLUMN_LIST_IMP

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


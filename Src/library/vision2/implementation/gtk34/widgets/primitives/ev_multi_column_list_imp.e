note
	description:
		"EiffelVision multi-column-list, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_IMP

inherit
	EV_MULTI_COLUMN_LIST_I
		export
			{EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES}
				column_widths, update_column_width, column_resized_actions_internal,
				column_title_click_actions_internal
		redefine
			interface,
			make,
			call_pebble_function,
			wipe_out,
			remove_row_pixmap
		end

	EV_PRIMITIVE_IMP
		redefine
			disable_transport,
			pre_pick_steps,
			call_pebble_function,
			post_drop_steps,
			on_mouse_button_event,
			make,
			interface,
			destroy,
			able_to_transport,
			ready_for_pnd_menu,
			set_to_drag_and_drop,
			call_button_event_actions,
			visual_widget,
			on_pointer_motion,
			pebble_source,
			needs_event_box
		end

	EV_ITEM_LIST_IMP [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			i_th,
			count,
			interface,
			wipe_out,
			make
		end

	EV_PND_DEFERRED_ITEM_PARENT
		redefine
			call_selection_action_sequences
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		local
			l_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
		do
			scrollable_area := {GTK}.gtk_scrolled_window_new (NULL, NULL)
			{GTK2}.gtk_scrolled_window_set_shadow_type (scrollable_area, {GTK}.gtk_shadow_in_enum)
			set_c_object (scrollable_area)
			{GTK}.gtk_scrolled_window_set_policy (
				scrollable_area,
				{GTK}.GTK_POLICY_AUTOMATIC_ENUM,
				{GTK}.GTK_POLICY_AUTOMATIC_ENUM
			)
			create ev_children.make (0)
			create previous_selection.make (0)
			tree_view := {GTK2}.gtk_tree_view_new
			{GTK}.gtk_container_add (scrollable_area, tree_view)
			{GTK}.gtk_widget_show (tree_view)
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_MULTI_COLUMN_LIST_I}
			{GTK2}.gtk_tree_view_set_enable_search (tree_view, False)
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

	needs_event_box: BOOLEAN = True

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	connect_selection_actions
			-- Connect the selection signal
		local
			a_selection: POINTER
		do
			if selection_signal_id = 0 then
				a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
				real_signal_connect (a_selection, "changed", agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id), Void)
				selection_signal_id := last_signal_connection_id
			end
		end

	disconnect_selection_actions
			-- Disconnect the selection signal
		local
			a_selection: POINTER
		do
			if selection_signal_id /= 0 then
				a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
				{GTK2}.signal_disconnect (a_selection, selection_signal_id)
				selection_signal_id := 0
			end
		end

	selection_signal_id: INTEGER
		-- Signal id used for the selection changed event

feature {NONE} -- Implementation

	call_selection_action_sequences
			-- Call appropriate selection and deselection action sequences
		local
			new_selection: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			newly_selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			an_item: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
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
						call_deselect_actions (an_item)
					end
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

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Event handling

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
			a_row_number: INTEGER
			clicked_row: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
			a_gdkwin, a_gtkwid: POINTER
			l_x, l_y: INTEGER
		do
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			if a_type /= {GTK}.gdk_button_release_enum then
				a_gdkwin := {GDK_HELPERS}.window_at ($l_x, $l_y)
				if a_gdkwin /= default_pointer then
					{GTK}.gdk_window_get_user_data (a_gdkwin, $a_gtkwid)
					if a_gtkwid = tree_view then
							-- This prevents item actions from being called if clicking on a scrollbar
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
						if a_type = {GTK}.gDK_BUTTON_PRESS_ENUM then
							if
								clicked_row /= Void and then
								clicked_row.pointer_button_press_actions_internal /= Void
							then
								clicked_row.pointer_button_press_actions.call (t)
							end
						elseif a_type = {GTK}.gDK_2BUTTON_PRESS_ENUM then
							if
								clicked_row /= Void and then
								clicked_row.pointer_double_press_actions_internal /= Void
							then
								clicked_row.pointer_double_press_actions.call (t)
							end
						end
					end
				end
			else
				mouse_button_pressed := False
				call_selection_action_sequences
			end
		end

	mouse_button_pressed: BOOLEAN
		-- Is the mouse button pressed

feature {NONE} -- Implementation

	call_selection_actions (clicked_row: EV_MULTI_COLUMN_LIST_ROW_IMP)
			-- Call the selections actions for `clicked_row'
		do
			if not previous_selection.has (clicked_row.attached_interface) then
				if clicked_row.select_actions_internal /= Void then
					clicked_row.select_actions.call (void)
				end
				if select_actions_internal /= Void then
					select_actions_internal.call ([clicked_row.attached_interface])
				end
			end
		end

	call_deselect_actions (deselected_row: EV_MULTI_COLUMN_LIST_ROW_IMP)
			-- Call deselect actions for `deselected_row'
		do
			if deselected_row.deselect_actions_internal /= Void then
				deselected_row.deselect_actions.call (Void)
			end
			if deselect_actions_internal /= Void then
				deselect_actions_internal.call ([deselected_row.attached_interface])
			end
		end

	resize_model_if_needed (a_columns: INTEGER)
			--
		local
			a_type_array: MANAGED_POINTER
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
			i: INTEGER
		do
			if a_columns > model_column_count - 1 then
				create a_type_array.make ((a_columns + 1) * {GTK2}.sizeof_gtype)
				from
					{GTK2}.add_gdk_type_pixbuf (a_type_array.item, 0)
					i := 1
				until
					i > a_columns
				loop
					{GTK2}.add_g_type_string (a_type_array.item, i * {GTK2}.sizeof_gtype)
					i := i + 1
				end

				list_store := {GTK2}.gtk_list_store_newv (a_columns + 1, a_type_array.item)

				{GTK2}.gtk_tree_view_set_model (tree_view, list_store)

				from
					ev_children.start
				until
					ev_children.after
				loop
					create a_tree_iter.make
					{GTK2}.gtk_list_store_insert (list_store, a_tree_iter.item, ev_children.index - 1)
					ev_children.item.set_list_iter (a_tree_iter)
					update_child (ev_children.item, ev_children.index)
					ev_children.forth
				end
			end
		end


	create_list (a_columns: INTEGER)
			-- Create the clist with `a_columns' columns.
		require
			a_columns_positive: a_columns > 0
		local
			i: INTEGER
			temp_title: STRING_32
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
				a_column := {GTK2}.gtk_tree_view_column_new
				{GTK2}.gtk_tree_view_column_set_resizable (a_column, True)
				{GTK2}.gtk_tree_view_column_set_clickable (a_column, True)
				{GTK2}.gtk_tree_view_column_set_sizing (a_column, {GTK2}.gtk_tree_view_column_fixed_enum)

				if i = 1 then
					a_cell_renderer := {GTK2}.gtk_cell_renderer_pixbuf_new
					{GTK2}.gtk_tree_view_column_pack_start (a_column, a_cell_renderer, False)
					a_gtk_c_str := once "pixbuf"
					{GTK2}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 0)
				end

				a_cell_renderer := {GTK2}.gtk_cell_renderer_text_new
				{GTK2}.gtk_tree_view_column_pack_start (a_column, a_cell_renderer, True)
				a_gtk_c_str := once "text"
				{GTK2}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, i)
				{GTK2}.gtk_tree_view_insert_column (tree_view, a_column, i - 1)


				if column_titles /= Void and then
					column_titles.valid_index (i) and then
						attached column_titles.i_th (i) as l_temp_title then
					temp_title := l_temp_title
				else
					temp_title := once {STRING_32} ""
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

	on_pointer_motion (a_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
		local
			a_row_number: INTEGER
			a_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			Precursor (a_motion_tuple)
			if not app_implementation.is_in_transport and then a_motion_tuple.integer_item (2) > 0 and a_motion_tuple.integer_item (1) <= width then
				a_row_number := row_index_from_y_coord (a_motion_tuple.integer_item (2))
				if a_row_number > 0 and then a_row_number <= count then
					a_row_imp := ev_children @ a_row_number
					if a_row_imp.pointer_motion_actions_internal /= Void then
						a_row_imp.pointer_motion_actions.call (a_motion_tuple)
					end
				end
			end
		end

	pixmaps_size_changed
			--
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
--			if pixmaps_height > {EV_GTK_EXTERNALS}.gtk_clist_struct_row_height (list_widget) then
--				set_row_height (pixmaps_height)
--			end
		end

feature -- Access

	column_count: INTEGER
			-- Number of columns in the list.
		local
			col_list: POINTER
		do
			col_list := {GTK2}.gtk_tree_view_get_columns (tree_view)
			if col_list /= NULL then
				Result := {GTK}.g_list_length (col_list)
				{GTK}.g_list_free (col_list)
			end
		end

	model_column_count: INTEGER
			-- Number of columns in GtkTreeModel
		do
			if list_store /= NULL then
				Result := {GTK2}.gtk_tree_model_get_n_columns (list_store)
			end
		end

	rows, count: INTEGER
			-- Number of rows in the list.
		do
			Result := ev_children.count
		end

	i_th (i: INTEGER): EV_MULTI_COLUMN_LIST_ROW
			-- `i_th' row in `Current'
		do
			Result := (ev_children @ i).attached_interface
		end

	selected_item: detachable EV_MULTI_COLUMN_LIST_ROW
			-- Item which is currently selected
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

			if a_tree_path_list /= NULL then
					a_tree_path := {GTK}.glist_struct_data (a_tree_path_list)
					a_int_ptr := {GTK2}.gtk_tree_path_get_indices (a_tree_path)
					create mp.share_from_pointer (a_int_ptr, {PLATFORM}.integer_32_bytes)
					Result := ((ev_children @ (mp.read_integer_32 (0) + 1)).attached_interface)
					{GTK2}.gtk_tree_path_list_free_contents (a_tree_path_list)
					{GTK}.g_list_free (a_tree_path_list)
			end
		end

	selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
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
			if a_tree_path_list /= NULL then
				from
				until
					a_tree_path_list = NULL
				loop
					a_tree_path := {GTK}.glist_struct_data (a_tree_path_list)
					a_int_ptr := {GTK2}.gtk_tree_path_get_indices (a_tree_path)
					create mp.share_from_pointer (a_int_ptr, {PLATFORM}.integer_32_bytes)
					Result.extend ((ev_children @ (mp.read_integer_32 (0) + 1)).attached_interface)
					a_tree_path_list := {GTK}.glist_struct_next (a_tree_path_list)
				end
				{GTK2}.gtk_tree_path_list_free_contents (a_tree_path_list)
				{GTK}.g_list_free (a_tree_path_list)
			end
		end

feature -- Status report

	selected: BOOLEAN
			-- Is at least one item selected ?
		local
			a_selection: POINTER
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			Result := {GTK2}.gtk_tree_selection_count_selected_rows (a_selection) > 0
		end

	multiple_selection_enabled: BOOLEAN
			-- True if the user can choose several items
			-- False otherwise.
		local
			a_selection: POINTER
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			Result := {GTK2}.gtk_tree_selection_get_mode (a_selection) = {GTK}.gtk_selection_multiple_enum
		end

	title_shown: BOOLEAN
			-- True if the title row is shown.
			-- False if the title row is not shown.
		do
			Result := {GTK2}.gtk_tree_view_get_headers_visible (tree_view)
		end

feature -- Status setting

	destroy
			-- Destroy screen widget implementation and EV_LIST_ITEM objects.
		do
			wipe_out
			Precursor {EV_PRIMITIVE_IMP}
		end

	show_title_row
			-- Show the row of the titles.
		do
			{GTK2}.gtk_tree_view_set_headers_visible (tree_view, True)
		end

	hide_title_row
			-- Hide the row of the titles.
		do
			{GTK2}.gtk_tree_view_set_headers_visible (tree_view, False)
			resize_column_to_content (1)
		end

	enable_multiple_selection
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS.
		local
			a_selection: POINTER
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			{GTK2}.gtk_tree_selection_set_mode (a_selection, {GTK}.gtk_selection_multiple_enum)
		end

	disable_multiple_selection
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS.
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
			a_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			l_list_iter := (ev_children @ an_index).list_iter
			check l_list_iter /= Void then end
			{GTK2}.gtk_tree_selection_select_iter (a_selection, l_list_iter.item)
			if selection_signal_id = 0 then
				a_row_imp := ev_children.i_th (an_index)
				call_selection_actions (a_row_imp)
			end
		end

	deselect_item (an_index: INTEGER)
			-- Unselect the item at the one-based `index'.
		local
			a_selection: POINTER
			a_row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			l_list_iter := (ev_children @ an_index).list_iter
			check l_list_iter /= Void then end
			{GTK2}.gtk_tree_selection_unselect_iter (a_selection, l_list_iter.item)
			if selection_signal_id = 0 then
				a_row_imp := ev_children.i_th (an_index)
				call_deselect_actions (a_row_imp)
			end
		end

	clear_selection
			-- Clear the selection of the list.
		local
			a_selection: POINTER
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			{GTK2}.gtk_tree_selection_unselect_all (a_selection)
		end

	resize_column_to_content (a_column: INTEGER)
			-- Resize column `a_column' to width of its widest text.
		local
			a_column_ptr: POINTER
		do
			a_column_ptr := {GTK2}.gtk_tree_view_get_column (tree_view, a_column - 1)
			{GTK2}.gtk_tree_view_column_set_sizing (a_column_ptr, {GTK2}.gtk_tree_view_column_grow_only_enum)
		end

feature -- Element change

	column_title_changed (a_txt: READABLE_STRING_GENERAL; a_column: INTEGER)
			-- Make `a_txt' the title of the column number.
		local
			l_txt: STRING_32
			a_cs: EV_GTK_C_STRING
			a_column_ptr: POINTER
		do
			if a_column > column_count then
				expand_column_count_to (a_column)
			end
			a_column_ptr := {GTK2}.gtk_tree_view_get_column (tree_view, a_column - 1)
			check
				a_column_not_null: a_column_ptr /= default_pointer
			end
			l_txt := a_txt.as_string_32
			l_txt.replace_substring_all (once {STRING_32} "_", once {STRING_32} "__")
			a_cs := l_txt
			{GTK2}.gtk_tree_view_column_set_title (a_column_ptr, a_cs.item)
		end

	column_width_changed (value: INTEGER; a_column: INTEGER)
			-- Make `value' the new width of the column number
			-- `a_column'.
		local
			a_column_ptr: POINTER
		do
			if column_widths /= Void then
				a_column_ptr := {GTK2}.gtk_tree_view_get_column (tree_view, a_column - 1)
				{GTK2}.gtk_tree_view_column_set_sizing (a_column_ptr, {GTK2}.gtk_tree_view_column_fixed_enum)
				{GTK2}.gtk_tree_view_column_set_fixed_width (a_column_ptr, value.max (1))
			end
		end

	column_alignment_changed (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER)
			-- Set alignment of `a_column' to corresponding `alignment_code'.
		local
			alignment: REAL
			a_column_ptr, a_cell_rend_list, a_cell_rend: POINTER
			i: INTEGER
		do
			if an_alignment.is_left_aligned then
				alignment := {REAL_32} 0.0
			elseif an_alignment.is_center_aligned then
				alignment := {REAL_32} 0.5
			else
				alignment := {REAL_32} 1.0
			end

			a_column_ptr := {GTK2}.gtk_tree_view_get_column (tree_view, a_column - 1)
			a_cell_rend_list := {GTK}.gtk_cell_layout_get_cells (a_column_ptr)
			from
				i := 0
			until
				i = {GTK}.g_list_length (a_cell_rend_list)
			loop
				a_cell_rend := {GTK}.g_list_nth_data (a_cell_rend_list, i)
				{GTK2}.g_object_set_real_32 (a_cell_rend, {GTK_PROPERTIES}.xalign, alignment)
				i := i + 1
			end

			{GTK2}.gtk_tree_view_column_set_alignment (a_column_ptr, alignment)
			{GTK}.g_list_free (a_cell_rend_list)
		end

	set_row_height (value: INTEGER)
			-- Make `value' the new height of all the rows.
		local
			a_column_ptr, a_cell_rend_list, a_cell_rend: POINTER
			a_vert_sep: INTEGER
		do
			a_column_ptr := {GTK2}.gtk_tree_view_get_column (tree_view, 0)
			a_cell_rend_list := {GTK}.gtk_cell_layout_get_cells (a_column_ptr)
			a_cell_rend := {GTK}.g_list_nth_data (a_cell_rend_list, 0)

				-- Row height setting has to take the vertical spacing of the tree view in to account
			{GTK2}.gtk_widget_style_get_integer (tree_view, {GTK_PROPERTIES}.vertical_separator, $a_vert_sep)

			{GTK2}.g_object_set_integer (a_cell_rend, {GTK_PROPERTIES}.height, value - a_vert_sep)
			{GTK}.g_list_free (a_cell_rend_list)
		end

	wipe_out
			-- Remove all items.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
				-- Remove all items (GTK part)
			clear_selection
			{GTK2}.gtk_list_store_clear (list_store)
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

	pebble_source: EV_PICK_AND_DROPABLE
			-- Source of pebble, used for widgets with deferred PND implementation
			-- such as EV_TREE and EV_MULTI_COLUMN_LIST.
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.attached_interface
			else
				Result := Precursor
			end
		end

	set_to_drag_and_drop: BOOLEAN
			-- Set transport mode to drag and drop.
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.mode_is_drag_and_drop
			else
				Result := mode_is_drag_and_drop
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is list or row able to transport PND data using `a_button'.
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.able_to_transport (a_button)
			else
				Result := Precursor (a_button)
			end
		end

	ready_for_pnd_menu (a_button: INTEGER_32; a_press: BOOLEAN): BOOLEAN
			-- Is list or row able to display PND menu using `a_button'
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.ready_for_pnd_menu (a_button, a_press)
			else
				Result := Precursor (a_button, a_press)
			end
		end

	disable_transport
			-- Disable PND transport
		do
			Precursor
			update_pnd_status
		end

	update_pnd_status
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

	update_pnd_connection (a_enable: BOOLEAN)
			-- Update the PND connection of `Current' if needed.
		do
			if not is_transport_enabled then
				if a_enable or pebble /= Void then
					is_transport_enabled := True
				end
			elseif not a_enable and pebble = Void then
				is_transport_enabled := False
			end
		end

	on_mouse_button_event (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

			-- Initialize a pick and drop transport.
		local
			a_row_index: INTEGER
			l_pnd_row_imp: like pnd_row_imp
		do
			a_row_index := row_index_from_y_coord (a_y)

			if a_row_index > 0 then
				l_pnd_row_imp := ev_children.i_th (a_row_index)
				check l_pnd_row_imp /= Void end
				pnd_row_imp := l_pnd_row_imp
				if not (l_pnd_row_imp.able_to_transport (a_button) or l_pnd_row_imp.mode_is_configurable_target_menu) then
					pnd_row_imp := Void
				end
			else
				pnd_row_imp := Void
			end

			Precursor (
					a_type,
					a_x, a_y, a_button,
					a_x_tilt, a_y_tilt, a_pressure,
					a_screen_x, a_screen_y
				)
		end

	pnd_row_imp: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: detachable ANY

	temp_pebble_function: detachable FUNCTION [detachable ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: detachable EV_POINTER_STYLE

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Set `pebble' using `pebble_function' if present.
		do
			temp_pebble := pebble
			temp_pebble_function := pebble_function
			if attached pnd_row_imp as l_pnd_row_imp then
				pebble := l_pnd_row_imp.pebble
				pebble_function := l_pnd_row_imp.pebble_function
			end

			if attached pebble_function as l_pebble_function then
				pebble := l_pebble_function.item ([a_x, a_y]);
			end
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Steps to perform before transport initiated.
		local
			l_pnd_row_imp: like pnd_row_imp
			l_pebble: like pebble
		do
			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor
			l_pebble := pebble
			if l_pebble /= Void then
				app_implementation.on_pick (Current, l_pebble)
			end

			l_pnd_row_imp := pnd_row_imp

			if l_pnd_row_imp /= Void then
				if l_pnd_row_imp.pick_actions_internal /= Void then
					l_pnd_row_imp.pick_actions.call ([a_x, a_y])
				end
				accept_cursor := l_pnd_row_imp.accept_cursor
				deny_cursor := l_pnd_row_imp.deny_cursor
			else
				if pick_actions_internal /= Void then
					pick_actions_internal.call ([a_x, a_y])
				end
			end

			pointer_x := a_screen_x.to_integer_16
			pointer_y := a_screen_y.to_integer_16

			if l_pnd_row_imp = Void then
				if (pick_x = 0 and then pick_y = 0) then
					App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
				else
					if pick_x > width then
						pick_x := width.to_integer_16
					end
					if pick_y > height then
						pick_y := height.to_integer_16
					end
					App_implementation.set_x_y_origin (pick_x + (a_screen_x - a_x), pick_y + (a_screen_y - a_y))
				end
			else
				if (l_pnd_row_imp.pick_x = 0 and then l_pnd_row_imp.pick_y = 0) then
					App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
				else
					if pick_x > width then
						pick_x := width.to_integer_16
					end
					if pick_y > row_height then
						pick_y := row_height.to_integer_16
					end
					App_implementation.set_x_y_origin (
						l_pnd_row_imp.pick_x + (a_screen_x - a_x),
						l_pnd_row_imp.pick_y +
						(a_screen_y - a_y) +
						((ev_children.index_of (l_pnd_row_imp, 1) - 1) * row_height)
					)
				end
			end
			modify_widget_appearance (True)
		end

	post_drop_steps (a_button: INTEGER)
			-- Steps to perform once an attempted drop has happened.
		do
			App_implementation.set_x_y_origin (0, 0)

			if pebble_function /= Void then
				if attached pnd_row_imp as l_pnd_row_imp then
					l_pnd_row_imp.set_pebble_void
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

	row_index_from_y_coord (a_y: INTEGER): INTEGER
			-- Returns the row index at relative coordinate `a_y'.
		local
			a_tree_path, a_tree_column: POINTER
			a_success: BOOLEAN
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
		do
			a_success := {GTK2}.gtk_tree_view_get_path_at_pos (tree_view, 1, a_y, $a_tree_path, $a_tree_column, NULL, NULL)
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
			a_row_index := row_index_from_y_coord (a_y)
			if a_row_index > 0 then
				Result := ev_children @ a_row_index
			end
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP}

	set_text_on_position (a_column, a_row: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Set cell text at (a_column, a_row) to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
			str_value: POINTER
			a_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			--create a_cs.make (a_text)
			a_cs := a_text
				-- Replace when we have UTF16 support
			str_value := g_value_string_struct
			{GTK2}.g_value_unset (str_value)
			{GTK2}.g_value_init_string (str_value)
			{GTK2}.g_value_set_string (str_value, a_cs.item)

			a_list_iter := ev_children.i_th (a_row).list_iter
			check a_list_iter /= Void then end
			{GTK2}.gtk_list_store_set_value (list_store, a_list_iter.item, a_column, str_value)
		end

	g_value_string_struct: POINTER
			-- Optimization for GValue struct access
		once
			Result := {GTK2}.c_g_value_struct_allocate
			{GTK2}.g_value_init_string (Result)
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP)
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
			a_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
			a_pixbuf: POINTER
		do
			pixmap_imp ?= a_pixmap.implementation
			check pixmap_imp /= Void then end
			a_pixbuf := pixmap_imp.pixbuf_from_drawable_with_size (pixmaps_width, pixmaps_height)
			a_list_iter := ev_children.i_th (a_row).list_iter
			check a_list_iter /= Void then end
			{GTK2}.gtk_list_store_set_pixbuf (list_store, a_list_iter.item, 0, a_pixbuf)
			{GTK2}.g_object_unref (a_pixbuf)
		end

	remove_row_pixmap (a_row: INTEGER)
			-- Remove pixmap from `a_row'
		local
			a_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_list_iter := ev_children.i_th (a_row).list_iter
			check a_list_iter /= Void then end
			{GTK2}.gtk_list_store_set_pixbuf (list_store, a_list_iter.item, 0, NULL)
		end

feature {NONE} -- Implementation

	update_child (child: EV_MULTI_COLUMN_LIST_ROW_IMP; a_row: INTEGER)
			-- Update `child'.
		require
			child_exists: child /= Void
		local
			cur: CURSOR
			txt: detachable STRING_32
			list: EV_MULTI_COLUMN_LIST_ROW
			column_counter: INTEGER
		do
			list := child.attached_interface
			cur := list.cursor

			if attached child.pixmap as l_child_pixmap then
				set_row_pixmap (a_row, l_child_pixmap)
			end
			from
				column_counter := 1
				list.start
			until
				column_counter > column_count
			loop
					-- Set the text in the cell
				if list.after then
					txt := Void
				else
					txt := list.item
				end
				if txt = Void then
					create txt.make_empty
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

	ensure_item_visible (a_item: EV_MULTI_COLUMN_LIST_ROW)
			-- Ensure `a_item' is visible on the screen.
		local
			list_item_imp: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
			a_path: POINTER
		do
			list_item_imp ?= a_item.implementation
			check list_item_imp /= Void then end
			l_list_iter := list_item_imp.list_iter
			check l_list_iter /= Void then end
			a_path := {GTK2}.gtk_tree_model_get_path (list_store, l_list_iter.item)
			{GTK2}.gtk_tree_view_scroll_to_cell (tree_view, a_path, NULL, False, 0, 0)
			{GTK2}.gtk_tree_path_free (a_path)
		end

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			item_imp: detachable EV_MULTI_COLUMN_LIST_ROW_IMP
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
		do
			item_imp ?= v.implementation
			check item_imp /= Void end
			if item_imp /= Void then
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
				{GTK2}.gtk_list_store_insert (list_store, a_tree_iter.item, i - 1)
				update_child (item_imp, i)

				if item_imp.is_transport_enabled then
					update_pnd_connection (True)
				end

				child_array.go_i_th (i)
				child_array.put_left (v)
			end
		end

	remove_i_th (a_position: INTEGER)
			-- Remove item from list at `a_position'.
			-- Set the items parent to void.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			item_imp := (ev_children @ (a_position))
			item_imp.set_parent_imp (Void)
			l_list_iter := item_imp.list_iter
			check l_list_iter /= Void end
			if l_list_iter /= Void then
				{GTK2}.gtk_list_store_remove (list_store, l_list_iter.item)
				-- remove the row from the `ev_children'
				ev_children.go_i_th (a_position)
				ev_children.remove
				child_array.go_i_th (a_position)
				child_array.remove
				update_pnd_status
			end
		end

feature -- Access

	row_height: INTEGER
			-- Height of rows in `Current'
		local
			a_column_ptr: POINTER
			a_x, a_y, a_width, a_height: INTEGER
		do
			a_column_ptr := {GTK2}.gtk_tree_view_get_column (tree_view, 0)
			{GTK2}.gtk_tree_view_column_cell_get_size (a_column_ptr, NULL, $a_x, $a_y, $a_width, $a_height)
			Result := a_height
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP} -- Implementation

	expand_column_count_to (a_columns: INTEGER)
			-- Expand the number of columns to `a_columns'
		do
			create_list (a_columns)
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	tree_view: POINTER
		-- Pointer to the View

feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER
			-- Pointer to on-screen interactive widget
		do
			Result := tree_view
		end

	scrollable_area: POINTER
		-- Gtk widget used to scroll tree view

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MULTI_COLUMN_LIST note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_MULTI_COLUMN_LIST_IMP

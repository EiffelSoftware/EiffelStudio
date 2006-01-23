indexing
	description: "[
			A EV_TITLED_WINDOW containing a tree view of application preferences.  Provides a
			list to view preference information and ability to edit the preferences using popup floating widgets.  Also allows
			to restore preferences to their defaults.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_WINDOW

inherit
	PREFERENCES_WINDOW_IMP
		redefine
			destroy
		end

	PREFERENCE_VIEW
		undefine
			copy, default_create
		redefine
			make
		end

	PREFERENCE_CONSTANTS
		undefine
			copy, default_create
		end

create
	make, make_with_hidden

feature {NONE} -- Initialization

	make (a_preferences: like preferences; a_parent_window: like parent_window) is
			-- New view.
		do
			default_create
			Precursor {PREFERENCE_VIEW} (a_preferences, Current)
			root_node_text := "Preferences root"
			set_size (640, 460)
			set_title ("Preferences")
			fill_list
			create grid
			default_row_height := grid.row_height
			grid.disable_row_height_fixed
			grid.enable_single_row_selection
			grid_container.extend (grid)
			grid.set_item (4, 1, Void)
			grid.column (1).set_title (l_name)
			grid.column (2).set_title (l_type)
			grid.column (3).set_title (l_status)
			grid.column (4).set_title (l_literal_value)
			grid.pointer_double_press_item_actions.extend (agent on_grid_item_double_pressed)
			grid.key_press_actions.extend (agent on_grid_key_pressed)
			close_button.select_actions.extend (agent on_close)
			close_request_actions.extend (agent on_close)
			set_default_cancel_button (close_button)
			restore_button.select_actions.extend (agent on_restore)
			split_area.enable_item_expand (grid_container)
			split_area.disable_item_expand (description_frame)
			description_text.key_press_actions.extend (agent on_description_key_pressed)
			resize_actions.force_extend (agent on_window_resize)
			grid.header.pointer_double_press_actions.force_extend (agent on_header_double_clicked)
			grid.header.item_resize_end_actions.force_extend (agent on_header_resize)
			display_update_agent := agent on_preference_changed_externally
		end

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
		end

feature -- Status Setting

	set_show_full_preference_name (a_flag: BOOLEAN) is
			-- Set 'show_full_preference_name'
		do
			show_full_preference_name := a_flag
		end

	set_root_icon (a_icon: EV_PIXMAP) is
			-- Set the root node icon
		require
			icon_not_void: a_icon /= Void
		do
			root_icon := a_icon
		end

	set_folder_icon (a_icon: EV_PIXMAP) is
			-- Set the folder node icon
		require
			icon_not_void: a_icon /= Void
		do
			folder_icon := a_icon
		end

feature {NONE} -- Events

	on_close is
			-- Close button has been pushed: apply the changes then close
			-- the Preferences Window.
		do
			preferences.save_preferences
			hide
		end

	on_preference_changed (a_pref: PREFERENCE) is
			-- Set the preference value to the newly entered value in the edit item.
		local
			l_default_item: EV_GRID_LABEL_ITEM
			l_font_pref: FONT_PREFERENCE
		do
			if not grid.selected_rows.is_empty then
				l_font_pref ?= a_pref
				if l_font_pref /= Void then
					grid.selected_rows.first.set_height (l_font_pref.value.height.max (default_row_height))
				end

				l_default_item ?= grid.selected_rows.first.item (3)

				if a_pref.is_default_value then
					l_default_item.set_text (p_default_value)
					l_default_item.set_font (default_font)
				else
					l_default_item.set_text (user_value)
					l_default_item.set_font (non_default_font)
				end

				if a_pref.is_auto then
					l_default_item.set_text (l_default_item.text + " (" + auto_value + ")")
				end
			end
		end

	on_preference_changed_externally (a_pref: PREFERENCE) is
			-- Set the preference value to the newly entered value NOT changed in the edit item.
		do
			if grid.row_count > 0 then
				rebuild_right_list
			end
		end

	set_preference_to_default (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE) is
			-- Set the preference value to the original default.
		local
			l_text_item: EV_GRID_EDITABLE_ITEM
			l_combo_item: EV_GRID_COMBO_ITEM
			l_label_item: EV_GRID_LABEL_ITEM
			l_color_item: EV_GRID_DRAWABLE_ITEM
			l_font: FONT_PREFERENCE
		do
			a_pref.reset
			a_item.set_text (p_default_value)
			a_item.set_font (default_font)
			if a_pref.is_auto then
				a_item.set_text (a_item.text + " (" + auto_value + ")")
			end

			l_text_item ?= a_item.row.item (4)
			if l_text_item /= Void then
					-- Editable text item
				l_text_item.set_text (a_pref.string_value)
			else
				l_combo_item ?= a_item.row.item (4)
				if l_combo_item /= Void then
						-- Combo selectable item
					l_combo_item.set_text (a_pref.string_value)
				else
					l_color_item ?= a_item.row.item (4)
					if l_color_item /= Void then
							-- Color drawable item
						l_color_item.redraw
					else
						l_label_item ?= a_item.row.item (1)
						if l_label_item /= Void and then a_pref.generating_preference_type.is_equal ("FONT") then
								-- Font label item
							l_font ?= a_pref
							l_label_item ?= a_item.row.item (4)
							l_label_item.set_text (l_font.string_value)
							l_label_item.set_font (l_font.value)
						end
					end
				end
			end
		end

	on_restore is
			-- Restore all preferences to their default values.
		local
			l_confirmation_dialog: EV_CONFIRMATION_DIALOG
		do
			create l_confirmation_dialog
			l_confirmation_dialog.set_text ("This will reset ALL preferences to their default values%N%
				% and all previous settings will be overwritten.  Are you sure?")
			l_confirmation_dialog.show_modal_to_window (parent_window)
			if l_confirmation_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				preferences.restore_defaults
				if selected_preference_name /= Void then
					fill_right_list (selected_preference_name)
				end
			end
		end

	on_default_item_selected (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- The default cloumn was clicked.
		local
			l_popup_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
			l_pref: PREFERENCE
		do
			if not a_pref.is_default_value and then a_button = 3 then
					-- Extract `l_pref' from row data.
				l_pref ?= a_item.row.data

					-- Show the menu only if necessary (that is to say, the preference value is different from the default one)
				if l_pref /= Void and then l_pref = a_pref and then l_pref.has_default_value then
						-- Ensure that before showing the menu, the row gets selected.
					grid.remove_selection
					a_item.row.enable_select

						-- The right clicked preference matches the selection in the grid
					create l_popup_menu
					create l_menu_item.make_with_text ("Restore Default")
					l_menu_item.select_actions.extend (agent set_preference_to_default (a_item, a_pref))
					l_popup_menu.extend (l_menu_item)
					l_popup_menu.show
				end
			end
		end

	on_grid_item_double_pressed (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM) is
			-- An item was double pressed
		local
			l_col_index: INTEGER
			l_bool_preference: BOOLEAN_PREFERENCE
			l_combo_widget: EV_GRID_COMBO_ITEM
		do
			if a_item /= Void then
				l_col_index := a_item.column.index
				if l_col_index = 1 or l_col_index = 2 or l_col_index = 3 then
					l_bool_preference ?= a_item.row.data
					if l_bool_preference /= Void then
						l_combo_widget ?= a_item.row.item (4)
						l_combo_widget.set_text ((not l_bool_preference.value).out)
						l_combo_widget.deactivate_actions.call ([])
					end
				end
			end
		end

	on_grid_key_pressed (k: EV_KEY) is
			-- An key was pressed
		local
			l_preference_widget: PREFERENCE_WIDGET
		do
			if k /= Void then
				if k.code = {EV_KEY_CONSTANTS}.key_enter then
					if not grid.selected_rows.is_empty then
						l_preference_widget ?= grid.selected_rows.first.item (4).data
						if l_preference_widget /= Void then
							l_preference_widget.show
						end
					end
				end
			end
		end

	on_description_key_pressed (a_key: EV_KEY) is
			-- Description text area was key pressed
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_tab then
				if application.shift_pressed then
					grid.set_focus
				else
					restore_button.set_focus
				end
			end
		end

	on_window_resize is
			-- Dialog was resized
		local
			l_width: INTEGER
		do
			l_width := grid.width - (grid.column (1).width + grid.column (2).width + grid.column (3).width)
			if not resized_columns_list.item (4) then
				grid.column (4).set_width (l_width)
			end
		end

	on_header_double_clicked is
			-- Header was double-clicked.
		local
			div_index: INTEGER
			col: EV_GRID_COLUMN
		do
			div_index := grid.header.pointed_divider_index
			if div_index > 0 then
				col := grid.column (div_index)
				col.set_width (col.required_width_of_item_span (1, col.parent.row_count) + column_border_space)
			end
		end

	on_header_resize is
			-- Header was double-clicked.
		local
			div_index: INTEGER
			col: EV_GRID_COLUMN
		do
			div_index := grid.header.pointed_divider_index
			if div_index > 0 then
				col := grid.column (div_index)
				resized_columns_list.put (True, col.index)
			end
		end

feature {NONE} -- Implementation

	fill_list is
			-- Fill left tree.
		local
 			it,
 			l_parent: EV_TREE_ITEM
			l_pref_hash: HASH_TABLE [EV_TREE_ITEM, STRING]
			l_known_pref_hash: HASH_TABLE [PREFERENCE, STRING]
			l_pref_name,
			l_pref_parent_name,
			l_pref_parent_full_name,
			l_prev_parent_name,
			l_pref_parent_short_name: STRING
			l_node_count,
			l_index: INTEGER

			l_sorted_preferences: SORTED_TWO_WAY_LIST [STRING]
			l_split_string: LIST [STRING]
		do
				-- Retrieve known preferences
			l_known_pref_hash := preferences.preferences

			if not l_known_pref_hash.is_empty then
				create l_pref_hash.make (l_known_pref_hash.count)

					-- Alphabetically sort the known preferences
				create l_sorted_preferences.make
				l_sorted_preferences.compare_objects
				l_sorted_preferences.append (create {ARRAYED_LIST [STRING]}.make_from_array (l_known_pref_hash.current_keys))
				l_sorted_preferences.sort

					-- Generate a root node
				create it.make_with_text (formatted_name (root_node_text))
				if root_icon /= Void then
					it.set_pixmap (root_icon)
				end
				it.select_actions.extend (agent clear_edit_widget)
				it.select_actions.extend (agent fill_right_list (root_node_text))
				l_pref_hash.put (it, root_node_text)
				left_list.extend (it)

					-- Traverse the preferences in the system
				from
					l_sorted_preferences.finish
				until
					l_sorted_preferences.before
				loop
					l_pref_name := l_sorted_preferences.item
					l_pref_hash.put (it, l_pref_name)
					if l_pref_name.has ('.') then
						  -- Build parent nodes	as this preference is of the form 'a.b.c' so we must build 'a' and 'b'.
						l_pref_parent_full_name := l_pref_name.substring (1, l_pref_name.last_index_of ('.', l_pref_name.count) - 1)
						if l_pref_parent_full_name.has ('.') then
							from
								l_split_string := l_pref_parent_full_name.split ('.')
								l_node_count := 0
								l_index := 1
								create l_pref_parent_name.make_empty
							until
								l_node_count = l_split_string.count
							loop
								l_pref_parent_short_name := l_split_string.i_th (l_index)

								if not l_pref_parent_name.is_empty then
									l_pref_parent_name.extend ('.')
								end
								l_pref_parent_name.append (l_pref_parent_short_name)
								l_index := l_index + 1
								create l_parent.make_with_text (formatted_name (l_pref_parent_short_name))
								if folder_icon /= Void then
									l_parent.set_pixmap (folder_icon)
								end
								l_parent.select_actions.extend (agent clear_edit_widget)
								l_parent.select_actions.extend (agent fill_right_list (l_pref_parent_name.twin))
								if not l_pref_hash.has (l_pref_parent_name) then
									l_pref_hash.put (l_parent, l_pref_parent_name.twin)
									if l_prev_parent_name /= Void then
										l_pref_hash.item (l_prev_parent_name).put_front (l_parent)
									else
										l_pref_hash.item (root_node_text).put_front (l_parent)
									end
								end
								l_prev_parent_name := l_pref_parent_name.twin
								l_node_count := l_node_count + 1
							end
						else
								-- We reach the end of building parent, so here we build 'a'.
							if not l_pref_hash.has (l_pref_parent_full_name) then
								create l_parent.make_with_text (formatted_name (l_pref_parent_full_name))
								if folder_icon /= Void then
									l_parent.set_pixmap (folder_icon)
								end
								l_parent.select_actions.extend (agent clear_edit_widget)
								l_parent.select_actions.extend (agent fill_right_list (l_pref_parent_full_name.twin))
								l_pref_hash.put (l_parent, l_pref_parent_full_name.twin)
								l_pref_hash.item (root_node_text).put_front (l_parent)
								l_prev_parent_name := Void
							end
						end
					elseif not l_pref_hash.has (l_pref_name) then
							-- Add as child to root node
						create it.make_with_text (formatted_name (l_pref_name))
						if folder_icon /= Void then
							it.set_pixmap (folder_icon)
						end
						it.select_actions.extend (agent clear_edit_widget)
						it.select_actions.extend (agent fill_right_list (l_pref_name.twin))
						l_pref_hash.item (root_node_text).put_front (it)
					end
					l_sorted_preferences.back
				end
			end
		end

	fill_right_list (a_pref_name: STRING) is
			-- Fill right list.
		require
			pref_name_not_void: a_pref_name /= Void
			pref_name_not_empty: not a_pref_name.is_empty
		local
			l_names: SORTED_TWO_WAY_LIST [STRING]
			l_pref_name: STRING
			grid_name_item,
			grid_default_item,
			grid_type_item: EV_GRID_LABEL_ITEM
			l_preference: PREFERENCE
			curr_row: INTEGER
			l_column: EV_GRID_COLUMN
		do
			grid.enable_row_height_fixed
			grid.disable_row_height_fixed
			selected_preference_name := a_pref_name
			wipe_out_visible_preference_change_action
			visible_preferences.wipe_out

				-- Retrieve known preferences
			create l_names.make

			l_names.append (create {ARRAYED_LIST [STRING]}.make_from_array (preferences.preferences.current_keys))
			l_names.sort
			from
				l_names.start
				grid_remove_and_clear_all_rows (grid)
				description_text.set_text ("")
				curr_row := 1
			until
				l_names.after
			loop
				l_pref_name := l_names.item
				if should_display_preference (l_pref_name, a_pref_name) and l_pref_name.count > a_pref_name.count then
					l_preference := preferences.preferences.item (l_pref_name)

					if show_hidden_preferences or (not show_hidden_preferences and then not l_preference.is_hidden) then

						check
							preference_not_void: l_preference /= Void
						end

						if l_preference.name /= Void then
							create grid_name_item
							grid.set_item (1, curr_row, grid_name_item)
							if show_full_preference_name then
								grid_name_item.set_text (l_preference.name)
							else
								grid_name_item.set_text (formatted_name (short_preference_name (l_preference.name)))
							end
						else
							grid_name_item.set_text ("")
						end
						add_preference_change_item (l_preference, curr_row)
						l_preference.change_actions.extend (display_update_agent)
						grid.row (curr_row).set_data (l_preference)
						grid.row (curr_row).select_actions.extend (agent show_preference_description (l_preference))
						create grid_default_item
						grid_default_item.pointer_button_press_actions.extend (agent on_default_item_selected (grid_default_item, l_preference, ?, ?, ?, ?, ?, ?, ?, ?))
						grid.set_item (3, curr_row, grid_default_item)
						if l_preference.is_default_value then
							grid_default_item.set_text (p_default_value)
							grid_default_item.set_font (default_font)
						else
							grid_default_item.set_text (user_value)
							grid_default_item.set_font (non_default_font)
						end
						if l_preference.is_auto then
							grid_default_item.set_text (grid_default_item.text + " (" + auto_value + ")")
						end
						create grid_type_item
						grid_type_item.set_text (l_preference.string_type)
						grid.set_item (2, curr_row, grid_type_item)
						visible_preferences.extend (l_preference)
						curr_row := curr_row + 1
					end
				end
				l_names.forth
			end
			if grid.row_count > 0 then
				grid.row (1).enable_select
				l_column := grid.column (1)
				if not resized_columns_list.item (1) then
					l_column.resize_to_content
					l_column.set_width (l_column.width + column_border_space)
				end
				l_column := grid.column (2)
				if not resized_columns_list.item (2) then
					l_column.resize_to_content
					l_column.set_width (l_column.width + column_border_space)
				end
				l_column := grid.column (3)
				if not resized_columns_list.item (3) then
					l_column.resize_to_content
					l_column.set_width (l_column.width + column_border_space)
				end
				on_window_resize
				l_preference ?= grid.row (1).data
				if l_preference /= Void then
					show_preference_description (l_preference)
				end
			end
		end

	rebuild_right_list is
			-- Rebuild right list.  This is used to update the values shown for the currently visible preferences
			-- in case they have been changed external to this window.
		local
			grid_default_item,
			grid_value_label_item: EV_GRID_LABEL_ITEM
			grid_value_drawable_item: EV_GRID_DRAWABLE_ITEM
			l_preference: PREFERENCE
			curr_row: INTEGER
		do
			from
				visible_preferences.start
				curr_row := 1
			until
				visible_preferences.after
			loop
				l_preference := visible_preferences.item
				grid_default_item ?= grid.row (curr_row).item (3)
				if grid_default_item /= Void and then l_preference.is_default_value then
					grid_default_item.set_text (p_default_value)
					grid_default_item.set_font (default_font)
				else
					grid_default_item.set_text (user_value)
					grid_default_item.set_font (non_default_font)
				end
				if l_preference.is_auto then
					grid_default_item.set_text (grid_default_item.text + "(" + auto_value + ")")
				end
				grid_value_label_item ?= grid.row (curr_row).item (4)
				if grid_value_label_item /= Void then
					grid_value_label_item.set_text (l_preference.string_value)
				else
					grid_value_drawable_item ?= grid.row (curr_row).item (4)
					if grid_value_drawable_item /= Void then
						grid_value_drawable_item.redraw
					end
				end
				curr_row := curr_row + 1

				visible_preferences.forth
			end
		end

	should_display_preference (a_pref_name, b_pref_name: STRING): BOOLEAN is
			-- Should we display the preference in the right list?
		do
			Result := a_pref_name.substring (1, b_pref_name.count).is_equal (b_pref_name)
			if Result then
				Result := not (a_pref_name.substring (b_pref_name.count + 2, a_pref_name.count).has ('.'))
			end
		end

	wipe_out_visible_preference_change_action is
			-- Wipe out the change action setup to notify Current about a change from outside
		do
			from
				visible_preferences.start
			until
				visible_preferences.after
			loop
				visible_preferences.item.change_actions.prune_all (display_update_agent)
				visible_preferences.forth
			end
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy.
		do
			Precursor
		end

	pixmap_file_contents (pn: STRING): EV_PIXMAP is
			-- Load a pixmap in file named `pn'.
		require
			valid_file_name: pn /= Void
		local
			retried: BOOLEAN
			fullp: FILE_NAME
		do
			create Result
			if not retried then
				create fullp.make_from_string (pixmaps_path_cell.item)
				fullp.set_file_name (pn)
				fullp.add_extension (pixmaps_extension_cell.item)
				Result.set_with_named_file (fullp)
			end
		rescue
			retried := True
			retry
		end

	show_preference_description (a_preference: PREFERENCE) is
			-- Show selected list preference in edit widget.
		require
			preference_not_void: a_preference /= Void
		local
			l_text: STRING
		do
			if a_preference.description /= Void then
				l_text := a_preference.description
			else
				l_text := no_description_text
			end

			if a_preference.restart_required then
				description_text.set_text (l_text + once " (REQUIRES RESTART)")
			else
				description_text.set_text (l_text)
			end
		end

	add_preference_change_item (l_preference: PREFERENCE; row_index: INTEGER) is
			-- Add the correct preference change widget item at `row_index' of `grid'.
		local
			l_bool: BOOLEAN_PREFERENCE
			l_font: FONT_PREFERENCE
			l_color: COLOR_PREFERENCE
			l_array: ARRAY_PREFERENCE
			l_shortcut: SHORTCUT_PREFERENCE

			l_bool_widget: BOOLEAN_PREFERENCE_WIDGET
			l_edit_widget: STRING_PREFERENCE_WIDGET
			l_choice_widget: CHOICE_PREFERENCE_WIDGET
			l_font_widget: FONT_PREFERENCE_WIDGET
			l_color_widget: COLOR_PREFERENCE_WIDGET
			l_shortcut_widget: SHORTCUT_PREFERENCE_WIDGET
		do
			l_bool ?= l_preference
			if l_bool /= Void then
					-- Boolean
				create l_bool_widget.make_with_preference (l_bool)
				l_bool_widget.change_actions.extend (agent on_preference_changed)
				grid.set_item (4, row_index, l_bool_widget.change_item_widget)
				grid.item (4, row_index).set_data (l_bool_widget)
			else
				if l_preference.generating_preference_type.is_equal ("TEXT") then
					create l_edit_widget.make_with_preference (l_preference)
					l_edit_widget.change_actions.extend (agent on_preference_changed)
					grid.set_item (4, row_index, l_edit_widget.change_item_widget)
					grid.item (4, row_index).set_data (l_edit_widget)
				elseif l_preference.generating_preference_type.is_equal ("COMBO") then
					l_array ?= l_preference
					if l_array /= Void then
							-- Choice
						create l_choice_widget.make_with_preference (l_array)
						l_choice_widget.change_actions.extend (agent on_preference_changed)
						grid.set_item (4, row_index, l_choice_widget.change_item_widget)
						grid.item (4, row_index).set_data (l_choice_widget)
					end
				else
					l_font ?= l_preference
					if l_font /= Void then
							-- Font
						create l_font_widget.make_with_preference (l_font)
						l_font_widget.change_actions.extend (agent on_preference_changed)
						l_font_widget.set_caller (Current)
						grid.set_item (4, row_index, l_font_widget.change_item_widget)
						grid.item (4, row_index).set_data (l_font_widget)
						grid.row (row_index).set_height (l_font.value.height.max (default_row_height))
					else
						l_color ?= l_preference
						if l_color /= Void then
								-- Color
							create l_color_widget.make_with_preference (l_color)
							l_color_widget.change_actions.extend (agent on_preference_changed)
							l_color_widget.set_caller (Current)
							grid.set_item (4, row_index, l_color_widget.change_item_widget)
							grid.item (4, row_index).set_data (l_color_widget)
						else
							l_shortcut ?= l_preference
							if l_shortcut /= Void then
									-- Shortcut
								create l_shortcut_widget.make_with_preference (l_shortcut)
								l_shortcut_widget.change_actions.extend (agent on_preference_changed)
								grid.set_item (4, row_index, l_shortcut_widget.change_item_widget)
								grid.item (4, row_index).set_data (l_shortcut_widget)
							end
						end
					end
				end
			end
		end

	clear_edit_widget is
			-- Clear the edit widget
		do
			description_text.set_text ("")
		end

	short_preference_name (a_name: STRING): STRING is
			-- The short, non-unique name of a preference
		require
			name_not_void: a_name /= Void
		do
			Result := a_name.substring (a_name.last_index_of ('.', a_name.count) + 1, a_name.count)
		end

	formatted_name (a_name: STRING): STRING is
			-- Formatted name for display
		do
			create Result.make_from_string (a_name)
			Result.replace_substring_all ("_", " ")
			Result.replace_substring (Result.item (1).upper.out, 1, 1)
		end

	grid_remove_and_clear_all_rows (g: EV_GRID) is
		require
			g /= Void
		local
			rc: INTEGER
		do
			from
				rc := g.row_count
			until
				rc = 0
			loop
				g.row (rc).set_data (Void)
				g.row (rc).clear
				g.remove_row (rc)
				rc := g.row_count
			end
			g.clear
		ensure
			g.row_count = 0
			g.selected_rows.count = 0
		end

	visible_preferences: ARRAYED_LIST [PREFERENCE] is
			-- List of the preferences currently in view.
		once
			create Result.make (10)
		end

feature {NONE} -- Private attributes

	show_full_preference_name: BOOLEAN
			-- Show the full name of the preference in the list?

	root_node_text: STRING
			-- Text for the top level node.

	selected_preference_name: STRING
			-- Name of preference selected in tree.  Used to programatically to update the right-side list.

	root_icon: EV_PIXMAP
			-- Icon for root node

	folder_icon: EV_PIXMAP
			-- Folder icon

	default_font: EV_FONT is
			-- Font for row when value is a default value
		once
			create Result
		end

	non_default_font: EV_FONT is
			-- Font for row when value is not a default value
		once
			create Result
			Result.set_weight ((create {EV_FONT_CONSTANTS}).weight_bold)
		end

	grid: EV_GRID
		-- Grid	

	column_border_space: INTEGER is 3
		-- Padding space for column content

	default_row_height: INTEGER
		-- Default row height

	display_update_agent: PROCEDURE [ANY, TUPLE [PREFERENCE]]
			-- Agent to be called when preference is changed outside	

	resized_columns_list: ARRAY [BOOLEAN] is
			-- List of boolean s for each column indicating if it has been user resizedat all.
		once
			Result := <<False, False, False, False>>
		end

	application: EV_APPLICATION is
			-- Application
		once
			Result := (create {EV_ENVIRONMENT}).application
		end

invariant
	has_preferences: preferences /= Void

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




end -- class PREFERENCES_GRID_WINDOW


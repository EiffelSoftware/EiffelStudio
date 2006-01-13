indexing
	description: "[
			A EV_TITLED_WINDOW containing a tree view of application preferences.  Provides a
			list to view preference information and ability to edit the preferences using popup floating widgets.  Also allows
			to restore preferences to their defaults.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_GRID

inherit
	PREFERENCES_GRID_IMP
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
			set_size (640, 460)
			set_title (preferences_title)
			create grid
			default_row_height := grid.row_height
			grid.enable_single_row_selection
			grid_container.extend (grid)
			grid.set_item (4, 1, Void)
			grid.column (1).set_title (l_name)
			grid.column (2).set_title (l_type)
			grid.column (3).set_title (l_status)
			grid.column (4).set_title (l_literal_value)
			grid.pointer_double_press_item_actions.extend (agent on_grid_item_double_pressed)
			grid.key_press_actions.extend (agent on_grid_key_pressed)
			enable_tree_view

				-- Agents
			close_button.select_actions.extend (agent on_close)
			close_request_actions.extend (agent on_close)
			restore_button.select_actions.extend (agent on_restore)
			description_text.key_press_actions.extend (agent on_description_key_pressed)
			resize_actions.force_extend (agent on_window_resize)
			grid.header.pointer_double_press_actions.force_extend (agent on_header_double_clicked)
			grid.header.item_resize_end_actions.force_extend (agent on_header_resize)
			display_update_agent := agent on_preference_changed_externally
			view_toggle_button.select_actions.extend (agent toggle_view)
		end

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			acc: EV_ACCELERATOR
		do
				--| Toggle hidden preferences display on/off
			create acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_h), True, False, True)
			acc.actions.extend (agent toggle_hiddens)
			accelerators.extend (acc)

				--| Ctrl+Tab -> toggle flat/structured
			create acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_tab), True, False, False)
			acc.actions.extend (agent toggle_view)
			accelerators.extend (acc)

				--| When escape is press, close the dialog
			set_default_cancel_button (close_button)

				--| Make sure to have the grid focused when dialog is shown
				--| this way, we can use only keyboard.
			show_actions.extend (agent on_show)

				--|
			filter_text_box.change_actions.extend (agent request_update_matches)

		end

feature -- Status Setting

	set_show_full_resource_name (a_flag: BOOLEAN) is
			-- Set 'show_full_resource_name'
		do
			show_full_resource_name := a_flag
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

	on_show is
		do
			if grid.is_displayed then
				grid.set_focus
			end
		end

	on_close is
			-- Close button has been pushed: apply the changes then close
			-- the Preferences Window.
		do
			preferences.save_preferences
			hide
		end

	on_preference_changed (a_pref: PREFERENCE) is
			-- Set the resource value to the newly entered value in the edit item.
		local
			l_row: EV_GRID_ROW
		do
			if not grid.selected_rows.is_empty then
				l_row := grid.selected_rows.first
				preference_changed_on_row (a_pref, l_row, False)
			end
		end

	preference_changed_on_row (a_pref: PREFERENCE; a_row: EV_GRID_ROW; a_update_value: BOOLEAN) is
			-- Set the resource value to the newly entered value in the edit item.
		local
			l_default_item: EV_GRID_LABEL_ITEM
			l_selected_row: EV_GRID_ROW
		do
			if not grid.selected_rows.is_empty then
				l_selected_row := grid.selected_rows.first
			end

			l_default_item ?= a_row.item (3)

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

			if a_update_value then
				a_row.set_item (4, preference_value_column (a_pref))
			end

			if l_selected_row.parent /= Void and then not l_selected_row.is_selected then
				l_selected_row.enable_select
			end
		end

	on_preference_changed_externally (a_pref: PREFERENCE) is
			-- Set the resource value to the newly entered value NOT changed in the edit item.
		local
			nb: INTEGER
			r: INTEGER
			l_row: EV_GRID_ROW
			l_pref: PREFERENCE
		do
			nb := grid.row_count
			if nb > 0 then
					--| Find the parent row
				from
					r := 1
				until
					r > nb or l_row /= Void
				loop
					l_pref ?= grid.row (r).data
					if l_pref /= Void and then l_pref.name.is_equal (a_pref.name) then
						l_row := grid.row (r)
						preference_changed_on_row (a_pref, l_row, True)
					end
					r := r + 1
				end
				--rebuild
			end
		end

	set_resource_to_default (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE) is
			-- Set the resource value to the original default.
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
						if l_label_item /= Void and then a_pref.generating_resource_type.is_equal ("FONT") then
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
			l_confirmation_dialog.set_text (restore_preference_string)
			l_confirmation_dialog.show_modal_to_window (parent_window)
			if l_confirmation_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				preferences.restore_defaults
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
					l_menu_item.select_actions.extend (agent set_resource_to_default (a_item, a_pref))
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
			l_pref: PREFERENCE
			l_preference_widget: PREFERENCE_WIDGET
			l_row: EV_GRID_ROW
		do
			if k /= Void then
				if k.code = {EV_KEY_CONSTANTS}.key_enter then
					if not grid.selected_rows.is_empty then
						l_row :=  grid.selected_rows.first
						l_pref ?= l_row.data
						if l_pref /= Void then
							check l_row.count >= 4 end
							if l_row.count >= 4 and then l_row.item (4) /= Void then
								l_preference_widget ?= l_row.item (4).data
								if l_preference_widget /= Void then
									l_preference_widget.show
								end
							end
						elseif l_row.is_expandable then
							if l_row.is_expanded then
								l_row.collapse
							else
								l_row.expand
							end
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
				grid.column (4).set_width (l_width.max (0))
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

	build_structured is
			-- Fill with preferences structured hierarchically.
		local
			l_pref_hash: HASH_TABLE [EV_GRID_ROW, STRING]
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
			l_row: EV_GRID_ROW
			l_grid_label: EV_GRID_LABEL_ITEM
			l_pref: PREFERENCE
		do
			status_label.set_text ("Building tree view ...")
			status_label.refresh_now

				-- Retrieve known preferences
			l_known_pref_hash := preferences.preferences

			if not l_known_pref_hash.is_empty then
				create l_pref_hash.make (l_known_pref_hash.count)

					-- Alphabetically sort the known preferences
				create l_sorted_preferences.make
				l_sorted_preferences.compare_objects
				l_sorted_preferences.append (create {ARRAYED_LIST [STRING]}.make_from_array (l_known_pref_hash.current_keys))
				l_sorted_preferences.sort

					-- Traverse the preferences in the system
				from
					l_sorted_preferences.finish
				until
					l_sorted_preferences.before
				loop
					l_pref_name := l_sorted_preferences.item
					if l_pref_name.has ('.') then
						  -- Build parent nodes	as this preference is of the form 'a.b.c' so we must build 'a' and 'b'.
						l_pref_parent_full_name := l_pref_name.substring (1, l_pref_name.last_index_of ('.', l_pref_name.count) - 1)
						if l_pref_parent_full_name.has ('.') then
							if not l_pref_hash.has (l_pref_parent_full_name) then
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

									if not l_pref_hash.has (l_pref_parent_name) then
											-- New parent node										
										create l_grid_label.make_with_text (formatted_name (l_pref_parent_short_name))
										if grid.row_count < 1 then
											grid.set_item (1, grid.row_count + 1, l_grid_label)
											grid.row (1).expand_actions.extend (agent node_expanded (l_row))
										else
											if l_prev_parent_name /= Void then
												l_row := l_pref_hash.item (l_prev_parent_name)
												l_row.insert_subrow (l_row.subrow_count + 1)
--												l_row.expand_actions.extend (agent node_expanded (l_row))
												l_row := l_row.subrow (l_row.subrow_count)
												l_row.set_item (1, l_grid_label)
											else
												grid.set_item (1, grid.row_count + 1, l_grid_label)
												l_row := grid.row (grid.row_count)
												l_row.expand_actions.extend (agent node_expanded (l_row))
											end
										end
										if folder_icon /= Void then
											l_grid_label.set_pixmap (folder_icon)
										end
										l_pref_hash.put (grid.row (grid.row_count), l_pref_parent_name.twin)
									end
									l_prev_parent_name := l_pref_parent_name.twin
									l_node_count := l_node_count + 1
								end
							end
						end
						if not l_pref_hash.has (l_pref_parent_full_name) then
								-- Here we build parent at root, i.e. 'a' of 'a.b', and child 'b'.
							l_pref := l_known_pref_hash.item (l_pref_name.twin)
							if l_pref /= Void and then show_hidden_preferences or (not show_hidden_preferences and then not l_pref.is_hidden) then
								create l_grid_label.make_with_text (formatted_name (l_pref_parent_full_name))
								grid.set_item (1, grid.row_count + 1, l_grid_label)
								l_row := grid.row (grid.row_count)
								l_row.expand_actions.extend (agent node_expanded (l_row))
								l_pref_hash.put (grid.row (grid.row_count), l_pref_parent_full_name.twin)
								add_preference_row (l_row, l_pref)
								l_pref_hash.put (grid.row (grid.row_count), l_pref_name.twin)
								if folder_icon /= Void then
									l_grid_label.set_pixmap (folder_icon)
								end
							end
							l_prev_parent_name := Void
						else
								-- We reach the end of building parent, so here we build 'c'.
							l_pref := l_known_pref_hash.item (l_pref_name.twin)
							if l_pref /= Void and then show_hidden_preferences or (not show_hidden_preferences and then not l_pref.is_hidden) then
								l_row ?= l_pref_hash.item (l_pref_parent_full_name)
								create l_grid_label.make_with_text (formatted_name (short_resource_name (l_pref_name.twin)))
								add_preference_row (l_row, l_pref)
								l_row.expand_actions.extend (agent node_expanded (l_row))
							end
							l_pref_hash.put (l_row, l_pref_name.twin)
						end
					elseif not l_pref_hash.has (l_pref_name) then
							-- Add as child to root node
						create l_grid_label.make_with_text (formatted_name (l_pref_name))
						grid.set_item (1, grid.row_count + 1, l_grid_label)

						if folder_icon /= Void then
							l_grid_label.set_pixmap (folder_icon)
						end
					end
					l_sorted_preferences.back
				end
				update_grid_columns
			end
		end

	build_flat is
			-- Fill with preferences no structure, flat list.
		local
			l_known_pref_hash: HASH_TABLE [PREFERENCE, STRING]
			l_pref_name: STRING
			l_sorted_preferences: SORTED_TWO_WAY_LIST [STRING]
			l_pref: PREFERENCE
		do
			status_label.set_text ("Building flat view ...")
			status_label.refresh_now

			grid_remove_and_clear_all_rows (grid)

				-- Retrieve known preferences				
			l_known_pref_hash := preferences.preferences

			if not l_known_pref_hash.is_empty then

					-- Alphabetically sort the known preferences
				create l_sorted_preferences.make
				l_sorted_preferences.compare_objects
				l_sorted_preferences.append (create {ARRAYED_LIST [STRING]}.make_from_array (l_known_pref_hash.current_keys))
				l_sorted_preferences.sort

					-- Traverse the preferences in the system and add to grid list
				from
					l_sorted_preferences.start
				until
					l_sorted_preferences.after
				loop
					l_pref_name := l_sorted_preferences.item
					l_pref := l_known_pref_hash.item (l_pref_name)
					if show_hidden_preferences or (not show_hidden_preferences and then not l_pref.is_hidden) then
						add_preference_row (Void, l_pref)
					end
					l_sorted_preferences.forth
				end
				update_grid_columns
			end
		end

	rebuild is
			-- Rebuild entire grid
		do
			grid.clear
			grid.set_row_count_to (0)
			if grid.is_tree_enabled then
				build_structured
			else
				build_flat
			end
			update_status_bar
		end

	add_preference_row (a_row: EV_GRID_ROW; a_pref: PREFERENCE) is
			-- Add a preference as a new row display in parent `a_row'.  If `a_row' is
			-- Void then add to end of `grid'.
		require
			pref_name_not_void: a_pref /= Void
			can_show: show_hidden_preferences or (not show_hidden_preferences and then not a_pref.is_hidden)
		local
			l_row: EV_GRID_ROW
		do
--			grid.enable_row_height_fixed
--			grid.disable_row_height_fixed
--			selected_resource_name := a_pref_name
--			wipe_out_visible_preference_change_action
--			visible_preferences.wipe_out	

				-- Create row
			if a_row = Void then
				grid.insert_new_row (grid.row_count + 1)
				l_row := grid.row (grid.row_count)
			else
				a_row.insert_subrow (a_row.subrow_count + 1)
				l_row := a_row.subrow (a_row.subrow_count)
			end
			if not a_pref.change_actions.has (display_update_agent) then
				a_pref.change_actions.extend (display_update_agent)
			end
			l_row.set_data (a_pref)
			l_row.select_actions.extend (agent show_resource_description (a_pref))

				-- Add Items
			l_row.set_item (1, preference_name_column (a_pref))
			l_row.set_item (2, preference_type_column (a_pref))
			l_row.set_item (3, preference_status_column (a_pref))
			l_row.set_item (4, preference_value_column (a_pref))
			if a_pref.is_hidden then
				l_row.item (1).set_foreground_color (hidden_fg_color)
			end
		end

	node_expanded (a_row: EV_GRID_ROW) is
			-- Row was expanded to show children
		local
			l_column: EV_GRID_COLUMN
		do
			l_column := grid.column (1)
			if l_column.required_width_of_item_span (1, grid.row_count) > l_column.width then
				l_column.resize_to_content
				l_column.set_width (l_column.width + column_border_space)
			end
		end

	preference_name_column (a_pref: PREFERENCE): EV_GRID_LABEL_ITEM is
			--
		do
			if a_pref.name /= Void then
				create Result
				if show_full_resource_name then
					Result.set_text (a_pref.name)
				else
					Result.set_text (formatted_name (short_resource_name (a_pref.name)))
				end
			else
				Result.set_text ("")
			end
		end

	preference_type_column (a_pref: PREFERENCE): EV_GRID_LABEL_ITEM is
			--
		do
			create Result
			Result.set_text (a_pref.string_type)
		end

	preference_status_column (a_pref: PREFERENCE): EV_GRID_LABEL_ITEM is
			--
		do
			create Result
			Result.pointer_button_press_actions.extend (agent on_default_item_selected (Result, a_pref, ?, ?, ?, ?, ?, ?, ?, ?))
			if a_pref.is_default_value then
				Result.set_text (p_default_value)
				Result.set_font (default_font)
			else
				Result.set_text (user_value)
				Result.set_font (non_default_font)
			end
			if a_pref.is_auto then
				Result.set_text (Result.text + " (" + auto_value + ")")
			end
		end

	preference_value_column (a_pref: PREFERENCE): EV_GRID_ITEM is
			--
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
			l_bool ?= a_pref
			if l_bool /= Void then
				create l_bool_widget.make_with_resource (l_bool)
				l_bool_widget.change_actions.extend (agent on_preference_changed)
				Result := l_bool_widget.change_item_widget
				Result.set_data (l_bool_widget)
			else
				if a_pref.generating_resource_type.is_equal ("TEXT") then
					create l_edit_widget.make_with_resource (a_pref)
					l_edit_widget.change_actions.extend (agent on_preference_changed)
					Result := l_edit_widget.change_item_widget
					Result.set_data (l_edit_widget)
				elseif a_pref.generating_resource_type.is_equal ("COMBO") then
					l_array ?= a_pref
					if l_array /= Void then
						create l_choice_widget.make_with_resource (l_array)
						l_choice_widget.change_actions.extend (agent on_preference_changed)
						Result := l_choice_widget.change_item_widget
						Result.set_data (l_choice_widget)
					end
				else
					l_font ?= a_pref
					if l_font /= Void then
						create l_font_widget.make_with_resource (l_font)
						l_font_widget.change_actions.extend (agent on_preference_changed)
						l_font_widget.set_caller (Current)
						l_font := l_font.twin
						Result := l_font_widget.change_item_widget
						Result.set_data (l_font_widget)
--						a_row.set_height (l_font.value.height.max (default_row_height))
					else
						l_color ?= a_pref
						if l_color /= Void then
							create l_color_widget.make_with_resource (l_color)
							l_color_widget.change_actions.extend (agent on_preference_changed)
							l_color_widget.set_caller (Current)
							Result := l_color_widget.change_item_widget
							Result.set_data (l_color_widget)
						else
							l_shortcut ?= a_pref
							if l_shortcut /= Void then
								create l_shortcut_widget.make_with_resource (l_shortcut)
								l_shortcut_widget.change_actions.extend (agent on_preference_changed)
								Result := l_shortcut_widget.change_item_widget
								Result.set_data (l_shortcut_widget)
							end
						end
					end
				end
			end
		end

	update_grid_columns is
			-- Update the grid columns widths and borders depending on current display type
		local
			l_column: EV_GRID_COLUMN
			l_resource: PREFERENCE
			w: INTEGER
			nb: INTEGER
		do
			nb := grid.row_count
			if nb > 0 then
				grid.row (1).enable_select
				l_column := grid.column (1)
				if not resized_columns_list.item (1) then
					w := l_column.required_width_of_item_span (1, nb)
					l_column.set_width (w + column_border_space)
				end
				l_column := grid.column (2)
				if not resized_columns_list.item (2) then
					w := l_column.required_width_of_item_span (1, nb)
					l_column.set_width (w + column_border_space)
				end
				l_column := grid.column (3)
				if not resized_columns_list.item (3) then
					w := l_column.required_width_of_item_span (1, nb)
					l_column.set_width (w + column_border_space)
				end
				on_window_resize
				l_resource ?= grid.row (1).data
				if l_resource /= Void then
					show_resource_description (l_resource)
				end
				if grid.is_displayed and grid.is_sensitive then
					grid.set_focus
				end
			end
		end

	toggle_view is
			-- Toggle voew
		do
			if grid.is_tree_enabled then
				enable_flat_view
			else
				enable_tree_view
			end
		end

	toggle_hiddens is
			-- Show/hide hiddens preferences
		do
			set_show_hidden_preferences (not show_hidden_preferences)
			rebuild
		end

	enable_flat_view is
			-- Enable view to be flat
		do
			grid.clear
			grid.set_row_count_to (0)
			grid.disable_tree
			grid.set_dynamic_content_function (agent dynamic_content_function)
			grid.enable_partial_dynamic_content
			filter_box.enable_sensitive
			set_show_full_resource_name (True)
			build_flat
			update_matches
			view_toggle_button.set_text (once "Tree View")
		end

	enable_tree_view is
			-- Enable view to tree (structured)
		do
			grid.clear
			grid.set_row_count_to (0)
			grid.enable_tree
			grid.disable_dynamic_content
			filter_box.disable_sensitive
			set_show_full_resource_name (False)
			build_structured
			update_status_bar
			view_toggle_button.set_text (once "Flat View")
		end

	update_status_bar is
			-- Update status bar
		do
			if grid.is_tree_enabled then
				status_label.set_text (grid.row_count.out + " preferences")
			else
				status_label.set_text (matches.count.out + " matches of " + preferences.preferences.count.out + " total preferences")
			end
			status_label.refresh_now
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

	show_resource_description (a_resource: PREFERENCE) is
			-- Show selected list resource in edit widget.
		require
			resource_not_void: a_resource /= Void
		local
			l_text: STRING
		do
			if a_resource.description /= Void then
				l_text := a_resource.description
			else
				l_text := no_description_text
			end

			if a_resource.restart_required then
				description_text.set_text (l_text + once " (REQUIRES RESTART)")
			else
				description_text.set_text (l_text)
			end
		end

	add_resource_change_item (l_resource: PREFERENCE; a_row: EV_GRID_ROW) is
			-- Add the correct resource change widget item at `row_index' of `grid'.
		local
			l_bool: BOOLEAN_PREFERENCE
			l_font: FONT_PREFERENCE
			l_color: COLOR_PREFERENCE
			l_array: ARRAY_PREFERENCE
			l_shortcut: SHORTCUT_PREFERENCE
			l_text: STRING_PREFERENCE

			l_pref_widget: PREFERENCE_WIDGET
		do
			l_bool ?= l_resource
			if l_bool /= Void then
				create {BOOLEAN_PREFERENCE_WIDGET} l_pref_widget.make_with_resource (l_bool)
			elseif l_resource.generating_resource_type.is_equal ("TEXT") then
				l_text ?= l_resource
				check l_text_not_void: l_text /= Void end
				create {STRING_PREFERENCE_WIDGET} l_pref_widget.make_with_resource (l_text)
			elseif l_resource.generating_resource_type.is_equal ("COMBO") then
				l_array ?= l_resource
				if l_array /= Void then
					create {CHOICE_PREFERENCE_WIDGET} l_pref_widget.make_with_resource (l_array)
				else
					l_font ?= l_resource
					if l_font /= Void then
						create {FONT_PREFERENCE_WIDGET} l_pref_widget.make_with_resource (l_font)
--						a_row.set_height (l_font.value.height.max (default_row_height))
					else
						l_color ?= l_resource
						if l_color /= Void then
							create {COLOR_PREFERENCE_WIDGET} l_pref_widget.make_with_resource (l_color)

						else
							l_shortcut ?= l_resource
							if l_shortcut /= Void then
								create {SHORTCUT_PREFERENCE_WIDGET} l_pref_widget.make_with_resource (l_shortcut)
							end
						end
					end
				end
			end
			if l_pref_widget /= Void then
				l_pref_widget.change_actions.extend (agent on_preference_changed)
				l_pref_widget.set_caller (Current)
				a_row.set_item (4, l_pref_widget.change_item_widget)
				a_row.item (4).set_data (l_pref_widget)
			end
		end


	clear_edit_widget is
			-- Clear the edit widget
		do
			description_text.set_text (once "")
		end

	short_resource_name (a_name: STRING): STRING is
			-- The short, non-unique name of a resource
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

feature {NONE} -- Filtering

	filter_text: STRING is
			-- Match text
		do
			create Result.make_empty
			if not grid.is_tree_enabled then
				Result.append (filter_text_box.text)
			end
		end

	update_matches_timeout: EV_TIMEOUT

	request_update_matches is
		require
			in_flat_mode: not grid.is_tree_enabled
		do
			cancel_delayed_update_matches
			if update_matches_timeout = Void then
				create update_matches_timeout
				update_matches_timeout.actions.extend_kamikaze (agent delayed_update_matches)
			end
			update_matches_timeout.set_interval (700)
		end

	update_matches_requested: BOOLEAN is
		do
			Result := update_matches_timeout /= Void
		end

	cancel_delayed_update_matches is
		do
			if update_matches_timeout /= Void then
				update_matches_timeout.destroy
				update_matches_timeout := Void
			end
		end

	delayed_update_matches is
		do
			cancel_delayed_update_matches
			update_matches
		end

	update_matches is
			-- List of matches against `filter_text'
		require
			in_flat_mode: not grid.is_tree_enabled
		local
			l_match_text: STRING
			l_pref_count: INTEGER
			l_preference: PREFERENCE
			l_known_pref_hash: HASH_TABLE [PREFERENCE, STRING]
			l_sorted_preferences: SORTED_TWO_WAY_LIST [STRING]
		do
			status_label.set_text ("Updating the view ...")
			status_label.refresh_now

			matches.wipe_out

			l_known_pref_hash := preferences.preferences
				-- Alphabetically sort the known preferences first
			create l_sorted_preferences.make
			l_sorted_preferences.compare_objects
			l_sorted_preferences.append (create {ARRAYED_LIST [STRING]}.make_from_array (l_known_pref_hash.current_keys))
			l_sorted_preferences.sort

			if not update_matches_requested then
				l_pref_count := l_sorted_preferences.count
				if l_pref_count > matches.capacity then
					matches.resize (l_pref_count)
				end
				l_match_text := filter_text

				from
					l_sorted_preferences.start
				until
					l_sorted_preferences.after
				loop
					l_preference := l_known_pref_hash.item (l_sorted_preferences.item)
					if (l_preference.name.has_substring (l_match_text)) and then
						(show_hidden_preferences or
						(not show_hidden_preferences and then not l_preference.is_hidden))
					then
						matches.extend (l_preference)
					end
					l_sorted_preferences.forth
				end
				if not update_matches_requested then
					grid.set_row_count_to (matches.count)
					grid.clear
					update_status_bar
				end
			end
		end

	matches: ARRAYED_LIST [PREFERENCE] is
			--
		once
			create Result.make (10)
		end

	dynamic_content_function (x, y: INTEGER): EV_GRID_ITEM is
			-- Function to compute the necessary EV_GRID_ITEM for grid co-ordinates x,y.
		local
			l_preference: PREFERENCE
		do
			if matches.valid_index (y) then
				l_preference := matches.i_th (y)
				inspect x
				when 1 then
					Result := preference_name_column (l_preference)
				when 2 then
					Result := preference_type_column (l_preference)
				when 3 then
					Result := preference_status_column (l_preference)
				when 4 then
					Result := preference_value_column (l_preference)
				else
					-- Should not get here.
				end
			end
		end

feature {NONE} -- Private attributes

	show_full_resource_name: BOOLEAN
			-- Show the full name of the resource in the list?

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

	hidden_fg_color: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (127, 127, 127)
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
			-- List of booleans for each column indicating if it has been user resizedat all.
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

end -- class PREFERENCES_GRID


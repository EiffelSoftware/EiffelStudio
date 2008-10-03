indexing
	description: "[
			A widget containing a tree/grid view of application preferences.  Provides a
			list to view preference information and ability to edit the preferences using popup floating widgets.  Also allows
			to restore preferences to their defaults.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_GRID_CONTROL

inherit

	PREFERENCE_VIEW
		redefine
			make
		end

	PREFERENCES_GRID_CONSTANTS

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make, make_with_hidden

feature {NONE} -- Initialization

	make (a_preferences: like preferences) is
			-- New view.
		do
			Precursor {PREFERENCE_VIEW} (a_preferences)
			build_interface
		end

	build_interface is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			box: EV_VERTICAL_BOX
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			ffilter, fgrid, fdesc: EV_FRAME
			lab: EV_LABEL
			tb: EV_TOOL_BAR
		do
			create box
			widget := box
			box.set_border_width (small_border_size)
			box.set_padding_width (small_padding_size)

			create ffilter
			create hb
			hb.set_border_width (small_border_size)
			hb.set_padding_width (small_padding_size)
			create filter_box
			create lab.make_with_text (l_filter)
			create filter_text_box
			create tb
			create view_toggle_button.make_with_text (l_flat_view)
			filter_box.extend (lab)
			filter_box.disable_item_expand (lab)
			filter_box.extend (filter_text_box)
			hb.extend (filter_box)
			tb.extend (view_toggle_button)
			hb.extend (tb)
			hb.disable_item_expand (tb)
			ffilter.extend (hb)
			box.extend (ffilter)
			box.disable_item_expand (ffilter)

			create split_area

			create fgrid
			create vb
			vb.set_border_width (small_border_size)
			create grid_container
			grid_container.set_border_width (1)
			grid_container.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			vb.extend (grid_container)
			create status_box
			status_box.set_padding_width (tiny_padding_size)

			create description_location
			status_box.extend (description_location)
			create status_label
			status_box.extend (status_label)
			status_label.align_text_right
			status_box.disable_item_expand (status_label)
			vb.extend (status_box)
			vb.disable_item_expand (status_box)
			fgrid.extend (vb)

			create fdesc.make_with_text (l_description)
			create vb
			vb.set_padding_width (tiny_padding_size)
			vb.set_border_width (small_border_size)

			create description_text
			description_text.set_minimum_height (40)
			vb.extend (description_text)

			fdesc.extend (vb)

			split_area.extend (fgrid)
			split_area.extend (fdesc)
			split_area.enable_item_expand (fgrid)
			split_area.disable_item_expand (fdesc)
			box.extend (split_area)

			create hb
			hb.set_padding_width (small_padding_size)
			hb.set_border_width (small_border_size)
			create restore_button.make_with_text (l_restore_defaults)
			create import_button.make_with_text (l_import_preferences)
			create export_button.make_with_text (l_export_preferences)

			create apply_or_close_button.make_with_text (l_apply)
			set_default_width_for_button (restore_button)
			set_default_width_for_button (import_button)
			set_default_width_for_button (export_button)
			set_default_width_for_button (apply_or_close_button)
			hb.extend (restore_button)
			hb.extend (import_button)
			hb.extend (export_button)
			hb.extend (create {EV_CELL})
			hb.extend (apply_or_close_button)
			hb.disable_item_expand (restore_button)
			hb.disable_item_expand (import_button)
			hb.disable_item_expand (export_button)
			hb.disable_item_expand (apply_or_close_button)
			box.extend (hb)
			box.disable_item_expand (hb)

				--| Widget properties
			description_location.set_background_color (description_location.parent.background_color)
			description_location.disable_edit
			description_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			description_text.disable_edit

				--| Dynamic behavior

			flat_sorting_info := Name_sorting_mode
			create grid
			default_row_height := grid.row_height
			grid.enable_single_row_selection
			grid_container.extend (grid)
			grid.set_column_count_to (4)
			grid.column (col_name_index).set_title (l_name)
			grid.column (col_type_index).set_title (l_type)
			grid.column (col_status_index).set_title (l_status)
			grid.column (col_value_index).set_title (l_literal_value)
			enable_tree_view


				-- Agents
			grid.pointer_double_press_item_actions.extend (agent on_grid_item_double_pressed)
			grid.key_press_actions.extend (agent on_grid_key_pressed)

			grid.header.pointer_double_press_actions.force_extend (agent on_header_double_clicked)
			grid.header.item_resize_end_actions.force_extend (agent on_header_item_resize)
			grid.header.item_pointer_button_press_actions.extend (agent on_header_item_single_clicked)

			restore_button.select_actions.extend (agent on_restore)
			import_button.select_actions.extend (agent on_import)
			export_button.select_actions.extend (agent on_export)
			apply_or_close_button.select_actions.extend (agent on_apply_or_close)
			description_location.key_press_actions.extend (agent on_description_key_pressed)
			description_text.key_press_actions.extend (agent on_description_key_pressed)
			box.resize_actions.force_extend (agent on_resize)
			display_update_agent := agent on_preference_changed_externally
			view_toggle_button.select_actions.extend (agent toggle_view)

				--| Filter
			build_filter_icons
			filter_text_box.change_actions.extend (agent request_update_matches)

			init_shortcuts
		end

	init_shortcuts is
		do
			filter_text_box.key_press_actions.extend (agent accelerator_on_key_pressed)
			description_location.key_press_actions.extend (agent accelerator_on_key_pressed)
			description_text.key_press_actions.extend (agent accelerator_on_key_pressed)
		end

feature -- Access

	widget: EV_WIDGET
			-- Main widget

	close_button_action: PROCEDURE [ANY, TUPLE]
			-- Action called when "Close" button is pressed.

	parent_window: EV_WINDOW
			-- Parent window.  Used to display this view relative to.

	parent_window_of (w: EV_WIDGET): EV_WINDOW is
			-- Computed parent window of `w'.
		do
			Result ?= w
			if Result = Void and w.parent /= Void then
				Result := parent_window_of (w.parent)
			end
		ensure
			Result_not_void: Result /= Void
		end

	restore_button, apply_or_close_button: EV_BUTTON
	export_button, import_button: EV_BUTTON
	description_text: EV_TEXT
	description_location: EV_TEXT_FIELD
	view_toggle_button: EV_TOOL_BAR_BUTTON
	split_area: EV_VERTICAL_SPLIT_AREA
	filter_box,
	status_box: EV_HORIZONTAL_BOX
	grid_container: EV_VERTICAL_BOX
	status_label: EV_LABEL
	filter_text_box: EV_TEXT_FIELD

feature -- Status Setting

	set_parent_window (p: like parent_window) is
			-- Set `parent_window'
		do
			parent_window := p
		end

	set_close_button_action (p: like close_button_action) is
			-- Set close button action to `p'.
		do
			close_button_action := p
			if close_button_action /= Void then
				apply_or_close_button.set_text (l_close)
			else
				apply_or_close_button.set_text (l_apply)
			end
		end

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

	set_filter_icon_up (a_icon: EV_PIXMAP) is
			-- Set the grid's header arrow up icon
		require
			icon_not_void: a_icon /= Void
		do
			icon_up := a_icon
		end

	set_filter_icon_down (a_icon: EV_PIXMAP) is
			-- Set the grid's header arrow down icon
		require
			icon_not_void: a_icon /= Void
		do
			icon_down := a_icon
		end

feature -- Events

	on_show is
		do
			if grid.is_displayed then
				on_resize
				grid.set_focus
			end
		end

	on_apply_or_close is
			-- Close button has been pushed: apply the changes then close
			-- the Preferences Window.
		do
			preferences.save_preferences
			if close_button_action /= Void then
				close_button_action.call (Void)
			end
		end

feature {NONE} -- Events		

	on_preference_changed (a_pref: PREFERENCE; a_pref_widget: PREFERENCE_WIDGET) is
			-- Set the preference value to the newly entered value in the edit item.
		local
			l_row: EV_GRID_ROW
			l_item: EV_GRID_ITEM
		do
			if a_pref_widget /= Void then
				l_item := a_pref_widget.change_item_widget
				if l_item /= Void and l_item.is_parented then
					l_row := l_item.row
				end
			end
			if l_row = Void then
				l_row := preference_row	(a_pref)
			end
			if l_row /= Void then
				preference_changed_on_row (a_pref, l_row, True)
			end
		end

	preference_changed_on_row (a_pref: PREFERENCE; a_row: EV_GRID_ROW; a_update_value: BOOLEAN) is
			-- Set the preference value to the newly entered value in the edit item.
		require
			a_pref_not_void: a_pref /= Void
			a_row_parented: a_row /= Void and then a_row.parent /= Void
		local
			l_default_item: EV_GRID_LABEL_ITEM
			l_selected_row: EV_GRID_ROW
		do
			if not grid.selected_rows.is_empty then
				l_selected_row := grid.selected_rows.first
			end

			l_default_item ?= a_row.item (3)
			if l_default_item /= Void then
					--| In flat mode, we use dynamic computation
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
			if a_update_value then
				a_row.set_item (4, preference_value_column (a_pref))
			end

			if l_selected_row /= Void and then l_selected_row.parent /= Void and then not l_selected_row.is_selected then
				l_selected_row.enable_select
			end
		end

	on_preference_changed_externally (a_pref: PREFERENCE) is
			-- Set the preference value to the newly entered value NOT changed in the edit item.
		local
			l_row: EV_GRID_ROW
		do
			l_row := preference_row (a_pref)
			if l_row /= Void then
				preference_changed_on_row (a_pref, l_row, True)
			end
		end

	preference_row (a_pref: PREFERENCE): EV_GRID_ROW is
			-- Row containing `a_pref'.
		require
			a_pref_not_void: a_pref /= Void
		local
			nb: INTEGER
			r: INTEGER
			l_pref: PREFERENCE
		do
			nb := grid.row_count
			if nb > 0 then
					--| Find the parent row
				from
					r := 1
				until
					r > nb or Result /= Void
				loop
					l_pref ?= grid.row (r).data
					if l_pref /= Void and then l_pref.name.is_equal (a_pref.name) then
						Result := grid.row (r)
					end
					r := r + 1
				end
			end
		end

	set_preference_to_default (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE) is
			-- Set the preference value to the original default.
		local
			l_gitem: EV_GRID_ITEM
			l_prefwidget: PREFERENCE_WIDGET
		do
			a_pref.reset
			a_item.set_text (p_default_value)
			a_item.set_font (default_font)
			if a_pref.is_auto then
				a_item.set_text (a_item.text + " (" + auto_value + ")")
			end

			l_gitem := a_item.row.item (col_value_index)
			if l_gitem /= Void then
				l_prefwidget ?= l_gitem.data
				if l_prefwidget /= Void then
					l_prefwidget.refresh
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
			show_dialog_modal (l_confirmation_dialog)
			if l_confirmation_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				preferences.restore_defaults
			end
		end

	on_export is
		local
			dlg: EV_FILE_SAVE_DIALOG
			s: STRING_32
			stor: PREFERENCES_STORAGE_XML
			p: EV_WINDOW
		do
			create dlg.make_with_title (l_export_preferences)
			p := parent_window
			if p = Void then
				p := parent_window_of (widget)
			end
			dlg.show_modal_to_window (p)
			s := dlg.file_name
			if s /= Void then
				create stor.make_with_location (s)
				preferences.export_to_storage (stor, False)
			end
		end

	on_import is
		local
			dlg: EV_FILE_OPEN_DIALOG
			s: STRING_32
			stor: PREFERENCES_STORAGE_XML
			p: EV_WINDOW
		do
			create dlg.make_with_title (l_import_preferences)
			p := parent_window
			if p = Void then
				p := parent_window_of (widget)
			end
			dlg.show_modal_to_window (p)
			s := dlg.file_name
			if s /= Void then
				create stor.make_with_location (s)
				preferences.import_from_storage (stor)
				rebuild
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
				if l_pref /= Void and then l_pref = a_pref then
						-- Ensure that before showing the menu, the row gets selected.
					grid.remove_selection
					a_item.row.enable_select
					create l_popup_menu
					if l_pref.has_default_value then
							-- The right clicked preference matches the selection in the grid
						create l_menu_item.make_with_text (l_restore_defaults)
						l_menu_item.select_actions.extend (agent set_preference_to_default (a_item, a_pref))
						l_popup_menu.extend (l_menu_item)
					else
						create l_menu_item.make_with_text (l_no_default_value)
						l_menu_item.disable_sensitive
						l_popup_menu.extend (l_menu_item)
					end
					l_popup_menu.show
				end
			end
		end

	on_grid_item_double_pressed (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM) is
			-- An item was double pressed
		local
			l_col_index: INTEGER
			l_bool_preference: BOOLEAN_PREFERENCE
			l_combo_widget: EV_GRID_CHOICE_ITEM
		do
			if a_item /= Void then
				l_col_index := a_item.column.index
				if l_col_index = col_name_index or l_col_index = col_type_index or l_col_index = col_status_index then
					l_bool_preference ?= a_item.row.data
					if l_bool_preference /= Void then
						l_combo_widget ?= a_item.row.item (col_value_index)
						if l_combo_widget /= Void then
							l_combo_widget.set_text ((not l_bool_preference.value).out)
							l_combo_widget.deactivate_actions.call (Void)
						end
					end
				end
			end
		end

	accelerator_on_key_pressed (k: EV_KEY) is
		do
			inspect
				k.code
			when {EV_KEY_CONSTANTS}.key_h then
				if
					ev_application.ctrl_pressed
					and not ev_application.alt_pressed
					and ev_application.shift_pressed
				then
					toggle_hiddens
				end
			when {EV_KEY_CONSTANTS}.key_tab then
				if
					ev_application.ctrl_pressed
					and not ev_application.alt_pressed
					and not ev_application.shift_pressed
				then
					toggle_view
				end
			else
			end
		end

	on_grid_key_pressed (k: EV_KEY) is
			-- An key was pressed
		local
			l_pref: PREFERENCE
			l_preference_widget: PREFERENCE_WIDGET
			l_boolean_widget: EV_GRID_CHECKABLE_LABEL_ITEM
			l_row: EV_GRID_ROW
		do
			if k /= Void then
				inspect
					k.code
				when {EV_KEY_CONSTANTS}.key_enter then
					if not grid.selected_rows.is_empty then
						l_row :=  grid.selected_rows.first
						l_pref ?= l_row.data
						if l_pref /= Void then
							check l_row.count >= col_value_index end
							if l_row.count >= col_value_index and then l_row.item (col_value_index) /= Void then
								l_preference_widget ?= l_row.item (col_value_index).data
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
				when {EV_KEY_CONSTANTS}.key_space then
					if not grid.selected_rows.is_empty then
						l_row :=  grid.selected_rows.first
						if l_row.count >= col_value_index and then l_row.item (col_value_index) /= Void then
							l_boolean_widget ?= l_row.item (col_value_index)
							if l_boolean_widget /= Void then
								l_boolean_widget.toggle_is_checked
							end
						end
					end
				else
					accelerator_on_key_pressed (k)
				end
			end
		end

	on_description_key_pressed (a_key: EV_KEY) is
			-- Description text area was key pressed
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_tab then
				if ev_application.shift_pressed then
					grid.set_focus
				else
					restore_button.set_focus
				end
			end
		end

	on_resize is
			-- Dialog was resized
		local
			l_width: INTEGER
			cnb, c: INTEGER
		do
			cnb := grid.column_count
			l_width := grid.width
			from
				c := 1
			until
				c < cnb
			loop
				l_width := l_width - grid.column (c).width
				c := c + 1
			end
			if not resized_columns_list.item (cnb) then
				grid.column (cnb).set_width (l_width.max (0))
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

	on_header_item_single_clicked (hi: EV_HEADER_ITEM; ax,ay, a_but: INTEGER) is
		local
			ghi: EV_GRID_HEADER_ITEM
			col_index: INTEGER
		do
			if
				not grid.is_tree_enabled
				and a_but = 1
				and grid.header.pointed_divider_index = 0 --| Let's be sure no divider is clicked
			then
				ghi ?= hi
				if ghi /= Void then
					col_index := ghi.column.index
					if col_index /= Value_sorting_mode then
						if col_index = flat_sorting_info.abs then
							flat_sorting_info := - flat_sorting_info
						else
							if grid.column_count >= flat_sorting_info.abs then
								grid.column (flat_sorting_info.abs).header_item.remove_pixmap
							end
							flat_sorting_info := col_index
						end
						rebuild
					end
				end
			end
		end

	on_header_item_resize is
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

	build_preference_name_to_display (a_pref: PREFERENCE): STRING_32 is
		do
			Result := a_pref.name
		end

	build_full_name_to_display (a_pref_name: STRING): STRING_32 is
			-- Name to show on display for a preference name
		do
			Result := a_pref_name.as_string_32
		end

	build_structured is
			-- Fill with preferences structured hierarchically.
		local
			l_pref_hash: HASH_TABLE [EV_GRID_ROW, STRING]
			l_pref_name,
			l_pref_parent_full_name: STRING
			l_sorted_preferences: LIST [PREFERENCE]
			l_row: EV_GRID_ROW
			l_pref: PREFERENCE
			show_this_pref: BOOLEAN
		do
			if grid.column_count >= flat_sorting_info.abs then
				grid.column (flat_sorting_info.abs).header_item.remove_pixmap
			end

			status_label.set_text (l_building_tree_view)
			status_label.refresh_now

				-- Alphabetically sort the known preferences
			l_sorted_preferences := sorted_known_preferences_by (-Name_sorting_mode, show_hidden_preferences, preferences.preferences.linear_representation)

			if not l_sorted_preferences.is_empty then
				create l_pref_hash.make (l_sorted_preferences.count)

					-- Traverse the preferences in the system
				from
					l_sorted_preferences.finish
				until
					l_sorted_preferences.before
				loop
					l_pref := l_sorted_preferences.item
					if l_pref /= Void then
						l_pref_name := l_pref.name
						if l_pref_name.has ('.') then
							  -- Build parent nodes	as this preference is of the form 'a.b.c' so we must build 'a' and 'b'.
							l_pref_parent_full_name := parent_preference_name (l_pref_name)
							if not l_pref_hash.has (l_pref_parent_full_name) then
								add_parent_structure_preference_row (l_pref_parent_full_name, l_pref_hash)
							end
							l_row := l_pref_hash.item (l_pref_parent_full_name)
							check l_row /= Void and then l_row.parent /= Void end
						else
							l_row := Void
						end
						show_this_pref := show_hidden_preferences
									or (not show_hidden_preferences and then not l_pref.is_hidden)
						if show_this_pref then
							add_short_preference_row (l_row, l_pref)
								--| We assume we build the whole tree at once
								--| then the last inserted row is the one we care
							l_pref_hash.put (grid.row (grid.row_count), l_pref_name)
						end
					end
					l_sorted_preferences.back
				end
				update_grid_columns
			end
		end

	add_parent_structure_preference_row (a_pref_parent_full_name: STRING; a_grid_structure: HASH_TABLE [EV_GRID_ROW, STRING]) is
		require
			structured_mode: grid.is_tree_enabled
			no_row_for_pref: not a_grid_structure.has (a_pref_parent_full_name)
		local
			l_parent_name: STRING
			l_short_name: STRING
			l_row: EV_GRID_ROW
			l_grid_label: EV_GRID_LABEL_ITEM
		do
			if a_pref_parent_full_name.has ('.') then
				l_short_name := short_preference_name (a_pref_parent_full_name)
				l_parent_name := parent_preference_name (a_pref_parent_full_name)
				if not a_grid_structure.has (l_parent_name) then
					add_parent_structure_preference_row (l_parent_name, a_grid_structure)
				end
				l_row := a_grid_structure.item (l_parent_name)
				l_row.insert_subrow (l_row.subrow_count + 1)
				l_row := l_row.subrow (l_row.subrow_count)
			else
					--| Precondition requires `a_pref_parent_full_name' is not already inserted
					--| So it can only be a new top row
				l_short_name := a_pref_parent_full_name
				grid.insert_new_row (grid.row_count + 1)
				l_row := grid.row (grid.row_count)
			end
			check l_row /= Void end
			create l_grid_label.make_with_text (try_to_translate (formatted_name (l_short_name)))
			if folder_icon /= Void then
				l_grid_label.set_pixmap (folder_icon)
			end
			l_row.select_actions.extend (agent description_text.set_text (""))
			l_row.set_item (1, l_grid_label)
			l_row.expand_actions.extend (agent node_expanded (l_row))
			a_grid_structure.put (l_row, a_pref_parent_full_name)
		ensure
			pref_parent_inserted: a_grid_structure.has (a_pref_parent_full_name)
							and then a_grid_structure.item (a_pref_parent_full_name) /= Void
		end

	build_flat is
			-- Fill with preferences no structure, flat list.
		local
			l_sorted_preferences: LIST [PREFERENCE]
			l_pref: PREFERENCE
		do
			if flat_sorting_info.abs <= grid.column_count then
				if flat_sorting_info > 0 then
					grid.column (flat_sorting_info).header_item.set_pixmap (icon_up)
				else
					grid.column (flat_sorting_info.abs).header_item.set_pixmap (icon_down)
				end
			end

			status_label.set_text (l_building_flat_view)
			status_label.refresh_now

			grid_remove_and_clear_all_rows (grid)

				-- Retrieve known preferences
			if matches /= Void then
				l_sorted_preferences := sorted_known_preferences_by (flat_sorting_info, show_hidden_preferences, matches)
			else
				l_sorted_preferences := sorted_known_preferences_by (flat_sorting_info, show_hidden_preferences, preferences.preferences.linear_representation)
			end

			if not l_sorted_preferences.is_empty then
					-- Traverse the preferences in the system and add to grid list
				from
					l_sorted_preferences.start
				until
					l_sorted_preferences.after
				loop
					l_pref := l_sorted_preferences.item
					add_short_preference_row (Void, l_pref)
					l_sorted_preferences.forth
				end
				update_grid_columns
			end
		end

	index_tuple_less_than (a, b: TUPLE [pref_name: STRING_32; index: STRING_32]): BOOLEAN is
			-- Compare two tuples on their string index
		do
			Result := a.index < b.index
		end

	sorted_known_preferences_by (a_sorting_info: INTEGER; a_show_hidden: BOOLEAN; a_prefs_to_sort: LIST [PREFERENCE]): LIST [PREFERENCE] is
			-- Sorted known preferences using criteria `a_sorting_info'.
			-- Exclude hidden preferences when `a_show_hidden' is False.
		local
			l_prefs_to_sort: LIST [PREFERENCE]
			l_known_pref_ht: HASH_TABLE [PREFERENCE, STRING]
			l_sorted_preferences: SORTED_TWO_WAY_LIST [PROXY_COMPARABLE [TUPLE [pref_name: STRING_32; index: STRING_32]]]
			l_compare_agent: PREDICATE [ANY, TUPLE [TUPLE [STRING_32, STRING_32], TUPLE [STRING_32, STRING_32]]]
			l_proxy_comparable: PROXY_COMPARABLE [TUPLE [pref_name: STRING_32; index: STRING_32]]
			l_pref_index, l_pref_name, l_display_name: STRING_32
			l_pref: PREFERENCE
			l_sorting_up: BOOLEAN
			l_sorting_criteria: INTEGER
		do
			l_prefs_to_sort := a_prefs_to_sort
			if l_prefs_to_sort /= Void then
				l_sorting_up := a_sorting_info > 0
				l_sorting_criteria := a_sorting_info.abs
				l_compare_agent := agent index_tuple_less_than

					-- Alphabetically sort the known preferences
				from
					create l_sorted_preferences.make
					l_prefs_to_sort.start
				until
					l_prefs_to_sort.after
				loop
					l_pref := l_prefs_to_sort.item
					l_pref_name := l_pref.name
					l_display_name := build_full_name_to_display (l_pref_name)
					inspect l_sorting_criteria
					when Name_sorting_mode then --| Pref name
						l_pref_index := l_display_name
					when Type_sorting_mode then --| type name
						l_pref_index := l_pref.string_type + "@" + l_display_name
					when Status_sorting_mode then --| type name
						l_pref_index := ""
						if l_pref.is_default_value then
							l_pref_index.append_string (p_default_value)
						else
							l_pref_index.append_string (user_value)
						end
						if l_pref.is_auto then
							l_pref_index.append_string (auto_value)
						end
						l_pref_index.append_string ("@" + l_display_name)
					else
						check False end
					end
					create l_proxy_comparable.make ([l_pref_name, l_pref_index], l_compare_agent)
					l_sorted_preferences.extend (l_proxy_comparable)
					l_prefs_to_sort.forth
				end
				l_prefs_to_sort := Void

				create {ARRAYED_LIST [PREFERENCE]} Result.make (l_sorted_preferences.count)

					-- Traverse the preferences in the system and add to grid list
				from
					l_known_pref_ht := preferences.preferences
					if l_sorting_up then
						l_sorted_preferences.start
					else
						l_sorted_preferences.finish
					end
				until
					l_sorted_preferences.off
				loop
					l_pref_name := l_sorted_preferences.item.item.pref_name

					l_pref := l_known_pref_ht.item (l_pref_name)
					if a_show_hidden or (not a_show_hidden and then not l_pref.is_hidden) then
						Result.extend (l_pref)
					end
					if l_sorting_up then
						l_sorted_preferences.forth
					else
						l_sorted_preferences.back
					end
				end
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
			resize_columns
			update_status_bar
		end

	add_short_preference_row (a_row: EV_GRID_ROW; a_pref: PREFERENCE) is
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
--			selected_preference_name := a_pref_name
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

			initialize_row_for_preference (l_row, a_pref)

				-- Add Items
			l_row.set_item (col_name_index, preference_name_column (a_pref))
			l_row.set_item (col_type_index, preference_type_column (a_pref))
			l_row.set_item (col_status_index, preference_status_column (a_pref))
			l_row.set_item (col_value_index, preference_value_column (a_pref))
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
		do
			create Result
			if a_pref.name /= Void then
				if show_full_preference_name then
					Result.set_text (a_pref.name)
				else
					Result.set_text (short_preference_name (a_pref.name))
				end
			else
				Result.set_text ("")
			end
		ensure
			Result /= Void
		end

	preference_type_column (a_pref: PREFERENCE): EV_GRID_LABEL_ITEM is
		do
			create Result
			Result.set_text (a_pref.string_type)
		ensure
			Result /= Void
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
		ensure
			Result /= Void
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
				l_bool_widget := new_boolean_widget (l_bool)
				l_bool_widget.change_actions.extend (agent on_preference_changed (?, l_bool_widget))
				Result := l_bool_widget.change_item_widget
				Result.set_data (l_bool_widget)
			else
				if a_pref.generating_preference_type.is_equal ("TEXT") then
					create l_edit_widget.make_with_preference (a_pref)
					l_edit_widget.change_actions.extend (agent on_preference_changed (?, l_edit_widget))
					Result := l_edit_widget.change_item_widget
					Result.set_data (l_edit_widget)
				elseif a_pref.generating_preference_type.is_equal ("COMBO") then
					l_array ?= a_pref
					if l_array /= Void then
						l_choice_widget := new_choice_widget (l_array)
						l_choice_widget.change_actions.extend (agent on_preference_changed (?, l_choice_widget))
						Result := l_choice_widget.change_item_widget
						Result.set_data (l_choice_widget)
					end
				else
					l_font ?= a_pref
					if l_font /= Void then
						create l_font_widget.make_with_preference (l_font)
						l_font_widget.change_actions.extend (agent on_preference_changed (?, l_font_widget))
						l_font_widget.set_caller (Current)
						Result := l_font_widget.change_item_widget
						Result.set_data (l_font_widget)
--						a_row.set_height (l_font.value.height.max (default_row_height))
					else
						l_color ?= a_pref
						if l_color /= Void then
							create l_color_widget.make_with_preference (l_color)
							l_color_widget.change_actions.extend (agent on_preference_changed (?, l_color_widget))
							l_color_widget.set_caller (Current)
							Result := l_color_widget.change_item_widget
							Result.set_data (l_color_widget)
						else
							l_shortcut ?= a_pref
							if l_shortcut /= Void then
								create l_shortcut_widget.make_with_preference (l_shortcut)
								l_shortcut_widget.change_actions.extend (agent on_preference_changed (?, l_shortcut_widget))
								Result := l_shortcut_widget.change_item_widget
								Result.set_data (l_shortcut_widget)
								l_shortcut.overridden_actions.wipe_out
								l_shortcut.overridden_actions.extend (agent on_shortcut_overriden (l_shortcut_widget))
								l_shortcut.modification_deny_actions.wipe_out
								l_shortcut.modification_deny_actions.extend (agent on_shortcut_modification_denied (l_shortcut))
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
			l_preference: PREFERENCE
			w: INTEGER
			nb: INTEGER
			cnb, c: INTEGER
		do
			nb := grid.row_count
			if nb > 0 then
				grid.row (1).enable_select
				from
					cnb := grid.column_count
					c := 1
				until
					c < cnb --| do no process last column
				loop
					l_column := grid.column (c)
					if not resized_columns_list.item (c) then
						w := l_column.required_width_of_item_span (1, nb)
						l_column.set_width (w + column_border_space)
					end
					c := c + 1
				end

				on_resize
				l_preference ?= grid.row (col_name_index).data
				if l_preference /= Void then
					show_preference_description (l_preference)
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

	reset_grid_view is
		do
			grid.clear
			grid.set_row_count_to (0)
			description_text.remove_text
			description_location.remove_text
		end

	enable_flat_view is
			-- Enable view to be flat
		do
			reset_grid_view
			grid.disable_tree
			grid.set_dynamic_content_function (agent dynamic_content_function)
			grid.enable_partial_dynamic_content
			filter_box.enable_sensitive
			set_show_full_preference_name (True)
			build_flat
			resize_columns
			update_status_bar
			view_toggle_button.set_text (l_tree_view)
			view_toggle_button.set_tooltip (f_switch_to_tree_view)
		end

	enable_tree_view is
			-- Enable view to tree (structured)
		do
			reset_grid_view
			filter_box.disable_sensitive
			grid.enable_tree
			grid.disable_dynamic_content
			set_show_full_preference_name (False)
			build_structured
			resize_columns
			update_status_bar
			view_toggle_button.set_text (l_flat_view)
			view_toggle_button.set_tooltip (f_switch_to_flat_view)
		end

	update_status_bar is
			-- Update status bar
		do
			if not grid.is_tree_enabled and matches /= Void then
				status_label.set_text (l_matches_of_total_preferences (matches.count, preferences.preferences.count))
			else
				status_label.set_text (l_count_preferences (preferences.preferences.count.out))
			end
			status_label.refresh_now
		end

	resize_columns is
			-- Resize all columns to it's contents.
		local
			col: EV_GRID_COLUMN
		do
			col := grid.column (1)
			col.set_width (col.required_width_of_item_span (1, col.parent.row_count) + column_border_space)
			col := grid.column (2)
			col.set_width (col.required_width_of_item_span (1, col.parent.row_count) + column_border_space)
			col := grid.column (3)
			col.set_width (col.required_width_of_item_span (1, col.parent.row_count) + column_border_space)
		end

feature {NONE} -- Implementation

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
			l_text: STRING_GENERAL
		do
			description_location.set_text (a_preference.name)
			if a_preference.description /= Void then
					-- We know that descriptions of preference have been extacted out
					-- from the config file.
				l_text := try_to_translate (a_preference.description)
			else
				l_text := no_description_text
			end

			if a_preference.restart_required then
				description_text.set_text (l_text.as_string_32 + l_request_restart)
			else
				description_text.set_text (l_text)
			end
		end

	clear_edit_widget is
			-- Clear the edit widget
		do
			description_text.remove_text
			description_text.remove_text
		end

	short_preference_name (a_name: STRING): STRING is
			-- The short, non-unique name of a preference
		require
			name_not_void: a_name /= Void
		do
			Result := a_name.substring (a_name.last_index_of ('.', a_name.count) + 1, a_name.count)
		ensure
			a_name /= Result
		end

	parent_preference_name (a_name: STRING): STRING is
			-- The short, non-unique name of a preference
		require
			name_not_void: a_name /= Void
			name_has_parent: a_name.has ('.')
		do
			Result := a_name.substring (1, a_name.last_index_of ('.', a_name.count) - 1)
		ensure
			a_name /= Result
		end

	formatted_name (a_name: STRING): STRING is
			-- Formatted name for display
		do
			create Result.make_from_string (a_name)
			Result.replace_substring_all ("_", " ")
			Result.replace_substring (Result.item (1).upper.out, 1, 1)
		ensure
			a_name /= Result
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

	on_shortcut_overriden (a_shortcut_widget: SHORTCUT_PREFERENCE_WIDGET) is
			-- Shortcut is overriden.
		require
			a_shortcut_widget_not_void: a_shortcut_widget /= Void
		local
			l_row: EV_GRID_ROW
		do
			if a_shortcut_widget.change_item_widget.is_parented then
				l_row := a_shortcut_widget.change_item_widget.row
				preference_changed_on_row (a_shortcut_widget.preference, l_row, True)
			end
		end

	on_shortcut_modification_denied (a_shortcut_pref: SHORTCUT_PREFERENCE) is
			-- Shortcut modification denied.
		require
			a_shortcut_pref_not_void: a_shortcut_pref /= Void
		local
			l_error_dialog: EV_WARNING_DIALOG
		do
			create l_error_dialog
			l_error_dialog.set_text (shortcut_modification_denied)
			show_dialog_modal (l_error_dialog)
		end

	try_to_translate (a_string: STRING_GENERAL): STRING_GENERAL is
			-- Try to translate `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			Result := a_string
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Widgets initialization

	new_boolean_widget (a_pref: BOOLEAN_PREFERENCE): BOOLEAN_PREFERENCE_WIDGET is
		require
			a_pref_not_void: a_pref /= Void
		do
			create Result.make_with_preference (a_pref)
		ensure
			Result_not_void: Result /= Void
		end

	new_choice_widget (a_pref: ARRAY_PREFERENCE): CHOICE_PREFERENCE_WIDGET is
		require
			a_pref_not_void: a_pref /= Void
		do
			create Result.make_with_preference (a_pref)
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Sorting

	flat_sorting_info: INTEGER
			-- Sorting criteria when sorting known preferences

	Name_sorting_mode: INTEGER is 1
	Type_sorting_mode: INTEGER is 2
	Status_sorting_mode: INTEGER is 3
	Value_sorting_mode: INTEGER is 4

feature {NONE} -- Filtering

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
			l_match_text: STRING_32
			s32: STRING_32

			l_preference: PREFERENCE
			l_prefs: LIST [PREFERENCE]
			l_filter_engine: LX_DFA_WILDCARD
		do
			status_label.set_text (l_updating_the_view)
			status_label.refresh_now

			matches := Void
			if not grid.is_tree_enabled and not update_matches_requested then
				l_prefs := preferences.preferences.linear_representation
				l_match_text := filter_text_box.text
				if l_match_text.is_empty then
					matches := l_prefs
				else
					create {ARRAYED_LIST [PREFERENCE]} matches.make (l_prefs.count)
					from
						l_match_text := l_match_text.as_string_8
						if l_match_text.item (1) /= '*' then
							l_match_text.prepend_character ('*')
						end
						if l_match_text.item (l_match_text.count) /= '*' then
							l_match_text.append_character ('*')
						end
						create l_filter_engine.compile_case_insensitive (l_match_text)
						if not l_filter_engine.is_compiled then
							l_filter_engine := Void
						end
						l_prefs.start
					until
						l_prefs.after
					loop
						l_preference := l_prefs.item
						s32 := build_preference_name_to_display (l_preference)
						if
							s32 /= Void
							and then not s32.is_empty
							and l_filter_engine /= Void
						then
							if l_filter_engine.recognizes (s32.as_string_8) then
								matches.extend (l_preference)
							end
						else
							matches.extend (l_preference)
						end
						l_prefs.forth
					end
				end
				if update_matches_requested then
					matches := Void
				else
						--| Sort the known preferences
					matches := sorted_known_preferences_by (Name_sorting_mode, show_hidden_preferences, matches)
--					matches := sorted_known_preferences_by (flat_sorting_info, show_hidden_preferences, preferences.preferences.linear_representation)
					if update_matches_requested then
						matches := Void
					else
						if grid.row_count > 0 then
							grid.remove_rows (1, grid.row_count)
						end
						grid.set_row_count_to (matches.count)
						update_status_bar
					end
				end
			end
		end

	matches: LIST [PREFERENCE]

	initialize_row_for_preference (a_row: EV_GRID_ROW; a_preference: PREFERENCE) is
			-- Initialize `a_row' with `a_preference'.
		require
			a_row_not_void: a_row /= Void
			a_preference_not_void: a_preference /= Void
			a_row_not_initialized: a_row.data = Void
		do
			a_row.set_data (a_preference)
			a_row.select_actions.extend (agent show_preference_description (a_preference))
			a_row.deselect_actions.extend (agent description_text.remove_text)
			a_row.deselect_actions.extend (agent description_location.remove_text)
			if a_preference.is_hidden then
				a_row.set_foreground_color (hidden_fg_color)
			end
		end

	dynamic_content_function (c, r: INTEGER): EV_GRID_ITEM is
			-- Function to compute the necessary EV_GRID_ITEM for grid co-ordinates c,r.
		require
			flat_mode: not grid.is_tree_enabled
		local
			l_preference: PREFERENCE
			l_row: EV_GRID_ROW
		do
			l_preference ?= grid.row (r).data
			if l_preference = Void then
				if matches.valid_index (r) then
					--| grid indexes start at 1
					--| list start at 1
					l_preference := matches.i_th (r)
					l_row := grid.row (r)
					initialize_row_for_preference (l_row, l_preference)
				end
			end

			check l_preference /= Void end

			if l_preference /= Void then
				inspect c
				when col_name_index then
					Result := preference_name_column (l_preference)
				when col_type_index then
					Result := preference_type_column (l_preference)
				when col_status_index then
					Result := preference_status_column (l_preference)
				when col_value_index then
					Result := preference_value_column (l_preference)
				else
					-- Should not get here.
				end
			end
		end

feature {NONE} -- Private attributes

	show_full_preference_name: BOOLEAN
			-- Show the full name of the preference in the list?

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


	icon_up: EV_PIXMAP

	icon_down: EV_PIXMAP

	build_filter_icons is
		local
			w,h: INTEGER
			bc: EV_COLOR
		do
			w := 16
			h := 16

			bc := (create {EV_STOCK_COLORS}).Default_background_color

			if icon_up = Void then
				create icon_up.make_with_size (w, h)
				icon_up.set_background_color (bc)
				icon_up.clear
				icon_up.fill_polygon (<<
							create {EV_COORDINATE}.make_precise (0.2 * w, 0.2 * h),
							create {EV_COORDINATE}.make_precise (0.8 * w, 0.2 * h),
							create {EV_COORDINATE}.make_precise (0.5 * w, 0.6 * h)
						>>)
			end
			if icon_down = Void then
				create icon_down.make_with_size (w, h)
				icon_down.set_background_color (bc)
				icon_down.clear
				icon_down.fill_polygon (<<
					create {EV_COORDINATE}.make_precise (0.2 * w, 0.6 * h),
					create {EV_COORDINATE}.make_precise (0.8 * w, 0.6 * h),
					create {EV_COORDINATE}.make_precise (0.5 * w, 0.2 * h)
						>>)
			end
		ensure
			icon_up /= Void
			icon_down /= Void
		end

	column_border_space: INTEGER is 3
		-- Padding space for column content

	default_row_height: INTEGER
		-- Default row height

	display_update_agent: PROCEDURE [ANY, TUPLE [PREFERENCE]]
			-- Agent to be called when preference is changed outside	

	col_name_index: INTEGER is 1
			-- column index for name.

	col_type_index: INTEGER is 2
			-- column index for type.

	col_status_index: INTEGER is 3
			-- column index for status.

	col_value_index: INTEGER is 4
			-- column index for value.

	resized_columns_list: ARRAY [BOOLEAN] is
			-- List of booleans for each column indicating if it has been user resizedat all.
		once
			Result := <<False, False, False, False>>
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

end -- class PREFERENCES_GRID_CONTROL


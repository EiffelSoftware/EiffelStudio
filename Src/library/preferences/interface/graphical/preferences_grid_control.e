note
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

	make (a_preferences: like preferences)
			-- New view.
		do
			Precursor {PREFERENCE_VIEW} (a_preferences)
			build_interface
		end

	build_interface
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_box: EV_VERTICAL_BOX
			l_vb: EV_VERTICAL_BOX
			l_hb: EV_HORIZONTAL_BOX
			l_ffilter, l_fgrid, l_fdesc: EV_FRAME
			l_lab: EV_LABEL
			l_tb: EV_TOOL_BAR
		do
				-- Create objects before using them for void-safety reasons.
			create_controls
			build_filter_icons

			display_update_agent := agent on_preference_changed_externally

			create l_box
			widget := l_box
			l_box.set_border_width (small_border_size)
			l_box.set_padding_width (small_padding_size)

			create l_ffilter
			create l_hb
			l_hb.set_border_width (small_border_size)
			l_hb.set_padding_width (small_padding_size)
			create l_lab.make_with_text (l_filter)
			create l_tb
			filter_box.extend (l_lab)
			filter_box.disable_item_expand (l_lab)
			filter_box.extend (filter_text_box)
			filter_box.extend (filter_value_check_box)
			filter_box.disable_item_expand (filter_value_check_box)
			filter_box.set_padding_width (small_padding_size)
			l_hb.extend (filter_box)
			l_tb.extend (view_toggle_button)
			l_hb.extend (l_tb)
			l_hb.disable_item_expand (l_tb)
			l_ffilter.extend (l_hb)
			l_box.extend (l_ffilter)
			l_box.disable_item_expand (l_ffilter)

			create l_fgrid
			create l_vb
			l_vb.set_border_width (small_border_size)
			grid_container.set_border_width (1)
			grid_container.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			l_vb.extend (grid_container)
			status_box.set_padding_width (tiny_padding_size)

			status_box.extend (description_location)
			status_box.extend (status_label)
			status_label.align_text_right
			status_box.disable_item_expand (status_label)
			l_vb.extend (status_box)
			l_vb.disable_item_expand (status_box)
			l_fgrid.extend (l_vb)

			create l_fdesc.make_with_text (l_description)
			create l_vb
			l_vb.set_padding_width (tiny_padding_size)
			l_vb.set_border_width (small_border_size)

			description_text.set_minimum_height (40)
			l_vb.extend (description_text)

			l_fdesc.extend (l_vb)

			split_area.extend (l_fgrid)
			split_area.extend (l_fdesc)
			split_area.enable_item_expand (l_fgrid)
			split_area.disable_item_expand (l_fdesc)
			l_box.extend (split_area)

			add_buttons (l_box)

				--| Widget properties
			if attached description_location.parent as p then
				description_location.set_background_color (p.background_color)
			end

			description_location.disable_edit
			description_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			description_text.disable_edit

			initialize_grid
			initialize_actions
			initialize_shortcuts
		end

	create_controls
			-- Create control widgets.
		do
			create filter_box
			create filter_text_box
			create filter_value_check_box.make_with_text (l_filter_value)
			create view_toggle_button.make_with_text (l_flat_view)
			create split_area
			create grid_container
			create status_box
			create description_location
			create status_label
			create description_text
			create restore_button.make_with_text (l_restore_defaults)
			create import_button.make_with_text (l_import_preferences)
			create export_button.make_with_text (l_export_preferences)
			create display_hidden_button.make_with_text (l_display_hidden_preferences)
			create apply_or_close_button.make_with_text (l_apply)
			create grid
		end

	add_buttons (b: EV_VERTICAL_BOX)
			-- Add buttons to the given box.
		local
			l_hb: EV_HORIZONTAL_BOX
		do
			create l_hb
			l_hb.set_padding_width (small_padding_size)
			l_hb.set_border_width (small_border_size)
			if show_hidden_preferences then
				display_hidden_button.enable_select
			end

			set_default_width_for_button (restore_button)
			set_default_width_for_button (import_button)
			set_default_width_for_button (export_button)
			set_default_width_for_button (apply_or_close_button)
			l_hb.extend (restore_button)
			l_hb.extend (import_button)
			l_hb.extend (export_button)
			l_hb.extend (display_hidden_button)
			l_hb.extend (create {EV_CELL})
			l_hb.extend (apply_or_close_button)
			l_hb.disable_item_expand (restore_button)
			l_hb.disable_item_expand (import_button)
			l_hb.disable_item_expand (export_button)
			l_hb.disable_item_expand (display_hidden_button)
			l_hb.disable_item_expand (apply_or_close_button)
			b.extend (l_hb)
			b.disable_item_expand (l_hb)
		end

	initialize_grid
			-- Initialize grid widget.
		do
			flat_sorting_info := Name_sorting_mode
			default_row_height := grid.row_height
			grid.enable_single_row_selection
			grid_container.extend (grid)
			grid.set_column_count_to (4)
			grid.column (col_name_index).set_title (l_name)
			grid.column (col_type_index).set_title (l_type)
			grid.column (col_status_index).set_title (l_status)
			grid.column (col_value_index).set_title (l_literal_value)
			enable_tree_view
		end

	initialize_actions
			-- Initialize actions associated with widgets.
		do
			grid.pointer_double_press_item_actions.extend (agent on_grid_item_double_pressed)
			grid.key_press_actions.extend (agent on_grid_key_pressed)

			grid.header.pointer_double_press_actions.extend
				(agent (x, y, b: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32) do on_header_double_clicked end)
			grid.header.item_resize_end_actions.extend (agent on_header_item_resize)
			grid.header.item_pointer_button_press_actions.extend (agent on_header_item_single_clicked)

			restore_button.select_actions.extend (agent on_restore)
			import_button.select_actions.extend (agent on_import)
			export_button.select_actions.extend (agent on_export)
			display_hidden_button.select_actions.extend (agent toggle_hiddens)
			apply_or_close_button.select_actions.extend (agent on_apply_or_close)
			description_location.key_press_actions.extend (agent on_description_key_pressed)
			description_text.key_press_actions.extend (agent on_description_key_pressed)
			widget.resize_actions.extend (agent (x, y, w, h: INTEGER_32) do on_resize end)
			widget.dpi_changed_actions.extend (agent (dpi: NATURAL_32; x, y, w, h: INTEGER_32) do on_resize end)
			view_toggle_button.select_actions.extend (agent toggle_view)

				--| Filter
			filter_text_box.change_actions.extend (agent request_update_matches)
			filter_value_check_box.select_actions.extend (agent request_update_matches)
		end

	initialize_shortcuts
		do
			filter_text_box.key_press_actions.extend (agent accelerator_on_key_pressed)
			description_location.key_press_actions.extend (agent accelerator_on_key_pressed)
			description_text.key_press_actions.extend (agent accelerator_on_key_pressed)
		end

feature -- Access

	widget: EV_WIDGET
			-- Main widget

	close_button_action: detachable PROCEDURE
			-- Action called when "Close" button is pressed.

	parent_window: detachable EV_WINDOW note option: stable attribute end
			-- Parent window.  Used to display this view relative to.

	parent_window_of (w: EV_WIDGET): detachable EV_WINDOW
			-- Computed parent window of `w'.
		do
			if attached {like parent_window_of} w as l_win then
				Result := l_win
			elseif attached w.parent as p then
				Result := parent_window_of (p)
			end
		end

	restore_button, apply_or_close_button: EV_BUTTON
	display_hidden_button: EV_CHECK_BUTTON
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
	filter_value_check_box: EV_CHECK_BUTTON

feature -- Status Setting

	set_parent_window (p: attached like parent_window)
			-- Set `parent_window'
		do
			parent_window := p
		end

	set_close_button_action (p: like close_button_action)
			-- Set close button action to `p'.
		do
			close_button_action := p
			if close_button_action /= Void then
				apply_or_close_button.set_text (l_close)
			else
				apply_or_close_button.set_text (l_apply)
			end
		end

	set_show_full_preference_name (a_flag: BOOLEAN)
			-- Set 'show_full_preference_name'
		do
			show_full_preference_name := a_flag
		end

	set_root_icon (a_icon: EV_PIXMAP)
			-- Set the root node icon
		require
			icon_not_void: a_icon /= Void
		do
			root_icon := a_icon
		end

	set_folder_icon (a_icon: EV_PIXMAP)
			-- Set the folder node icon
		require
			icon_not_void: a_icon /= Void
		do
			folder_icon := a_icon
		end

	set_filter_icon_up (a_icon: EV_PIXMAP)
			-- Set the grid's header arrow up icon
		require
			icon_not_void: a_icon /= Void
		do
			icon_up := a_icon
		end

	set_filter_icon_down (a_icon: EV_PIXMAP)
			-- Set the grid's header arrow down icon
		require
			icon_not_void: a_icon /= Void
		do
			icon_down := a_icon
		end

feature -- Events

	on_show
		do
			if grid.is_displayed then
				on_resize
				grid.set_focus
			end
		end

	on_apply_or_close
			-- Close button has been pushed: apply the changes then close
			-- the Preferences Window.
		do
			preferences.save_preferences
			if attached close_button_action as but then
				but.call (Void)
			end
		end

feature {NONE} -- Events		

	on_preference_changed (a_pref: PREFERENCE; a_pref_widget: PREFERENCE_WIDGET)
			-- Set the preference value to the newly entered value in the edit item.
		local
			l_row: detachable EV_GRID_ROW
			l_item: EV_GRID_ITEM
		do
			if a_pref_widget /= Void then
				l_item := a_pref_widget.change_item_widget
				if l_item.is_parented then
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

	preference_changed_on_row (a_pref: PREFERENCE; a_row: EV_GRID_ROW; a_update_value: BOOLEAN)
			-- Set the preference value to the newly entered value in the edit item.
		require
			a_pref_not_void: a_pref /= Void
			a_row_parented: a_row /= Void and then a_row.parent /= Void
		local
			l_selected_row: detachable EV_GRID_ROW
		do
			if grid.has_selected_row then
				l_selected_row := grid.selected_rows.first
			end

			if attached {EV_GRID_LABEL_ITEM} a_row.item (3) as l_default_item then
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

	on_preference_changed_externally (a_pref: PREFERENCE)
			-- Set the preference value to the newly entered value NOT changed in the edit item.
		local
			l_row: like preference_row
		do
			l_row := preference_row (a_pref)
			if l_row /= Void then
				preference_changed_on_row (a_pref, l_row, True)
			end
		end

	preference_row (a_pref: PREFERENCE): detachable EV_GRID_ROW
			-- Row containing `a_pref'.
		require
			a_pref_not_void: a_pref /= Void
		local
			nb: INTEGER
			r: INTEGER
		do
			nb := grid.row_count
			if nb > 0 then
					--| Find the parent row
				from
					r := 1
				until
					r > nb or Result /= Void
				loop
					if attached {PREFERENCE} grid.row (r).data as l_pref and then l_pref.name.is_equal (a_pref.name) then
						Result := grid.row (r)
					end
					r := r + 1
				end
			end
		end

	set_preference_to_default (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE)
			-- Set the preference value to the original default.
		do
			a_pref.reset
			a_item.set_text (p_default_value)
			a_item.set_font (default_font)
			if a_pref.is_auto then
				a_item.set_text (a_item.text + " (" + auto_value + ")")
			end

			if
				attached a_item.row.item (col_value_index) as l_gitem and then
				attached {PREFERENCE_WIDGET} l_gitem.data as l_prefwidget
			then
				l_prefwidget.refresh
			end
		end

	on_restore
			-- Restore all preferences to their default values.
		local
			l_confirmation_dialog: EV_CONFIRMATION_DIALOG
		do
			create l_confirmation_dialog
			l_confirmation_dialog.set_text (restore_preference_string)
			show_dialog_modal (l_confirmation_dialog)
			if l_confirmation_dialog.selected_button ~ (create {EV_DIALOG_CONSTANTS}).ev_ok then
				preferences.restore_defaults
			end
		end

	on_export
		local
			dlg: EV_FILE_SAVE_DIALOG
			s: STRING_32
			stor: PREFERENCES_STORAGE_XML
			p: detachable EV_WINDOW
		do
			p := parent_window
			if p = Void then
				p := parent_window_of (widget)
			end
			if p /= Void then
				create dlg.make_with_title (l_export_preferences)
				dlg.show_modal_to_window (p)
				s := dlg.file_name
				if s /= Void and then not s.is_empty then --| Cancelled
					create stor.make_with_location_and_version (s, preferences.version)
					preferences.export_to_storage (stor, False)
				end
			end
		end

	on_import
		local
			dlg: EV_FILE_OPEN_DIALOG
			stor: PREFERENCES_STORAGE_XML
			p: detachable EV_WINDOW
			popup: detachable EV_POPUP_WINDOW
			bb,vb: EV_VERTICAL_BOX
			lab: EV_LABEL
			l_style: detachable EV_POINTER_STYLE
		do
			p := parent_window
			if p = Void then
				p := parent_window_of (widget)
			end
			if p /= Void then
				create dlg.make_with_title (l_import_preferences)
				dlg.show_modal_to_window (p)
				create stor.make_with_location_and_version (dlg.file_name, preferences.version)

					-- Busy style
				l_style := p.pointer_style
				p.set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))

					-- Popup dialog
				create popup.make_with_shadow
				create bb
				bb.set_border_width (1)
				create vb
				bb.extend (vb)
				vb.set_border_width (10)
				create lab.make_with_text (l_importing_preferences)
				lab.align_text_left
				vb.extend (lab)

				create lab.make_with_text ("...")
				lab.align_text_left
				vb.extend (lab)

				popup.extend (bb)
				popup.set_background_color ((create {EV_STOCK_COLORS}).white)
				popup.propagate_background_color
				bb.set_background_color ((create {EV_STOCK_COLORS}).blue)
				popup.set_width ((9 * p.width) // 10)
				popup.set_position (p.x_position + (p.width - popup.width) // 2, p.y_position + (p.height - popup.height) // 2)
				popup.show_relative_to_window (p)
				popup.refresh_now

				preferences.import_from_storage_with_callback (stor, agent (ia_txt: EV_LABEL; ia_i, ia_count: INTEGER; ia_name, ia_value: READABLE_STRING_GENERAL)
						do
							ia_txt.set_text ("[" + ia_i.out + "/" + ia_count.out + "] " + ia_name.out + "%N")
							ia_txt.refresh_now
						end (lab, ?, ?, ?, ?))
				popup.destroy
				p.set_pointer_style (l_style)
				rebuild
			end
		end

	on_default_item_selected (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- The default cloumn was clicked.
		local
			l_popup_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
		do
			if
				not a_pref.is_default_value and then
				a_button = 3 and then
				a_item.row.data = a_pref
			then
					-- Extract preference from row data.
					-- Show the menu only if necessary (that is to say, the preference value is different from the default one)
					-- Ensure that before showing the menu, the row gets selected.
				grid.remove_selection
				a_item.row.enable_select
				create l_popup_menu
				if a_pref.has_default_value then
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

	on_grid_item_double_pressed (a_x, a_y, a_button: INTEGER; a_item: detachable EV_GRID_ITEM)
			-- An item was double pressed
		local
			l_col_index: INTEGER
		do
			if a_item /= Void then
				l_col_index := a_item.column.index
				if
					(l_col_index = col_name_index or l_col_index = col_type_index or l_col_index = col_status_index) and then
					attached {BOOLEAN_PREFERENCE} a_item.row.data as l_bool_preference and then
					attached {EV_GRID_CHOICE_ITEM} a_item.row.item (col_value_index) as l_combo_widget
				then
					l_combo_widget.set_text ((not l_bool_preference.value).out)
					l_combo_widget.deactivate_actions.call (Void)
				end
			end
		end

	accelerator_on_key_pressed (k: EV_KEY)
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

	on_grid_key_pressed (k: EV_KEY)
			-- An key was pressed
		require
			k_attached: k /= Void
		local
			l_row: EV_GRID_ROW
		do
			inspect
				k.code
			when {EV_KEY_CONSTANTS}.key_enter then
				if grid.has_selected_row then
					l_row := grid.selected_rows.first
					if attached {PREFERENCE} l_row.data then
						check l_row.count >= col_value_index end
						if
							l_row.count >= col_value_index and then
							attached l_row.item (col_value_index) as l_item and then
							attached {PREFERENCE_WIDGET} l_item.data as l_preference_widget
						then
							l_preference_widget.show
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
				if grid.has_selected_row then
					l_row :=  grid.selected_rows.first
					if
						l_row.count >= col_value_index and then
						attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_row.item (col_value_index) as l_boolean_widget
					then
						l_boolean_widget.toggle_is_checked
					end
				end
			else
				accelerator_on_key_pressed (k)
			end
		end

	on_description_key_pressed (a_key: EV_KEY)
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

	on_resize
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

	on_header_double_clicked
			-- Header was double-clicked.
		local
			div_index: INTEGER
			col: EV_GRID_COLUMN
		do
			div_index := grid.header.pointed_divider_index
			if div_index > 0 then
				col := grid.column (div_index)
				col.set_width (col.required_width_of_item_span (1, grid.row_count) + column_border_space)
			end
		end

	on_header_item_single_clicked (hi: detachable EV_HEADER_ITEM; ax,ay, a_but: INTEGER)
		local
			col_index: INTEGER
		do
			if
				not grid.is_tree_enabled and
				a_but = 1 and
					-- Let's be sure no divider is clicked
				grid.header.pointed_divider_index = 0 and then
				attached {EV_GRID_HEADER_ITEM} hi as ghi and then
				attached ghi.column as l_column
			then
				col_index := l_column.index
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

	on_header_item_resize (h: EV_HEADER_ITEM)
			-- Header was double-clicked.
		local
			div_index: INTEGER
		do
			div_index := grid.header.pointed_divider_index
			if div_index > 0 then
				resized_columns_list.put (True, grid.column (div_index).index)
			end
		end

feature {NONE} -- Implementation

	build_preference_name_to_display (a_pref: PREFERENCE): STRING_32
		do
			Result := a_pref.name
		ensure
			result_attached: Result /= Void
		end

	build_full_name_to_display (a_pref_name: READABLE_STRING_GENERAL): STRING_32
			-- Name to show on display for a preference name
		do
			Result := a_pref_name.as_string_32
		ensure
			result_attached: Result /= Void
		end

	build_structured
			-- Fill with preferences structured hierarchically.
		local
			l_pref_hash: STRING_TABLE [EV_GRID_ROW]
			l_pref_name,
			l_pref_parent_full_name: READABLE_STRING_GENERAL
			l_sorted_preferences: like sorted_known_preferences_by
			l_row: detachable EV_GRID_ROW
			l_pref: PREFERENCE
		do
			if grid.column_count >= flat_sorting_info.abs then
				grid.column (flat_sorting_info.abs).header_item.remove_pixmap
			end

			status_label.set_text (l_building_tree_view)
			status_label.refresh_now

				-- Alphabetically sort the known preferences
			l_sorted_preferences := sorted_known_preferences_by (-Name_sorting_mode, show_hidden_preferences, preferences.preferences)

			if l_sorted_preferences /= Void and then not l_sorted_preferences.is_empty then
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
						if show_hidden_preferences or else not l_pref.is_hidden then
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

	add_parent_structure_preference_row (a_pref_parent_full_name: READABLE_STRING_GENERAL; a_grid_structure: STRING_TABLE [EV_GRID_ROW])
		require
			structured_mode: grid.is_tree_enabled
			a_pref_parent_full_name_not_empty: not a_pref_parent_full_name.is_empty
			no_row_for_pref: not a_grid_structure.has (a_pref_parent_full_name)
		local
			l_parent_name: READABLE_STRING_GENERAL
			l_short_name: READABLE_STRING_GENERAL
			l_row: detachable EV_GRID_ROW
			l_grid_label: EV_GRID_LABEL_ITEM
		do
			if a_pref_parent_full_name.has ('.') then
				l_short_name := short_preference_name (a_pref_parent_full_name)
				l_parent_name := parent_preference_name (a_pref_parent_full_name)
				if not a_grid_structure.has (l_parent_name) then
					add_parent_structure_preference_row (l_parent_name, a_grid_structure)
				end
				l_row := a_grid_structure.item (l_parent_name)
				if l_row /= Void then
					l_row.insert_subrow (l_row.subrow_count + 1)
					l_row := l_row.subrow (l_row.subrow_count)
				else
						-- implied by `not a_grid_structure.has (l_parent_name)' and postcondition from `add_parent_structure_preference_row'
					check l_row /= Void then end
				end
			else
					--| Precondition requires `a_pref_parent_full_name' is not already inserted
					--| So it can only be a new top row
				l_short_name := a_pref_parent_full_name
				grid.insert_new_row (grid.row_count + 1)
				l_row := grid.row (grid.row_count)
			end
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

	build_flat
			-- Fill with preferences no structure, flat list.
		local
			l_sorted_preferences: like sorted_known_preferences_by
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
			if attached matches as m then
				l_sorted_preferences := sorted_known_preferences_by (flat_sorting_info, show_hidden_preferences, m)
			else
				l_sorted_preferences := sorted_known_preferences_by (flat_sorting_info, show_hidden_preferences, preferences.preferences)
			end

			if l_sorted_preferences /= Void and then not l_sorted_preferences.is_empty then
					-- Traverse the preferences in the system and add to grid list
				across
					l_sorted_preferences as p
				loop
					add_short_preference_row (Void, p.item)
				end
				update_grid_columns
			end
		end

	index_tuple_less_than (a, b: TUPLE [pref_name: STRING_32; index: STRING_32]): BOOLEAN
			-- Compare two tuples on their string index
		do
			Result := a.index < b.index
		end

	sorted_known_preferences_by (a_sorting_info: INTEGER; a_show_hidden: BOOLEAN; a_prefs_to_sort: ITERABLE [PREFERENCE]): LIST [PREFERENCE]
			-- Sorted known preferences using criteria `a_sorting_info'.
			-- Exclude hidden preferences when `a_show_hidden' is False.
		local
			l_known_pref_ht: STRING_TABLE [PREFERENCE]
			l_sorted_preferences: SORTED_TWO_WAY_LIST [PROXY_COMPARABLE [TUPLE [pref_name: STRING_32; index: STRING_32]]]
			l_compare_agent: PREDICATE [TUPLE [STRING_32, STRING_32], TUPLE [STRING_32, STRING_32]]
			l_proxy_comparable: PROXY_COMPARABLE [TUPLE [pref_name: STRING_32; index: STRING_32]]
			l_pref_index, l_pref_name, l_display_name: STRING_32
			l_pref: detachable PREFERENCE
			l_sorting_up: BOOLEAN
			l_sorting_criteria: INTEGER
		do
			l_sorting_up := a_sorting_info > 0
			l_sorting_criteria := a_sorting_info.abs
			l_compare_agent := agent index_tuple_less_than

				-- Alphabetically sort the known preferences
			create l_sorted_preferences.make
			across
				a_prefs_to_sort as p
			loop
				l_pref := p.item
				l_pref_name := l_pref.name
				l_display_name := build_full_name_to_display (l_pref_name)
				inspect l_sorting_criteria
				when Name_sorting_mode then --| Pref name
					l_pref_index := l_display_name
				when Type_sorting_mode then --| type name
					l_pref_index := l_pref.string_type.as_string_32 + "@" + l_display_name
				when Status_sorting_mode then --| type name
					create l_pref_index.make_empty
					if l_pref.is_default_value then
						l_pref_index.append (p_default_value)
					else
						l_pref_index.append (user_value)
					end
					if l_pref.is_auto then
						l_pref_index.append (auto_value)
					end
					l_pref_index.append ({STRING_32} "@")
					l_pref_index.append (l_display_name)
				else
					check False end
					create l_pref_index.make_empty
				end
				create l_proxy_comparable.make ([l_pref_name, l_pref_index], l_compare_agent)
				l_sorted_preferences.extend (l_proxy_comparable)
			end

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
				if
					attached l_known_pref_ht.item (l_pref_name) as p and then
					(a_show_hidden or not p.is_hidden)
				then
					Result.extend (p)
				end
				if l_sorting_up then
					l_sorted_preferences.forth
				else
					l_sorted_preferences.back
				end
			end
		end

	rebuild
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

	add_short_preference_row (a_row: detachable EV_GRID_ROW; a_pref: PREFERENCE)
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

	node_expanded (a_row: EV_GRID_ROW)
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

	preference_name_column (a_pref: PREFERENCE): EV_GRID_LABEL_ITEM
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

	preference_type_column (a_pref: PREFERENCE): EV_GRID_LABEL_ITEM
		do
			create Result
			Result.set_text (a_pref.string_type)
		ensure
			Result /= Void
		end

	preference_status_column (a_pref: PREFERENCE): EV_GRID_LABEL_ITEM
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

	preference_value_column (a_pref: PREFERENCE): EV_GRID_ITEM
			-- Grid item related to `a_pref'
		local
			l_bool_widget: BOOLEAN_PREFERENCE_WIDGET
			l_edit_widget: STRING_PREFERENCE_WIDGET
			l_choice_widget: CHOICE_PREFERENCE_WIDGET
			l_font_widget: FONT_PREFERENCE_WIDGET
			l_color_widget: COLOR_PREFERENCE_WIDGET
			l_shortcut_widget: SHORTCUT_PREFERENCE_WIDGET
		do
			if attached {BOOLEAN_PREFERENCE} a_pref as l_bool then
				l_bool_widget := new_boolean_widget (l_bool)
				l_bool_widget.change_actions.extend (agent on_preference_changed (?, l_bool_widget))
				Result := l_bool_widget.change_item_widget
				Result.set_data (l_bool_widget)
			elseif a_pref.generating_preference_type.is_equal ("TEXT") then
				create l_edit_widget.make_with_preference (a_pref)
				l_edit_widget.change_actions.extend (agent on_preference_changed (?, l_edit_widget))
				Result := l_edit_widget.change_item_widget
				Result.set_data (l_edit_widget)
			elseif a_pref.generating_preference_type.is_equal ("COMBO") and then
				attached {ABSTRACT_CHOICE_PREFERENCE [ANY]} a_pref as l_choice
			then
				l_choice_widget := new_choice_widget (l_choice)
				l_choice_widget.change_actions.extend (agent on_preference_changed (?, l_choice_widget))
				Result := l_choice_widget.change_item_widget
				Result.set_data (l_choice_widget)
			elseif attached {FONT_PREFERENCE} a_pref as l_font then
				create l_font_widget.make_with_preference (l_font)
				l_font_widget.change_actions.extend (agent on_preference_changed (?, l_font_widget))
				l_font_widget.set_caller (Current)
				Result := l_font_widget.change_item_widget
				Result.set_data (l_font_widget)
--				a_row.set_height (l_font.value.height.max (default_row_height))
			elseif attached {COLOR_PREFERENCE} a_pref as l_color then
				create l_color_widget.make_with_preference (l_color)
				l_color_widget.change_actions.extend (agent on_preference_changed (?, l_color_widget))
				l_color_widget.set_caller (Current)
				Result := l_color_widget.change_item_widget
				Result.set_data (l_color_widget)
			elseif attached {SHORTCUT_PREFERENCE} a_pref as l_shortcut then
				create l_shortcut_widget.make_with_preference (l_shortcut)
				l_shortcut_widget.change_actions.extend (agent on_preference_changed (?, l_shortcut_widget))
				Result := l_shortcut_widget.change_item_widget
				Result.set_data (l_shortcut_widget)
				l_shortcut.overridden_actions.wipe_out
				l_shortcut.overridden_actions.extend (agent on_shortcut_overriden (l_shortcut_widget))
				l_shortcut.modification_deny_actions.wipe_out
				l_shortcut.modification_deny_actions.extend (agent on_shortcut_modification_denied (l_shortcut))
			else
				create Result
				check should_not_occur: False end
			end
		end

	update_grid_columns
			-- Update the grid columns widths and borders depending on current display type
		local
			l_column: EV_GRID_COLUMN
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
				if attached {PREFERENCE} grid.row (col_name_index).data as l_preference then
					show_preference_description (l_preference)
				end
				if grid.is_displayed and grid.is_sensitive then
					grid.set_focus
				end
			end
		end

	toggle_view
			-- Toggle voew
		do
			if grid.is_tree_enabled then
				enable_flat_view
			else
				enable_tree_view
			end
		end

	toggle_hiddens
			-- Show/hide hiddens preferences
		do
			set_show_hidden_preferences (not show_hidden_preferences)
			display_hidden_button.select_actions.block
			if show_hidden_preferences then
				display_hidden_button.enable_select
			else
				display_hidden_button.disable_select
			end
			display_hidden_button.select_actions.resume
			rebuild
		end

	reset_grid_view
		do
			grid.clear
			grid.set_row_count_to (0)
			description_text.remove_text
			description_location.remove_text
		end

	enable_flat_view
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

	enable_tree_view
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

	update_status_bar
			-- Update status bar
		do
			if not grid.is_tree_enabled and attached matches as l_matches then
				status_label.set_text (l_matches_of_total_preferences (l_matches.count, preferences.preferences.count))
			else
				status_label.set_text (l_count_preferences (preferences.preferences.count.out))
			end
			status_label.refresh_now
		end

	resize_columns
			-- Resize all columns to it's contents.
		local
			col: EV_GRID_COLUMN
			p: like grid
			n: INTEGER
		do
			p := grid
			n := p.row_count
			if n > 0 then
				col := p.column (1)
				col.set_width (col.required_width_of_item_span (1, n) + column_border_space)
				col := p.column (2)
				col.set_width (col.required_width_of_item_span (1, n) + column_border_space)
				col := p.column (3)
				col.set_width (col.required_width_of_item_span (1, n) + column_border_space)
			end
		end

	pixmap_file_contents (pn: READABLE_STRING_GENERAL): EV_PIXMAP
			-- Load a pixmap in file named `pn'.
		require
			valid_file_name: pn /= Void
		local
			retried: BOOLEAN
			fullp: PATH
		do
			create Result
			if not retried then
				fullp := pixmaps_path_cell.item.extended (pn.to_string_32 + {STRING_32} "." + pixmaps_extension_cell.item)
				Result.set_with_named_path (fullp)
			end
		rescue
			retried := True
			retry
		end

	show_preference_description (a_preference: PREFERENCE)
			-- Show selected list preference in edit widget.
		require
			preference_not_void: a_preference /= Void
		local
			l_text: STRING_32
		do
			description_location.set_text (a_preference.name)
			if attached a_preference.description as d then
					-- We know that descriptions of preference have been extacted out
					-- from the config file.
				l_text := try_to_translate (d)
			else
				l_text := no_description_text
			end

			if a_preference.restart_required then
				description_text.set_text (l_text + l_request_restart)
			else
				description_text.set_text (l_text)
			end
		end

	clear_edit_widget
			-- Clear the edit widget
		do
			description_text.remove_text
			description_text.remove_text
		end

	short_preference_name (a_name: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- The short, non-unique name of a preference
		require
			name_not_void: a_name /= Void
		do
			Result := a_name.substring (a_name.last_index_of ('.', a_name.count) + 1, a_name.count)
		ensure
			a_name /= Result
		end

	parent_preference_name (a_name: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- The short, non-unique name of a preference
		require
			name_not_void: a_name /= Void
			name_has_parent: a_name.has ('.')
		do
			Result := a_name.substring (1, a_name.last_index_of ('.', a_name.count) - 1)
		ensure
			a_name /= Result
		end

	formatted_name (a_name: READABLE_STRING_GENERAL): STRING_32
			-- Formatted name for display.
		require
			not_empty: not a_name.is_empty
		do
			create Result.make_from_string_general (a_name)
			if not Result.has (' ') then
				Result.replace_substring_all ({STRING_32} "_", {STRING_32} " ")
			end
			Result [1] := Result [1].upper
		ensure
			a_name /= Result
		end

	grid_remove_and_clear_all_rows (g: EV_GRID)
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

	on_shortcut_overriden (a_shortcut_widget: SHORTCUT_PREFERENCE_WIDGET)
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

	on_shortcut_modification_denied (a_shortcut_pref: SHORTCUT_PREFERENCE)
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

	try_to_translate (a_string: READABLE_STRING_GENERAL): STRING_32
			-- Try to translate `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			Result := a_string.as_string_32
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Widgets initialization

	new_boolean_widget (a_pref: BOOLEAN_PREFERENCE): BOOLEAN_PREFERENCE_WIDGET
		require
			a_pref_not_void: a_pref /= Void
		do
			create Result.make_with_preference (a_pref)
		ensure
			Result_not_void: Result /= Void
		end

	new_choice_widget (a_pref: ABSTRACT_CHOICE_PREFERENCE [ANY]): CHOICE_PREFERENCE_WIDGET
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

	Name_sorting_mode: INTEGER = 1
	Type_sorting_mode: INTEGER = 2
	Status_sorting_mode: INTEGER = 3
	Value_sorting_mode: INTEGER = 4

feature {NONE} -- Filtering

	update_matches_timeout: detachable EV_TIMEOUT

	request_update_matches
		require
			in_flat_mode: not grid.is_tree_enabled
		local
			l_update_matches_timeout: like update_matches_timeout
		do
			cancel_delayed_update_matches
			l_update_matches_timeout := update_matches_timeout
			if l_update_matches_timeout = Void then
				create l_update_matches_timeout
				update_matches_timeout := l_update_matches_timeout
				l_update_matches_timeout.actions.extend_kamikaze (agent delayed_update_matches)
			end
			l_update_matches_timeout.set_interval (700)
		end

	update_matches_requested: BOOLEAN
		do
			Result := update_matches_timeout /= Void
		end

	cancel_delayed_update_matches
		do
			if attached update_matches_timeout as l_update_matches_timeout then
				l_update_matches_timeout.destroy
				update_matches_timeout := Void
			end
		end

	delayed_update_matches
		do
			cancel_delayed_update_matches
			update_matches
		end

	update_matches
			-- List of matches against `filter_text'
		require
			in_flat_mode: not grid.is_tree_enabled
		local
			s: STRING_32
			l_match_text: STRING_32
			l_matched: BOOLEAN
			l_preference: PREFERENCE
			l_prefs: like preferences.preferences
			l_filter_engine: KMP_WILD
			l_filter_also_value: BOOLEAN
			l_matches: like matches
		do
			status_label.set_text (l_updating_the_view)
			status_label.refresh_now

			matches := Void
			if not grid.is_tree_enabled and not update_matches_requested then
				l_prefs := preferences.preferences
				l_match_text := filter_text_box.text
				l_filter_also_value := filter_value_check_box.is_selected
				if not l_match_text.is_empty then
					create {ARRAYED_LIST [PREFERENCE]} l_matches.make (l_prefs.count)
					matches := l_matches
					if l_match_text.item (1) /= '*' then
						l_match_text.prepend_character ('*')
					end
					if l_match_text.item (l_match_text.count) /= '*' then
						l_match_text.append_character ('*')
					end
					create l_filter_engine.make_empty
					l_filter_engine.set_pattern (l_match_text)
					l_filter_engine.disable_case_sensitive
					across
						l_prefs  as p
					loop
						l_preference := p.item
						s := build_preference_name_to_display (l_preference)
						l_matched := False
						if not s.is_empty then
							l_filter_engine.set_text (s)
							l_matched := l_filter_engine.pattern_matches
						end
						if not l_matched and l_filter_also_value then
							s := l_preference.text_value
							if not s.is_empty then
								l_filter_engine.set_text (s)
								l_matched := l_filter_engine.pattern_matches
							end
						end
						if l_matched then
							l_matches.extend (l_preference)
						end
					end
				end
				if update_matches_requested then
					matches := Void
				else
						-- Sort the known preferences.
					l_matches :=
						if attached l_matches then
							sorted_known_preferences_by (Name_sorting_mode, show_hidden_preferences, l_matches)
						else
							sorted_known_preferences_by (Name_sorting_mode, show_hidden_preferences, l_prefs)
						end
					matches := l_matches
					if update_matches_requested then
						matches := Void
					else
						if grid.row_count > 0 then
							grid.remove_rows (1, grid.row_count)
						end
						grid.set_row_count_to (l_matches.count)
						update_status_bar
					end
				end
			end
		end

	matches: detachable LIST [PREFERENCE]

	initialize_row_for_preference (a_row: EV_GRID_ROW; a_preference: PREFERENCE)
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

	dynamic_content_function (c, r: INTEGER): EV_GRID_ITEM
			-- Function to compute the necessary EV_GRID_ITEM for grid co-ordinates c,r.
		require
			flat_mode: not grid.is_tree_enabled
		local
			l_preference: detachable PREFERENCE
			l_item: detachable EV_GRID_ITEM
		do
			if attached {PREFERENCE} grid.row (r).data as p then
				l_preference := p
			else
				if attached matches as l_matches and then l_matches.valid_index (r) then
					--| grid indexes start at 1
					--| list start at 1
					l_preference := l_matches.i_th (r)
					initialize_row_for_preference (grid.row (r), l_preference)
				end
			end

			if l_preference /= Void then
				inspect c
				when col_name_index then
					l_item := preference_name_column (l_preference)
				when col_type_index then
					l_item := preference_type_column (l_preference)
				when col_status_index then
					l_item := preference_status_column (l_preference)
				when col_value_index then
					l_item := preference_value_column (l_preference)
				else
					-- Should not get here.
				end
			end
			if l_item = Void then
				create Result
			else
				Result := l_item
			end
		end

feature {NONE} -- Private attributes

	show_full_preference_name: BOOLEAN
			-- Show the full name of the preference in the list?

	root_icon: detachable EV_PIXMAP note option: stable attribute end
			-- Icon for root node

	folder_icon: detachable EV_PIXMAP note option: stable attribute end
			-- Folder icon

	default_font: EV_FONT
			-- Font for row when value is a default value
		once
			create Result
		end

	non_default_font: EV_FONT
			-- Font for row when value is not a default value
		once
			create Result
			Result.set_weight ((create {EV_FONT_CONSTANTS}).weight_bold)
		end

	hidden_fg_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (127, 127, 127)
		end

	grid: EV_GRID
		-- Grid


	icon_up: EV_PIXMAP

	icon_down: EV_PIXMAP

	build_filter_icons
		local
			w,h: INTEGER
			bc: EV_COLOR
		do
			w := 16
			h := 16

			bc := (create {EV_STOCK_COLORS}).Default_background_color

			create icon_up.make_with_size (w, h)
			icon_up.set_background_color (bc)
			icon_up.clear
			icon_up.fill_polygon (<<
						create {EV_COORDINATE}.make_precise (0.2 * w, 0.2 * h),
						create {EV_COORDINATE}.make_precise (0.8 * w, 0.2 * h),
						create {EV_COORDINATE}.make_precise (0.5 * w, 0.6 * h)
					>>)
			create icon_down.make_with_size (w, h)
			icon_down.set_background_color (bc)
			icon_down.clear
			icon_down.fill_polygon (<<
				create {EV_COORDINATE}.make_precise (0.2 * w, 0.6 * h),
				create {EV_COORDINATE}.make_precise (0.8 * w, 0.6 * h),
				create {EV_COORDINATE}.make_precise (0.5 * w, 0.2 * h)
					>>)
		ensure
			icon_up /= Void
			icon_down /= Void
		end

	column_border_space: INTEGER = 3
			-- Padding space for column content

	default_row_height: INTEGER
			-- Default row height

	display_update_agent: PROCEDURE [PREFERENCE]
			-- Agent to be called when preference is changed outside	

	col_name_index: INTEGER = 1
			-- column index for name.

	col_type_index: INTEGER = 2
			-- column index for type.

	col_status_index: INTEGER = 3
			-- column index for status.

	col_value_index: INTEGER = 4
			-- column index for value.

	resized_columns_list: ARRAY [BOOLEAN]
			-- List of booleans for each column indicating if it has been user resizedat all.
		once
			Result := <<False, False, False, False>>
		end

invariant
	has_preferences: preferences /= Void

note
	ca_ignore:
		"CA011", "CA011: too many arguments",
		"CA033", "CA033: very large class"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

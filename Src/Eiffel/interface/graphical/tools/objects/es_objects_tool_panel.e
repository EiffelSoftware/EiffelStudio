note
	description: "Objects that represents the display of stack and debugged objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_TOOL_PANEL

inherit
	ES_DEBUGGER_DOCKABLE_STONABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			on_before_initialize,
			on_after_initialized,
			create_mini_tool_bar_items,
			internal_recycle,
			show
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	REFACTORING_HELPER

	ES_OBJECTS_GRID_SPECIFIC_LINE_CONSTANTS
		rename
			stack_id as position_stack,
			current_object_id as position_current,
			arguments_id as position_arguments,
			locals_id as position_locals,
			result_id as position_result,
			dropped_id as position_dropped
		end

	ES_OBJECTS_GRID_MANAGER

	VALUE_TYPES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		do
			cleaning_delay := preferences.debug_tool_data.delay_before_cleaning_objects_grid
			set_debugger_manager (tool_descriptor.debugger_manager)

			create displayed_objects.make
			grid_preferences := preferences.development_window_data.grid_preferences

			Precursor
		end

	build_tool_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_box: EV_HORIZONTAL_BOX
			stack_objects_grid, debugged_objects_grid: like objects_grid
		do
				--| Build interface

			create objects_grids.make (2)
			objects_grids.compare_objects
			create_objects_grid (interface_names.l_object_tool_left, first_grid_id)
			create_objects_grid (interface_names.l_object_tool_right, second_grid_id)

			stack_objects_grid := objects_grid (first_grid_id)
			debugged_objects_grid := objects_grid (second_grid_id)

			create split
			split.pointer_double_press_actions.extend (agent (i_split: EV_SPLIT_AREA; i_x, i_y, i_but: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
					do
						i_split.set_proportion ({REAL_32} 0.5)
					end(split, ?,?,?,?,?,?,?,?)
				)

				-- The `stack_objects_grid' and `debugged_objects_grid' are
				-- inserted into a temporary box to provide a padding of one pixel
				-- so that it appears that they have a border. This makes the distinction
				-- between the edges of the control and the split area more pronounced.

			create l_box
			l_box.set_border_width (1)
			l_box.set_background_color ((create {EV_STOCK_COLORS}).gray)
			split.set_first (l_box)
			l_box.extend (stack_objects_grid)

			create l_box
			l_box.set_border_width (1)
			l_box.set_background_color ((create {EV_STOCK_COLORS}).gray)
			split.set_second (l_box)
			l_box.extend (debugged_objects_grid)

			a_widget.extend (split)

				--| objects grid layout
			initialize_objects_grid_layout (preferences.debug_tool_data.is_stack_grid_layout_managed_preference, stack_objects_grid)
			initialize_objects_grid_layout (preferences.debug_tool_data.is_debugged_grid_layout_managed_preference, debugged_objects_grid)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor

				-- FIXME: Tool should be refactored to implement {ES_DOCKABLE_STONEABLE_TOOL_PANEL}
			register_action (content.drop_actions, agent add_debugged_object)
			register_action (content.drop_actions, agent drop_stack_element)

				--| Initialize various agent and special mecanisms
			init_delayed_cleaning_mecanism
			preferences.debug_tool_data.objects_tool_layout_preference.change_actions.extend (agent refresh_objects_layout_from_preference)

			refresh_objects_layout_from_preference (preferences.debug_tool_data.objects_tool_layout_preference)

				--| Attach the slices_cmd to the objects grid
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				objects_grids.item_for_iteration.grid.set_slices_cmd (slices_cmd)
				objects_grids.forth
			end
		end

	create_mini_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display on the window title
		local
			tbb: SD_TOOL_BAR_BUTTON
			scmd: EB_STANDARD_CMD
			wi: SD_TOOL_BAR_WIDGET_ITEM
        do
			create Result.make (7)

			create_header_box
			create wi.make (header_box)
			wi.set_name ("Location")
			header_box_widget := wi
			Result.extend (wi)

			create scmd.make
			scmd.set_mini_pixmap (pixmaps.mini_pixmaps.toolbar_dropdown_icon)
			scmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.toolbar_dropdown_icon_buffer)
			scmd.set_tooltip (interface_names.f_Open_object_tool_menu)
			scmd.enable_sensitive
			tbb := scmd.new_mini_sd_toolbar_item
			scmd.add_agent (agent open_objects_menu (tbb))
			Result.extend (tbb)

				--| Delete command
			create remove_debugged_object_cmd.make
			remove_debugged_object_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_delete_icon)
			remove_debugged_object_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_delete_icon_buffer)
			remove_debugged_object_cmd.set_tooltip (Interface_names.e_Remove_object)
			remove_debugged_object_cmd.add_agent (agent remove_selected_debugged_objects)
			tbb := remove_debugged_object_cmd.new_mini_sd_toolbar_item
			tbb.drop_actions.extend (agent remove_dropped_debugged_object)
			tbb.drop_actions.set_veto_pebble_function (agent is_removable_debugged_object)
			remove_debugged_object_cmd.enable_sensitive
			Result.extend (tbb)

			create slices_cmd.make (Current)
			slices_cmd.enable_sensitive
			Result.extend (slices_cmd.new_mini_sd_toolbar_item)

			Result.extend (object_viewer_cmd.new_mini_sd_toolbar_item)

			create hex_format_cmd.make (agent set_hexadecimal_mode (?))
			hex_format_cmd.enable_sensitive
			Result.extend (hex_format_cmd.new_mini_sd_toolbar_item)

			Result.extend (debugger_manager.object_storage_management_cmd.new_mini_sd_toolbar_item)
		end

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "6B736424-1729-0B6F-6DDD-8240F9F8FFD6"
		end

feature {NONE} -- Grid preferences

	grid_preferences: EB_GRID_PREFERENCES

feature {NONE} -- Factory

    create_widget: EV_VERTICAL_BOX
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
        do
        	Create Result
        end

	create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		do
		end

	create_header_box
		do
			create header_box
		ensure
			header_box /= Void
		end

feature {ES_OBJECTS_TOOL_LAYOUT_EDITOR} -- Internal properties

	first_grid_id: STRING = "1"

	second_grid_id: STRING = "2"

	reset_objects_grids_contents_to_default
		local
			lst: LIST [INTEGER]
		do
			dropped_objects_grid := Void
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				lst := objects_grids.item_for_iteration.ids
				lst.wipe_out
				if objects_grids.key_for_iteration.is_equal (first_grid_id) then
					lst.extend (position_stack)
					lst.extend (position_current)
					lst.extend (position_arguments)
					lst.extend (position_locals)
					lst.extend (position_result)
					if dropped_objects_grid /= Void then
						ids_from_objects_grid (dropped_objects_grid.id).prune_all (position_dropped)
					end
					lst.extend (position_dropped)
					dropped_objects_grid := objects_grids.item_for_iteration.grid
				end
				objects_grids.forth
			end
		end

	objects_grids_contents: ARRAYED_LIST [STRING]
			--
		local
			lst: LIST [INTEGER]
			nb: INTEGER
			s: STRING
		do
			from
				nb := 0
				objects_grids.start
			until
				objects_grids.after
			loop
				nb := nb + 1 + objects_grids.item_for_iteration.ids.count
				objects_grids.forth
			end

			create Result.make (nb)
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				s := objects_grids.key_for_iteration.twin
				s.prepend_character ('#')
				Result.extend (s)
				lst := objects_grids.item_for_iteration.ids
				from
					lst.start
				until
					lst.after
				loop
					Result.extend (lst.item.out)
					lst.forth
				end
				objects_grids.forth
			end
		ensure
			Result_has_no_void_item: not Result.has (Void)
		end

	Position_entries: ARRAY [INTEGER]
		once
			Result := <<
							position_stack,
							position_current,
							position_arguments,
							position_locals,
							position_result,
							position_dropped
					>>
		end

	objects_grids: HASH_TABLE [like objects_grid_data, STRING]
			-- Contains the stack and debugged objects grids

	objects_grid_ids: LIST [STRING]
			-- Grid id of all the objects_grids
		local
			ht: like objects_grids
		do
			ht := objects_grids
			create {ARRAYED_LIST [STRING]} Result.make (ht.count)
			from
				ht.start
			until
				ht.after
			loop
				Result.extend (ht.key_for_iteration)
				ht.forth
			end
		end

	objects_grid (a_id: STRING): ES_OBJECTS_GRID
			-- Objects grid identified by `a_id'.
		require
			a_id /= Void
		do
			Result := objects_grids.item (a_id).grid
		end

	ids_from_objects_grid (a_id: STRING): LIST [INTEGER]
			-- Objects grid's contents identified by `a_id'.
		require
			a_id /= Void
		do
			Result := objects_grids.item (a_id).ids
		end

	objects_grid_data (a_id: STRING): TUPLE [grid:ES_OBJECTS_GRID; grid_is_empty:BOOLEAN;
						layout_initialized:BOOLEAN;
						ids:LIST[INTEGER]; lines:LIST[ES_OBJECTS_GRID_SPECIFIC_LINE]
					]
			-- Objects grid identified by `a_id'.
		require
			a_id /= Void
		do
			Result := objects_grids.item (a_id)
		end

	dropped_objects_grid: ES_OBJECTS_GRID

feature {NONE} -- Interface

	create_objects_grid (a_name: STRING_GENERAL; a_id: STRING)
			-- Create an objects grid named `a_name' and identified by `a_id'
		local
			spref: STRING_PREFERENCE
			g: like objects_grid
		do
			create g.make_with_name (a_name, a_id)

			objects_grids.force ([g, True, False, create {ARRAYED_LIST[INTEGER]}.make (6) ,create {ARRAYED_LIST[ES_OBJECTS_GRID_SPECIFIC_LINE]}.make (6)], a_id)

			g.set_objects_grid_item_function (agent objects_grid_object_line)
			spref := preferences.debug_tool_data.grid_column_layout_preference_for (g.id)
			g.set_default_columns_layout (
						<<
							[g.col_name_id, 	True,  False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (150), interface_names.l_name, interface_names.to_name],
							[g.col_value_id, 	True,  False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (150), interface_names.l_value, interface_names.to_value],
							[g.col_type_id, 	True,  False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (200), interface_names.l_type, interface_names.to_type],
							[g.col_address_id, 	True,  False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size  (80), interface_names.l_address, interface_names.to_address],
							[g.col_scoop_pid_id, True, False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size  (30), interface_names.l_scoop_pid, interface_names.to_scoop_pid],
							[g.col_context_id, 	False, False,   0, interface_names.l_context_dot, interface_names.to_context_dot]
						>>
					)
			g.set_columns_layout_from_string_preference (preferences.debug_tool_data.grid_column_layout_preference_for (g.id))

				-- Set scrolling preferences.
			g.set_mouse_wheel_scroll_size (preferences.editor_data.mouse_wheel_scroll_size)
			g.set_mouse_wheel_scroll_full_page (preferences.editor_data.mouse_wheel_scroll_full_page)
			g.set_scrolling_common_line_count (preferences.editor_data.scrolling_common_line_count)
			preferences.editor_data.mouse_wheel_scroll_size_preference.typed_change_actions.extend (
				agent g.set_mouse_wheel_scroll_size)
			preferences.editor_data.mouse_wheel_scroll_full_page_preference.typed_change_actions.extend (
				agent g.set_mouse_wheel_scroll_full_page)
			preferences.editor_data.scrolling_common_line_count_preference.typed_change_actions.extend (
				agent g.set_scrolling_common_line_count)

				-- Key actions
			g.key_press_actions.extend (agent debug_value_key_action (g, ?))

				-- PND settings
			g.drop_actions.extend (agent object_stone_dropped_on_grid (g, ?))
			g.drop_actions.set_veto_pebble_function (agent grid_veto_pebble_function (g, ?))

				-- Select/Unselect behavior
			g.row_select_actions.extend (agent on_objects_row_selected)
			g.row_deselect_actions.extend (agent on_objects_row_deselected)

			g.set_pre_activation_action (agent pre_activate_cell)

			g.set_configurable_target_menu_mode
			g.set_configurable_target_menu_handler (agent context_menu_handler (?, ?, ?, ?, g))
		end

	open_objects_menu (tbi: SD_TOOL_BAR_ITEM)
			-- Open objects tool menu
		require
			is_initialized: is_initialized
		local
			m: EV_MENU
		do
			m := tool_menu (True)
			if m /= Void then
				if tbi /= Void and then attached tbi.rectangle as rect then
					m.show_at (mini_toolbar, rect.x, rect.y)
				else
					m.show_at (mini_toolbar, 0, 0)
				end
			end
		end

	reset_objects_grids_positions
			-- Reset Objects tool grids positions
		local
			apref: ARRAY_PREFERENCE
		do
			reset_objects_grids_contents_to_default
			apref := preferences.debug_tool_data.objects_tool_layout_preference
			apref.set_value (objects_grids_contents.to_array) --| Should trigger "update"				
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_grid: ES_OBJECTS_GRID )
			-- Context menu handler
		do
			develop_window.menus.context_menu_factory.object_tool_menu (a_menu, a_target_list, a_source, a_pebble, Current, a_grid)
		end

feature -- preference

	change_objects_layout_preference_value (ar: ARRAY [STRING])
		local
			apref: ARRAY_PREFERENCE
		do
			apref := preferences.debug_tool_data.objects_tool_layout_preference
			apref.set_value (ar) --| Should trigger "update"
		end

	refresh_objects_layout_from_preference (p: ARRAY_PREFERENCE)
			-- Refresh the layout using preference `p'
		local
			error_occurred: BOOLEAN
			vals: ARRAY [STRING]
			l_id: STRING
			s: STRING
			i, si: INTEGER
			lst: LIST [INTEGER]
		do
			vals := p.value
			if not error_occurred and (vals /= Void and then not vals.is_empty) then
				from
					i := vals.lower
				until
					i > vals.upper
				loop
					s := vals [i]
					if s = Void or else s.is_empty then
						error_occurred := True
					elseif s.item (1) = '#' then
						l_id := s.substring (2, s.count)
						lst := ids_from_objects_grid (l_id)
						if lst /= Void then
							lst.wipe_out
						end
					elseif lst /= Void and s.is_integer then
						si := s.to_integer
						if i = position_dropped then
							if dropped_objects_grid /= Void then
								ids_from_objects_grid (dropped_objects_grid.id).prune_all (position_dropped)
							end
							dropped_objects_grid := objects_grid (l_id)
						end
						if not lst.has (si) then
							lst.extend (si)
						end
					else
						error_occurred := True
					end
					i := i + 1
				end
				if not error_occurred then
					lst := ids_from_objects_grid (second_grid_id)
					if lst = Void or else lst.is_empty then
						split.second.hide
					elseif not split.second.is_show_requested then
						split.second.show
					end
					split.show
					update
				end
			end
			if error_occurred or (vals = Void or else vals.is_empty) then
				reset_objects_grids_positions
			end
		rescue
			error_occurred := True
			retry
		end

	save_grids_preferences
			-- Save grids preferences
		require
			is_initialized: is_initialized
		local
			g: like objects_grid
		do
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				g := objects_grids.item_for_iteration.grid
				g.save_columns_layout_to_string_preference (
					preferences.debug_tool_data.grid_column_layout_preference_for (g.id)
					)
				objects_grids.forth
			end
		end

feature -- Access

	header_box_widget: SD_TOOL_BAR_WIDGET_ITEM
			-- header box item

	header_box: EV_HORIZONTAL_BOX
			-- Associated header box

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

feature -- Status report

	split_exists: BOOLEAN
		do
			Result := split /= Void
		end

	split_proportion: REAL
		require
			split_exists: split_exists
		do
			Result := (split.split_position / split.width).truncated_to_real
		end

	set_split_proportion (p: like split_proportion)
		do
			if attached split as l_split then
				l_split.set_proportion (p)
			end
		end

feature -- Menu

	open_objects_tool_layout_editor
			-- Open layout editor
		local
			dlg: ES_OBJECTS_TOOL_LAYOUT_EDITOR
		do
			create dlg.make
			dlg.set_is_modal (True)
			dlg.show_on_active_window
			dlg.recycle
		end

	tool_menu (for_tool: BOOLEAN): EV_MENU
			-- Menu for Current tool.
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
		do
			if objects_grids /= Void and then not objects_grids.is_empty then
				create m
				Result := m
				if for_tool then
					create mi.make_with_text (interface_names.m_objects_tool_layout_menu_title)
					m.extend (mi)
					mi.disable_sensitive
					m.extend (create {EV_MENU_SEPARATOR})
				else
					m.set_text (interface_names.m_objects_tool_layout_menu_title)
				end

				create mi.make_with_text (interface_names.m_objects_tool_layout_editor_title)
				mi.select_actions.extend (agent open_objects_tool_layout_editor)
				m.extend (mi)

				create mi.make_with_text (interface_names.m_objects_tool_layout_reset)
				mi.select_actions.extend (agent reset_objects_grids_positions)
				m.extend (mi)
			end
		end

feature {NONE} -- Notebook item's behavior

	header_class_label: EV_LABEL
			-- Label to display class information in `header_box'.

	header_text_label: EV_LABEL
			-- Label to display information in `header_box'.

	header_feature_label: EV_LABEL
			-- Label to display feature information in `header_box'.

	clean_header_box
		do
			if header_box /= Void then
				header_box.wipe_out
				if header_box_widget /= Void then
					header_box_widget.replace_widget (header_box)
					header_box_widget.update_parent_tool_bar_size
				end
				if
					content /= Void and then
					content.is_docking_manager_attached and then
					not content.is_destroyed
				then
					content.update_mini_tool_bar_size
				end
			end
		ensure
			header_box /= Void implies header_box.count = 0
		end

	update_header_box (dbg_stopped: BOOLEAN)
		require
			header_box /= Void
		local
			app: APPLICATION_EXECUTION
			l_fstone: FEATURE_STONE
			l_cstone: CLASSC_STONE
			hbox: like header_box
			sep: EV_CELL
		do
			hbox := header_box
			if hbox /= Void then
				if header_text_label = Void or else header_text_label.parent /= hbox then
					clean_header_box

					create header_class_label
					header_class_label.set_foreground_color (preferences.editor_data.class_text_color)
					hbox.extend (header_class_label)
					hbox.disable_item_expand (header_class_label)

					create header_text_label
					hbox.extend (header_text_label)
					hbox.disable_item_expand (header_text_label)

					create header_feature_label
					header_feature_label.set_foreground_color (preferences.editor_data.feature_text_color)
					hbox.extend (header_feature_label)
					hbox.disable_item_expand (header_feature_label)

					create sep
					sep.set_minimum_width (20)
					hbox.extend (sep)
					hbox.disable_item_expand (sep)
				end
				check
					header_class_label /= Void
					header_text_label /= Void
					header_feature_label /= Void
					header_text_label.parent = header_box
				end
				if
					debugger_manager.application_is_executing
				then
					app := debugger_manager.application
					if app.is_stopped and then dbg_stopped then
						if not app.current_call_stack_is_empty then
							if attached {EIFFEL_CALL_STACK_ELEMENT} current_stack_element as ecse then
								header_class_label.set_text ("{" + ecse.dynamic_class.name_in_upper.twin + "}")
								create l_cstone.make (ecse.dynamic_class)
								header_class_label.set_pebble (l_cstone)
								header_class_label.set_accept_cursor (l_cstone.stone_cursor)
								header_class_label.set_deny_cursor (l_cstone.x_stone_cursor)

								header_text_label.set_text (".")

								header_feature_label.set_text (ecse.routine_name_for_display)
								if attached ecse.routine as r then
									create l_fstone.make (r)
									header_feature_label.set_pebble (l_fstone)
									header_feature_label.set_accept_cursor (l_fstone.stone_cursor)
									header_feature_label.set_deny_cursor (l_fstone.x_stone_cursor)
								end
							end
						else
							header_class_label.remove_text
							header_text_label.set_text (Interface_names.l_unknown_status)
							header_feature_label.remove_text
						end
					else
						header_class_label.remove_text
						header_text_label.set_text (Interface_names.l_System_running)
						header_feature_label.remove_text
					end
				else
					header_class_label.remove_text
					header_text_label.set_text (Interface_names.l_System_not_running)
					header_feature_label.remove_text
				end


				header_class_label.refresh_now
				header_text_label.refresh_now
				header_feature_label.refresh_now
				hbox.refresh_now
			end
			if header_box_widget /= Void then
				header_box_widget.update_parent_tool_bar_size
			end
			content.update_mini_tool_bar_size
		end

feature {ES_OBJECTS_GRID_SLICES_CMD} -- Query

	objects_grid_object_line (addr: DBG_ADDRESS): ES_OBJECTS_GRID_OBJECT_LINE
			-- Return managed object located at address `addr'.
		local
			found: BOOLEAN
		do
			from
				displayed_objects.start
			until
				displayed_objects.after or else found
			loop
				Result := displayed_objects.item
				check
					Result.object_address /= Void
				end
				found := Result.object_address.is_equal (addr)
				displayed_objects.forth
			end
			if not found then
				Result := Void
			end
		end

feature -- Properties setting

	set_hexadecimal_mode (v: BOOLEAN)
		do
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				objects_grids.item_for_iteration.grid.set_hexadecimal_mode (v)
				objects_grids.forth
			end
		end

feature {NONE} -- Row actions	

	on_objects_row_selected (row: EV_GRID_ROW)
			-- An item in the list of expression was selected.
		do
			if
				attached {like objects_grid} row.parent as g and then
				g = dropped_objects_grid and then
				attached {ES_OBJECTS_GRID_OBJECT_LINE} row.data as gline and then
				is_removable_debugged_object_line (gline)
			then
				remove_debugged_object_cmd.enable_sensitive
			else
				remove_debugged_object_cmd.disable_sensitive
			end
		end

	on_objects_row_deselected (row: EV_GRID_ROW)
			-- An item in the list of expression was selected.
		do
			remove_debugged_object_cmd.disable_sensitive
		end

feature {NONE} -- event handlers

	on_stone_changed (a_old_stone: detachable like stone)
			-- Assign `a_stone' as new stone.
		do
			if can_refresh then
				if attached {CALL_STACK_STONE} stone as conv_stack then
					update
				end
			end
		end

feature -- Change

	enable_refresh
			-- Set `can_refresh' to `True'.
		do
				-- FIXME: this should be useless now, to check
			can_refresh := True
		end

	disable_refresh
			-- Set `can_refresh' to `False'.
		do
				-- FIXME: this should be useless now, to check
			can_refresh := False
		end

	refresh
			-- Refresh current grid
			--| Could be optimized to refresh only grid's content display ..
		do
			record_grids_layout
			update
		end

	set_debugger_manager (a_manager: like debugger_manager)
			-- Affect `a_manager' to `debugger_manager'.
		do
			debugger_manager := a_manager
		end

	show
			-- Show tool.
		local
			l_grid: like objects_grid
		do
			Precursor
			l_grid := objects_grid (first_grid_id)
			if not l_grid.is_destroyed and then l_grid.is_displayed and then l_grid.is_sensitive then
				l_grid.set_focus
			end
			request_update
		end

feature {NONE} -- Update

	on_update_when_application_is_executing (dbg_stopped: BOOLEAN)
			-- Update when debugging
		do
		end

	on_update_when_application_is_not_executing
			-- Update when not debugging
		do
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				objects_grids.item_for_iteration.grid.reset_layout_recorded_values
				objects_grids.forth
			end
		end

	real_update (dbg_was_stopped: BOOLEAN)
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running
		local
			l_app: APPLICATION_EXECUTION
			l_status: APPLICATION_STATUS
			l_grids: like objects_grids
			l_dropped_objects_grid: like dropped_objects_grid
			g: like objects_grid
			lines: LIST [ES_OBJECTS_GRID_SPECIFIC_LINE]
			t: like objects_grid_data
		do
			l_grids := objects_grids
			from
				l_grids.start
			until
				l_grids.after
			loop
				l_grids.item_for_iteration.grid.handle_project_specific_columns
				l_grids.item_for_iteration.grid.request_delayed_clean
				l_grids.forth
			end

			if debugger_manager.application_is_executing then
				l_app := debugger_manager.application
				l_status := l_app.status
			end
			if l_status /= Void then
				if
					l_status.is_stopped and (dbg_was_stopped or l_status.break_on_assertion_violation_pending)
				then
					if l_status.has_valid_call_stack and then l_status.has_valid_current_eiffel_call_stack_element then
						init_specific_lines
						from
							l_grids.start
						until
							l_grids.after
						loop
							l_grids.item_for_iteration.grid.cancel_delayed_clean
							l_grids.forth
						end
						from
							l_dropped_objects_grid := dropped_objects_grid
							l_grids.start
						until
							l_grids.after
						loop
							t := l_grids.item_for_iteration
							g := t.grid
							g.call_delayed_clean
							t.grid_is_empty := False

							lines := t.lines
							from
								lines.start
							until
								lines.after
							loop
								if attached lines.item as l_line then
									l_line.attach_to_row (g.extended_new_row)
								else --| Void is the place for displayed objects
									if l_dropped_objects_grid = g then
										add_displayed_objects_to_grid (g)
									end
								end
								lines.forth
							end
							if g.row_count > 0 then
									--| be sure the grid is redrawn, and the first row is visible
								if attached g.row (1) as l_row_1 then
									l_row_1.redraw
								end
							end
							g.restore_layout
							l_grids.forth
						end
					end
				end
			end
			update_header_box (dbg_was_stopped or (l_status /= Void and then l_status.break_on_assertion_violation_pending))
			on_objects_row_deselected (Void) -- reset toolbar buttons
		end

feature -- Status report

	can_refresh: BOOLEAN
			-- Should we display the trees when a stone is set?

feature -- Status Setting

	reset_tool
			-- Reset tool
		local
			g: like objects_grid
			t: like objects_grid_data
			l: ES_OBJECTS_GRID_SPECIFIC_LINE
			lines: LIST [ES_OBJECTS_GRID_SPECIFIC_LINE]
		do
			reset_update_on_idle
			if is_initialized then
				displayed_objects.wipe_out
				from
					objects_grids.start
				until
					objects_grids.after
				loop
					t := objects_grids.item_for_iteration
					lines := t.lines
					from
						lines.start
					until
						lines.after
					loop
						l := lines.item
						if l /= Void then
							l.reset
						end
						lines.forth
					end

					g := t.grid
					g.call_delayed_clean
					g.reset_layout_manager
					objects_grids.forth
				end
			end
			clean_header_box
		end

feature {NONE} -- Memory management

	internal_recycle
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			reset_tool
			Precursor
		end

feature {ES_OBJECTS_TOOL} -- Cleaning timer change

	update_cleaning_delay (ms: INTEGER)
			-- Set cleaning delay to object grids
		require
			is_initialized: is_initialized
			delay_positive_or_null: ms >= 0
		local
			g: like objects_grid
		do
			cleaning_delay := ms
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				g := objects_grids.item_for_iteration.grid
				if g.delayed_cleaning_exists then
					g.set_cleaning_delay (cleaning_delay)
				end
				objects_grids.forth
			end
		ensure
			cleaning_delay = ms
		end

	init_delayed_cleaning_mecanism
		local
			g: like objects_grid
		do
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				g := objects_grids.item_for_iteration.grid
				if not g.delayed_cleaning_exists then
					g.build_delayed_cleaning
					g.set_cleaning_delay (cleaning_delay)
					g.set_delayed_cleaning_action (agent action_clean_objects_grid (g.id))
				end
				objects_grids.forth
			end
		end

feature {NONE} -- grid Layout Implementation

--	keep_object_reference_fixed (addr: STRING) is
--		do
--			if debugger_manager.application_is_executing then
--				debugger_manager.application_status.keep_object (addr)
--			end
--		end

	cleaning_delay: INTEGER
			-- Number of milliseconds waited before clearing debug output.
			-- By waiting for a short period of time, the flicker is removed
			-- for normal debug usage as it is only cleared immediately before
			-- being rebuilt, unless the timer period has been exceeded.

	current_stack_class_feature_identification: STRING_32
		local
			cse: CALL_STACK_ELEMENT
		do
			cse := current_stack_element
			if cse /= Void then
				Result := cse.class_name + "." + cse.routine_name
			end
		end

feature {NONE} -- Stack grid Layout Implementation

	initialize_objects_grid_layout (pv: BOOLEAN_PREFERENCE; g: like objects_grid)
		require
			not objects_grids.item (g.id).layout_initialized
			g.layout_manager = Void
		do
			g.initialize_layout_management (pv)
			check
				g.layout_manager /= Void
			end
			g.layout_manager.set_global_identification_agent (agent current_stack_class_feature_identification)
			objects_grids.item (g.id).layout_initialized := True
		end

	action_clean_objects_grid (g_id: STRING)
		local
			t: like objects_grid_data
		do
			t := objects_grid_data (g_id)
			if not t.grid_is_empty then
				t.grid.default_clean
				t.grid_is_empty := True
			end
		ensure
			objects_grid_cleaned: objects_grid_data (g_id).grid_is_empty
		end

feature -- grid Layout access

	record_grids_layout
		local
			g: like objects_grid
			lines: LIST [ES_OBJECTS_GRID_SPECIFIC_LINE]
		do
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				lines := objects_grids.item_for_iteration.lines
				from
					lines.start
				until
					lines.after
				loop
					if lines.item /= Void then
						lines.item.record_layout
					end
					lines.forth
				end
				g := objects_grids.item_for_iteration.grid
				if g.row_count > 0 then
					g.record_layout
				end
				objects_grids.forth
			end
		end

feature {NONE} -- Commands Implementation

	remove_debugged_object_cmd: EB_STANDARD_CMD
			-- Command that is used to remove objects from the tree.

	object_viewer_cmd: EB_OBJECT_VIEWER_COMMAND
		do
			Result := debugger_manager.object_viewer_cmd
		end

feature {NONE} -- Implementation

	current_stack_element: CALL_STACK_ELEMENT
			-- Stack element currently displayed in `stack_objects_grid'.
		local
			l_status: APPLICATION_STATUS
		do
			l_status := debugger_manager.application_status
			if l_status.current_call_stack /= Void then
				Result := l_status.current_call_stack_element
			end
		end

	split: EV_HORIZONTAL_SPLIT_AREA
			-- Split area that contains both `stack_objects_grid' and `debugged_objects_grid'.

feature {NONE} -- Current objects grid Implementation

	displayed_objects: LINKED_LIST [ES_OBJECTS_GRID_OBJECT_LINE];
			-- All displayed objects, their addresses, types and display options.

	add_displayed_objects_to_grid (a_target_grid: ES_OBJECTS_GRID)
		local
			item: ES_OBJECTS_GRID_LINE
		do
			from
				displayed_objects.start
			until
				displayed_objects.after
			loop
				item := displayed_objects.item
				if item.is_attached_to_row then
					item.unattach
				end
				if item.parent_grid /= a_target_grid then
					item.relocate_to_parent_grid (a_target_grid)
				end
				item.attach_to_row (a_target_grid.extended_new_row)
				displayed_objects.forth
			end
		end

feature {NONE} -- Impl : Debugged objects grid specifics

	object_stone_dropped_on_grid (a_grid: like objects_grid; st: OBJECT_STONE)
		do
			if attached {CALL_STACK_STONE} st as cst then
				drop_stack_element (cst)
			else
				check a_grid = dropped_objects_grid end
				add_debugged_object (st)
			end
		end

	grid_veto_pebble_function (a_grid: like objects_grid; a_pebble: ANY): BOOLEAN
		do
			if a_grid = dropped_objects_grid then
				Result := attached {OBJECT_STONE} a_pebble
			else
				Result := attached {CALL_STACK_STONE} a_pebble
			end
		end

	add_debugged_object (a_stone: OBJECT_STONE)
			-- Add the object represented by `a_stone' to the managed objects.
		require
			application_is_running: debugger_manager.application_is_executing
			dropped_objects_grid_not_void: dropped_objects_grid /= Void
		local
			l_stone_addr: DBG_ADDRESS
			n_obj: ES_OBJECTS_GRID_OBJECT_LINE
			exists: BOOLEAN
			l_item: EV_ANY
			g: like objects_grid
		do
			debug ("debug_recv")
				print (generator + ".add_object%N")
			end
			g := dropped_objects_grid
			l_stone_addr := a_stone.object_address
			from
				displayed_objects.start
			until
				displayed_objects.after or else exists
			loop
				n_obj := displayed_objects.item
				check
					n_obj.object_address /= Void
				end
				exists := n_obj.object_address.is_equal (l_stone_addr)
				displayed_objects.forth
			end
			n_obj := Void
			if not exists then
				l_item := a_stone.ev_item
				if l_item /= Void then
					if debugger_manager.is_dotnet_project then
						if attached {ABSTRACT_DEBUG_VALUE} grid_data_from_widget (l_item) as abstract_value then
							--| FIXME jfiat : check if it is safe to use a Value ?
							create {ES_OBJECTS_GRID_VALUE_LINE} n_obj.make_with_value (abstract_value, g)
						end
					else
						if attached {SPECIAL_VALUE} grid_data_from_widget (l_item) as conv_spec then
							create {ES_OBJECTS_GRID_VALUE_LINE} n_obj.make_with_value (conv_spec, g)
						end
					end
				end
				if n_obj = Void then
					create {ES_OBJECTS_GRID_ADDRESS_LINE} n_obj.make_with_address (l_stone_addr, a_stone.dynamic_class, g)
				end

				n_obj.set_title (a_stone.name + Left_address_delim + l_stone_addr.output + Right_address_delim)
				debugger_manager.application_status.keep_object (l_stone_addr)
				displayed_objects.extend (n_obj)
				g.insert_new_row (g.row_count + 1)
				n_obj.attach_to_row (g.row (g.row_count))
				if attached n_obj.row as l_row then
					if l_row.is_displayed then
						l_row.ensure_visible
					end
					l_row.enable_select
				end
			end
		end

	remove_dropped_debugged_object (ost: OBJECT_STONE)
		require
			ost_attached: ost /= Void
		do
			if attached {EV_GRID_ROW} ost.ev_item as row then
				if
					(attached {ES_OBJECTS_GRID_OBJECT_LINE} row.data as gline)
					and then (is_removable_debugged_object_line (gline))
				then
					remove_debugged_object_line (gline)
				end
			end
		end

	remove_selected_debugged_objects
		local
			glines: LIST [ES_OBJECTS_GRID_OBJECT_LINE]
			line: ES_OBJECTS_GRID_OBJECT_LINE
			line_row: EV_GRID_ROW
		do
			glines := selected_debugged_object_lines
			if glines /= Void then
				from
					glines.start
				until
					glines.after
				loop
					line := glines.item
					check attached line end

					line_row := line.row
					check attached line_row end
					if
						is_removable_debugged_object_line (line)
					then
						remove_debugged_object_line (line)
					end
					glines.forth
				end
			end
		end

	remove_debugged_object_line (gline: ES_OBJECTS_GRID_OBJECT_LINE)
		require
			gline_not_void: gline /= Void
			removable: is_removable_debugged_object_line (gline)
		local
			row: EV_GRID_ROW
		do
			row := gline.row
			gline.unattach
			displayed_objects.prune_all (gline)
			if attached gline.parent_grid as g then
--| bug#11272 : using the next line raises display issue:
--|				g.remove_row (row.index)
				g.remove_rows (row.index, row.index + row.subrow_count_recursive)
			end
		end

	selected_debugged_object_lines: LINKED_LIST [ES_OBJECTS_GRID_OBJECT_LINE]
		local
			row: EV_GRID_ROW
			rows: ARRAYED_LIST [EV_GRID_ROW]
			g: like objects_grid
		do
			g := dropped_objects_grid
			rows := g.selected_rows
			if not rows.is_empty then
				from
					rows.start
					create Result.make
				until
					rows.after
				loop
					row := rows.item
					if attached {ES_OBJECTS_GRID_OBJECT_LINE} row.data as gline then
						Result.extend (gline)
					end
					rows.forth
				end
			end
		end

	is_removable_debugged_object (a_stone: ANY): BOOLEAN
		do
			if attached {OBJECT_STONE} a_stone as ost then
				if attached {EV_GRID_ROW} ost.ev_item as row then
					Result := is_removable_debugged_object_row (row)
				end
				Result := Result and then is_removable_debugged_object_address (ost.object_address)
			end
		end

	is_removable_debugged_object_line (a_line: ES_OBJECTS_GRID_OBJECT_LINE): BOOLEAN
			-- `a_line' is removable?
		do
			Result := is_removable_debugged_object_row (a_line.row)
					and then is_removable_debugged_object_address (a_line.object_address)
					and then (
							(not attached {ES_OBJECTS_GRID_SPECIFIC_LINE} a_line) and
							not a_line.is_read_only
						) --| might be only `not line.is_read_only'
		end

	is_removable_debugged_object_row (row: EV_GRID_ROW): BOOLEAN
		require
			row_attached: row /= Void
		do
			Result := row.parent_row = Void
		end

	is_removable_debugged_object_address (addr: detachable DBG_ADDRESS): BOOLEAN
		do
			if addr /= Void then
				from
					displayed_objects.start
				until
					displayed_objects.after or else Result
				loop
					if attached {DBG_ADDRESS} displayed_objects.item.object_address as oa then
						Result := oa.is_equal (addr)
					end
					displayed_objects.forth
				end
			end
		end

feature {NONE} -- Impl : Stack objects grid

	drop_stack_element (st: CALL_STACK_STONE)
			-- Display stack element represented by `st'.
		do
			debugger_manager.launch_stone (st)
		end

	debug_value_key_action (grid: ES_OBJECTS_GRID; k: EV_KEY)
			-- Actions performed when a key is pressed on a debug_value.
			-- Handle `Ctrl+C'.
		do
			inspect
				k.code
			when {EV_KEY_CONSTANTS}.key_c , {EV_KEY_CONSTANTS}.key_insert then
				if
					ev_application.ctrl_pressed
					and then not ev_application.alt_pressed
					and then not ev_application.shift_pressed
				then
					update_clipboard_string_with_selection (grid)
				end
			when {EV_KEY_CONSTANTS}.key_e then
				if
					ev_application.ctrl_pressed
					and then not ev_application.alt_pressed
					and then not ev_application.shift_pressed
				then
					if grid.has_selected_row then
						if attached {OBJECT_STONE} grid.grid_pebble_from_row_and_column (grid.selected_rows.first, Void) as ost then
							object_viewer_cmd.set_stone (ost)
						end
					end
				end
			when {EV_KEY_CONSTANTS}.key_enter then
				toggle_expanded_state_of_selected_rows (grid)
			when {EV_KEY_CONSTANTS}.key_delete then
				remove_debugged_object_cmd.execute
			else
			end
		end

feature {NONE} -- Debugged objects grid Implementation

	new_specific_line (a_id: INTEGER): ES_OBJECTS_GRID_SPECIFIC_LINE
			--
		do
			inspect a_id
			when position_stack then
				create {ES_OBJECTS_GRID_STACK_LINE} Result.make
			when position_current then
				create {ES_OBJECTS_GRID_CURRENT_LINE} Result.make
			when position_arguments then
				create {ES_OBJECTS_GRID_ARGUMENTS_LINE} Result.make
			when position_locals then
				create {ES_OBJECTS_GRID_LOCALS_LINE} Result.make
			when position_result then
				create {ES_OBJECTS_GRID_RESULT_LINE} Result.make
			when position_dropped then
--				create Result.make_as_dropped
			else
				check should_not_occur: False end
			end
		end

	init_specific_lines
		local
			g: like objects_grid
			gdata: like objects_grid_data
			l: ES_OBJECTS_GRID_SPECIFIC_LINE
			lines: LIST [ES_OBJECTS_GRID_SPECIFIC_LINE]
			lst_pos: LIST [INTEGER]
			l_reused: HASH_TABLE [ARRAY [detachable ES_OBJECTS_GRID_SPECIFIC_LINE], STRING]
			l_reused_lines: ARRAY [detachable ES_OBJECTS_GRID_SPECIFIC_LINE]
		do
				--| Clean old lines
			from
				create l_reused.make (objects_grids.count)
				objects_grids.start
			until
				objects_grids.after
			loop
				g := objects_grids.item_for_iteration.grid
				lines := objects_grids.item_for_iteration.lines
				create l_reused_lines.make_filled (Void, position_stack, position_dropped)
				l_reused.put (l_reused_lines, g.id)
				from
					lines.start
				until
					lines.after
				loop
					l := lines.item
					if l /= Void then
						if l.is_attached_to_row then
							l.unattach
						end
						l_reused_lines[l.id] := l
					end
					lines.forth
				end
				objects_grids.forth
			end

				-- New lines
			dropped_objects_grid := Void
			from
				objects_grids.start
			until
				objects_grids.after
			loop
				gdata := objects_grid_data (objects_grids.key_for_iteration)
				lst_pos := gdata.ids
				gdata.lines.wipe_out
				from
					l_reused_lines := l_reused.item (objects_grids.key_for_iteration)
					lst_pos.start
				until
					lst_pos.after
				loop
					if lst_pos.item = position_dropped then
						if dropped_objects_grid /= Void then
							ids_from_objects_grid (dropped_objects_grid.id).prune_all (position_dropped)
						end
						dropped_objects_grid := gdata.grid
						gdata.lines.force (Void) --| FIXME: for now, Void item is the placeholder for displayed objects
					else
						l := l_reused_lines [lst_pos.item]
						if l = Void then
							l := new_specific_line (lst_pos.item)
						end
						if l /= Void then
							gdata.lines.force (l)
						end
					end
					lst_pos.forth
				end
				objects_grids.forth
			end
			if dropped_objects_grid = Void then
				check gdata /= Void end
				dropped_objects_grid := gdata.grid
			end
		end

feature {NONE} -- Constants

	Left_address_delim: STRING = " <"
	Right_address_delim: STRING = ">"

invariant
	debugger_manager_not_void: debugger_manager /= Void
	objects_grids_not_void: (is_initialized and is_interface_usable) implies objects_grids /= Void

note
	ca_ignore:
		"CA093", "CA093: manifest array type mismatch"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

indexing
	description: "Tool that displays breakpoints"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_BREAKPOINTS_TOOL_PANEL

inherit
	EB_TOOL
		redefine
			on_shown,
			attach_to_docking_manager,
			mini_toolbar,
			build_mini_toolbar,
			build_docking_content,
			internal_recycle,
			show
		end

	EB_VETO_FACTORY

	EB_RECYCLABLE

	EB_SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		local
			box: EV_VERTICAL_BOX
		do
			row_highlight_bg_color := Preferences.debug_tool_data.row_highlight_background_color
			set_row_highlight_bg_color_agent := agent set_row_highlight_bg_color
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.extend (set_row_highlight_bg_color_agent)

			create box
			box.set_padding (3)

			create grid
			grid.enable_tree
			grid.enable_single_row_selection
			grid.enable_border
			grid.enable_partial_dynamic_content
			grid.set_dynamic_content_function (agent computed_grid_item)
			grid.enable_default_tree_navigation_behavior (True, True, True, True)
			grid.key_press_actions.extend (agent key_pressed_on_grid)

			grid.set_column_count_to (3)
			grid.column (1).set_title (interface_names.l_data)
			grid.column (2).set_title (interface_names.l_status)
			grid.column (3).set_title (interface_names.l_details)

--			grid.pointer_double_press_actions.force_extend (agent on_row_double_clicked)
			grid.set_auto_resizing_column (1, True)
			grid.set_auto_resizing_column (2, True)
			grid.set_auto_resizing_column (3, True)
			grid.row_expand_actions.force_extend (agent grid.request_columns_auto_resizing)
			grid.row_collapse_actions.force_extend (agent grid.request_columns_auto_resizing)

			grid.set_item_pebble_function (agent on_item_pebble_function)
			grid.set_item_accept_cursor_function (agent on_item_pebble_accept_cursor)
			grid.set_item_deny_cursor_function (agent on_item_pebble_deny_cursor)

			grid.drop_actions.extend (agent on_stone_dropped)
			grid.drop_actions.set_veto_pebble_function (agent can_drop_debuggable_feature_or_class)

			box.extend (grid)

			grid.build_delayed_cleaning
			grid.set_delayed_cleaning_action (agent clean_breakpoints_info)

			grid.set_configurable_target_menu_mode
			grid.set_configurable_target_menu_handler (agent (develop_window.menus.context_menu_factory).standard_compiler_item_menu)

			widget := box
		end

	build_mini_toolbar is
			-- Build the associated tool bar
		local
			scmd: EB_STANDARD_CMD
			tb: SD_TOOL_BAR_BUTTON
			dbgm: EB_DEBUGGER_MANAGER
		do
			create mini_toolbar.make

			create scmd.make
			scmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_toogle_icon)
			scmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_toogle_icon_buffer)
			scmd.set_tooltip (interface_names.f_display_breakpoints)
			scmd.enable_sensitive
			tb := scmd.new_mini_sd_toolbar_item
			scmd.add_agent (agent toggle_breakpoint_layout_mode (tb))
			mini_toolbar.extend (tb)
			toggle_layout_cmd := scmd

			dbgm := Eb_debugger_manager

			if dbgm.enable_bkpt /= Void then
				enable_bkpt_button := dbgm.enable_bkpt.new_mini_sd_toolbar_item
				mini_toolbar.extend (enable_bkpt_button)
			end
			if dbgm.disable_bkpt /= Void then
				disable_bkpt_button := dbgm.disable_bkpt.new_mini_sd_toolbar_item
				mini_toolbar.extend (disable_bkpt_button)
			end
			if dbgm.clear_bkpt /= Void then
				clear_bkpt_button := dbgm.clear_bkpt.new_mini_sd_toolbar_item
				mini_toolbar.extend (clear_bkpt_button)
			end

			mini_toolbar.compute_minimum_size
		ensure then
			mini_toolbar_exists: mini_toolbar /= Void
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
		do
			Precursor {EB_TOOL} (a_docking_manager)
			check content_not_void : content /= Void end
			content.drop_actions.extend (agent on_stone_dropped)
			content.drop_actions.set_veto_pebble_function (agent can_drop_debuggable_feature_or_class)
		end

feature {EB_DEVELOPMENT_WINDOW_BUILDER} -- Initialization

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)

			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Properties

	grid: ES_GRID
			-- Grid containing the breakpoints list

feature -- Access

	mini_toolbar: SD_TOOL_BAR
			-- Associated mini toolbar.

	widget: EV_WIDGET
			-- Widget representing Current.

feature {NONE} -- Commands

	toggle_layout_cmd: EB_STANDARD_CMD
			-- Toggle layout command

feature -- Events

	on_stone_dropped (a_stone: STONE) is
			--	Stone dropped
		local
			fs: FEATURE_STONE
			cs: CLASSC_STONE
		do
			fs ?= a_stone
			if fs /= Void then
				if not debugger_manager.is_breakpoint_set (fs.e_feature, 1) then
					debugger_manager.enable_first_breakpoint_of_feature (fs.e_feature)
					debugger_manager.notify_breakpoints_changes
				end
			else
				cs ?= a_stone
				if cs /= Void then
					debugger_manager.enable_first_breakpoints_in_class (cs.e_class)
					debugger_manager.notify_breakpoints_changes
				end
			end
		end

	on_item_pebble_function (gi: EV_GRID_ITEM): STONE is
			-- Handle item pebble function
		do
			if gi /= Void then
				Result ?= gi.data
			end
		end

	on_item_pebble_accept_cursor (gi: EV_GRID_ITEM): EV_POINTER_STYLE is
			-- Handle item pebble accpet cursor
		local
			st: STONE
		do
			st := on_item_pebble_function (gi)
			if st /= Void then
				Result := st.stone_cursor
			end
		end

	on_item_pebble_deny_cursor (gi: EV_GRID_ITEM): EV_POINTER_STYLE is
			-- Handle item pebble deny cursor
		local
			st: STONE
		do
			st := on_item_pebble_function (gi)
			if st /= Void then
				Result := st.x_stone_cursor
			end
		end

--	on_row_double_clicked is
--		do
--		end

	refresh is
			-- Class has changed in `development_window'.
		local
			r: INTEGER
			bp: BREAKPOINT
		do
			if grid.row_count = 0 then
				update
			else
				from
					r := grid.row_count
				until
					r = 0
				loop
					bp ?= grid.row (r).data
					if bp /= Void then
						grid.row (r).clear
					end
					r := r - 1
				end
			end
		end

	synchronize	is
			-- Synchronize
		do
			update
		end

	on_project_loaded is
			-- Handle project loaded actions
		do
			update
		end

	on_shown is
			-- Handle show actions
		do
			update
		end

	update is
			-- Refresh `Current's display.
		do
			grid.request_delayed_clean
			refresh_breakpoints_info
		end

	show is
			-- Show tool.
		do
			Precursor {EB_TOOL}
			if grid.is_displayed and grid.is_sensitive then
				grid.set_focus
			end
			refresh
		end

feature -- Memory management

	enable_bkpt_button: EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Enable breakpoint button

	disable_bkpt_button: EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Disable breakpoint button

	clear_bkpt_button: EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Clear breakpoint button

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			enable_bkpt_button.recycle
			disable_bkpt_button.recycle
			clear_bkpt_button.recycle
			toggle_layout_cmd.recycle
			toggle_layout_cmd := Void
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.prune_all (set_row_highlight_bg_color_agent)
			set_row_highlight_bg_color_agent := Void
			Precursor {EB_TOOL}
		end

feature {NONE} -- Grid layout Implementation

	grid_layout_manager: ES_GRID_LAYOUT_MANAGER
			-- Grid layout manager

	record_grid_layout is
			-- Record grid layout
		do
			if grid_layout_manager = Void then
				create grid_layout_manager.make (grid, "Breakpoints")
			end
			grid_layout_manager.record
		end

	restore_grid_layout is
			-- Restore grid layout
		do
			if grid_layout_manager /= Void then
				grid_layout_manager.restore
			end
		end

feature {NONE} -- Implementation

	toggle_breakpoint_layout_mode (tt: SD_TOOL_BAR_BUTTON) is
			-- Toggle `breakpoints_separated_by_status' mode
		do
			breakpoints_separated_by_status := not breakpoints_separated_by_status
			if breakpoints_separated_by_status then
				tt.set_tooltip (interface_names.f_display_all_breakpoints_together)
			else
				tt.set_tooltip (interface_names.f_display_breakpoints_sep_by_status)
			end
			refresh_breakpoints_info
		end

	breakpoints_separated_by_status: BOOLEAN
			-- Display list of breakpoints in two parts
			-- enabled and disabled

	clean_breakpoints_info is
			-- Clean the breakpoints's grid
		do
			record_grid_layout
			grid.default_clean
		end

	refresh_breakpoints_info is
			-- Refresh and recomputed breakpoints's grid when shown
		local
			w: EV_WIDGET
		do
			if shown then -- Tool exists in layout
				check content /= Void end
				w := content.user_widget
				if
					w /= Void
					and then w /= Void
				then
					if w /= Void and then w.is_displayed then
						refresh_breakpoints_info_now
					else
						request_refresh_breakpoints_info_now
					end
				end
			end
		end

feature {NONE} -- Refresh breakpoints info Now implementation

	agent_refresh_breakpoints_info_now: PROCEDURE [ANY, TUPLE]
			-- agent on `refresh_breakpoints_info_now'.

	request_refresh_breakpoints_info_now is
			-- Request `refresh_breakpoints_info_now'
		require
			tool_shown: shown
		do
			if agent_refresh_breakpoints_info_now = Void then
				agent_refresh_breakpoints_info_now := agent refresh_breakpoints_info_now
				content.show_actions.extend_kamikaze (agent_refresh_breakpoints_info_now)
			else
				-- already requested
			end
		end

	cancel_refresh_breakpoints_info_now is
			-- Request `refresh_breakpoints_info_now'
		do
			if content /= Void and then agent_refresh_breakpoints_info_now /= Void then
				content.show_actions.prune_all (agent_refresh_breakpoints_info_now)
				agent_refresh_breakpoints_info_now := Void
			end
		end

	refresh_breakpoints_info_now is
			-- Refresh and recomputed breakpoints's grid
		require
			tool_shown: shown
			content_widget_visible: content /= Void and then content.user_widget /= Void and then content.user_widget.is_show_requested
		local
			row: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
			f_list: LIST[E_FEATURE]
			col: EV_COLOR
			bpm: BREAKPOINTS_MANAGER
		do
			cancel_refresh_breakpoints_info_now

			class_color := preferences.editor_data.class_text_color
			feature_color := preferences.editor_data.feature_text_color
			condition_color := preferences.editor_data.string_text_color

			col := preferences.editor_data.comments_text_color
			bpm := Debugger_manager
			grid.call_delayed_clean
			if not bpm.has_breakpoints then
				grid.insert_new_row (1)
				create lab.make_with_text (interface_names.l_no_break_point)
				lab.set_foreground_color (col)
				grid.set_item (1, 1, lab)
			else
				if not breakpoints_separated_by_status then
					if bpm.has_breakpoints then
						f_list := bpm.features_with_breakpoint_set
						insert_bp_features_list (f_list, Void, True, True)
					end
				else
					if bpm.has_enabled_breakpoints then
						row := grid.extended_new_row
						row.set_background_color (bg_separator_color)
						create lab.make_with_text (interface_names.l_enabled)
						lab.set_foreground_color (col)
						row.set_item (1, lab)
						row.set_item (2, create {EV_GRID_ITEM})
						row.set_item (3, create {EV_GRID_ITEM})

						f_list := bpm.features_with_breakpoint_set
						insert_bp_features_list (f_list, row, True, False)
						row.expand
					end
					if bpm.has_disabled_breakpoints then
						row := grid.extended_new_row
						row.set_background_color (bg_separator_color)
						create lab.make_with_text (interface_names.l_disabled)
						lab.set_foreground_color (col)
						row.set_item (1, lab)
						row.set_item (2, create {EV_GRID_ITEM})
						row.set_item (3, create {EV_GRID_ITEM})

						f_list := bpm.features_with_breakpoint_set
						insert_bp_features_list (f_list, row, False, True)
						row.expand
					end
				end
			end
			grid.request_columns_auto_resizing
			restore_grid_layout
		end

feature {NONE} -- Impl bp

	insert_bp_features_list (routine_list: LIST [E_FEATURE]; a_row: EV_GRID_ROW; display_enabled, display_disabled: BOOLEAN) is
			-- Insert `routine_list' into `a_row'
		require
			routine_list /= Void
		local
			r, sr: INTEGER
			lab: EV_GRID_LABEL_ITEM
			subrow: EV_GRID_ROW

			table: HASH_TABLE [PART_SORTED_TWO_WAY_LIST [E_FEATURE], INTEGER]
			stwl: PART_SORTED_TWO_WAY_LIST [E_FEATURE]
			f: E_FEATURE
			c: CLASS_C
			bp_list: LIST [INTEGER]
			has_bp: BOOLEAN
			cs: CLASSC_STONE
			bpm: BREAKPOINTS_MANAGER
		do
				--| Prepare data .. mainly sorting
			from
				create table.make (5)
				routine_list.start
			until
				routine_list.after
			loop
				f := routine_list.item
				c := f.written_class
				stwl := table.item (c.class_id)
				if stwl = Void then
					create stwl.make
					table.put (stwl, c.class_id)
				end
				stwl.extend (f)
				routine_list.forth
			end

				--| Process insertion
			bpm := Debugger_manager
			from
				table.start
				r := 1
			until
				table.after
			loop
				stwl := table.item_for_iteration
				c := Eiffel_system.class_of_id (table.key_for_iteration)
				has_bp := False
					--| Check if there are any valid and displayable breakpoints
				from
					stwl.start
				until
					stwl.after or has_bp
				loop
					f := stwl.item
					if display_enabled and display_disabled then
						bp_list := bpm.breakpoints_set_for (f)
					elseif display_enabled then
						bp_list := bpm.breakpoints_enabled_for (f)
					else
						bp_list := bpm.breakpoints_disabled_for (f)
					end
					has_bp := not bp_list.is_empty
					stwl.forth
				end

				if has_bp then
					create lab.make_with_text (c.name_in_upper)
					lab.set_foreground_color (class_color)
					create cs.make (c)
					lab.set_data (cs)

					if a_row = Void then
						r := grid.row_count + 1
						grid.insert_new_row (r)
						subrow := grid.row (r)
					else
						a_row.insert_subrow (r)
						subrow := a_row.subrow (r)
						r := r + 1
					end

					sr := 1
					subrow.set_item (1, lab)
					subrow.set_item (2, create {EV_GRID_ITEM})
					subrow.item (2).pointer_button_release_actions.force_extend (agent on_class_item_right_clicked (c, subrow, ?,?,?))
					subrow.set_item (3, create {EV_GRID_ITEM})

					from
						stwl.start
					until
						stwl.after
					loop
						f := stwl.item
						insert_feature_bp_detail (f, subrow, display_enabled, display_disabled)
						stwl.forth
					end
					if subrow.is_expandable then
						subrow.expand
					end
				end
				table.forth
			end
		end

	insert_feature_bp_detail (f: E_FEATURE; a_row: EV_GRID_ROW; display_enabled, display_disabled: BOOLEAN) is
			-- Insert features breakpoints details.
		require
			f /= Void
			a_row /= Void
		local
			bp_list: LIST [INTEGER]
			sorted_bp_list: SORTED_TWO_WAY_LIST [INTEGER]
			s: STRING
			ir, sr: INTEGER
			subrow: EV_GRID_ROW
			lab: EV_GRID_LABEL_ITEM
			first_bp: BOOLEAN
			i: INTEGER
			fs: FEATURE_STONE
			bp: BREAKPOINT
			bpm: BREAKPOINTS_MANAGER
		do
			bpm := Debugger_manager
			if display_enabled and display_disabled then
				bp_list := bpm.breakpoints_set_for (f)
			elseif display_enabled then
				bp_list := bpm.breakpoints_enabled_for (f)
			elseif display_disabled then
				bp_list := bpm.breakpoints_disabled_for (f)
			end
			if not bp_list.is_empty then
				sr := a_row.subrow_count + 1
				a_row.insert_subrow (sr)
				subrow := a_row.subrow (sr)

				create lab.make_with_text (f.name) -- f
				lab.set_foreground_color (feature_color)
				create fs.make (f)
				lab.set_data (fs)

				subrow.set_item (1, lab)
				from
					s := ""
					first_bp := True
					create sorted_bp_list.make
					sorted_bp_list.fill (bp_list)
					bp_list := sorted_bp_list
					bp_list.start
					ir := 1
					subrow.insert_subrows (bp_list.count, ir)
				until
					bp_list.after
				loop
					i := bp_list.item
					if bpm.is_breakpoint_set (f, i) then
						bp := bpm.breakpoint (f, i)
						if not first_bp then
							s.append_string (", ")
						else
							first_bp := False
						end
						s.append_string (i.out)
						subrow.subrow (ir).set_data (bp)

						if bp.has_condition then
							if bp.is_disabled then
								s.append_string (Disabled_conditional_bp_symbol)
							else
								s.append_string (Conditional_bp_symbol)
							end
						elseif bp.is_disabled then
							s.append_string (Disabled_bp_symbol)
						end
					else
						create lab.make_with_text (interface_names.l_error_with_line (f.name, i.out))
						subrow.subrow (ir).set_item (2, lab)
					end

					ir := ir + 1
					bp_list.forth
				end
				create lab.make_with_text (s)
				subrow.set_item (2, lab)
				lab.pointer_button_release_actions.force_extend (agent on_feature_item_right_clicked (f, subrow, ?,?,?))
				subrow.set_item (3, create {EV_GRID_ITEM})
				subrow.ensure_expandable
			end
		end

	computed_grid_item (c, r: INTEGER): EV_GRID_ITEM is
			-- Computed grid item corresponding to `c,r'.
		local
			row: EV_GRID_ROW
		do
			row := grid.row (r)
			compute_bp_row (row)
			Result := row.item (c)
		end

	compute_bp_row (a_row: EV_GRID_ROW) is
			-- Compute `a_row' 's grid items
		require
			a_row_not_void: a_row /= Void
		local
			f: E_FEATURE
			s: STRING_GENERAL
			t: STRING
			lab: EV_GRID_LABEL_ITEM
			i: INTEGER
			fs: FEATURE_STONE
			bp: BREAKPOINT
		do
			bp ?= a_row.data
			if bp /= Void then
				f := bp.routine
				i := bp.breakable_line_number

				create lab.make_with_text (interface_names.l_offset_is (i.out))
				create fs.make (f)
				lab.set_data (fs)
				a_row.set_item (1, lab)
				if bp.is_enabled then
					s := interface_names.l_space_enabled.twin
					if bp.hits_count > 0 then
						s.append (" (")
						s.append (interface_names.l_hit_count_is (bp.hits_count))
						s.append (")")
					end
					create lab.make_with_text (s)
					if bp.has_condition then
						lab.set_pixmap (breakable_icons.bp_enabled_conditional_icon)
					else
						lab.set_pixmap (breakable_icons.bp_enabled_icon)
					end
				elseif bp.is_disabled then
					create lab.make_with_text (interface_names.l_space_disabled)
					if bp.has_condition then
						lab.set_pixmap (breakable_icons.bp_disabled_conditional_icon)
					else
						lab.set_pixmap (breakable_icons.bp_disabled_icon)
					end
				else
					create lab.make_with_text (interface_names.l_space_error)
				end
				debug ("breakpoint")
					t := bp.routine.associated_class.name_in_upper + "." + bp.routine.name + "#" + bp.breakable_line_number.out
					if debugger_manager.application_is_executing then
						if bp.is_set_for_application then
							t.append_string ("Application: set")
						else
							t.append_string ("Application: not set")
						end
					end
					if bp.hits_count > 0 then
						t.append_character ('%N')
						t.append_string_general (Interface_names.l_current_hit_count)
						t.append_integer (bp.hits_count)
					end
					if bp.has_condition then
						t.append_character ('%N')
						t.append_string_general (interface_names.l_condition)
						t.append_string (": " + bp.condition.expression)
					end
					if bp.has_message then
						t.append_character ('%N')
						t.append_string_general (interface_names.l_print_message)
						t.append_string (bp.message)
					end
					if bp.continue_execution then
						t.append_character ('%N')
						t.append_string_general (interface_names.l_continue_execution)
					end
					lab.set_tooltip (t)
				end

				lab.pointer_button_release_actions.force_extend (agent on_line_cell_right_clicked (f, i, lab, ?, ?, ?))
				a_row.set_item (2, lab)

				if bp.has_condition then
					create lab.make_with_text (bp.condition.expression)
					lab.set_tooltip (lab.text)
					lab.set_font (condition_font)
					a_row.set_item (3, lab)
				else
					if not bp.is_disabled then
						a_row.set_item (3, create {EV_GRID_ITEM})
					end
				end
			end
		end

	on_line_cell_right_clicked (f: E_FEATURE; i: INTEGER; gi: EV_GRID_ITEM; x, y, button: INTEGER) is
			-- Handle a cell right click actions.
		require
			f /= Void
			i > 0
			gi /= Void
		local
			bp_stone: BREAKABLE_STONE
		do
			grid.remove_selection
			gi.row.enable_select
			if button = 3 then
				create bp_stone.make (f, i)
				bp_stone.display_bkpt_menu
			end
		end

	on_class_item_right_clicked	(c: CLASS_C; r: EV_GRID_ROW; x, y, button: INTEGER) is
		require
			c /= Void
			r /= Void
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			bpm: BREAKPOINTS_MANAGER
		do
			grid.remove_selection
			r.enable_select
			if button = 3 then
				bpm := Debugger_manager
				create m
				create mi.make_with_text (interface_names.m_add_first_breakpoints_in_class)
				mi.select_actions.extend (agent bpm.enable_first_breakpoints_in_class (c))
				mi.select_actions.extend (agent window_manager.synchronize_all_about_breakpoints)
				m.extend (mi)
				create mi.make_with_text (Interface_names.m_enable_stop_points)
				mi.select_actions.extend (agent bpm.enable_breakpoints_in_class (c))
				mi.select_actions.extend (agent window_manager.synchronize_all_about_breakpoints)
				m.extend (mi)
				create mi.make_with_text (Interface_names.m_disable_stop_points)
				mi.select_actions.extend (agent bpm.disable_breakpoints_in_class (c))
				mi.select_actions.extend (agent window_manager.synchronize_all_about_breakpoints)
				m.extend (mi)
				create mi.make_with_text (Interface_names.m_clear_breakpoints)
				mi.select_actions.extend (agent bpm.remove_breakpoints_in_class (c))
				mi.select_actions.extend (agent window_manager.synchronize_all_about_breakpoints)
				m.extend (mi)
				m.show
			end
		end

	on_feature_item_right_clicked	(f: E_FEATURE; r: EV_GRID_ROW; x, y, button: INTEGER) is
		require
			f /= Void
			r /= Void
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			bpm: BREAKPOINTS_MANAGER
		do
			grid.remove_selection
			r.enable_select
			if button = 3 then
				bpm := Debugger_manager
				create m
				create mi.make_with_text (interface_names.m_add_first_breakpoints_in_feature)
				mi.select_actions.extend (agent bpm.enable_first_breakpoint_of_feature (f))
				mi.select_actions.extend (agent window_manager.synchronize_all_about_breakpoints)
				m.extend (mi)
				create mi.make_with_text (Interface_names.m_enable_stop_points)
				mi.select_actions.extend (agent bpm.enable_breakpoints_in_feature (f))
				mi.select_actions.extend (agent window_manager.synchronize_all_about_breakpoints)
				m.extend (mi)
				create mi.make_with_text (Interface_names.m_disable_stop_points)
				mi.select_actions.extend (agent bpm.disable_breakpoints_in_feature (f))
				mi.select_actions.extend (agent window_manager.synchronize_all_about_breakpoints)
				m.extend (mi)
				create mi.make_with_text (Interface_names.m_clear_breakpoints)
				mi.select_actions.extend (agent bpm.remove_breakpoints_in_feature (f))
				mi.select_actions.extend (agent window_manager.synchronize_all_about_breakpoints)

				m.extend (mi)
				m.show
			end
		end

	key_pressed_on_grid (a_key: EV_KEY) is
			--
		local
			l_selected_rows: LIST [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_bp: BREAKPOINT
			bp_stone: BREAKABLE_STONE
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				l_selected_rows := grid.selected_rows
				if not l_selected_rows.is_empty then
					l_row := l_selected_rows.first
					l_bp ?= l_row.data
					if l_bp /= Void then
						create bp_stone.make_from_breakpoint (l_bp)
						bp_stone.display_bkpt_menu
					end
				end
			end
		end

feature {NONE} -- Implementation, cosmetic

	Disabled_bp_symbol: STRING is "-"
			-- Disable breakpoint symbol.

	Conditional_bp_symbol: STRING is "*"
			-- Conditional breakpoint symbol.

	Disabled_conditional_bp_symbol: STRING is "*-"
			-- Disable conditional breakpoint symbol.

	Breakable_icons: ES_PIXMAPS_12X12 is
			-- Breakable icons.
		local
			l_shared: EB_SHARED_PIXMAPS
		once
			create l_shared
			Result := l_shared.small_pixmaps
		ensure
			result_attached: Result /= Void
		end

	bg_separator_color: EV_COLOR is
			-- Background separator color.
		once
			create Result.make_with_8_bit_rgb (220, 220, 240)
		end

	class_color: EV_COLOR
			-- Class color
	feature_color: EV_COLOR
			-- Feature color
	condition_color: EV_COLOR
			-- Condition color
	condition_font: EV_FONT is
			-- Condition font
		once
			create Result
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
		end

	set_row_highlight_bg_color_agent : PROCEDURE [ANY, TUPLE]
			-- Set row highlight background color agent.

	set_row_highlight_bg_color (v: COLOR_PREFERENCE) is
			-- Set row highlight background color.
		do
			row_highlight_bg_color := v.value
		end

	row_highlight_bg_color: EV_COLOR;
			-- Row highlight background color.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

indexing
	description: "Tool that evaluates expressions in the debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_WATCH_TOOL_PANEL

inherit
	REFACTORING_HELPER

	ES_OBJECTS_GRID_MANAGER

	EB_STONABLE_TOOL
		redefine
			make,
			show,
			close,
			internal_recycle,
			mini_toolbar,
			build_mini_toolbar,
			build_docking_content
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_RECYCLABLE
		export
			{NONE} all
		end

	EB_SHARED_PIXMAPS
		export
			{NONE} all
		end

	DEBUGGING_UPDATE_ON_IDLE
		redefine
			real_update, update
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: like develop_window; a_tool: like tool_descriptor) is
		do
			watch_id := a_tool.edition
			auto_expression_enabled := False
			Precursor (a_manager, a_tool)
		end

	build_interface is
			-- Build all the tool's widgets.
		local
			esgrid: ES_OBJECTS_GRID
		do
			auto_expressions_deltas := [-2, +1]
			create watched_items.make (10)

			create esgrid.make_with_name (title, "watches" + watch_id.out)
			esgrid.enable_multiple_row_selection
			esgrid.set_column_count_to (5)
			esgrid.set_default_columns_layout (<<
						[1, True, False, 150, interface_names.l_Expression, interface_names.to_expression],
						[2, True, False, 150, interface_names.l_value, interface_names.to_value],
						[3, True, False, 100, interface_names.l_type, interface_names.to_type],
						[4, True, False, 80, interface_names.l_address, interface_names.to_address],
						[5, True, False, 200, interface_names.l_Context, interface_names.to_context]
					>>
				)
			esgrid.set_columns_layout (1, esgrid.default_columns_layout)

				-- Set scrolling preferences.
			esgrid.set_mouse_wheel_scroll_size (preferences.editor_data.mouse_wheel_scroll_size)
			esgrid.set_mouse_wheel_scroll_full_page (preferences.editor_data.mouse_wheel_scroll_full_page)
			esgrid.set_scrolling_common_line_count (preferences.editor_data.scrolling_common_line_count)
			preferences.editor_data.mouse_wheel_scroll_size_preference.typed_change_actions.extend (
				agent esgrid.set_mouse_wheel_scroll_size)
			preferences.editor_data.mouse_wheel_scroll_full_page_preference.typed_change_actions.extend (
				agent esgrid.set_mouse_wheel_scroll_full_page)
			preferences.editor_data.scrolling_common_line_count_preference.typed_change_actions.extend (
				agent esgrid.set_scrolling_common_line_count)

			esgrid.row_select_actions.extend (agent on_row_selected)
			esgrid.row_deselect_actions.extend (agent on_row_deselected)
			esgrid.drop_actions.extend (agent on_element_drop)
			esgrid.key_press_actions.extend (agent key_pressed)
			esgrid.key_press_string_actions.extend (agent string_key_pressed)

			esgrid.set_pre_activation_action (agent pre_activate_cell)

			esgrid.set_configurable_target_menu_mode
			esgrid.set_configurable_target_menu_handler (agent context_menu_handler)

			watches_grid := esgrid
			initialize_watches_grid_layout (preferences.debug_tool_data.is_watches_grids_layout_managed_preference)

			create_update_on_idle_agent
		end

	build_mini_toolbar is
			-- Build associated tool bar
		local
			tbb: SD_TOOL_BAR_BUTTON
			scmd: EB_STANDARD_CMD
		do
			create mini_toolbar.make

			create scmd.make
			scmd.set_mini_pixmap (pixmaps.mini_pixmaps.toolbar_dropdown_icon)
			scmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.toolbar_dropdown_icon_buffer)
			scmd.set_tooltip (interface_names.f_Open_watch_tool_menu)
			scmd.add_agent (agent open_watch_menu (mini_toolbar, 0, 0))
			scmd.enable_sensitive
			mini_toolbar.extend (scmd.new_mini_sd_toolbar_item)

			create toggle_auto_behavior_cmd.make
			toggle_auto_behavior_cmd.set_pixmap (pixmaps.mini_pixmaps.watch_auto_icon)
			toggle_auto_behavior_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.watch_auto_icon)
			toggle_auto_behavior_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.watch_auto_icon_buffer)
			toggle_auto_behavior_cmd.set_name ("AutoExpression")
			toggle_auto_behavior_cmd.set_menu_name (interface_names.m_auto_expressions)
			toggle_auto_behavior_cmd.set_tooltip (interface_names.t_auto_expressions)
			toggle_auto_behavior_cmd.add_action (agent toggle_auto_expressions)
			toggle_auto_behavior_cmd.set_is_selected_function (agent auto_expression_enabled)
			toggle_auto_behavior_cmd.enable_sensitive
			mini_toolbar.extend (toggle_auto_behavior_cmd.new_mini_sd_toolbar_item)

			create create_expression_cmd.make
			create_expression_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.new_expression_icon)
			create_expression_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.new_expression_icon_buffer)
			create_expression_cmd.set_tooltip (interface_names.e_new_expression)
			create_expression_cmd.add_agent (agent define_new_expression)
			create_expression_cmd.enable_sensitive
			mini_toolbar.extend (create_expression_cmd.new_mini_sd_toolbar_item)

			create edit_expression_cmd.make
			edit_expression_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_edit_icon)
			edit_expression_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_edit_icon_buffer)
			edit_expression_cmd.set_tooltip (interface_names.e_edit_expression)
			edit_expression_cmd.add_agent (agent edit_expression)
			tbb := edit_expression_cmd.new_mini_sd_toolbar_item
			mini_toolbar.extend (tbb)

			create toggle_state_of_expression_cmd.make
			toggle_state_of_expression_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_toogle_icon)
			toggle_state_of_expression_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_toogle_icon_buffer)
			toggle_state_of_expression_cmd.set_tooltip (interface_names.e_toggle_state_of_expressions)
			toggle_state_of_expression_cmd.add_agent (agent toggle_state_of_selected)
			tbb := toggle_state_of_expression_cmd.new_mini_sd_toolbar_item
			mini_toolbar.extend (tbb)

			create slices_cmd.make (Current)
			slices_cmd.enable_sensitive
			mini_toolbar.extend (slices_cmd.new_mini_sd_toolbar_item)

			create hex_format_cmd.make (agent set_hexadecimal_mode (?))
			hex_format_cmd.enable_sensitive
			mini_toolbar.extend (hex_format_cmd.new_mini_sd_toolbar_item)

			mini_toolbar.extend (object_viewer_cmd.new_mini_sd_toolbar_item)
			mini_toolbar.extend (debugger_manager.object_storage_management_cmd.new_mini_sd_toolbar_item_for_watch_tool (Current))

			create delete_expression_cmd.make
			delete_expression_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_delete_icon)
			delete_expression_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_delete_icon_buffer)
			delete_expression_cmd.set_tooltip (interface_names.e_remove_expressions)
			delete_expression_cmd.add_agent (agent remove_selected)
			tbb := delete_expression_cmd.new_mini_sd_toolbar_item
			tbb.drop_actions.extend (agent remove_object_line)
			tbb.drop_actions.set_veto_pebble_function (agent is_removable )
			mini_toolbar.extend (tbb)

			create move_up_cmd.make
			move_up_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_up_icon)
			move_up_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_up_icon_buffer)
			move_up_cmd.set_tooltip (interface_names.f_move_item_up)
			move_up_cmd.add_agent (agent move_selected (watches_grid, -1))
			tbb := move_up_cmd.new_mini_sd_toolbar_item
			mini_toolbar.extend (tbb)

			create move_down_cmd.make
			move_down_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_down_icon)
			move_down_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_down_icon_buffer)
			move_down_cmd.set_tooltip (interface_names.f_move_item_down)
			move_down_cmd.add_agent (agent move_selected (watches_grid, +1))
			tbb := move_down_cmd.new_mini_sd_toolbar_item
			mini_toolbar.extend (tbb)

				--| Attach the slices_cmd to the objects grid
			watches_grid.set_slices_cmd (slices_cmd)

			mini_toolbar.compute_minimum_size
		ensure then
			mini_toolbar_exists: mini_toolbar /= Void
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build content for docking.

		do
			Precursor {EB_STONABLE_TOOL} (a_docking_manager)
			content.drop_actions.extend (agent on_element_drop)
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu handler
		do
			develop_window.menus.context_menu_factory.watch_tool_menu (a_menu, a_target_list, a_source, a_pebble, Current)
		end

feature -- Properties

	watch_id: INTEGER
			-- Watch's identifier

feature {EB_DEBUGGER_MANAGER} -- Closing

	close is
		do
			Precursor
			debugger_manager.watch_tool_list.prune_all (Current)
			debugger_manager.update_all_debugging_tools_menu
		end

feature -- Access

	mini_toolbar: SD_TOOL_BAR
			-- Associated mini toolbar.

	widget: EV_WIDGET is
			-- Widget representing Current.
		do
			Result := watches_grid
		end

	can_refresh: BOOLEAN
			-- Should we display data when a stone is set?

	auto_expression_enabled: BOOLEAN
			-- Is auto expression enabled ?

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

	stone: STONE
			-- Not used.

feature -- Change

	set_debugger_manager (a_manager: like debugger_manager) is
			-- Affect `a_manager' to `debugger_manager'.
		do
			debugger_manager := a_manager
		end

	show is
			-- Show tool
		do
			Precursor {EB_STONABLE_TOOL}
			if watches_grid.is_displayed then
				watches_grid.set_focus
			end
		end

feature -- Properties setting

	set_hexadecimal_mode (v: BOOLEAN) is
		do
			watches_grid.set_hexadecimal_mode (v)
		end

feature {ES_OBJECTS_GRID_SLICES_CMD} -- Query

	objects_grid_object_line (addr: STRING): ES_OBJECTS_GRID_OBJECT_LINE is
		local
			r: INTEGER
			lrow: EV_GRID_ROW
			ladd: STRING
		do
			from
				r := 1
			until
				r > watches_grid.row_count or Result /= Void
			loop
				lrow := watches_grid.row (r)
				if lrow.parent_row = Void then
					Result ?= grid_data_from_widget (lrow)
					if Result /= Void then
						ladd := Result.object_address
						if ladd = Void or else not ladd.is_equal (addr) then
							Result := Void
						end
					end
				end
				r := r + 1
			end
		end

feature -- Status setting

	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		local
			cst: CALL_STACK_STONE
			app_impl: APPLICATION_EXECUTION_DOTNET
		do
			if can_refresh then
				cst ?= a_stone
				if cst /= Void and then debugger_manager.safe_application_is_stopped then
					fixme ("Check if we should not call `update' to benefit real_update optimisation")
					if debugger_manager.is_dotnet_project then
						app_impl ?= debugger_manager.application
						check app_impl /= Void end
						if not app_impl.callback_notification_processing then
							refresh_context_expressions
						end
					else
						refresh_context_expressions
					end
				end
			end
		end

	enable_refresh is
			-- Set `can_refresh' to `True'.
		do
			can_refresh := True
		end

	disable_refresh is
			-- Set `can_refresh' to `False'.
		do
			can_refresh := False
		end

	prepare_for_debug is
			-- Remove obsolete expressions from `Current'.
		local
			l_expr: EB_EXPRESSION
			witem: like watched_item_from
			witems: like watched_items
		do
			clean_watched_grid
			from
				witems := watched_items
				witems.start
			until
				witems.after
			loop
				witem := witems.item
				if witem = Void then
					witems.remove
				else
					if witem.is_auto_expression then
						witem.safe_unattach
						witems.remove
					else
						l_expr := witem.expression
						if
							l_expr = Void
							or else not l_expr.is_still_valid
						then
							witems.remove
						else
							l_expr.set_unevaluated
							add_watched_item_to_grid (witem, watches_grid)
							witems.forth
						end
					end
				end
			end

			update
		end

feature -- Memory management

	reset_tool is
		do
			reset_update_on_idle
			recycle_expressions
			watches_grid.reset_layout_manager
			clean_watched_grid
			if update_commands_on_expressions_delayer /= Void then
				update_commands_on_expressions_delayer.destroy
				update_commands_on_expressions_delayer := Void
			end
		end

feature {NONE} -- Memory management

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			reset_tool
			Precursor {EB_STONABLE_TOOL}
		end

	recycle_expressions is
			-- Recycle
		local
			witem: ES_OBJECTS_GRID_EXPRESSION_LINE
			witems: like watched_items
		do
			from
				witems := watched_items
				witems.start
			until
				witems.after
			loop
				witem := witems.item
				if witem /= Void then
					if witem.is_auto_expression then
						witem.safe_unattach
						witems.remove
					else
						check witem.expression /= Void	end
						if not witem.expression.is_still_valid then
							witems.remove
						else
							witems.forth
						end
					end
					witem.reset
				else
					witems.remove
				end
			end
		end

	set_mouse_wheel_scroll_size_agent : PROCEDURE [ANY, TUPLE [INTEGER_32]]
	set_mouse_wheel_scroll_full_page_agent: PROCEDURE [ES_OBJECTS_GRID, TUPLE [BOOLEAN]]
	set_scrolling_common_line_count_agent: PROCEDURE [ANY, TUPLE [INTEGER_32]]
			-- Agents for recycling

feature {NONE} -- add new expression from the grid

	new_expression_row: EV_GRID_ROW
			-- Grid row which should always be at the end of the grid
			-- this is used to enter new expression easily

	ensure_last_row_is_new_expression_row is
			-- ensure
		local
			glab: ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL
		do
			if
				new_expression_row = Void
				or else new_expression_row.is_destroyed
				or else new_expression_row.parent = Void
			then
				new_expression_row := watches_grid.extended_new_row
				create glab.make_with_text ("...")
				grid_cell_set_tooltip (glab, interface_names.f_add_new_expression)

				new_expression_row.set_item (1, glab)
				glab.pointer_double_press_actions.force_extend (agent glab.activate)
				glab.apply_actions.extend (agent add_new_expression_for_context)
				set_up_complete_possibilities_provider (glab)
			elseif new_expression_row.index < watches_grid.row_count then
				grid_move_to_end_of_grid (new_expression_row)
			end
			watches_grid_empty := False
		end

	add_new_expression_for_context (s: STRING_32) is
		local
			expr: EB_EXPRESSION
		do
			if valid_expression_text (s) then
				create expr.make_for_context (s)
				add_expression (expr, False)
			end
		end

	add_new_auto_expression (s: STRING_32) is
		local
			expr: EB_EXPRESSION
		do
			if valid_expression_text (s) then
				create expr.make_for_context (s)
				add_expression (expr, True)
			end
		end

	valid_expression_text (s: STRING_32): BOOLEAN is
		do
			Result := s /= Void and then not s.has ('%R') and not s.has ('%N')
		end

feature {EB_CONTEXT_MENU_FACTORY} -- Context menu

	on_element_drop (s: CLASSC_STONE) is
			-- Something was dropped in `ev_list'.
		local
			fst: FEATURE_STONE
			cst: CLASSC_STONE
			ost: OBJECT_STONE
			fost: FEATURE_ON_OBJECT_STONE
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
			oname: STRING
		do
			show
			fost ?= s
			if fost /= Void then
				oname := fost.feature_name
				if ev_application.ctrl_pressed then
					ost := fost.object_stone
					if ost /= Void then
						on_element_drop (ost)
					end
				else
					create dlg.make_with_expression_on_object (fost.object_address, fost.feature_name)
				end
			else
				fst ?= s
				if fst /= Void then
					oname := fst.feature_name
					create dlg.make_with_expression_text (fst.feature_name)
					if fst.e_class /= Void then
						dlg.set_class_text (fst.e_class)
					end
				else
					ost ?= s
					if ost /= Void then
						oname := ost.name + ": " + ost.object_address
						if ev_application.ctrl_pressed then
							add_object (ost, oname)
						else
							create dlg.make_with_named_object (ost.object_address, oname)
						end
					else
						cst ?= s
						if cst /= Void then
							create dlg.make_with_class (cst.e_class)
						end
					end
				end
			end
			if dlg /= Void then
				dlg.set_callback (agent add_expression_with_dialog (dlg))
				dlg.show_modal_to_window (debugger_manager.debugging_window.window)
			end
		end

	remove_expression_row (row: EV_GRID_ROW) is
		require
			row_not_void: row /= Void
		local
			l_item: like watched_item_from
		do
			l_item ?= watched_item_from (row)
			if l_item /= Void then
				l_item.safe_unattach
				watched_items.prune_all (l_item)
			end
--| bug#11272 : using the next line raises display issue:
--|			watches_grid.remove_row (row.index)
			watches_grid.remove_rows (row.index, row.index + row.subrow_count_recursive)
		end

	is_removable (a: ANY): BOOLEAN is
		do
			Result := True
		end

	remove_object_line (a: ANY) is
		do
			remove_selected
		end

	has_selected_item: BOOLEAN is
			-- Does the grid have selected item?
		do
			if watches_grid /= Void then
				Result := not watches_grid.selected_items.is_empty
			end
		end

feature {NONE} -- Event handling

	open_watch_menu (w: EV_WIDGET; ax, ay: INTEGER) is
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			mci: EV_CHECK_MENU_ITEM
		do
			create m
				--| Auto expressions
			if toggle_auto_behavior_cmd /= Void then
				mci := toggle_auto_behavior_cmd.new_menu_item
				m.extend (mci)
				m.extend (create {EV_MENU_SEPARATOR})
			end

				--| Watch wipeout
			if watched_items.count > 0 then
				create mi.make_with_text_and_action (interface_names.f_clear_watch_tool_expressions, agent clear_watch_tool)
				m.extend (mi)
			end

				--| Watch management
			create mi.make_with_text_and_action (interface_names.f_create_new_watch, agent open_new_created_watch_tool)
			m.extend (mi)
			if debugger_manager.watch_tool_list.count > 1 then
				create mi.make_with_text_and_action (interface_names.b_Close_tool (title), agent close)
				m.extend (mi)
			end

			m.show_at (w, ax, ay)
		end

	open_new_created_watch_tool is
			-- Open new created watch tool.
		local
			wt: like Current
		do
			debugger_manager.create_new_watch_tool_inside_notebook (develop_window, Current)
			wt := debugger_manager.watch_tool_list.last
			wt.update
		end

	define_new_expression is
			-- Create a new expression.
		local
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
			ce: EB_EDITOR
			l_text: STRING
			debwin: EB_DEVELOPMENT_WINDOW
		do
			debwin := debugger_manager.debugging_window
			if debwin /= Void then
				ce := debwin.ui.current_editor
				if ce /= Void and then ce.has_selection then
					l_text := ce.string_selection
					if l_text.has ('%N') then
						l_text := Void
					end
				end
				if l_text /= Void and then not l_text.is_empty then
					create dlg.make_with_expression_text (l_text)
				else
					create dlg.make_new_expression
				end
				dlg.set_new_expression_mode
				dlg.set_callback (agent add_expression_with_dialog (dlg))
				dlg.show_modal_to_window (debwin.window)
			end
		end

	toggle_auto_expressions is
		do
			if not auto_expression_enabled then
				auto_expression_enabled := True
			else
				auto_expression_enabled := False
				remove_auto_expressions_from_watched_items
			end
			update
		end

	auto_expressions_deltas: TUPLE [low: INTEGER; up: INTEGER]
			-- Default might be (-)2, (+)1

	show_only_auto_expression_successfully_evaluated: BOOLEAN is True
			-- Show auto expression only if successfully evaluated ?

	add_auto_expressions is
		local
			l_auto: AST_DEBUGGER_AUTO_EXPRESSION_VISITOR
			exprs: LIST [STRING]
			s: STRING
		do
			create l_auto
			exprs := l_auto.auto_expressions (
									debugger_manager.current_debugging_breakable_index,
									auto_expressions_deltas.low,
									auto_expressions_deltas.up,
									debugger_manager.current_debugging_feature,
									debugger_manager.current_debugging_class_c
								)
			if exprs /= Void and then not exprs.is_empty then
				watches_grid_empty := False
				from
					exprs.start
				until
					exprs.after
				loop
					s := exprs.item
					if s /= Void then
						add_new_auto_expression (s.as_string_32)
					end
					exprs.forth
				end
			end
		end

	edit_expression is
			-- Edit a selected expression.
		local
			rows: ARRAYED_LIST [EV_GRID_ROW]
			sel: EV_GRID_ROW
			expr: EB_EXPRESSION
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
			l_item: like watched_item_from
		do
			rows := grid_selected_top_rows (watches_grid)
			if not rows.is_empty then
				from
					rows.start
				until
					rows.after
				loop
					sel := rows.item
					l_item := watched_item_from (sel)
					if l_item /= Void then
						expr := l_item.expression
						check expr /= Void end
						create dlg.make_with_expression (expr)
						dlg.set_edit_expression_title
						dlg.set_callback (agent refresh_expression (expr))
						dlg.show_modal_to_window (debugger_manager.debugging_window.window)
					end
					rows.forth
				end
			end
		end

	toggle_state_of_selected is
			-- Toggle state of the selected expressions from the list.
		local
			rows: LIST [EV_GRID_ROW]
			l_expr: EB_EXPRESSION
			sel_index: INTEGER
			l_item: like watched_item_from
		do
			rows := grid_selected_top_rows (watches_grid)
			if not rows.is_empty then
				sel_index := rows.first.index
			end
			from
				rows.start
			until
				rows.after
			loop
				if rows.item.parent /= Void and then rows.item.parent_row = Void then
					l_item := watched_item_from (rows.item)
					if l_item = Void then
						check False end
					else
						l_expr := l_item.expression
						if l_expr /= Void and then l_expr.evaluation_disabled then
							l_expr.enable_evaluation
						else
							l_expr.disable_evaluation
						end
						refresh_watched_item (l_item)
					end
				end
				rows.forth
			end
			if not rows.is_empty then
				if watches_grid.row_count >= sel_index then
					watches_grid.row (sel_index).enable_select
				else
					on_row_deselected (Void)
				end
			end
		end

	move_processing: BOOLEAN

	move_selected (grid: ES_OBJECTS_GRID; offset: INTEGER) is
		local
			sel_rows: LIST [EV_GRID_ROW]
			sel: EV_GRID_ROW
			sel_index: INTEGER
			new_index, to_index: INTEGER
			line: ES_OBJECTS_GRID_EXPRESSION_LINE
			witems: like watched_items
		do
			if not move_processing then
				move_processing := True --| To avoid concurrent move
				sel_rows := grid_selected_top_rows (watches_grid)
				if not sel_rows.is_empty then
					sel := sel_rows.first
					if sel.parent_row = Void then
						sel_index := sel.index
						line ?= sel.data
						if line /= Void then
							witems := watched_items
							witems.start
							witems.search (line)
							if not witems.exhausted then
								check witems.item = line end
								new_index := witems.index + offset
								if new_index < 1 then
									new_index := 1
								elseif new_index > witems.count then
									new_index := witems.count
								end
								witems.swap (new_index)
							end
						end
						to_index := grid.grid_move_top_row_node_by (grid, sel_index, offset)
						check to_index > 0 end
						grid.remove_selection
						sel.enable_select
					end
				end
				move_processing := False
				ensure_last_row_is_new_expression_row
			end
		end

	remove_selected is
			-- Remove the selected expressions from the list.
		local
			rows: LIST [EV_GRID_ROW]
			sel_index: INTEGER
		do
			rows := grid_selected_top_rows (watches_grid)
			if not rows.is_empty then
				sel_index := rows.first.index
			end
			from
				rows.start
			until
				rows.after
			loop
				if rows.item.parent_row = Void then
					remove_expression_row (rows.item)
				end
				rows.forth
			end
			ensure_last_row_is_new_expression_row
			if not rows.is_empty then
				if watches_grid.row_count >= sel_index then
					if sel_index > 1 and sel_index = new_expression_row.index then
						sel_index := sel_index - 1
					end
					watches_grid.row (sel_index).enable_select
				else
					on_row_deselected (Void)
				end
			end
		end

	update_commands_on_expressions_delayer: ES_DELAYED_ACTION
			-- Action delayer for `update_commands_on_expressions'
			-- this way we don't disable command to re-enable right after

	request_update_commands_on_expressions is
		do
			if update_commands_on_expressions_delayer = Void then
				create update_commands_on_expressions_delayer.make (agent update_commands_on_expressions, 100)
			end
			update_commands_on_expressions_delayer.request_call
		end

	update_commands_on_expressions is
		local
			lst: LIST [EV_GRID_ROW]
			row: EV_GRID_ROW
		do
			if update_commands_on_expressions_delayer /= Void then
				update_commands_on_expressions_delayer.cancel_request
			end
			lst := watches_grid.selected_rows
			if not lst.is_empty then
				from
					lst.start
				until
					lst.after
				loop
					row := lst.item_for_iteration
					if
						row.parent_row = Void and then
						row /= new_expression_row
					then
						lst.forth
					else
						lst.remove
					end
				end
			end

			if lst.count > 0 then
				delete_expression_cmd.enable_sensitive
				toggle_state_of_expression_cmd.enable_sensitive
			else
				delete_expression_cmd.disable_sensitive
				toggle_state_of_expression_cmd.disable_sensitive
			end
			if watches_grid.selected_rows.count = 1 then
				edit_expression_cmd.enable_sensitive
				move_up_cmd.enable_sensitive
				move_down_cmd.enable_sensitive
			else
				edit_expression_cmd.disable_sensitive
				move_up_cmd.disable_sensitive
				move_down_cmd.disable_sensitive
			end
		end

	on_row_selected (row: EV_GRID_ROW) is
			-- An item in the list of expression was selected.
		do
			update_commands_on_expressions
		end

	on_row_deselected (row: EV_GRID_ROW) is
			-- An item in the list of expression was selected.
		do
			request_update_commands_on_expressions
		end

	key_pressed (k: EV_KEY) is
			-- A key was pressed in `ev_list'.
		local
			ost: OBJECT_STONE
		do
			if k /= Void then
				inspect k.code
				when {EV_KEY_CONSTANTS}.key_delete then
					remove_selected
				when {EV_KEY_CONSTANTS}.key_f2 then
					edit_expression
				when {EV_KEY_CONSTANTS}.key_c , {EV_KEY_CONSTANTS}.key_insert then
					if
						ev_application.ctrl_pressed
						and not ev_application.alt_pressed
						and not ev_application.shift_pressed
					then
						update_clipboard_string_with_selection (watches_grid)
					end
				when {EV_KEY_CONSTANTS}.key_v then
					if
						ev_application.ctrl_pressed
						and not ev_application.alt_pressed
						and not ev_application.shift_pressed
					then
						set_expression_from_clipboard (watches_grid)
					end
				when {EV_KEY_CONSTANTS}.key_e then
					if
						ev_application.ctrl_pressed
						and not ev_application.alt_pressed
						and not ev_application.shift_pressed
					then
						if watches_grid.selected_rows.count > 0 then
							ost ?= watches_grid.grid_pebble_from_row_and_column (watches_grid.selected_rows.first, Void)
							object_viewer_cmd.set_stone (ost)
						end
					end
				when {EV_KEY_CONSTANTS}.key_numpad_subtract then
					if
						ev_application.ctrl_pressed
						and not ev_application.alt_pressed
						and not ev_application.shift_pressed
					then
						move_selected (watches_grid, -1)
					end
				when {EV_KEY_CONSTANTS}.key_numpad_add then
					if
						ev_application.ctrl_pressed
						and not ev_application.alt_pressed
						and not ev_application.shift_pressed
					then
						move_selected (watches_grid, +1)
					end
				when {EV_KEY_CONSTANTS}.key_right then
					expand_selected_rows (watches_grid)
				when {EV_KEY_CONSTANTS}.key_left then
					collapse_selected_rows (watches_grid)
				when {EV_KEY_CONSTANTS}.key_enter then
					if
						not ev_application.ctrl_pressed
						and not ev_application.alt_pressed
						and not ev_application.shift_pressed
					then
						enter_key_pressed (watches_grid)
					end
				else
				end
			end
		end

	string_key_pressed (s: STRING_32) is
			-- A key was pressed in `watches_grid'.
		local
			row: EV_GRID_ROW
			rows: ARRAYED_LIST [EV_GRID_ROW]
			empty_expression_cell: ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL
		do
			if
				not ev_application.ctrl_pressed
				and not ev_application.alt_pressed
			then
				rows := grid_selected_top_rows (watches_grid)
				if not rows.is_empty then
					row := rows.first
					if
						watches_grid.col_name_index <= row.count
					then
						empty_expression_cell ?= row.item (watches_grid.col_name_index)
						if empty_expression_cell /= Void then
							if s.is_equal ("%N") then
								empty_expression_cell.activate
							else
								empty_expression_cell.activate_with_string (s)
							end
						end
					end
				end
			end
		end

	enter_key_pressed (a_grid: ES_OBJECTS_GRID) is
			-- A [enter] key was pressed in `watches_grid'.
		local
			row: EV_GRID_ROW
			rows: ARRAYED_LIST [EV_GRID_ROW]
			expression_cell: ES_OBJECTS_GRID_EXPRESSION_CELL
		do
			if
				not ev_application.ctrl_pressed
				and not ev_application.alt_pressed
				and not ev_application.shift_pressed
			then
				rows := grid_selected_top_rows (watches_grid)
				if not rows.is_empty then
					row := rows.first
					if
						watches_grid.col_name_index <= row.count
					then
						expression_cell ?= row.item (watches_grid.col_name_index)
						if expression_cell /= Void then
							expression_cell.activate
						end
					end
				end
			end
		end

	add_expression_with_dialog (dlg: EB_EXPRESSION_DEFINITION_DIALOG) is
			-- Add a new expression defined by `dlg'.
		local
			l_expr: EB_EXPRESSION
		do
			l_expr := dlg.new_expression
			add_expression (l_expr, False)
		end

	add_object (ost: OBJECT_STONE; oname: STRING) is
		require
			ost_ot_void: ost /= Void
			oname /= Void
			application_is_running: debugger_manager.application_is_executing
		local
			expr: EB_EXPRESSION
		do
			debugger_manager.application_status.keep_object (ost.object_address)
			create expr.make_as_object (ost.dynamic_class , ost.object_address)
			expr.set_name (oname)
			add_expression (expr, False)
		end

	add_expression (expr: EB_EXPRESSION; is_auto: BOOLEAN) is
		local
			expr_item: like watched_item_from
		do
			if is_auto then
				if debugger_manager.safe_application_is_stopped then
					if not expr.is_evaluated then
						expr.evaluate_as_auto_expression
					end
				end
				if not show_only_auto_expression_successfully_evaluated or else not expr.error_occurred then
					expr_item := new_watched_item_from_expression (expr, watches_grid)
					expr_item.set_auto_expression (True)
				end
			else
				expr_item := new_watched_item_from_expression (expr, watches_grid)
			end
			if expr_item /= Void then
				if not expr.is_evaluated and debugger_manager.safe_application_is_stopped then
					expr_item.request_evaluation (True)
				end

				watched_items.extend (expr_item)
				if expr_item.row /= Void then
					if
						not expr_item.compute_grid_display_done
						and then (expr /= Void and then (expr.evaluation_disabled or not expr.is_evaluated))
					then
						expr_item.compute_grid_display
					end
					watches_grid.remove_selection
					if not expr_item.row.is_destroyed and then expr_item.row.is_displayed then
						expr_item.row.ensure_visible
					end
					expr_item.row.enable_select
				end
			end
		end

feature {NONE} -- Event handling on notebook item

--| Commented since not used for now
--	on_notebook_item_pointer_button_pressed (ax, ay, ab: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
--			-- FIXIT: this feature seems useless?
--		do
--			if
--				ab = 3
--				and then not Ev_application.ctrl_pressed
--				and then not Ev_application.shift_pressed
--				and then not Ev_application.alt_pressed
--			then
--				open_watch_menu (notebook_item.parent.widget, ax, ay)
--			end
--		end

feature {NONE} -- Implementation: internal data

	delete_expression_cmd: EB_STANDARD_CMD
			-- Command that deletes one or more rows from the list of expressions.

	create_expression_cmd: EB_STANDARD_CMD
			-- Command that creates a new expression.

	edit_expression_cmd: EB_STANDARD_CMD
			-- Command that creates a new expression.

	toggle_state_of_expression_cmd: EB_STANDARD_CMD
			-- Command that enable/disable a new expression

	toggle_auto_behavior_cmd: EB_STANDARD_TOOLBARABLE_AND_MENUABLE_TOGGLE_COMMAND
			-- Command that activate/deactivate auto expressions.

	move_up_cmd, move_down_cmd: EB_STANDARD_CMD
			-- Move selected item up or down.

	update_agent: PROCEDURE [ANY, TUPLE]
			-- Agent that is put in the idle_actions to update the call stack after a while.

	object_viewer_cmd: EB_OBJECT_VIEWER_COMMAND is
		do
			Result := debugger_manager.object_viewer_cmd
		end

feature {EB_DEBUGGER_MANAGER} -- Grid

	watches_grid: ES_OBJECTS_GRID
			-- Graphical representation of the list of expressions to evaluate.

	watched_items: ARRAYED_LIST [like watched_item_from]
			-- List of items that are displayed
			-- ie: mostly ES_OBJECTS_GRID_EXPRESSION_LINE

	remove_auto_expressions_from_watched_items is
		local
			witem: like watched_item_from
			witems: like watched_items
			r: EV_GRID_ROW
		do
			from
				witems := watched_items
				witems.start
			until
				witems.after
			loop
				witem := witems.item
				if witem = Void then
					witems.remove
				else
					if witem.is_auto_expression then
						r := witem.row
						witem.safe_unattach
						if r /= Void and r.parent /= Void then
							watches_grid.remove_rows (r.index, r.index + r.subrow_count_recursive)
--							watches_grid.remove_row (r.index)
						end
						witems.remove
					else
						witems.forth
					end
				end
			end
		end

feature -- Grid management

	watches_grid_empty: BOOLEAN

	clean_watched_grid is
		do
			if not watches_grid_empty then
				watches_grid.remove_and_clear_all_rows
				watches_grid_empty := True
			end
		end

	record_grid_layout is
		do
			if process_record_layout_on_next_recording_request then
				watches_grid.record_layout
				process_record_layout_on_next_recording_request := False
			end
		end

	clear_watch_tool is
			-- Clear watch tool expression.
		do
			watched_items.wipe_out
			clean_watched_grid
			ensure_last_row_is_new_expression_row
		end

feature {NONE} -- grid Layout Implementation

	keep_object_reference_fixed (addr: STRING) is
		do
			if debugger_manager.application_is_executing then
				debugger_manager.application_status.keep_object (addr)
			end
		end

	initialize_watches_grid_layout (pv: BOOLEAN_PREFERENCE) is
		require
			not is_grid_layout_initialized
			watches_grid.layout_manager = Void
		local
			l_grid: ES_OBJECTS_GRID
		do
			l_grid := watches_grid
			l_grid.initialize_layout_management (pv)
			check
				l_grid.layout_manager /= Void
			end
			is_grid_layout_initialized := True
		end

	is_grid_layout_initialized: BOOLEAN

	process_record_layout_on_next_recording_request: BOOLEAN

feature -- Access

	refresh_watched_item (a_item: like watched_item_from) is
			-- Refresh expression grid row item
		require
			a_item_not_void: a_item /= Void
			a_item_has_expression: a_item.expression /= Void
			a_item_attached: a_item.row /= Void
		local
			l_row: EV_GRID_ROW
			l_expr: EB_EXPRESSION
		do
			l_row := a_item.row
			l_expr := a_item.expression
			if l_expr.evaluation_disabled then
				--| nothing special
			else
				if debugger_manager.safe_application_is_stopped then
					l_expr.evaluate
				else
					l_expr.set_unevaluated
				end
			end
			a_item.refresh
		end

	add_debug_value (dv: ABSTRACT_DEBUG_VALUE) is
			-- Add value `dv' to the watch tool's grid
		local
			expr: EB_EXPRESSION
		do
			if dv.dynamic_class = Void then
				create expr.make_for_context ("Void")
			else
				create expr.make_as_object (dv.dynamic_class, dv.address)
			end
			add_expression (expr, False)
		end

feature -- Update

	refresh is
			-- Refresh current grid
			--| Could be optimized to refresh only grid's content display ..
		do
			record_grid_layout
			update
		end

	update is
			-- Display current execution status.
		do
			cancel_process_real_update_on_idle
			if debugger_manager.application_is_executing then
				process_real_update_on_idle (debugger_manager.application_is_stopped)
			else
				watches_grid.reset_layout_recorded_values
			end
		end

feature {NONE} -- Auto-completion

	set_up_complete_possibilities_provider (a_item: ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL) is
			-- Set up code completion possibilities.
		local
			l_provider: EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER
		do
			create l_provider.make (Void, Void)
			l_provider.set_dynamic_context_functions (
										agent debugger_manager.current_debugging_class_c,
										agent debugger_manager.current_debugging_feature_as)
			a_item.set_completion_possibilities_provider (l_provider)
		end

feature {NONE} -- Implementation

	real_update (dbg_was_stopped: BOOLEAN) is
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running
		local
			eval: BOOLEAN
			l_expr: EB_EXPRESSION
			l_item: like watched_item_from
			witems: like watched_items
		do
			Precursor {DEBUGGING_UPDATE_ON_IDLE} (dbg_was_stopped)
			if debugger_manager.safe_application_is_stopped and dbg_was_stopped then
				eval := True
			end
			watches_grid.remove_selection
			if
				watches_grid.row_count > 0
				and not eval
				and process_record_layout_on_next_recording_request
			then
				process_record_layout_on_next_recording_request := False
				watches_grid.record_layout
			end
			remove_auto_expressions_from_watched_items
			from
				witems := watched_items
				witems.start
			until
				witems.after
			loop
				l_item := witems.item
				l_item.request_evaluation (False)
				l_expr := l_item.expression
				if l_expr.evaluation_disabled then
					-- Nothing special
				else
					if eval then
						l_item.request_evaluation (True)
					else
						l_expr.set_unevaluated
					end
				end
				if l_item.row = Void then
						--| It seems to occur when "Restarting" debugging
					l_item.attach_to_row (watches_grid.extended_new_row)
				end
				l_item.request_refresh
				witems.forth
			end
			if auto_expression_enabled then
				add_auto_expressions
			end
			ensure_last_row_is_new_expression_row
			on_row_deselected (Void) -- Reset toolbar buttons
			if eval then
				watches_grid.restore_layout
			end
			process_record_layout_on_next_recording_request := eval
		end

	standard_grid_label (s: STRING): EV_GRID_LABEL_ITEM is
		do
			create Result
			Result.set_text (s)
		end

	Cst_expression_col: INTEGER is 1

	Cst_type_col: INTEGER is 2

	Cst_value_col: INTEGER is 3

	Cst_context_col: INTEGER is 4

	Cst_nota_col: INTEGER is 5

	new_watched_item_from_expression (expr: EB_EXPRESSION; a_grid: ES_OBJECTS_GRID): like watched_item_from is
		require
			expr /= Void
			a_grid /= Void
		do
			create Result.make_with_expression (expr, a_grid)
			add_watched_item_to_grid (Result, a_grid)
		end

	add_watched_item_to_grid (witem: like watched_item_from; a_grid: ES_OBJECTS_GRID) is
		require
			witem /= Void
			a_grid /= Void
		do
			witem.safe_unattach
			witem.attach_to_row (a_grid.extended_new_row)
			ensure_last_row_is_new_expression_row
		end

	show_text_in_popup (txt: STRING; x, y, button: INTEGER; gi: EV_GRID_ITEM) is
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt (txt, debugger_manager.debugging_window.window, Void)
		end

	watched_item_from (row: EV_GRID_ROW): ES_OBJECTS_GRID_EXPRESSION_LINE is
		require
			row_not_void: row /= Void
		local
			ctlr: ES_GRID_ROW_CONTROLLER
		do
			Result ?= row.data
			if Result = Void then
				ctlr ?= row.data
				if ctlr /= Void then
					Result ?= ctlr.data
				end
			end
		end

	is_auto_expression_watched_item (row: EV_GRID_ROW): BOOLEAN is
		require
			row_not_void: row /= Void
		local
			w: like watched_item_from
		do
			w := watched_item_from (row)
			Result := w /= Void and then w.is_auto_expression
		end

	watched_item_for_expression (expr: EB_EXPRESSION): like watched_item_from is
		require
			valid_expr: expr /= Void
		local
			witems: like watched_items
		do
			from
				witems := watched_items
				witems.start
			until
				witems.after or Result /= Void
			loop
				Result := witems.item
				if Result.expression /= expr then
					Result := Void
				end
				witems.forth
			end
		end

	refresh_expression (expr: EB_EXPRESSION) is
		require
			valid_expr: expr /= Void
		local
			l_item: like watched_item_from
		do
			l_item := watched_item_for_expression (expr)
			check l_item /= Void end
			refresh_watched_item (l_item)
		end

	refresh_context_expressions is
			-- Refresh the value and display of context-related expressions.
		require
			application_stopped: debugger_manager.safe_application_is_stopped
		local
			r: INTEGER
			row: EV_GRID_ROW
			expr: EB_EXPRESSION
			l_item: like watched_item_from
		do
			if watches_grid.row_count > 0 then
				remove_auto_expressions_from_watched_items
				from
					r := 1
				until
					r > watches_grid.row_count
				loop
					row := watches_grid.row (r)
					if row.parent_row = Void then
						l_item := watched_item_from (row)
						if l_item /= Void then
							expr ?= l_item.expression
							if expr.on_context then
								refresh_watched_item (l_item)
							end
						end
					end
					r := r + 1
				end
				if auto_expression_enabled then
					add_auto_expressions
				end
			end
		end

	Unevaluated: STRING is ""
			-- String that is displayed in the "expression" column when an expression was not evaluated.
			--	expressions.count = watches_grid.row_count

invariant
	watched_items_not_void: watched_items /= Void
	not_void_delete_expression_cmd: mini_toolbar /= Void implies delete_expression_cmd /= Void

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

end -- class ES_WATCH_TOOL


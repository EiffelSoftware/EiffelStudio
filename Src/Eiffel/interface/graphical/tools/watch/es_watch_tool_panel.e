note
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

	ES_DEBUGGER_DOCKABLE_STONABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			close,
			on_before_initialize,
			on_after_initialized,
			on_show,
			create_mini_tool_bar_items,
			internal_recycle,
			show
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		do
			watch_id := tool_descriptor.edition
			auto_expression_enabled := False
			auto_expressions_deltas := [-2, +1]
			create watched_items.make (10)

			Precursor
		end

	build_tool_interface (a_widget: EV_VERTICAL_BOX)
			-- Build all the tool's widgets.
		local
			esgrid: ES_OBJECTS_GRID
		do
			create esgrid.make_with_name (title, "watches" + watch_id.out)
			esgrid.enable_multiple_row_selection
			esgrid.set_column_count_to (6)
			esgrid.set_default_columns_layout (<<
						[esgrid.col_name_id, True, False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (150), interface_names.l_Expression, interface_names.to_expression],
						[esgrid.col_value_id, True, False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (150), interface_names.l_value, interface_names.to_value],
						[esgrid.col_type_id, True, False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (100), interface_names.l_type, interface_names.to_type],
						[esgrid.col_address_id, True, False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (80), interface_names.l_address, interface_names.to_address],
						[esgrid.col_scoop_pid_id, True, False,   {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (30), interface_names.l_scoop_pid, interface_names.to_scoop_pid],
						[esgrid.col_context_id, True, False, {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (200), interface_names.l_Context, interface_names.to_context]
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
			initialize_shortcuts

				--| Attach the slices_cmd to the objects grid
			watches_grid.set_slices_cmd (slices_cmd)

			a_widget.extend (watches_grid)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor

				-- FIXME: Tool should be refactored to implement {ES_DOCKABLE_STONEABLE_TOOL_PANEL}
			register_action (content.drop_actions, agent on_element_drop)
		end

    create_mini_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display on the window title
		local
			tbb: SD_TOOL_BAR_BUTTON
			scmd: EB_STANDARD_CMD
		do
			create Result.make (12)

			create scmd.make
			scmd.set_mini_pixmap (pixmaps.mini_pixmaps.toolbar_dropdown_icon)
			scmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.toolbar_dropdown_icon_buffer)
			scmd.set_tooltip (interface_names.f_Open_watch_tool_menu)
			scmd.enable_sensitive
			tbb := scmd.new_mini_sd_toolbar_item
			scmd.add_agent (agent open_watch_menu (tbb))
			Result.extend (tbb)

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
			Result.extend (toggle_auto_behavior_cmd.new_mini_sd_toolbar_item)

			create create_expression_cmd.make
			create_expression_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.new_expression_icon)
			create_expression_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.new_expression_icon_buffer)
			create_expression_cmd.set_tooltip (interface_names.e_new_expression)
			create_expression_cmd.add_agent (agent define_new_expression)
			create_expression_cmd.enable_sensitive
			Result.extend (create_expression_cmd.new_mini_sd_toolbar_item)

			create edit_expression_cmd.make
			edit_expression_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_edit_icon)
			edit_expression_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_edit_icon_buffer)
			edit_expression_cmd.set_tooltip (interface_names.e_edit_expression)
			edit_expression_cmd.add_agent (agent edit_expression)
			tbb := edit_expression_cmd.new_mini_sd_toolbar_item
			Result.extend (tbb)

			create toggle_state_of_expression_cmd.make
			toggle_state_of_expression_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_toogle_icon)
			toggle_state_of_expression_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_toogle_icon_buffer)
			toggle_state_of_expression_cmd.set_tooltip (interface_names.e_toggle_state_of_expressions)
			toggle_state_of_expression_cmd.add_agent (agent toggle_state_of_selected)
			tbb := toggle_state_of_expression_cmd.new_mini_sd_toolbar_item
			Result.extend (tbb)

			create slices_cmd.make (Current)
			slices_cmd.enable_sensitive
			Result.extend (slices_cmd.new_mini_sd_toolbar_item)

			create hex_format_cmd.make (agent set_hexadecimal_mode (?))
			hex_format_cmd.enable_sensitive
			Result.extend (hex_format_cmd.new_mini_sd_toolbar_item)

			Result.extend (object_viewer_cmd.new_mini_sd_toolbar_item)
			Result.extend (debugger_manager.object_storage_management_cmd.new_mini_sd_toolbar_item_for_watch_tool (Current))

			create delete_expression_cmd.make
			delete_expression_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_delete_icon)
			delete_expression_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_delete_icon_buffer)
			delete_expression_cmd.set_tooltip (interface_names.e_remove_expressions)
			delete_expression_cmd.add_agent (agent remove_selected)
			tbb := delete_expression_cmd.new_mini_sd_toolbar_item
			tbb.drop_actions.extend (agent remove_object_line)
			tbb.drop_actions.set_veto_pebble_function (agent is_removable )
			Result.extend (tbb)

			create move_up_cmd.make
			move_up_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_up_icon)
			move_up_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_up_icon_buffer)
			move_up_cmd.set_tooltip (interface_names.f_move_item_up)
			move_up_cmd.add_agent (agent move_selected (-1))
			tbb := move_up_cmd.new_mini_sd_toolbar_item
			Result.extend (tbb)

			create move_down_cmd.make
			move_down_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_down_icon)
			move_down_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_down_icon_buffer)
			move_down_cmd.set_tooltip (interface_names.f_move_item_down)
			move_down_cmd.add_agent (agent move_selected (+1))
			tbb := move_down_cmd.new_mini_sd_toolbar_item
			Result.extend (tbb)
		end

	context_menu_handler (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu handler
		do
			develop_window.menus.context_menu_factory.watch_tool_menu (a_menu, a_target_list, a_source, a_pebble, Current, watches_grid)
		end

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "E70D5827-A00D-47EE-9E7A-B7B4BFB34CCF"
		end

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

feature -- Properties

	watch_id: INTEGER
			-- Watch's identifier

feature -- Closing

	close
		do
			Precursor
			if attached {ES_WATCH_TOOL} tool_descriptor as wt then
				debugger_manager.watch_tool_list.prune_all (wt)
			end
			debugger_manager.update_all_debugging_tools_menu
		end

feature -- Access

	can_refresh: BOOLEAN
			-- Should we display data when a stone is set?

	auto_expression_enabled: BOOLEAN
			-- Is auto expression enabled ?

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

feature -- Change

	set_debugger_manager (a_manager: like debugger_manager)
			-- Affect `a_manager' to `debugger_manager'.
		do
			debugger_manager := a_manager
		end

	show
			-- Show tool
		do
			Precursor
			if watches_grid.is_displayed then
				watches_grid.set_focus
			end
			request_update
		end

feature -- Properties setting

	set_hexadecimal_mode (v: BOOLEAN)
		do
			watches_grid.set_hexadecimal_mode (v)
		end

feature {ES_OBJECTS_GRID_SLICES_CMD} -- Query

	objects_grid_object_line (addr: DBG_ADDRESS): detachable ES_OBJECTS_GRID_OBJECT_LINE
		local
			r: INTEGER
			lrow: EV_GRID_ROW
			ladd: detachable DBG_ADDRESS
		do
			from
				r := 1
			until
				r > watches_grid.row_count or Result /= Void
			loop
				lrow := watches_grid.row (r)
				if lrow.parent_row = Void then
					if attached {like objects_grid_object_line} grid_data_from_widget (lrow) as res then
						ladd := res.object_address
						if ladd = Void or else not ladd.is_equal (addr) then
							Result := Void
						else
							Result := res
						end
					else
						Result := Void
					end
				end
				r := r + 1
			end
		end

feature {NONE} -- Stone handlers

	on_stone_changed (a_old_stone: detachable like stone)
			-- Assign `a_stone' as new stone.
		do
			if can_refresh then
				if attached {CALL_STACK_STONE} stone as cst and then debugger_manager.safe_application_is_stopped then
					debug ("refactor_fixme")
						fixme ("Check if we should not call `update' to benefit real_update optimisation")
					end
					if debugger_manager.is_dotnet_project then
						if attached {APPLICATION_EXECUTION_DOTNET} debugger_manager.application as app_impl then
							if not app_impl.callback_notification_processing then
								refresh_context_expressions
							end
						else
							check is_dotnet_app: False end
						end
					else
						refresh_context_expressions
					end
				end
			end
		end

feature -- Change status

	enable_refresh
			-- Set `can_refresh' to `True'.
		do
			can_refresh := True
		end

	disable_refresh
			-- Set `can_refresh' to `False'.
		do
			can_refresh := False
		end

	prepare_for_debug
			-- Remove obsolete expressions from `Current'.
		local
			evl: DBG_EXPRESSION_EVALUATION
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
						evl := witem.expression_evaluation
						if
							evl = Void
							or else not evl.expression.is_reusable
						then
							witems.remove
						else
							evl.reset --| i.e: set unevaluated
							add_watched_item_to_grid (witem, watches_grid)
							witems.forth
						end
					end
				end
			end

			update
		end

feature -- Memory management

	reset_tool
		do
			reset_update_on_idle
			recycle_expressions
			if is_initialized then
				watches_grid.reset_layout_manager
				clean_watched_grid
			end
			if update_commands_on_expressions_delayer /= Void then
				update_commands_on_expressions_delayer.destroy
				update_commands_on_expressions_delayer := Void
			end
		end

feature {NONE} -- Memory management

	internal_recycle
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			reset_tool
			Precursor {ES_DEBUGGER_DOCKABLE_STONABLE_TOOL_PANEL}
		end

	recycle_expressions
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
						if not witem.expression.is_reusable then
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

	set_mouse_wheel_scroll_size_agent : PROCEDURE [INTEGER_32]
	set_mouse_wheel_scroll_full_page_agent: PROCEDURE [BOOLEAN]
	set_scrolling_common_line_count_agent: PROCEDURE [INTEGER_32]
			-- Agents for recycling

feature {NONE} -- add new expression from the grid

	new_expression_row: EV_GRID_ROW
			-- Grid row which should always be at the end of the grid
			-- this is used to enter new expression easily

	ensure_last_row_is_new_expression_row
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
				glab.set_font (watches_grid.grid_font)
				grid_cell_set_tooltip (glab, interface_names.f_add_new_expression)

				new_expression_row.set_item (1, glab)
				glab.pointer_double_press_actions.extend (agent (i_glab: EV_GRID_ITEM; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER) do i_glab.activate end (glab, ?,?,?,?,?,?,?,?))
				glab.apply_actions.extend (agent add_new_expression_for_context)
				set_up_complete_possibilities_provider (glab)
			elseif new_expression_row.index < watches_grid.row_count then
				grid_move_to_end_of_grid (new_expression_row)
			end
			watches_grid_empty := False
		end

	add_new_expression_for_context (s: STRING_32)
		local
			expr: DBG_EXPRESSION
		do
			if valid_expression_text (s) then
				create expr.make_with_context (s)
				add_expression (expr, False)
			end
		end

	add_new_auto_expression (s: STRING_32)
		local
			expr: DBG_EXPRESSION
		do
			if valid_expression_text (s) then
				create expr.make_with_context (s)
				add_expression (expr, True)
			end
		end

	valid_expression_text (s: STRING_32): BOOLEAN
		do
			Result := s /= Void and then (not s.is_empty and not s.has ('%R') and not s.has ('%N'))
		end

feature {EB_CONTEXT_MENU_FACTORY, ES_WATCH_TOOL} -- Context menu

	drop_text (s: STRING_32)
			-- Drop Clipboard's text into watch tool
		require
			s_attached: s /= Void
		local
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
		do
			show
			create dlg.make_with_expression_text (s)
			dlg.set_callback (agent add_expression_with_dialog (dlg))
			dlg.show_modal_to_window (debugger_manager.debugging_window.window)
		end

	on_element_drop (s: CLASSC_STONE)
			-- Something was dropped in watch tool.
		local
			obj_st: detachable OBJECT_STONE
			dlg: detachable EB_EXPRESSION_DEFINITION_DIALOG
			oname: STRING_32
			cl: detachable CLASS_C
			ctrl_pressed: BOOLEAN
		do
			ctrl_pressed := ev_application.ctrl_pressed
			show
			if attached {FEATURE_STONE} s as fst then
				oname := fst.feature_name
				cl := fst.e_class
				if ctrl_pressed then
					if attached {FEATURE_ON_OBJECT_STONE} s as fost then
						obj_st := fost.object_stone
						if
							obj_st = Void and then
							attached fost.object_address as add and then
							cl /= Void
						then
							create obj_st.make (add, oname, cl)
						end
					elseif attached {ACCESS_ID_FEATURE_STONE} s as afst then
						if attached afst.associated_text as txt then
							oname := txt
						else
							oname := ""
						end
						obj_st := Void
					end
					if obj_st /= Void then
						on_element_drop (obj_st)
					else
						add_new_expression_for_context (oname)
					end
				else
					if attached {FEATURE_ON_OBJECT_STONE} s as fost then
						create dlg.make_with_expression_on_object (fost.object_address, oname)
					elseif attached {ACCESS_ID_FEATURE_STONE} s as afst then
						if attached afst.associated_text as txt then
							create dlg.make_with_expression_text (txt)
						else
--							oname := ""
						end
					else
						create dlg.make_with_expression_text (oname)
					end
					if cl /= Void and not dlg.has_class_text then
						dlg.set_class_text (cl)
					end
				end
			elseif attached {OBJECT_STONE} s as ost then
				oname := ost.name + ": " + ost.object_address.output
				cl := ost.dynamic_class
				if ctrl_pressed then
					add_object (ost, oname)
				else
					create dlg.make_with_named_object (ost.object_address, oname, cl)
				end
			elseif s /= Void then
				create dlg.make_with_class (s.e_class)
			end
			if dlg /= Void then
				dlg.set_callback (agent add_expression_with_dialog (dlg))
				dlg.show_modal_to_window (debugger_manager.debugging_window.window)
			end
		end

	remove_expression_row (row: EV_GRID_ROW)
		require
			row_not_void: row /= Void
		do
			if attached watched_item_from (row) as l_item then
				l_item.safe_unattach
				watched_items.prune_all (l_item)
			end
--| bug#11272 : using the next line raises display issue:
--|			watches_grid.remove_row (row.index)
			watches_grid.remove_rows (row.index, row.index + row.subrow_count_recursive)
		end

	is_removable (a: ANY): BOOLEAN
		do
			Result := True
		end

	remove_object_line (a: ANY)
		do
			remove_selected
		end

	has_selected_item: BOOLEAN
			-- Does the grid have selected item?
		do
			if watches_grid /= Void then
				Result := not watches_grid.selected_items.is_empty
			end
		end

feature {NONE} -- Event handling

	on_show
			-- <Precursor>
			--| Be sure the "..." cell is available	
		do
			Precursor
			ensure_last_row_is_new_expression_row
		end

	open_watch_menu (tbi: SD_TOOL_BAR_ITEM)
		require
			is_initialized: is_initialized
		local
			w: EV_WIDGET
			m: EV_MENU
			mi: EV_MENU_ITEM
			mci: EV_CHECK_MENU_ITEM
			l_has_items: BOOLEAN
		do
			w := mini_toolbar

			create m
				--| Auto expressions
			if toggle_auto_behavior_cmd /= Void then
				mci := toggle_auto_behavior_cmd.new_menu_item
				m.extend (mci)
				m.extend (create {EV_MENU_SEPARATOR})
			end

				--| Watch wipeout
			l_has_items := watched_items.count > 0
			if l_has_items then
				create mi.make_with_text_and_action (interface_names.f_clear_watch_tool_expressions, agent clear_watch_tool)
				m.extend (mi)
				create mi.make_with_text_and_action (interface_names.f_copy_watch_tool_selected_expressions_to_clipboard, agent copy_expressions_to_clipboard)
				m.extend (mi)
				m.extend (create {EV_MENU_SEPARATOR})
			end
			create mi.make_with_text_and_action (interface_names.f_export_watch_tool_expressions_to_file, agent export_expressions_to_file)
			m.extend (mi)
			if not l_has_items then
				mi.disable_sensitive
			end
			create mi.make_with_text_and_action (interface_names.f_import_watch_tool_expressions_from_file, agent import_expressions_from_file)
			m.extend (mi)
			m.extend (create {EV_MENU_SEPARATOR})

				--| Watch management
			create mi.make_with_text_and_action (interface_names.f_create_new_watch, agent open_new_created_watch_tool)
			m.extend (mi)
			if debugger_manager.watch_tool_list.count > 1 then
				create mi.make_with_text_and_action (interface_names.b_Close_tool (title), agent close)
				m.extend (mi)
			end


			if tbi /= Void and then attached tbi.rectangle as rect then
				m.show_at (w, rect.x, rect.y)
			else
				m.show_at (w, 0, 0)
			end
		end

	open_new_created_watch_tool
			-- Open new created watch tool.
		local
			wt: ES_WATCH_TOOL
		do
			debugger_manager.create_new_watch_tool_tabbed_with (develop_window, tool_descriptor)
			wt := debugger_manager.watch_tool_list.last
			if wt /= Void then
				wt.show (True)
				wt.request_update
			end
		end

	define_new_expression
			-- Create a new expression.
		local
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
			ce: EB_EDITOR
			l_text: STRING_32
			debwin: EB_DEVELOPMENT_WINDOW
		do
			debwin := debugger_manager.debugging_window
			if debwin /= Void then
				ce := debwin.ui.current_editor
				if ce /= Void and then ce.has_selection then
					l_text := ce.wide_string_selection
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

	toggle_auto_expressions
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

	show_only_auto_expression_successfully_evaluated: BOOLEAN = True
			-- Show auto expression only if successfully evaluated ?

	add_auto_expressions
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

	edit_expression
			-- Edit a selected expression.
		local
			rows: ARRAYED_LIST [EV_GRID_ROW]
			sel: EV_GRID_ROW
			expr: DBG_EXPRESSION
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

	open_viewer_on_expression
			-- Open viewer on selected expression
		do
			if
				object_viewer_cmd /= Void and then
				attached watches_grid as g and then g.has_selected_row
			then
				if attached {OBJECT_STONE} g.grid_pebble_from_row_and_column (g.selected_rows.first, Void) as ost then
					object_viewer_cmd.set_stone (ost)
				end
			end
		end

	toggle_state_of_selected
			-- Toggle state of the selected expressions from the list.
		local
			rows: LIST [EV_GRID_ROW]
			evl: DBG_EXPRESSION_EVALUATION
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
						-- Void if this is the new expression row
					else
						evl := l_item.expression_evaluation
						if evl /= Void and then evl.disabled then
							evl.set_disabled (False)
						else
							evl.set_disabled (True)
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

	remove_selected
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
					watches_grid.row (sel_index).parent_row_root.enable_select
				else
					on_row_deselected (Void)
				end
			end
		end

	update_commands_on_expressions_delayer: ES_DELAYED_ACTION
			-- Action delayer for `update_commands_on_expressions'
			-- this way we don't disable command to re-enable right after

	request_update_commands_on_expressions
		do
			if update_commands_on_expressions_delayer = Void then
				create update_commands_on_expressions_delayer.make (agent update_commands_on_expressions, 100)
			end
			update_commands_on_expressions_delayer.request_call
		end

	update_commands_on_expressions
		local
			lst: LIST [EV_GRID_ROW]
			row: EV_GRID_ROW
			l_new_exp_row: like new_expression_row
			n: INTEGER
		do
			if update_commands_on_expressions_delayer /= Void then
				update_commands_on_expressions_delayer.cancel_request
			end
			if watches_grid.has_selected_row then
				lst := watches_grid.selected_rows
				from
					lst.start
					l_new_exp_row := new_expression_row
					n := 0
				until
					lst.after or n > 1
						--| the following process depend on lst.count = 0, lst.count > 0 or lst.count = 1
						--| So we can stop, whenever we know we have at least 2 rows...
				loop
					row := lst.item_for_iteration
					if
						row /= l_new_exp_row and then
						row.parent_row = Void
					then
						n := n + 1
					end
					lst.forth
				end
			end

			if n > 0 then
				delete_expression_cmd.enable_sensitive
				toggle_state_of_expression_cmd.enable_sensitive
				move_up_cmd.enable_sensitive
				move_down_cmd.enable_sensitive
			else
				delete_expression_cmd.disable_sensitive
				toggle_state_of_expression_cmd.disable_sensitive
				move_up_cmd.disable_sensitive
				move_down_cmd.disable_sensitive
			end

			if n = 1 then
				edit_expression_cmd.enable_sensitive
			else
				edit_expression_cmd.disable_sensitive
			end
		end

	on_row_selected (row: EV_GRID_ROW)
			-- An item in the list of expression was selected.
		do
			request_update_commands_on_expressions
		end

	on_row_deselected (row: EV_GRID_ROW)
			-- An item in the list of expression was selected.
		do
			request_update_commands_on_expressions
		end

	key_pressed (k: EV_KEY)
			-- A key was pressed in `ev_list'.
		local
			ev_app: EV_APPLICATION
		do
			if k /= Void then
				ev_app := ev_application

				inspect k.code
				when {EV_KEY_CONSTANTS}.key_delete then
					remove_selected
				when {EV_KEY_CONSTANTS}.key_c then
					if
						ev_app.ctrl_pressed
						and not ev_app.alt_pressed
						and not ev_app.shift_pressed
					then
						update_clipboard_string_with_selection (watches_grid)
					end
				when {EV_KEY_CONSTANTS}.key_v then
					if
						ev_app.ctrl_pressed
						and not ev_app.alt_pressed
						and not ev_app.shift_pressed
					then
						set_expression_from_clipboard (watches_grid)
					end
				when {EV_KEY_CONSTANTS}.key_insert then
					if not ev_app.alt_pressed then
						if
							not ev_app.ctrl_pressed
							and ev_app.shift_pressed
						then
							set_expression_from_clipboard (watches_grid)
						elseif
							ev_app.ctrl_pressed
							and not ev_app.shift_pressed
						then
							update_clipboard_string_with_selection (watches_grid)
						end
					end
				when {EV_KEY_CONSTANTS}.key_right then
					expand_selected_rows (watches_grid)
				when {EV_KEY_CONSTANTS}.key_left then
					collapse_selected_rows (watches_grid)
				when {EV_KEY_CONSTANTS}.key_enter then
					if
						not ev_app.ctrl_pressed
						and not ev_app.alt_pressed
						and not ev_app.shift_pressed
					then
						enter_key_pressed (watches_grid)
					end
				else
				end
			end
		end

	string_key_pressed (s: STRING_32)
			-- A key was pressed in `watches_grid'.
		local
			row: EV_GRID_ROW
			rows: ARRAYED_LIST [EV_GRID_ROW]
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
						if attached {ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL} row.item (watches_grid.col_name_index) as empty_expression_cell then
							if s.same_string ("%N") then
								empty_expression_cell.activate
							else
								empty_expression_cell.activate_with_string (s)
							end
						end
					end
				end
			end
		end

	key_home_pressed
		local
			g: like watches_grid
		do
			g := watches_grid
			g.set_virtual_position (g.virtual_x_position, 0)
		end

	key_end_pressed
		local
			g: like watches_grid
		do
			g := watches_grid
			g.set_virtual_position (g.virtual_x_position, g.maximum_virtual_y_position)
		end

	enter_key_pressed (a_grid: ES_OBJECTS_GRID)
			-- A [enter] key was pressed in `watches_grid'.
		local
			row: EV_GRID_ROW
			rows: ARRAYED_LIST [EV_GRID_ROW]
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
						if attached {ES_OBJECTS_GRID_EXPRESSION_CELL} row.item (watches_grid.col_name_index) as expression_cell then
							expression_cell.activate
						end
					end
				end
			end
		end

	add_expression_with_dialog (dlg: EB_EXPRESSION_DEFINITION_DIALOG)
			-- Add a new expression defined by `dlg'.
		local
			l_expr: DBG_EXPRESSION
		do
			l_expr := dlg.new_expression
			add_expression (l_expr, False)
		end

	add_object (ost: OBJECT_STONE; oname: READABLE_STRING_GENERAL)
		require
			ost_ot_void: ost /= Void
			oname /= Void
			application_is_running: debugger_manager.application_is_executing
		local
			expr: DBG_EXPRESSION
		do
			debugger_manager.application_status.keep_object (ost.object_address)
			create expr.make_as_object (ost.dynamic_class , ost.object_address)
				-- FIXME: better Unicode support
			expr.set_name ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (oname))
			add_expression (expr, False)
		end

	add_expression (expr: DBG_EXPRESSION; is_auto: BOOLEAN)
		local
			expr_item: like watched_item_from
			evl: DBG_EXPRESSION_EVALUATION
		do
			create evl.make (expr)
			if is_auto then
				if debugger_manager.safe_application_is_stopped then
					if not evl.evaluated then
						evl.side_effect_forbidden := not preferences.debug_tool_data.always_evaluate_potential_side_effect_expression
						evl.evaluate
					else
						--| Should not occurred since `evl' has just been created
					end
				end
				if not show_only_auto_expression_successfully_evaluated or else not evl.error_occurred then
					expr_item := new_watched_item_from_expression_evaluation (evl, watches_grid)
					expr_item.set_auto_expression (True)
				end
			else
					-- Always evaluate in Watch tool to keep consistent behavior.
				evl.side_effect_forbidden := False
				expr_item := new_watched_item_from_expression_evaluation (evl, watches_grid)
			end

			if expr_item /= Void then
				check evaluation_attached: evl /= Void end
				if not evl.evaluated and debugger_manager.safe_application_is_stopped then
					expr_item.request_evaluation (True)
				end

				watched_items.extend (expr_item)
				if attached expr_item.row as l_row then
					if
						not expr_item.compute_grid_display_done
						and then (evl.disabled or not evl.evaluated)
					then
						expr_item.compute_grid_display
					end
					watches_grid.remove_selection
					if not l_row.is_destroyed and then l_row.is_displayed then
						l_row.ensure_visible
					end
					l_row.enable_select
				end
			end
		end

feature {NONE} -- Element change: expression moving

	move_processing: BOOLEAN
			-- Are we moving expressions up/down?

	integer_sorter: DS_QUICK_SORTER [INTEGER]
		once
			create Result.make (create {KL_COMPARABLE_COMPARATOR [INTEGER]}.make)
		end

	indexes_from_list_of_rows (a_rows: LIST [EV_GRID_ROW]): DS_ARRAYED_LIST [INTEGER]
			-- Array build from
		do
			from
				create Result.make (a_rows.count)
				a_rows.start
			until
				a_rows.after
			loop
				if attached a_rows.item as r and then r.parent_row = Void then
					Result.put_last (r.index)
				end
				a_rows.forth
			end
			Result.sort (integer_sorter)
		ensure
			Result_attached: Result /= Void
		end

	move_selected (offset: INTEGER)
			-- Move selected top rows by `offset'
		local
			sel_rows: LIST [EV_GRID_ROW]
			g: ES_OBJECTS_GRID
			sel_indexes: like indexes_from_list_of_rows
			i: INTEGER
		do
			if not move_processing then
				g := watches_grid
				sel_rows := grid_selected_top_rows (g)
				if not sel_rows.is_empty then
					sel_indexes := indexes_from_list_of_rows (sel_rows)
					move_processing := True --| To avoid concurrent move					
					if offset < 0 then
						from
							sel_indexes.start
						until
							sel_indexes.after
						loop
							i := internal_moved_selected_row (g, sel_indexes.item_for_iteration, offset)
							sel_indexes.forth
						end
					else
						from
							sel_indexes.finish
						until
							sel_indexes.before
						loop
							i := internal_moved_selected_row (g, sel_indexes.item_for_iteration, offset)
							sel_indexes.back
						end
					end
					move_processing := False
				end
				ensure_last_row_is_new_expression_row
			end
		end

	internal_moved_selected_row (g: ES_OBJECTS_GRID; a_index: INTEGER; offset: INTEGER): INTEGER
		require
			move_processing: move_processing
		local
			sel: EV_GRID_ROW
			sel_index: INTEGER
			new_index, to_index: INTEGER
			witems: like watched_items
		do
			sel_index := a_index
			sel := g.row (a_index)
			check sel_is_top_row: sel.parent_row = Void end
			if attached {ES_OBJECTS_GRID_EXPRESSION_LINE} sel.data as line then
				witems := watched_items
				if witems /= Void then
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
			end
			to_index := g.grid_move_top_row_node_by (g, sel_index, offset)
			check to_index > 0 end
			Result := to_index
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

	update_agent: PROCEDURE
			-- Agent that is put in the idle_actions to update the call stack after a while.

	object_viewer_cmd: EB_OBJECT_VIEWER_COMMAND
		do
			Result := debugger_manager.object_viewer_cmd
		end

feature {EB_DEBUGGER_MANAGER} -- Grid

	watches_grid: ES_OBJECTS_GRID
			-- Graphical representation of the list of expressions to evaluate.

	watched_items: ARRAYED_LIST [like watched_item_from]
			-- List of items that are displayed
			-- ie: mostly ES_OBJECTS_GRID_EXPRESSION_LINE

	remove_auto_expressions_from_watched_items
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

	clean_watched_grid
		do
			if not watches_grid_empty then
				watches_grid.remove_and_clear_all_rows
				watches_grid_empty := True
			end
		end

	record_grid_layout
		do
			if process_record_layout_on_next_recording_request then
				watches_grid.record_layout
				process_record_layout_on_next_recording_request := False
			end
		end

	clear_watch_tool
			-- Clear watch tool expression.
		do
			watched_items.wipe_out
			clean_watched_grid
			ensure_last_row_is_new_expression_row
		end

feature -- Expressions storage management

	default_watches_storage_folder: PATH
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := internal_default_watches_storage_folder
				if Result = Void then
					if attached system.eiffel_project.project_location.location as d then
						Result := d
					end
					internal_default_watches_storage_folder := Result
				end
			end
		rescue
			retried := True
			retry
		end

	internal_default_watches_storage_folder: like default_watches_storage_folder
			-- Cached value of `default_watches_storage_folder'

	default_watches_storage_filename: detachable PATH
		local
			retried: BOOLEAN
		do
			if not retried then
				if attached system.eiffel_project.project_location as ploc then
					Result := ploc.location.extended (ploc.target + "-watch#" + watch_id.out + ".txt")
				end
			end
		rescue
			retried := True
			retry
		end

	expressions_to_text (only_selection: BOOLEAN): STRING_32
			-- Copy expressions to clipboard
		local
			line: like watched_item_from
			exp: DBG_EXPRESSION
		do
			create Result.make_empty
			if attached watched_items as lst then
				from
					lst.start
				until
					lst.after
				loop
					line := lst.item
					if line /= Void then
						if
							not only_selection or else
							(attached line.row as r and then r.is_selected)
						then
							exp := line.expression
							if exp /= Void and then exp.is_reusable then
								Result.append_string (exp.text)
								Result.extend ('%N')
							end
						end
					end
					lst.forth
				end
			end
		ensure
			Result_attached: Result /= Void
		end

	load_expressions_from_text (s: STRING_32)
			-- Load expressions from `s'
		local
			expr_list: LIST [STRING_32]
		do
			if s /= Void and then not s.is_empty then
				expr_list := s.split ('%N')
				from
					expr_list.start
				until
					expr_list.after
				loop
					if attached expr_list.item_for_iteration as e then
						if valid_expression_text (e) then
							add_new_expression_for_context (e)
						end
					end
					expr_list.forth
				end
			end
		end

	copy_expressions_to_clipboard
			-- Copy expressions to clipboard
		do
			ev_application.clipboard.set_text (expressions_to_text (True))
		end

	set_expression_from_clipboard (grid: ES_OBJECTS_GRID)
			-- Sets an expression from text held in clipboard
		local
			text_data: STRING_32
			row: EV_GRID_ROW
			rows: ARRAYED_LIST [EV_GRID_ROW]
		do
			text_data := ev_application.clipboard.text
			if text_data /= Void and then not text_data.is_empty then
				rows := grid_selected_top_rows (grid)
				if not rows.is_empty then
					row := rows.first
					if
						grid.col_name_index <= row.count
					then
						if attached {ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL} row.item (grid.col_name_index) as empty_expression_cell then
							if text_data.occurrences ('%N') > 0 then
								load_expressions_from_text (text_data)
							else
								empty_expression_cell.activate_with_string (text_data)
							end
						end
					end
				end
			end
		end

	export_expressions_to_file
			-- Export all expressions to file
		local
			s: STRING_32
			f_dlg: EV_FILE_SAVE_DIALOG
			fn: PATH
			f: PLAIN_TEXT_FILE
		do
			s := expressions_to_text (False)
			if s /= Void and then not s.is_empty then
				create f_dlg.make_with_title (interface_names.t_select_a_file)
				if attached default_watches_storage_folder as d then
					f_dlg.set_start_path (d)
					if attached default_watches_storage_filename as n then
						f_dlg.set_full_file_path (n)
					end
				end
				f_dlg.show_modal_to_window (parent_window)
				fn := f_dlg.full_file_path
				if fn /= Void and then not fn.is_empty then
					internal_default_watches_storage_folder := f_dlg.full_file_path.parent
					create f.make_with_path (fn)
					if not f.exists or else f.is_writable then
						f.open_write
						f.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s))
						f.close
					end
				end
			end
		end

	import_expressions_from_file
			-- Import expressions from file
		local
			s: STRING_32
			f_dlg: EV_FILE_OPEN_DIALOG
			fn: PATH
			f: PLAIN_TEXT_FILE
		do
			create f_dlg.make_with_title (interface_names.t_select_a_file)
			if attached default_watches_storage_folder as d then
				f_dlg.set_start_path (d)
				if attached default_watches_storage_filename as n then
					f_dlg.set_full_file_path (n)
				end
			end

			f_dlg.disable_multiple_selection
			f_dlg.show_modal_to_window (parent_window)
			fn := f_dlg.full_file_path
			if fn /= Void and then not fn.is_empty then
				internal_default_watches_storage_folder := f_dlg.full_file_path.parent
				create f.make_with_path (fn)
				if f.exists and then f.is_readable then
					f.open_read
					from
						create s.make (f.count)
					until
						f.end_of_file or f.exhausted
					loop
						f.read_stream (512)
						s.append (f.last_string)
					end
					f.close
					load_expressions_from_text (s)
				end
			end
		end

feature {NONE} -- grid Layout Implementation

	keep_object_reference_fixed (addr: DBG_ADDRESS)
		do
			if debugger_manager.application_is_executing then
				debugger_manager.application_status.keep_object (addr)
			end
		end

	initialize_watches_grid_layout (pv: BOOLEAN_PREFERENCE)
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

feature {NONE} -- Shortcuts

	initialize_shortcuts
			-- Initialize shortcuts
		require
			watches_grid_attached: watches_grid /= Void
		local
			g: like watches_grid
			p: SHORTCUT_PREFERENCE
			ag: PROCEDURE
		do
			g := watches_grid

			--| FIXME: for now, let's use shortcut functionality from ES_GRID/ES_TREE_NAVIGATOR
			--| ... key, ctrl, alt, shift

				--| move up
			ag := agent move_selected (-1)
			p := preferences.debug_tool_data.move_up_watch_expression_shortcut_preference
			if p /= Void then
				create move_row_up_shortcut.make_with_key_combination (p.key, p.is_ctrl, p.is_alt, p.is_shift)
				p.change_actions.extend (agent update_shortcut_with_pref (g, move_row_up_shortcut, ag, ?))
			else
				move_row_up_shortcut := new_shortcut ({EV_KEY_CONSTANTS}.key_up, False, True, True)
			end
			g.register_shortcut (move_row_up_shortcut, agent move_selected (-1))


				--| move down
			ag := agent move_selected (+1)
			p := preferences.debug_tool_data.move_down_watch_expression_shortcut_preference
			if p /= Void then
				create move_row_down_shortcut.make_with_key_combination (p.key, p.is_ctrl, p.is_alt, p.is_shift)
				p.change_actions.extend (agent update_shortcut_with_pref (g, move_row_down_shortcut, ag, ?))
			else
				move_row_down_shortcut := new_shortcut ({EV_KEY_CONSTANTS}.key_down, False, True, True)
			end
			g.register_shortcut (move_row_down_shortcut, agent move_selected (+1))

				--| Other shortcuts (non pref)
			edit_selected_shortcut 		:= preferences.debug_tool_data.new_edit_selected_shortcut
			open_viewer_shortcut 		:= preferences.debug_tool_data.new_open_viewer_shortcut
			goto_home_shortcut 			:= preferences.debug_tool_data.new_goto_home_shortcut
			goto_end_shortcut 			:= preferences.debug_tool_data.new_goto_end_shortcut

			g.register_shortcut (edit_selected_shortcut, agent edit_expression)
			g.register_shortcut (open_viewer_shortcut, agent open_viewer_on_expression)
			g.register_shortcut (goto_home_shortcut, agent key_home_pressed)
			g.register_shortcut (goto_end_shortcut,  agent key_end_pressed)
		end

	new_shortcut (a_key: INTEGER; a_ctrl, a_alt, a_shift: BOOLEAN): ES_KEY_SHORTCUT
			-- Create new shortcut from arguments
		do
			create Result.make_with_key_combination (create {EV_KEY}.make_with_code (a_key), a_ctrl, a_alt, a_shift)
		end

	update_shortcut_with_pref (g: like watches_grid; sh: like new_shortcut; ag: PROCEDURE; ap: SHORTCUT_PREFERENCE)
			-- Update shortcut `sh' on grid `g' with agent `ag' with pref `ap'
		require
			g_attached: g /= Void
			ag_attached: ag /= Void
			sh_shortcut_attached: sh /= Void
			pref_attached: ap /= Void
		do
			if g.is_shortcut_registered (sh) then
				g.deregister_shortcut (sh)
			end
			sh.set_key (ap.key)
			if ap.is_ctrl then
				sh.enable_control_required
			else
				sh.disable_control_required
			end
			if ap.is_alt then
				sh.enable_alt_required
			else
				sh.disable_alt_required
			end
			if ap.is_shift then
				sh.enable_shift_required
			else
				sh.disable_shift_required
			end
			g.register_shortcut (sh, ag)
		end

	move_row_up_shortcut,
	move_row_down_shortcut,
	edit_selected_shortcut,
	open_viewer_shortcut,
	goto_home_shortcut,
	goto_end_shortcut: ES_KEY_SHORTCUT

feature -- Access

	refresh_watched_item (a_item: like watched_item_from)
			-- Refresh expression grid row item
		require
			a_item_not_void: a_item /= Void
			a_item_has_expression: a_item.expression /= Void
			a_item_attached: a_item.row /= Void
		do
			a_item.refresh_expression
		end

	add_dump_value (dv: DUMP_VALUE)
			-- Add value `dv' to the watch tool's grid
		local
			expr: DBG_EXPRESSION
		do
			if dv.dynamic_class = Void then
				create expr.make_with_context ("Void")
			else
				create expr.make_as_object (dv.dynamic_class, dv.address)
			end
			add_expression (expr, False)
		end

	add_debug_value (dv: ABSTRACT_DEBUG_VALUE)
			-- Add value `dv' to the watch tool's grid
		local
			expr: DBG_EXPRESSION
		do
			if dv.dynamic_class = Void then
				create expr.make_with_context ("Void")
			else
				create expr.make_as_object (dv.dynamic_class, dv.address)
			end
			add_expression (expr, False)
		end

	refresh
			-- Refresh current grid
			--| Could be optimized to refresh only grid's content display ..
		do
			record_grid_layout
			update
		end

feature {NONE} -- Update

	on_update_when_application_is_executing (dbg_stopped: BOOLEAN)
			-- Update when debugging
		do
		end

	on_update_when_application_is_not_executing
			-- Update when not debugging
		do
			watches_grid.reset_layout_recorded_values
		end

	real_update (dbg_was_stopped: BOOLEAN)
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running
		local
			eval: BOOLEAN
			evl: DBG_EXPRESSION_EVALUATION
			l_item: like watched_item_from
			witems: like watched_items
		do
			watches_grid.handle_project_specific_columns
			if attached debugger_manager.application_status as l_status then
				if
					l_status.is_stopped and (dbg_was_stopped or l_status.break_on_assertion_violation_pending)
				then
					eval := True
				end
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
				evl := l_item.expression_evaluation
				if evl.disabled then
					-- Nothing special
				else
					if eval then
						l_item.request_evaluation (True)
					else
						evl.evaluated := False -- | i.e: set unevaluated
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

feature {NONE} -- Auto-completion

	set_up_complete_possibilities_provider (a_item: ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL)
			-- Set up code completion possibilities.
		local
			l_provider: EB_DEBUGGER_EXPRESSION_COMPLETION_POSSIBILITIES_PROVIDER
		do
			create l_provider.make (Void, Void)
			l_provider.set_dynamic_context_functions (
										agent debugger_manager.current_debugging_class_c,
										agent debugger_manager.current_debugging_feature_as)
			a_item.set_completion_possibilities_provider (l_provider)
		end

feature {NONE} -- Implementation

--	standard_grid_label (s: STRING): EV_GRID_LABEL_ITEM
--		do
--			create Result
--			Result.set_text (s)
--		end

	new_watched_item_from_expression_evaluation (evl: DBG_EXPRESSION_EVALUATION; a_grid: ES_OBJECTS_GRID): like watched_item_from
		require
			evaluation_attached: evl /= Void
			grid_attached: a_grid /= Void
		do
			create Result.make_with_expression_evaluation (evl, a_grid)
			add_watched_item_to_grid (Result, a_grid)
		ensure
			Result_evaluation_is_evl: Result.expression_evaluation = evl
		end

	add_watched_item_to_grid (witem: like watched_item_from; a_grid: ES_OBJECTS_GRID)
		require
			witem /= Void
			a_grid /= Void
		do
			witem.safe_unattach
			witem.attach_to_row (a_grid.extended_new_row)
			ensure_last_row_is_new_expression_row
		end

	show_text_in_popup (txt: STRING; x, y, button: INTEGER; gi: EV_GRID_ITEM)
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_info_prompt (txt, debugger_manager.debugging_window.window, Void)
		end

	watched_item_from (row: EV_GRID_ROW): ES_OBJECTS_GRID_EXPRESSION_LINE
		require
			row_not_void: row /= Void
		do
			if attached {ES_OBJECTS_GRID_EXPRESSION_LINE} row.data as r then
				Result := r
			else
				if attached {ES_GRID_ROW_CONTROLLER} row.data as ctlr then
					if attached {ES_OBJECTS_GRID_EXPRESSION_LINE} row.data as r then
						Result := r
					end
				end
			end
		end

	is_auto_expression_watched_item (row: EV_GRID_ROW): BOOLEAN
		require
			row_not_void: row /= Void
		local
			w: like watched_item_from
		do
			w := watched_item_from (row)
			Result := w /= Void and then w.is_auto_expression
		end

	watched_item_for_expression (expr: DBG_EXPRESSION): like watched_item_from
			-- watched item related to `expr'
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

	refresh_expression (expr: DBG_EXPRESSION)
			-- Refresh watched item related to `expr'
		require
			valid_expr: expr /= Void
		local
			l_item: like watched_item_from
		do
			l_item := watched_item_for_expression (expr)
			check l_item /= Void end
			refresh_watched_item (l_item)
		end

	refresh_context_expressions
			-- Refresh the value and display of context-related expressions.
		require
			application_stopped: debugger_manager.safe_application_is_stopped
		local
			r: INTEGER
			row: EV_GRID_ROW
			expr: DBG_EXPRESSION
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
							expr := l_item.expression
							if expr.context.on_context then
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

	Unevaluated: STRING = ""
			-- String that is displayed in the "expression" column when an expression was not evaluated.
			--	expressions.count = watches_grid.row_count

invariant
	watched_items_not_void: watched_items /= Void
	not_void_delete_expression_cmd: mini_toolbar /= Void implies delete_expression_cmd /= Void

note
	ca_ignore:
		"CA093", "CA093: manifest array type mismatch"
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

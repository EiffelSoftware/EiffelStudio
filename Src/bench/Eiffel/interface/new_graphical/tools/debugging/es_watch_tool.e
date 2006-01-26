indexing
	description: "Tool that evaluates expressions in the debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_WATCH_TOOL

inherit
	REFACTORING_HELPER

	ES_OBJECTS_GRID_MANAGER

	ES_NOTEBOOK_ATTACHABLE

	EB_TOOL
		redefine
			menu_name,
			pixmap,
			close
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_RECYCLABLE
		export
			{NONE} all
		end

	SHARED_DEBUG
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
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
	make_with_title

feature {NONE} -- Initialization

	make_with_title (a_manager: like manager; a_title: like title) is
		do
			if a_title = Void or else a_title.is_empty then
				set_title (interface_names.t_Watch_tool)
			else
				set_title (a_title)
			end
			make (a_manager)
		end

	build_interface is
			-- Build all the tool's widgets.
		local
			esgrid: ES_OBJECTS_GRID
		do
			create watched_items.make (10)

			create esgrid.make_with_name ("Watches")
			esgrid.enable_multiple_row_selection
			esgrid.set_column_count_to (5)
			esgrid.set_columns_layout ( 5, 1,
					<<
						[1, 150, "Expression"],
						[2, 80, "Address"],
						[3, 150, "Value"],
						[4, 100, "Type"],
						[5, 200, "Context"]
					>>
				)

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

			watches_grid := esgrid
			initialize_watches_grid_layout (preferences.debug_tool_data.is_watches_grids_layout_managed_preference)

			create_update_on_idle_agent
		end

	build_mini_toolbar is
			-- Build associated tool bar
		local
			tbb: EV_TOOL_BAR_BUTTON
			scmd: EB_STANDARD_CMD
		do
			create mini_toolbar

			create scmd.make
			scmd.set_mini_pixmap (pixmaps.small_pixmaps.icon_open_menu)
			scmd.set_tooltip ("Open Watch tool menu")
			scmd.add_agent (agent open_watch_menu (mini_toolbar, 0, 0))
			scmd.enable_sensitive
			mini_toolbar.extend (scmd.new_mini_toolbar_item)

			create create_expression_cmd.make
			create_expression_cmd.set_mini_pixmap (pixmaps.small_pixmaps.icon_new_expression)
			create_expression_cmd.set_tooltip (interface_names.e_new_expression)
			create_expression_cmd.add_agent (agent define_new_expression)
			create_expression_cmd.enable_sensitive
			mini_toolbar.extend (create_expression_cmd.new_mini_toolbar_item)

			create edit_expression_cmd.make
			edit_expression_cmd.set_mini_pixmap (pixmaps.small_pixmaps.icon_edit_expression)
			edit_expression_cmd.set_tooltip (interface_names.e_edit_expression)
			edit_expression_cmd.add_agent (agent edit_expression)
			tbb := edit_expression_cmd.new_mini_toolbar_item
			mini_toolbar.extend (tbb)

			create toggle_state_of_expression_cmd.make
			toggle_state_of_expression_cmd.set_mini_pixmap (pixmaps.small_pixmaps.icon_on_off)
			toggle_state_of_expression_cmd.set_tooltip (interface_names.e_toggle_state_of_expressions)
			toggle_state_of_expression_cmd.add_agent (agent toggle_state_of_selected)
			tbb := toggle_state_of_expression_cmd.new_mini_toolbar_item
			mini_toolbar.extend (tbb)

			create slices_cmd.make (Current)
			slices_cmd.enable_sensitive
			mini_toolbar.extend (slices_cmd.new_mini_toolbar_item)

			create hex_format_cmd.make (agent set_hexadecimal_mode (?))
			hex_format_cmd.enable_sensitive
			mini_toolbar.extend (hex_format_cmd.new_mini_toolbar_item)

			create pretty_print_cmd.make
			pretty_print_cmd.enable_sensitive
			mini_toolbar.extend (pretty_print_cmd.new_mini_toolbar_item)

			create delete_expression_cmd.make
			delete_expression_cmd.set_mini_pixmap (pixmaps.small_pixmaps.icon_delete)
			delete_expression_cmd.set_tooltip (interface_names.e_remove_expressions)
			delete_expression_cmd.add_agent (agent remove_selected)
			tbb := delete_expression_cmd.new_mini_toolbar_item
			tbb.drop_actions.extend (agent remove_object_line)
			tbb.drop_actions.set_veto_pebble_function (agent is_removable )
			mini_toolbar.extend (tbb)

			create move_up_cmd.make
			move_up_cmd.set_mini_pixmap (pixmaps.small_pixmaps.icon_mini_up)
			move_up_cmd.set_tooltip ("Move item up")
			move_up_cmd.add_agent (agent move_selected (watches_grid, -1))
			tbb := move_up_cmd.new_mini_toolbar_item
			mini_toolbar.extend (tbb)

			create move_down_cmd.make
			move_down_cmd.set_mini_pixmap (pixmaps.small_pixmaps.icon_mini_down)
			move_down_cmd.set_tooltip ("Move item down")
			move_down_cmd.add_agent (agent move_selected (watches_grid, +1))
			tbb := move_down_cmd.new_mini_toolbar_item
			mini_toolbar.extend (tbb)

				--| Attach the slices_cmd to the objects grid
			watches_grid.set_slices_cmd (slices_cmd)
		ensure
			mini_toolbar_exists: mini_toolbar /= Void
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			if mini_toolbar = Void then
				build_mini_toolbar
			end
			create explorer_bar_item.make_with_mini_toolbar (explorer_bar, widget, title, False, mini_toolbar)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

	build_notebook_item (nb: ES_NOTEBOOK) is
		do
			if mini_toolbar = Void then
				build_mini_toolbar
			end
			create notebook_item.make_with_mini_toolbar (nb, widget, title, mini_toolbar)
			notebook_item.drop_actions.extend (agent on_element_drop)
			notebook_item.pointer_button_pressed_actions.extend (agent on_notebook_item_pointer_button_pressed)
			nb.extend (notebook_item)
		end

feature {EB_DEBUGGER_MANAGER} -- Closing

	close is
		do
			Precursor
			if notebook_item /= Void then
				unattach_from_notebook
			end
		end

feature -- Access

	mini_toolbar: EV_TOOL_BAR
			-- Associated mini toolbar.

	widget: EV_WIDGET is
			-- Widget representing Current.
		do
			Result := watches_grid
		end

	title: STRING
			-- Title of the tool.

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := interface_names.m_Watch_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap as it may appear in toolbars and menus.
		do
		end

	can_refresh: BOOLEAN
			-- Should we display data when a stone is set?

feature -- Change

	set_title (a_title: like title) is
		require
			title_valid: a_title /= Void and then not a_title.is_empty
		do
			title := a_title
		ensure
			title_set: title.is_equal (a_title)
		end

feature -- Properties setting

	set_hexadecimal_mode (v: BOOLEAN) is
		do
			watches_grid.set_hexadecimal_mode (v)
		end

feature {ES_OBJECTS_GRID_SLICES_CMD} -- Query

	objects_grid_item (addr: STRING): ES_OBJECTS_GRID_LINE is
		local
			r: INTEGER
			lrow: EV_GRID_ROW
			litem: ES_OBJECTS_GRID_LINE
			ladd: STRING
		do
			from
				r := 1
			until
				r > watches_grid.row_count or Result /= Void
			loop
				lrow := watches_grid.row (r)
				if lrow.parent_row = Void then
					litem ?= grid_data_from_widget (lrow)
					if litem /= Void then
						ladd := litem.object_address
						if ladd /= Void and then ladd.is_equal (addr) then
							Result := litem
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
		do
			if can_refresh then
				cst ?= a_stone
				if cst /= Void and then application.is_stopped then
					if
						not Application.is_dotnet
						or else not Application.imp_dotnet.callback_notification_processing
					then
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

	refresh is
			-- Class has changed in `development_window'.
		do
		end

	prepare_for_debug is
			-- Remove obsolete expressions from `Current'.
		local
			l_expr: EB_EXPRESSION
			witem: like watched_item_from
		do
			clean_watched_grid
			from
				watched_items.start
			until
				watched_items.after
			loop
				witem := watched_items.item

				l_expr := witem.expression
				if not l_expr.is_still_valid then
					watched_items.remove
				else
					l_expr.set_unevaluated
					add_watched_item_to_grid (witem, watches_grid)
					watched_items.forth
				end
			end

			update
		end

	change_manager_and_explorer_bar (a_manager: EB_TOOL_MANAGER; an_explorer_bar: EB_EXPLORER_BAR) is
			-- Change the window and explorer bar `Current' is in.
		require
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			pretty_print_cmd.end_debug
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			recycle_expressions
			watches_grid.reset_layout_manager
			clean_watched_grid
		end

	recycle_expressions is
			-- Recycle
		local
			witem: ES_OBJECTS_GRID_EXPRESSION_LINE
		do
			from
				watched_items.start
			until
				watched_items.after
			loop
				witem := watched_items.item
				witem.recycle
				check witem.expression /= Void	end
				if not witem.expression.is_still_valid then
					watched_items.remove
				else
					watched_items.forth
				end
			end
		end

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
				grid_cell_set_tooltip (glab, "Click here to add a new expression")

				new_expression_row.set_item (1, glab)
				glab.pointer_double_press_actions.force_extend (agent glab.activate)
				glab.apply_actions.extend (agent add_new_expression_for_context)
				set_up_complete_possibilities_provider (glab)
			elseif new_expression_row.index < watches_grid.row_count then
				grid_move_to_end_of_grid (new_expression_row)
			end
			watches_grid_empty := False
		ensure
			new_expression_row.index = watches_grid.row_count
		end

	add_new_expression_for_context (s: STRING) is
		local
			expr: EB_EXPRESSION
		do
			if valid_expression_text (s) then
				create expr.make_for_context (s)
				add_expression (expr)
			end
		end

	valid_expression_text (s: STRING): BOOLEAN is
		do
			Result := s /= Void and then not s.has ('%R') and not s.has ('%N')
		end

feature {NONE} -- Event handling

	open_watch_menu (w: EV_WIDGET; ax, ay: INTEGER) is
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
		do
			if notebook_item /= Void then
				create m
				create mi.make_with_text_and_action ("Create new watch", agent open_new_created_watch_tool)
				m.extend (mi)
				if Eb_debugger_manager.watch_tool_list.count > 1 then
					create mi.make_with_text_and_action ("Close " + title, agent Eb_debugger_manager.close_watch_tool (Current))
					m.extend (mi)
				end

				m.show_at (w, ax, ay)
			end
		end

	open_new_created_watch_tool is
		local
			wt: like Current
		do
			if notebook_item /= Void then
				Eb_debugger_manager.create_new_watch_tool_inside_notebook (manager, notebook_item.parent)
				wt := Eb_debugger_manager.watch_tool_list.last
				if wt /= Void then
					if
						wt.notebook_item /= Void
						and then wt.notebook_item.tab /= Void
					then
						wt.notebook_item.tab.enable_select
					end
				end
				wt.update
			end
		end

	define_new_expression is
			-- Create a new expression.
		local
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
			ce: EB_EDITOR
			l_text: STRING
		do
			ce := Eb_debugger_manager.debugging_window.current_editor
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
			dlg.set_callback (agent add_expression_with_dialog (dlg))
			dlg.show_modal_to_window (Eb_debugger_manager.debugging_window.window)
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
						dlg.set_callback (agent refresh_expression (expr))
						dlg.show_modal_to_window (Eb_debugger_manager.debugging_window.window)
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
							watched_items.start
							watched_items.search (line)
							if not watched_items.exhausted then
								check watched_items.item = line end
								new_index := watched_items.index + offset
								if new_index < 1 then
									new_index := 1
								elseif new_index > watched_items.count then
									new_index := watched_items.count
								end
								watched_items.swap (new_index)
							end
						end
						to_index := grid.grid_move_top_row_node_by (grid, sel_index, offset)
						grid.remove_selection
						sel.enable_select
					end
				end
				move_processing := False
				ensure_last_row_is_new_expression_row
			end
		end

	is_removable (a: ANY): BOOLEAN is
		do
			Result := True
		end

	remove_object_line (a: ANY) is
		do
			remove_selected
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

	remove_expression_row (row: EV_GRID_ROW) is
		local
			l_item: like watched_item_from
		do
			l_item ?= watched_item_from (row)
			watched_items.prune_all (l_item)
			watches_grid.row (row.index).clear
			watches_grid.remove_row (row.index)
		end

	on_element_drop (s: CLASSC_STONE) is
			-- Something was dropped in `ev_list'.
		local
			cst: CLASSC_STONE
			ost: OBJECT_STONE
			fost: FEATURED_OBJECT_STONE
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
			oname: STRING
		do
			fost ?= s
			if fost /= Void then
				oname := fost.feature_name
				if ev_application.ctrl_pressed then
				else
					create dlg.make_with_expression_on_object (fost.object_address, fost.feature_name)
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
			if dlg /= Void then
				dlg.set_callback (agent add_expression_with_dialog (dlg))
				dlg.show_modal_to_window (Eb_debugger_manager.debugging_window.window)
			end
		end

	on_row_selected (row: EV_GRID_ROW) is
			-- An item in the list of expression was selected.
		do
			if row.parent_row = Void then
				delete_expression_cmd.enable_sensitive
				edit_expression_cmd.enable_sensitive
				toggle_state_of_expression_cmd.enable_sensitive
				move_up_cmd.enable_sensitive
				move_down_cmd.enable_sensitive
			else
				delete_expression_cmd.disable_sensitive
				edit_expression_cmd.disable_sensitive
				toggle_state_of_expression_cmd.disable_sensitive
				move_up_cmd.disable_sensitive
				move_down_cmd.disable_sensitive
			end
			if row = new_expression_row then
				delete_expression_cmd.disable_sensitive
				edit_expression_cmd.disable_sensitive
				toggle_state_of_expression_cmd.disable_sensitive
				move_up_cmd.disable_sensitive
				move_down_cmd.disable_sensitive
			end
		end

	on_row_deselected (row: EV_GRID_ROW) is
			-- An item in the list of expression was selected.
		do
			if row /= Void and then row.parent_row = Void then
				delete_expression_cmd.enable_sensitive
				edit_expression_cmd.enable_sensitive
				toggle_state_of_expression_cmd.enable_sensitive
				move_up_cmd.enable_sensitive
				move_down_cmd.enable_sensitive
			else
				delete_expression_cmd.disable_sensitive
				edit_expression_cmd.disable_sensitive
				toggle_state_of_expression_cmd.disable_sensitive
				move_up_cmd.disable_sensitive
				move_down_cmd.disable_sensitive
			end
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
							ost ?= watches_grid.grid_pebble_from_row (watches_grid.selected_rows.first)
							pretty_print_cmd.set_stone (ost)
						end
					end
				when {EV_KEY_CONSTANTS}.key_page_up then
					if
						ev_application.ctrl_pressed
						and not ev_application.alt_pressed
						and not ev_application.shift_pressed
					then
						move_selected (watches_grid, -1)
					end
				when {EV_KEY_CONSTANTS}.key_page_down then
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

	string_key_pressed (s: STRING) is
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
			add_expression (l_expr)
		end

	add_object (ost: OBJECT_STONE; oname: STRING) is
		require
			ost_ot_void: ost /= Void
			oname /= Void
			application_is_running: Application.is_running
		local
			expr: EB_EXPRESSION
		do
			Application.status.keep_object (ost.object_address)
			create expr.make_as_object (ost.dynamic_class , ost.object_address)
			expr.set_name (oname)
			add_expression (expr)
		end

	add_expression (expr: EB_EXPRESSION) is
		local
			expr_item: like watched_item_from
		do
			if expr.evaluation_disabled then
				-- Nothing special
			else
				if application.is_running and application.is_stopped then
					expr.evaluate
				else
					expr.set_unevaluated
				end
			end
			expr_item := new_watched_item_from_expression (expr, watches_grid)
			watched_items.extend (expr_item)

			if expr_item /= Void and then expr_item.row /= Void then
				if
					not expr_item.compute_grid_display_done
					and then (expr /= Void and then (expr.evaluation_disabled or not expr.is_evaluated))
				then
					expr_item.compute_grid_display
				end
				watches_grid.remove_selection
				expr_item.row.ensure_visible
				expr_item.row.enable_select
			end
		end

feature {NONE} -- Event handling on notebook item

	on_notebook_item_pointer_button_pressed (ax, ay, ab: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
		require
			notebook_item /= Void
		do
			if
				ab = 3
				and then not Ev_application.ctrl_pressed
				and then not Ev_application.shift_pressed
				and then not Ev_application.alt_pressed
			then
				open_watch_menu (notebook_item.parent.widget, ax, ay)
			end
		end

feature {NONE} -- Implementation: internal data

	delete_expression_cmd: EB_STANDARD_CMD
			-- Command that deletes one or more rows from the list of expressions.

	create_expression_cmd: EB_STANDARD_CMD
			-- Command that creates a new expression.

	edit_expression_cmd: EB_STANDARD_CMD
			-- Command that creates a new expression.

	toggle_state_of_expression_cmd: EB_STANDARD_CMD
			-- Command that enable/disable a new expression

	move_up_cmd, move_down_cmd: EB_STANDARD_CMD
			-- Move selected item up or down.


	watches_grid: ES_OBJECTS_GRID
			-- Graphical representation of the list of expressions to evaluate.

	update_agent: PROCEDURE [ANY, TUPLE]
			-- Agent that is put in the idle_actions to update the call stack after a while.

	watched_items: ARRAYED_LIST [like watched_item_from]
			-- List of items that are displayed
			-- ie: mostly ES_OBJECTS_GRID_EXPRESSION_LINE

feature -- Grid management

	watches_grid_empty: BOOLEAN

	clean_watched_grid is
		do
			if not watches_grid_empty then
--				if record_layout_on_next_clean then
--					watches_grid.record_layout
--					record_layout_on_next_clean := False
--				end
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

feature {NONE} -- grid Layout Implementation

	keep_object_reference_fixed (addr: STRING) is
		do
			if debugger_manager.application_is_executing then
				application.status.keep_object_for_gui (addr)
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

--			l_grid.layout_manager.set_row_is_ready_for_identification_agent (agent l_grid.row_is_ready_for_grid_objects_identification)
--			l_grid.layout_manager.set_identification_agent (agent l_grid.grid_objects_id_name_from_row)
--			l_grid.layout_manager.set_value_agent (agent l_grid.grid_objects_id_value_from_row)
--			l_grid.layout_manager.set_on_difference_callback (agent l_grid.grid_objects_on_difference_cb)
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
				-- nothing special
			else
				if Application.is_running and Application.is_stopped then
					l_expr.evaluate
				else
					l_expr.set_unevaluated
				end
			end
			a_item.refresh
		end

feature -- Update

	update is
			-- Display current execution status.
		local
			l_status: APPLICATION_STATUS
		do
			cancel_process_real_update_on_idle
			l_status := Application.status
			if l_status /= Void then
				process_real_update_on_idle (l_status.is_stopped)
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
			create l_provider.make (Void, Void, false)
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
		do
			if application.is_running and application.is_stopped and dbg_was_stopped then
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

			from
				watched_items.start
			until
				watched_items.after
			loop
				l_item := watched_items.item
				l_item.request_evaluation (False)
				check l_item.row /= Void end
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
					check
						should_not_occurred: False
					end
					l_item.attach_to_row (watches_grid.extended_new_row)
				end
				l_item.request_refresh
				watched_items.forth
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
			if witem.is_attached_to_row then
				witem.unattach
			end
			witem.attach_to_row (a_grid.extended_new_row)
			ensure_last_row_is_new_expression_row
		end

	show_text_in_popup (txt: STRING; x, y, button: INTEGER; gi: EV_GRID_ITEM) is
			--
			-- (export status {NONE})
		local
			w_dlg: EB_INFORMATION_DIALOG
		do
			create w_dlg.make_with_text (txt)
			w_dlg.show_modal_to_window (Eb_debugger_manager.debugging_window.window)
		end

	watched_item_from (row: EV_GRID_ROW): ES_OBJECTS_GRID_EXPRESSION_LINE is
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

	watched_item_for_expression (expr: EB_EXPRESSION): like watched_item_from is
		require
			valid_expr: expr /= Void
		local
		do
			from
				watched_items.start
			until
				watched_items.after or Result /= Void
			loop
				Result := watched_items.item
				if Result.expression /= expr then
					Result := Void
				end
				watched_items.forth
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
			application_stopped: application.is_running and application.is_stopped
		local
			r: INTEGER
			row: EV_GRID_ROW
			expr: EB_EXPRESSION
			l_item: like watched_item_from
		do
			if watches_grid.row_count > 0 then
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
								if expr.evaluation_disabled then
									expr.set_unevaluated
								else
									expr.evaluate
								end
								refresh_watched_item (l_item)
							end
						end
					end
					r := r + 1
				end
			end
		end

	Unevaluated: STRING is ""
			-- String that is displayed in the "expression" column when an expression was not evaluated.
			--	expressions.count = watches_grid.row_count

invariant

	not_void_delete_expression_cmd: delete_expression_cmd /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

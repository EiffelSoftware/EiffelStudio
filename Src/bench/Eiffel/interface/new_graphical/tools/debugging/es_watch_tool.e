indexing	
	description: "Tool that evaluates expressions in the debugger"
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
			pixmap
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
			real_update
		end

create 
	make

feature {NONE} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		local
			esgrid: ES_OBJECTS_GRID
		do
--			create expressions.make (10)
			create watched_items.make (10)

			create esgrid.make ("Watches", Current)
			esgrid.enable_multiple_row_selection
			esgrid.set_column_count_to (5)
			esgrid.column (col_name_index).set_title (col_titles @ col_name_index)
			esgrid.column (col_name_index).set_width (100)	
			esgrid.column (col_address_index).set_title (col_titles @ col_address_index)
			esgrid.column (col_address_index).set_width (80)
			esgrid.column (col_value_index).set_title (col_titles @ col_value_index)
			esgrid.column (col_value_index).set_width (150)
			esgrid.column (col_type_index).set_title (col_titles @ col_type_index)
			esgrid.column (col_type_index).set_width (100)
			esgrid.column (col_context_index).set_title (col_titles @ col_context_index)
			esgrid.column (col_context_index).set_width (200)

			esgrid.row_select_actions.extend (agent on_item_selected)
			esgrid.row_deselect_actions.extend (agent on_item_deselected)
			esgrid.drop_actions.extend (agent on_element_drop)
			esgrid.key_press_actions.extend (agent key_pressed)

			watches_grid := esgrid

			create_update_on_idle_agent
		end

	build_mini_toolbar is
			-- Build associated tool bar
		local
			tbb: EV_TOOL_BAR_BUTTON
		do
			create mini_toolbar
			create create_expression_cmd.make
			create_expression_cmd.set_mini_pixmaps (pixmaps.icon_new_expression)
			create_expression_cmd.set_tooltip (interface_names.e_new_expression)
			create_expression_cmd.add_agent (agent define_new_expression)
			create_expression_cmd.enable_sensitive
			mini_toolbar.extend (create_expression_cmd.new_mini_toolbar_item)

			create edit_expression_cmd.make
			edit_expression_cmd.set_mini_pixmaps (pixmaps.icon_edit_expression)
			edit_expression_cmd.set_tooltip (interface_names.e_edit_expression)
			edit_expression_cmd.add_agent (agent edit_expression)
			tbb := edit_expression_cmd.new_mini_toolbar_item
			mini_toolbar.extend (tbb)

			create toggle_state_of_expression_cmd.make
			toggle_state_of_expression_cmd.set_mini_pixmaps (pixmaps.icon_toggle_state_very_small)
			toggle_state_of_expression_cmd.set_tooltip (interface_names.e_toggle_state_of_expressions)
			toggle_state_of_expression_cmd.add_agent (agent toggle_state_of_selected)
			tbb := toggle_state_of_expression_cmd.new_mini_toolbar_item
			mini_toolbar.extend (tbb)

			create hex_format_cmd.make (agent set_hexadecimal_mode (?))
			hex_format_cmd.enable_sensitive
			mini_toolbar.extend (hex_format_cmd.new_mini_toolbar_item)
			

			create delete_expression_cmd.make
			delete_expression_cmd.set_mini_pixmaps (pixmaps.icon_delete_very_small)
			delete_expression_cmd.set_tooltip (interface_names.e_remove_expressions)
			delete_expression_cmd.add_agent (agent remove_selected)
			tbb := delete_expression_cmd.new_mini_toolbar_item
			tbb.drop_actions.extend (agent remove_object_line)
			tbb.drop_actions.set_veto_pebble_function (agent is_removable )
			mini_toolbar.extend (tbb)

			create move_up_cmd.make
			move_up_cmd.set_mini_pixmaps (pixmaps.icon_mini_up)
			move_up_cmd.set_tooltip ("Move item up")
			move_up_cmd.add_agent (agent move_selected (watches_grid, -1))
			tbb := move_up_cmd.new_mini_toolbar_item
			mini_toolbar.extend (tbb)			
			
			create move_down_cmd.make
			move_down_cmd.set_mini_pixmaps (pixmaps.icon_mini_down)
			move_down_cmd.set_tooltip ("Move item down")
			move_down_cmd.add_agent (agent move_selected (watches_grid, +1))
			tbb := move_down_cmd.new_mini_toolbar_item
			mini_toolbar.extend (tbb)

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
			nb.extend (notebook_item)
		end
	
feature -- Access

	mini_toolbar: EV_TOOL_BAR
			-- Associated mini toolbar.

	widget: EV_WIDGET is
			-- Widget representing Current.
		do
			Result := watches_grid
		end

	title: STRING is
			-- Title of the tool.
		do
			Result := interface_names.t_Watch_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := interface_names.m_Watch_tool
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
		end

	can_refresh: BOOLEAN
			-- Should we display data when a stone is set?

feature -- Properties setting

	hexadecimal_mode_enabled: BOOLEAN

	set_hexadecimal_mode (v: BOOLEAN) is
		local
			i: INTEGER
		do
			hexadecimal_mode_enabled := v
				--| update : Stack objects grid
			from
				i := 1
			until
				i > watches_grid.row_count
			loop
				propagate_hexadecimal_mode (watches_grid.row (i))
				i := i + 1
			end
		end

	propagate_hexadecimal_mode (t: EV_GRID_ROW) is
		local
			l_eb_t: ES_OBJECTS_GRID_LINE
		do
			l_eb_t ?= t.data
			if l_eb_t /= Void then
				l_eb_t.update_value
			end
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
		do
			from
				watched_items.start
			until
				watched_items.after
			loop
				l_expr := watched_items.item.expression
				if not l_expr.is_still_valid then
					watched_items.remove
				else
					watched_items.forth
				end
			end

--			from
--				expressions.start
--			until
--				expressions.after
--			loop
--				if not expressions.item.is_still_valid then
--					expressions.remove
--				else
--					expressions.forth
--				end
--			end
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
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			recycle_expressions
		end

	recycle_expressions is
			-- Recycle
		do
			from
				watched_items.start
			until
				watched_items.after
			loop
				check watched_items.item.expression /= Void	end
				watched_items.item.expression.recycle
				watched_items.forth
			end
--			if expressions /= Void then
--				from
--					expressions.start
--				until
--					expressions.after
--				loop
--					expressions.item.recycle
--					expressions.forth
--				end
--			end
		end
	
feature {NONE} -- Event handling

	define_new_expression is
			-- Create a new expression.
		local
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
			ce: EB_EDITOR
			l_text: STRING
		do
			ce := debugger_manager.debugging_window.current_editor
			if ce /= Void and then ce.has_selection then
				l_text := ce.string_selection
				if l_text.has ('%N') then
					l_text := Void
				end
			end
			if l_text /= Void and then not l_text.is_empty then
				create dlg.make_with_expression_text (l_text)
			else
				create dlg.make
			end
			dlg.set_callback (agent add_expression_with_dialog (dlg))
			dlg.show_modal_to_window (debugger_manager.debugging_window.window)
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
			rows := watches_grid.selected_rows
			if not rows.is_empty then
				sel := rows.first

				l_item := watched_item_from (sel)
				expr := l_item.expression
				check expr /= Void end
				create dlg.make_with_expression (expr)
				dlg.set_callback (agent refresh_expression (expr))
				dlg.show_modal_to_window (debugger_manager.debugging_window.window)
			end
		end

	toggle_state_of_selected is
			-- Toggle state of the selected expressions from the list.
		local
			rows: LIST [EV_GRID_ROW]
			l_expr: EB_EXPRESSION
			sel_index: INTEGER
--			litem: ES_OBJECTS_GRID_ITEM
			l_item: like watched_item_from
		do
			rows := watches_grid.selected_rows
			if not rows.is_empty then
				sel_index := rows.first.index
			end
			from
				rows.start
			until
				rows.after
			loop
				if rows.item.parent_row = Void then
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
					on_item_deselected (Void)
				end
			end
		end
		
	move_processing: BOOLEAN

	move_selected (grid: ES_OBJECTS_GRID ;offset: INTEGER) is
		local
			sel_rows: LIST [EV_GRID_ROW]
			sel: EV_GRID_ROW
			sel_index: INTEGER
			to_index: INTEGER
		do
			if not move_processing then
				move_processing := True --| To avoid concurrent move
				sel_rows := grid.selected_rows
				if not sel_rows.is_empty then
					sel := sel_rows.first
					if sel.parent_row = Void then
						sel_index := sel.index
						to_index := grid.grid_move_top_row_node_by (grid, sel_index, offset)
						grid.remove_selection
						sel.enable_select
					end
				end
				move_processing := False
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
			l_item: like watched_item_from
		do
			rows := watches_grid.selected_rows
			if not rows.is_empty then
				sel_index := rows.first.index
			end
			from
				rows.start
			until
				rows.after
			loop
				if rows.item.parent_row = Void then
					l_item ?= watched_item_from (rows.item)
					watched_items.prune_all (l_item)
					watches_grid.remove_row (rows.item.index)
				end
				rows.forth
			end
			if not rows.is_empty then
				if watches_grid.row_count >= sel_index then
					watches_grid.row (sel_index).enable_select
				else
					on_item_deselected (Void)
				end
			end
		end

	on_element_drop (s: CLASSC_STONE) is
			-- Something was dropped in `ev_list'.
		local
			cst: CLASSC_STONE
			ost: OBJECT_STONE
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
		do
			ost ?= s
			if ost /= Void then
				if ev_application.ctrl_pressed then
					add_object (ost)
				else
					create dlg.make_with_named_object (ost.object_address, ost.name)
				end
			else
				cst ?= s
				if cst /= Void then
					create dlg.make_with_class (cst.e_class)
				end
			end
			if dlg /= Void then
				dlg.set_callback (agent add_expression_with_dialog (dlg))
				dlg.show_modal_to_window (debugger_manager.debugging_window.window)
			end
		end

	on_item_selected (row: EV_GRID_ROW) is
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
		end

	on_item_deselected (row: EV_GRID_ROW) is
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
						and then not ev_application.alt_pressed
						and then not ev_application.shift_pressed
					then
						update_clipboard_string_with_selection (watches_grid)
					end
				when {EV_KEY_CONSTANTS}.key_page_up then
					if
						ev_application.ctrl_pressed
						and then not ev_application.alt_pressed
						and then not ev_application.shift_pressed
					then
						move_selected (watches_grid, -1)
					end
				when {EV_KEY_CONSTANTS}.key_page_down then
					if
						ev_application.ctrl_pressed
						and then not ev_application.alt_pressed
						and then not ev_application.shift_pressed
					then
						move_selected (watches_grid, +1)
					end
				else
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

	add_object (ost: OBJECT_STONE) is
		require
			ost_ot_void: ost /= Void
		local
			expr: EB_EXPRESSION
		do
			debugger_manager.keep_object (ost.object_address)
			create expr.make_as_object (ost.dynamic_class , ost.object_address)
			expr.set_name (ost.name + ": " + ost.object_address)
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
				expr_item.row.ensure_visible
				expr_item.row.enable_select
			end
		end

feature {NONE} -- Implementation: internal data

	hex_format_cmd: EB_HEX_FORMAT_CMD

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

--	expressions: ARRAYED_LIST [EB_EXPRESSION]
--			-- List of expressions that are to be evaluated.

	watched_items: ARRAYED_LIST [like watched_item_from]
			-- List of items that are displayed
			-- ie: mostly ES_OBJECTS_GRID_EXPRESSION_LINE
	
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
			if watched_items.is_empty and watches_grid.row_count > 0 then
				watches_grid.remove_all_rows
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
--						l_expr.evaluate
					else
						l_expr.set_unevaluated
					end
				end
				if l_item.row /= Void then
					l_item.refresh
				else
					check
						should_not_occurred: False
					end
					l_item.attach_to_row (watches_grid.extended_new_row)
				end
				watched_items.forth
			end
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
			create Result.make_with_expression (expr, Current)
			Result.attach_to_row (a_grid.extended_new_row)
		end

	show_text_in_popup (txt: STRING; x, y, button: INTEGER; gi: EV_GRID_ITEM) is
			--
			-- (export status {NONE})
		local
			w_dlg: EB_INFORMATION_DIALOG
		do
			create w_dlg.make_with_text (txt)
			w_dlg.show_modal_to_window (debugger_manager.debugging_window.window)
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

feature {NONE} -- Grid related Constants

	Col_pixmap_index: INTEGER is 1
	Col_name_index: INTEGER is 1
	Col_address_index: INTEGER is 2
	Col_value_index: INTEGER is 3
	Col_type_index: INTEGER is 4
	Col_context_index: INTEGER is 5

	Col_titles: ARRAY [STRING] is
		do
			create Result.make (1, 5)
			Result.put ("Name", Col_name_index)
			Result.put ("Address", Col_address_index)
			Result.put ("Value", Col_value_index)
			Result.put ("Type", Col_type_index)
			Result.put ("Context ...", Col_context_index)
		end	

invariant

	not_void_delete_expression_cmd: delete_expression_cmd /= Void

end -- class ES_WATCH_TOOL

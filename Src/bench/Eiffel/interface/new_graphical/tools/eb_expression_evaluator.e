indexing
	description: "Tool that evaluates expressions in the debugger"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPRESSION_EVALUATOR

inherit
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

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		do
			create expressions.make (10)
			
			create ev_list
			ev_list.set_column_titles (<<Interface_names.l_Context,
										Interface_names.l_Expression,
										Interface_names.l_Value>>)
			ev_list.set_column_widths (<<70, 120, 100>>)
			ev_list.drop_actions.extend (~on_element_drop)
			ev_list.key_press_actions.extend (~key_pressed)
			ev_list.select_actions.extend (~on_item_selected)
			ev_list.deselect_actions.extend (~on_item_deselected)
			update_agent := ~real_update
		end

	build_explorer_bar is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		local
			tb: EV_TOOL_BAR
			tbb: EV_TOOL_BAR_BUTTON
		do
			create tb
			
				--| Delete command
			create delete_expression_cmd.make
			delete_expression_cmd.set_mini_pixmaps (Pixmaps.Icon_delete_very_small)
			delete_expression_cmd.set_tooltip (Interface_names.e_Remove_expressions)
			delete_expression_cmd.add_agent (~remove_selected)
			tbb := delete_expression_cmd.new_mini_toolbar_item
--			tbb.drop_actions.extend (~delete_dropped)
			tb.extend (tbb)
			
				--| Create command
			create create_expression_cmd.make
			create_expression_cmd.set_mini_pixmaps (Pixmaps.Icon_new_expression)
			create_expression_cmd.set_tooltip (Interface_names.e_New_expression)
			create_expression_cmd.add_agent (~define_new_expression)
			create_expression_cmd.enable_sensitive
			tb.extend (create_expression_cmd.new_mini_toolbar_item)
			
				--| Edit command
			create edit_expression_cmd.make
			edit_expression_cmd.set_mini_pixmaps (Pixmaps.Icon_edit_expression)
			edit_expression_cmd.set_tooltip (Interface_names.e_Edit_expression)
			edit_expression_cmd.add_agent (~edit_expression)
			tbb := edit_expression_cmd.new_mini_toolbar_item
--			tbb.drop_actions.extend (~edit_dropped)
			tb.extend (tbb)

			create explorer_bar_item.make_with_mini_toolbar (explorer_bar, widget, title, False, tb)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
			explorer_bar.repack_widgets
		end

feature -- Access

	widget: EV_WIDGET is
			-- Widget representing Current.
		do
			Result := ev_list
		end

	title: STRING is 
			-- Title of the tool.
		do
			Result := Interface_names.t_Expression_evaluation
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Expression_evaluation
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
--| To be done.
--			Result := Pixmaps.Icon_expression_evaluator
		end

feature -- Status setting

	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		local
			cst: CALL_STACK_STONE
		do
			cst ?= a_stone
			if cst /= Void then
				refresh_context_expressions
			end
		end

	refresh is
			-- Class has changed in `development_window'.
		do
		end

	prepare_for_debug is
			-- Remove obsolete expressions from `Current'.
		do
			from
				expressions.start
			until
				expressions.after
			loop
				if not expressions.item.is_still_valid then
					expressions.remove
				else
					expressions.forth
				end
			end
			real_update
		end

	update is
			-- Refresh `Current's display.
		do
			ev_application.idle_actions.prune_all (update_agent)
			ev_application.idle_actions.extend (update_agent)
		end

	change_manager (a_manager: EB_TOOL_MANAGER; an_explorer_bar: like explorer_bar) is
			-- Change the window and explorer bar `Current' is in.
		require
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
				-- Link with the manager and the explorer.
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			explorer_bar_item.recycle
		end

feature {NONE} -- Event handling

	define_new_expression is
			-- Create a new expression.
		local
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
		do
			create dlg.make
			dlg.set_callback (~add_expression (dlg))
			dlg.show_modal_to_window (Debugger_manager.debugging_window.window)
		end

	edit_expression is
			-- Edit a selected expression.
		local
			sel: EV_MULTI_COLUMN_LIST_ROW
			expr: EB_EXPRESSION
			dlg: EB_EXPRESSION_DEFINITION_DIALOG
		do
			sel := ev_list.selected_item
			if sel /= Void then
				expr ?= sel.data
				create dlg.make_with_expression (expr)
				dlg.set_callback (~refresh_expression (expr))
				dlg.show_modal_to_window (Debugger_manager.debugging_window.window)
			end
		end

	remove_selected is
			-- Remove the selected expressions from the list.
		local
			sel: LIST [EV_MULTI_COLUMN_LIST_ROW]
			cv_expr: EB_EXPRESSION
		do
			sel := ev_list.selected_items
			from
				sel.start
			until
				sel.after
			loop
				cv_expr ?= sel.item.data
				expressions.prune_all (cv_expr)
				ev_list.prune_all (sel.item)
				sel.forth
			end
			if not sel.is_empty then
				on_item_deselected (Void)
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
				create dlg.make_with_object (ost.object_address)
				dlg.set_callback (~add_expression (dlg))
				dlg.show_modal_to_window (Debugger_manager.debugging_window.window)
			else
				cst ?= s
				if cst /= Void then
					create dlg.make_with_class (cst.e_class)
					dlg.set_callback (~add_expression (dlg))
					dlg.show_modal_to_window (Debugger_manager.debugging_window.window)
				end
			end
		end

	on_item_selected (unused: EV_MULTI_COLUMN_LIST_ROW) is
			-- An item in the list of expression was selected.
		do
			if ev_list.selected_item /= Void then
				delete_expression_cmd.enable_sensitive
				edit_expression_cmd.enable_sensitive
			else
				delete_expression_cmd.disable_sensitive
				edit_expression_cmd.disable_sensitive
			end
		end

	on_item_deselected (unused: EV_MULTI_COLUMN_LIST_ROW) is
			-- An item in the list of expression was selected.
		do
			if ev_list.selected_item /= Void then
				delete_expression_cmd.enable_sensitive
				edit_expression_cmd.enable_sensitive
			else
				delete_expression_cmd.disable_sensitive
				edit_expression_cmd.disable_sensitive
			end
		end

	key_pressed (k: EV_KEY) is
			-- A key was pressed in `ev_list'.
		do
			if k /= Void then
				inspect k.code
				when feature {EV_KEY_CONSTANTS}.Key_delete then
					remove_selected
				when feature {EV_KEY_CONSTANTS}.Key_f2 then
					edit_expression
				else
					
				end
			end
		end

	add_expression (dlg: EB_EXPRESSION_DEFINITION_DIALOG) is
			-- Add a new expression defined by `dlg'.
		do
			expressions.extend (dlg.new_expression)
			if Application.is_running and Application.is_stopped then
				dlg.new_expression.evaluate
				ev_list.extend (expression_to_row (dlg.new_expression))
			else
				ev_list.extend (unevaluated_expression_to_row (dlg.new_expression))
			end
		end

feature {NONE} -- Implementation: internal data

	delete_expression_cmd: EB_STANDARD_CMD
			-- Command that deletes one or more rows from the list of expressions.

	create_expression_cmd: EB_STANDARD_CMD
			-- Command that creates a new expression.

	edit_expression_cmd: EB_STANDARD_CMD
			-- Command that creates a new expression.

	ev_list: EV_MULTI_COLUMN_LIST
			-- Graphical representation of the list of expressions to evaluate.

	update_agent: PROCEDURE [ANY, TUPLE []]
			-- Agent that is put in the idle_actions to update the call stack after a while.

	expressions: ARRAYED_LIST [EB_EXPRESSION]
			-- List of expressions that are to be evaluated.

feature {NONE} -- Implementation

	real_update is
			-- Display current execution status.
		local
			lst: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			eval: BOOLEAN
		do
			ev_application.idle_actions.prune_all (update_agent)
			if Application.is_running and Application.is_stopped then
				eval := True
			end
			ev_list.wipe_out
			create lst.make (expressions.count)
			from
				expressions.start
			until
				expressions.after
			loop
				if eval then
					expressions.item.evaluate
					lst.extend (expression_to_row (expressions.item))
				else
					lst.extend (unevaluated_expression_to_row (expressions.item))
				end
				expressions.forth
			end
			ev_list.append (lst)
		end

	expression_to_row (expr: EB_EXPRESSION): EV_MULTI_COLUMN_LIST_ROW is
			-- Create a multi-column list row that represents expression `expr'.
		require
			valid_expression: expr /= Void
		local
			dmp: DUMP_VALUE
			ost: OBJECT_STONE
			res: STRING
		do
			create Result
			Result.extend (expr.context)
			Result.extend (expr.expression)
			if expr.error_message = Void then
				dmp := expr.final_result_value
				res := dmp.full_output
				Result.extend (res)
				if dmp.address /= Void then
					create ost.make (dmp.address, " ", dmp.dynamic_type)
					Result.set_pebble (ost)
					Result.set_accept_cursor (ost.stone_cursor)
					Result.set_deny_cursor (ost.X_stone_cursor)
				end
			else
				Result.extend (expr.error_message)
			end
			Result.set_data (expr)
		end

	unevaluated_expression_to_row (expr: EB_EXPRESSION): EV_MULTI_COLUMN_LIST_ROW is
			-- Create a multi-column list row that represents expression `expr'.
			-- `expr' is assumed not to have been evaluated.
		do
			create Result
			Result.extend (expr.context)
			Result.extend (expr.expression)
			Result.extend (Unevaluated)
			Result.set_data (expr)
		end

	refresh_expression (expr: EB_EXPRESSION) is
			-- Refresh the display of `expr'.
		require
			valid_expr: expr /= Void
		local
			pos: INTEGER
		do
			from
				ev_list.start
			until
				ev_list.after or pos > 0
			loop
				if ev_list.item.data = expr then
					pos := ev_list.index
				end
				ev_list.forth
			end
			ev_list.go_i_th (pos)
			if Application.is_running and Application.is_stopped then
				expr.evaluate
				ev_list.replace (expression_to_row (expr))
			else
				ev_list.replace (unevaluated_expression_to_row (expr))
			end
		end

	refresh_context_expressions is
			-- Refresh the value and display of context-related expressions.
		require
			Application_stopped: Application.is_running and Application.is_stopped
		local
			row: EV_MULTI_COLUMN_LIST_ROW
			expr: EB_EXPRESSION
		do
			from
				ev_list.start
			until
				ev_list.after
			loop
				row := ev_list.item
				expr ?= row.data
				if expr.on_context then
					expr.evaluate
					ev_list.replace (expression_to_row (expr))
				end
				ev_list.forth
			end
		end

	Unevaluated: STRING is ""
			-- String that is displayed in the "expression" column when an expression was not evaluated.

invariant
	not_void_delete_expression_cmd: delete_expression_cmd /= Void
	expressions.count = ev_list.count

end -- class EB_EXPRESSION_EVALUATOR

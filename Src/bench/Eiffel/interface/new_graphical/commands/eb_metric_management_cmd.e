indexing
	description: "Dialog that allows to reorder, delete or import metrics."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_MANAGEMENT_CMD

inherit
	EB_METRIC_COMMAND
		redefine
			make
		end

	SHARED_XML_ROUTINES
	
	EV_KEY_CONSTANTS

create
	make

feature -- Initialization

	make (a_target: like tool) is
			-- Initialize the command with target `a_target'.
			-- Create `import'.
		do
			Precursor (a_target)
			create import.make (Current)
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_select_metrics
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Reorder, delete, import metrics."
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Metric management"
		end

	name: STRING is "management"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature -- Widget

	build_management_dialog is
			-- Build `management_dialog' to reorder, delete, edit or import metrics.
		local
			hb, hb1: EV_HORIZONTAL_BOX
			vb1, vb2: EV_VERTICAL_BOX
			frame: EV_FRAME
			label: EV_LABEL
			ev_any: EV_WIDGET
			exit_button: EV_BUTTON
		do
			create management_dialog
			management_dialog.set_title ("Management")

			create vb1
			vb1.set_padding (5)
			vb1.set_border_width (5)
				create hb
				hb.set_padding (5)
					create frame.make_with_text ("Metrics")
					frame.set_minimum_size (170, 240)
						create vb2
						vb2.set_border_width (5)
						vb2.set_padding (5)
							create label.make_with_text ("Available composite metrics:")
							label.align_text_left
							vb2.extend (label)
							vb2.disable_item_expand (label)

							create ev_list
							ev_list.set_minimum_height (100)
							ev_list.key_press_actions.extend (~key_delete_action)
							ev_list.select_actions.extend (~on_select)
							create hb1
							hb1.extend (ev_list)
							vb2.extend (hb1)

							create label.make_with_text ("Formula:")
							label.align_text_left
							vb2.extend (label)
							vb2.disable_item_expand (label)

							create formula_field
							formula_field.disable_edit
							vb2.extend (formula_field)
							vb2.disable_item_expand (formula_field)

							create label.make_with_text ("Unit:")
							label.align_text_left
							vb2.extend (label)
							vb2.disable_item_expand (label)

							create unit_field
							unit_field.disable_edit
							vb2.extend (unit_field)
							vb2.disable_item_expand (unit_field)

						frame.extend (vb2)

					hb.extend (frame)

					create vb2
					vb2.set_minimum_width (75)
					vb2.set_padding (5)

						create {EV_CELL} ev_any
						vb2.extend (ev_any)

						create hb1
						hb1.set_border_width (5)
						create up_button.make_with_text_and_action ("Up", ~up_action)
						up_button.set_minimum_size (60, 22)
						hb1.extend (up_button)
						hb1.disable_item_expand (up_button)
						vb2.extend (hb1)
						vb2.disable_item_expand (hb1)

						create hb1
						hb1.set_border_width (5)
						create down_button.make_with_text_and_action ("Down", ~down_action)
						down_button.set_minimum_size (60, 22)
						hb1.extend (down_button)
						hb1.disable_item_expand (down_button)
						vb2.extend (hb1)
						vb2.disable_item_expand (hb1)

						create hb1
						hb1.set_border_width (5)
						create delete_button.make_with_text_and_action ("Delete", ~delete_action)
						delete_button.set_minimum_size (60, 22)
						hb1.extend (delete_button)
						hb1.disable_item_expand (delete_button)
						vb2.extend (hb1)
						vb2.disable_item_expand (hb1)

						create hb1
						hb1.set_border_width (5)
						create edit_button.make_with_text_and_action ("Edit", ~edit_action)
						edit_button.set_minimum_size (60, 22)
						hb1.extend (edit_button)
						hb1.disable_item_expand (edit_button)
						vb2.extend (hb1)
						vb2.disable_item_expand (hb1)

						create {EV_CELL} ev_any
						vb2.extend (ev_any)

					hb.extend (vb2)
					hb.disable_item_expand (vb2)
				vb1.extend (hb)

			create hb
				create save_button.make_with_text_and_action ("Save", ~save_action)
				save_button.set_minimum_width (60)
				hb.extend (create {EV_CELL})
				hb.extend (save_button)
				hb.disable_item_expand (save_button)

--				create import.make (Current)
				
				create import_button.make_with_text_and_action ("Import...", agent import.import_action)
				import_button.set_minimum_width (60)
				create {EV_CELL} ev_any
				ev_any.set_minimum_width (10)
				hb.extend (ev_any)
				hb.disable_item_expand (ev_any)
				hb.extend (import_button)
				hb.disable_item_expand (import_button)

				create exit_button.make_with_text_and_action ("Exit", ~exit_action)
				exit_button.set_minimum_width (60)
				create {EV_CELL} ev_any
				ev_any.set_minimum_width (10)
				hb.extend (ev_any)
				hb.disable_item_expand (ev_any)
				hb.extend (exit_button)
				hb.disable_item_expand (exit_button)
				hb.extend (create {EV_CELL})

			vb1.extend (hb)
			vb1.disable_item_expand (hb)

			management_dialog.extend (vb1)
			management_dialog.set_default_push_button (exit_button)
			management_dialog.set_default_cancel_button (exit_button)
		end


feature -- Access

	management_dialog: EV_DIALOG
			-- Dialog to reorder, delete, edit or import metrics.
			
	ev_list: EV_LIST
		-- List of available non basic metrics in current system.
		
	deleted_metrics: LINKED_LIST [EV_LIST_ITEM]
		-- List of deleted metrics.

	import: EB_METRIC_MANAGEMENT_IMPORT
		-- Interface for importation.
		
	up_button, down_button: EV_BUTTON
		-- Buttons to change non basic metrics order.
		
	delete_button: EV_BUTTON
		-- Button to delete selected metric.
		
	edit_button: EV_BUTTON
		-- Button to edit selected metric.
		
	save_button: EV_BUTTON
		-- Button to save changes.
		
	import_button: EV_BUTTON
		-- Button to import a setof metric definitions.

	formula_field: EV_TEXT_FIELD
		-- Text_field to display selected metric's formula in `management_dialog'.

	unit_field: EV_TEXT_FIELD
		-- Text field to display selected metric's unit in `management_dialog'.

	delete_confirmation_shown: BOOLEAN
		-- Has `confirm_dialog' been displayed at least once when user decided to remove metric?

	confirm_dialog: EV_CONFIRMATION_DIALOG
		-- Dialog to confirm actions.
		
feature -- Setting

	create_ev_list is
			-- Assign `a_list' to `ev_list'.
		do
			create ev_list
		end
		
	fill_ev_list (a_list: EV_LIST) is
			-- Fill `ev_list' with available non basic metrics of current system.
		require
			existing_metrics: tool.metrics /= Void
			check_non_basic: tool.metrics.count - tool.nb_basic_metrics = tool.user_metrics_xml_list.count
		local
			metric_list: LINKED_LIST [EB_METRIC]
			metric_xml_list: LINKED_LIST [XML_ELEMENT]
			list_item_data: CELL2 [EB_METRIC, XML_ELEMENT]
			list_item: EV_LIST_ITEM
			i: INTEGER
		do
			metric_list := tool.metrics
			metric_xml_list := tool.user_metrics_xml_list
			i := tool.nb_basic_metrics
			from
				metric_list.go_i_th (i + 1)
				metric_xml_list.start
			until
				metric_list.after and
				metric_xml_list.after
			loop
				create list_item.make_with_text (metric_list.item.name)
				create list_item_data.make (metric_list.item, metric_xml_list.item)
				list_item.set_data (list_item_data)
				list_item.set_pebble (list_item)
				list_item.drop_actions.extend (~drop_action_in_list (?, list_item))
				list_item.pointer_double_press_actions.extend (~double_click_edit)
				a_list.extend (list_item)
				metric_list.forth
				metric_xml_list.forth
			end
			ev_list.drop_actions.extend (~move_to_list (?, ev_list))
		end

	metric (str: STRING; list: EV_LIST): EB_METRIC is
			-- Return the metric object whose name is `str'.
		require
			list_not_void: list /= Void
		local
			cursor: CURSOR
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
		do
			cursor := list.cursor
			from
				list.start
			until
				list.after or Result /= Void
			loop
				cell ?= list.item.data
				if equal (cell.item1.name, str) then
					Result := cell.item1
				end
			list.forth
			end
			list.go_to (cursor)
		end

feature -- Drop actions

	drop_action_in_list (new_item, old_item: EV_LIST_ITEM) is
			-- Drop `new_item' to the left of `old_item'.
		require
			effective_new_item: new_item /= Void
			effective_old_item: old_item /= Void
		local
			new_parent, old_parent: EV_LIST
			drop_successful: BOOLEAN
		do
			new_parent ?= new_item.parent
			old_parent ?= old_item.parent
			if new_parent /= Void and old_parent /= Void then
				if not equal (new_parent, old_parent) then
					if equal (new_parent, import.importable_metric_list) and then import.add_button.is_sensitive then
						import.add_metric
					elseif equal (new_parent, import.current_metric_list) and then import.remove_button.is_sensitive then
						import.remove_metric
					end
					drop_successful := new_item.parent = old_parent
					if drop_successful then
						insert_item_at (new_item, old_item)
					end
				else
					insert_item_at (new_item, old_item)
				end
				save_button.enable_sensitive
			end
		ensure
			same_parent: new_item.parent = old_item.parent
		end

	insert_item_at (new_item, old_item: EV_LIST_ITEM) is
			-- Put `new_item' to the left of `old_item'.
		require
			effective_new_item: new_item /= Void
			effective_old_item: old_item /= Void
		do
			if not equal (new_item, old_item) then
				new_item.parent.start
				new_item.parent.prune (new_item)
				old_item.parent.start
				old_item.parent.search (old_item)
				old_item.parent.put_right (new_item)
			end
		ensure
			same_parent: new_item.parent = old_item.parent
		end

	move_to_list (an_item: EV_LIST_ITEM; list: EV_LIST) is
			-- Add `an_item' to `list'.
		require
			effective_item: an_item /= Void
			effective_list: list /= Void
		local
			parent: EV_LIST
		do
			parent ?= an_item.parent
			if not equal (parent, list) then
				if equal (list, import.current_metric_list) and then import.add_button.is_sensitive then
					import.add_metric
				elseif equal (list, import.importable_metric_list) and then import.remove_button.is_sensitive then
					import.remove_metric
				end
			else
				an_item.parent.start
				an_item.parent.prune (an_item)
				list.extend (an_item)
			end
		ensure
			new_parent: an_item.parent = list
		end

feature -- Action

	on_select is
			-- Action to be performed when selecting an `ev_list' item.
		require
			item_selected: ev_list.selected_item /= Void
		local
			a_formula: STRING
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
		do
			if ev_list.first = ev_list.selected_item then
				up_button.disable_sensitive
			else
				up_button.enable_sensitive
			end
			if ev_list.last = ev_list.selected_item then
				down_button.disable_sensitive
			else
				down_button.enable_sensitive
			end
			delete_button.enable_sensitive
			edit_button.enable_sensitive
			cell ?= ev_list.selected_item.data
			a_formula := xml_string (cell.item2, "FORMULA")
			formula_field.set_text (a_formula)
			unit_field.set_text (cell.item1.unit)
		end

	up_action is
			-- Move selected metric to upper position.
		require
			item_selected: ev_list.selected_item /= Void
		local
			selected_item: EV_LIST_ITEM
			i: INTEGER
		do
			selected_item := ev_list.selected_item
			if selected_item /= Void and then ev_list.first /= selected_item then
				i := ev_list.index_of (selected_item, 1)
				ev_list.go_i_th (i)
				ev_list.swap (i - 1)
				ev_list.i_th (i - 1).enable_select
				save_button.enable_sensitive
			end
		end

	down_action is
			-- Move selected metric to lower position.
		require
			item_selected: ev_list.selected_item /= Void
		local
			selected_item: EV_LIST_ITEM
			i: INTEGER
		do
			selected_item := ev_list.selected_item
			if selected_item /= Void and then ev_list.last /= selected_item then
				i := ev_list.index_of (selected_item, 1)
				ev_list.go_i_th (i)
				ev_list.swap (i + 1)
				ev_list.i_th (i + 1).enable_select
				save_button.enable_sensitive
			end
		end

	delete_action is
			-- Delete selected metric.
		require
			item_selected: ev_list.selected_item /= Void
		local
			selected_item: EV_LIST_ITEM
			actions_array: ARRAY [PROCEDURE [ANY, TUPLE []]]
		do
			selected_item := ev_list.selected_item
			if selected_item /= Void then
				create actions_array.make (1, 2)
				actions_array.put (~delete_confirmed, 1)
				actions_array.put (~do_nothing, 2)
				if not delete_confirmation_shown then
					create confirm_dialog.make_with_text_and_actions (
								"Clicking save will remove the selected metric%N%
								%any composite metric that involves it and any%N%
								%recorded measure that involves it.%NContinue?", actions_array)
					confirm_dialog.show_modal_to_window (management_dialog)	
					delete_confirmation_shown := True
				else
					delete_confirmed	
				end
			end
		end
	
	key_delete_action (a_key: EV_KEY) is
			-- Action to be performed on pressing delete.
		do
			if a_key.code = Key_delete then
				delete_action
			end
		end
	
	delete_confirmed is
			-- Remove metric, associated metrics and measures.
		require
			item_selected: ev_list.selected_item /= Void
		local
			selected_item: EV_LIST_ITEM
			i: INTEGER
		do
			selected_item := ev_list.selected_item
			i := ev_list.index_of (selected_item, 1)
			deleted_metrics.extend (ev_list.i_th (i))
			ev_list.go_i_th (i)
			ev_list.remove
			
			remove_metrics
			
			save_button.enable_sensitive
			up_button.disable_sensitive
			down_button.disable_sensitive
			delete_button.disable_sensitive
			edit_button.disable_sensitive
			formula_field.remove_text
			unit_field.remove_text			
		end

	edit_action is
			-- Open `tool.new_metric.new_metric_definition_dialog' with fields filled
			-- according to selected metric properties.
		require
			item_selected: ev_list.selected_item /= Void
		local
			x_pos, y_pos: INTEGER
			selected_item: EV_LIST_ITEM
			type: STRING 
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
		do
			selected_item := ev_list.selected_item
			if selected_item /= Void then
				tool.development_window.window.set_pointer_style (tool.development_window.Wait_cursor)

				cell ?= selected_item.data
				x_pos := tool.development_window.window.x_position + 200
				y_pos := tool.development_window.window.y_position + 40
				if tool.new_metric.new_metric_definition_dialog = Void then
					tool.new_metric.build_new_metric_definition_dialog
				end
				tool.new_metric.new_metric_definition_dialog.set_position (x_pos, y_pos)
				tool.new_metric.derived_tab.preset
				tool.new_metric.linear_tab.preset
				tool.new_metric.ratio_metric_tab.preset
				tool.new_metric.ratio_scope_tab.preset
				tool.new_metric.set_edition (True)

				type := cell.item2.attributes.item ("Type").value
				if equal (type, "Derived") then
					fill_derived (tool.new_metric.derived_tab, cell)
					tool.new_metric.notebook.select_item (tool.new_metric.derived_tab)
				elseif equal (type, "Linear") then
					fill_linear (tool.new_metric.linear_tab, cell)
					tool.new_metric.notebook.select_item (tool.new_metric.linear_tab)
				elseif equal (type, "MRatio") then
					fill_mratio (tool.new_metric.ratio_metric_tab, cell)
					tool.new_metric.notebook.select_item (tool.new_metric.ratio_metric_tab)
				elseif equal (type, "SRatio") then
					fill_sratio (tool.new_metric.ratio_scope_tab, cell)
					tool.new_metric.notebook.select_item (tool.new_metric.ratio_scope_tab)
				end

				tool.development_window.window.set_pointer_style (tool.development_window.Standard_cursor)
				tool.new_metric.new_metric_definition_dialog.show_modal_to_window (management_dialog)
				save_button.enable_sensitive
			end
		end

	save_action is
			-- Save changes order, redefinition, deletion and importation if any.
		require
			check_non_basic: tool.metrics.count - tool.nb_basic_metrics = tool.user_metrics_xml_list.count
		local
			metric_list: LINKED_LIST [EB_METRIC]
			metric_xml_list: LINKED_LIST [XML_ELEMENT]
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
			i: INTEGER
		do
			metric_list := clone (tool.metrics)
			metric_xml_list := clone (tool.user_metrics_xml_list)
			i := tool.nb_basic_metrics + 1
			from metric_list.go_i_th (i) until metric_list.after loop
				metric_list.remove
			end
			metric_xml_list.wipe_out
			tool.file_manager.metric_header.wipe_out
			if management_dialog /= Void and then management_dialog.is_displayed then
					-- Importation is also possible on archive comparison. in that case,
					-- there are no deleted item.
				if deleted_metrics.count > 0 then
					remove_measures
					deleted_metrics.wipe_out
				end
			end
			from ev_list.start until ev_list.after loop
				cell ?= ev_list.item.data
				metric_list.extend (cell.item1)
				metric_xml_list.extend (cell.item2)
				tool.file_manager.metric_header.put_last (cell.item2)
				ev_list.forth
			end
			if not tool.file_manager.metric_file.exists then
				tool.file_manager.destroy_file_name
				tool.set_file_loaded (False)
				tool.file_handler.load_files
			end
			check tool.file_manager.metric_file.exists end
			tool.file_manager.store
			tool.file_manager.metric_file.close
			check metric_list.count = tool.nb_basic_metrics + ev_list.count end
			tool.file_manager.management_metric_notify_all (metric_list, metric_xml_list)
			if management_dialog /= Void and then management_dialog.is_displayed then
					-- Importation is also possible on archive comparison.
					-- In that case `interface.management_dialog' may not exist.
				save_button.disable_sensitive
			end
		ensure
			check_non_basic: tool.metrics.count - tool.nb_basic_metrics = tool.user_metrics_xml_list.count
		end

	exit_action is
			-- Exit `management_dialog'.
		do
			management_dialog.hide
		end

feature -- Measures and metrics deletion.

	remove_measures is
			-- Remove recorded measures evaluated for removed metrics.
		require
			existing_tool: tool /= Void
			deleted_items: deleted_metrics.count > 0
		local
			current_metric: STRING
			i: INTEGER
		do
			from
				tool.multi_column_list.start
				i := 1
			until
				tool.multi_column_list.after
			loop
				current_metric := tool.multi_column_list.item.i_th (4)
				if metric_is_deleted (current_metric) then
					tool.multi_column_list.i_th (i).enable_select
				end
				i := i + 1
				tool.multi_column_list.forth
			end
			tool.delete.on_delete_click
		end
		
	metric_is_deleted (current_metric: STRING): BOOLEAN is
			-- Has `current_metric' been deleted?
		require
			deleted_items: deleted_metrics.count > 0
		local
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
		do
			from
				deleted_metrics.start
			until
				deleted_metrics.after or Result
			loop
				cell ?= deleted_metrics.item.data
				check cell /= Void end
				Result:= equal (cell.item1.name, current_metric)
				deleted_metrics.forth
			end
		end

	remove_metrics is
				-- Remove composite metrics whose definition involves a deleted metric.
		require
			existing_tool: tool /= Void
			deleted_items: deleted_metrics.count > 0
		local
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
		do
			from
				ev_list.start
			until
				ev_list.after
			loop
				cell ?= ev_list.item.data
				if has_deleted_metric (element_by_name (cell.item2, "DEFINITION")) then
					deleted_metrics.extend (ev_list.item)
					ev_list.remove
				else
					ev_list.forth
				end
			end
		end
		
	has_deleted_metric (xml_def: XML_ELEMENT): BOOLEAN is
			-- Has `xml_element' been defined with a removed metric?
		require
			existing_tool: tool /= Void
			valid_definition: xml_def /= Void
		local
			i: INTEGER
			metric_el: XML_ELEMENT
		do
			from
				xml_def.start
				i := 1 
			until
				xml_def.after or Result
			loop
				metric_el ?= xml_def.item (i)
				check metric_el /= Void end
				if equal (metric_el.name, "METRIC") then
					Result := metric_is_deleted (tool.file_handler.content_of_node (metric_el))
				end				
				xml_def.forth
				i := i + 1
			end
		end

feature -- Edit

	double_click_edit (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Open `tool.new_metric.new_metric_definition_dialog' with fields filled
			-- according to selected metric properties.
		require
			item_selected: ev_list.selected_item /= Void
		do
			if a_button = 1 then
				edit_action
			end
		end

	refresh (edited_metric: EB_METRIC; edited_xml_element: XML_ELEMENT) is
			-- Update metric_definition of `ev_list.selected_item' after edition.
		require
			item_selected: ev_list.selected_item /= Void
		local
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
			list_item: EV_LIST_ITEM
		do
			create cell.make (edited_metric, edited_xml_element)
			if equal (ev_list.selected_item.text, edited_metric.name) then
				ev_list.selected_item.set_data (cell)
			else
				create list_item.make_with_text (edited_metric.name)
				list_item.set_data (cell)
				list_item.set_pebble (list_item)
				list_item.drop_actions.extend (~drop_action_in_list (?, list_item))
				list_item.pointer_double_press_actions.extend (~double_click_edit)
				ev_list.extend (list_item)
			end
		end

	fill_linear (linear_tab: EB_METRIC_LINEAR_TAB; cell: CELL2 [EB_METRIC, XML_ELEMENT]) is
			-- Fill `tool.new_metric.new_metric_definition_dialog' for linear metric.
		require
			effective_linear_tab: linear_tab /= Void
			effective_cell: cell /= Void and then (cell.item1 /= Void and cell.item2 /= Void)
		local
			selected_metric: EB_METRIC_COMPOSITE
			definition, element: XML_ELEMENT
			i: INTEGER
		do
			selected_metric ?= cell.item1
			linear_tab.name_field.set_text (selected_metric.name)
			linear_tab.unit_field.set_text (selected_metric.unit)
			definition := element_by_name (cell.item2, "DEFINITION")
			element ?= definition.item (1)
			linear_tab.formula.extend (tool.file_handler.content_of_node (element))
			element ?= definition.item (3)
			linear_tab.formula.extend (tool.file_handler.content_of_node (element))
			element ?= definition.item (2)
			linear_tab.formula.extend (tool.file_handler.content_of_node (element))
			from
				i := 4
			until
				i > definition.count
			loop
				element ?= definition.item (i + 3)
				linear_tab.formula.extend (tool.file_handler.content_of_node (element))
				element ?= definition.item (i)
				linear_tab.formula.extend (tool.file_handler.content_of_node (element))
				element ?= definition.item (i + 2)
				linear_tab.formula.extend (tool.file_handler.content_of_node (element))
				element ?= definition.item (i + 1)
				linear_tab.formula.extend (tool.file_handler.content_of_node (element))
				i := i + 4
			end
			linear_tab.set_displayed_metric (xml_string (cell.item2, "FORMULA"))
			linear_tab.text_field.set_text (xml_string (cell.item2, "FORMULA"))
			linear_tab.keep_same_unit_metrics (selected_metric)
			linear_tab.disable_save
		end

	divide: STRING is " / "

	fill_mratio (mratio_tab: EB_METRIC_RATIO_TAB; cell: CELL2 [EB_METRIC, XML_ELEMENT]) is
			-- Fill `tool.new_metric.new_metric_definition_dialog' for ratio of two metrics over one scope.
		require
			effective_mratio_tab: mratio_tab /= Void
			effective_cell: cell /= Void and then (cell.item1 /= Void and cell.item2 /= Void)
		local
			selected_metric: EB_METRIC_COMPOSITE
			definition, num_element, den_element: XML_ELEMENT
			num, den: STRING
		do
			selected_metric ?= cell.item1
			mratio_tab.name_field.set_text (selected_metric.name)
			mratio_tab.unit_field.set_text (selected_metric.unit)
			definition := element_by_name (cell.item2, "DEFINITION")
			num_element ?= definition.item (1)
			den_element ?= definition.item (2)
			num := tool.file_handler.content_of_node (num_element)
			den := tool.file_handler.content_of_node (den_element)
			mratio_tab.formula.put_i_th (num, 1)
			mratio_tab.formula.put_i_th (divide, 2)
			mratio_tab.formula.put_i_th (den, 3)
			mratio_tab.put_item_with_text (mratio_tab.first_metric_combobox, num)
			mratio_tab.put_item_with_text (mratio_tab.second_metric_combobox, den)
			mratio_tab.set_displayed_metric (xml_string (cell.item2, "FORMULA"))
			mratio_tab.text_field.set_text (xml_string (cell.item2, "FORMULA"))
			if selected_metric.percentage then
				mratio_tab.percentage_button.enable_select
			else
				mratio_tab.percentage_button.disable_select
			end
			mratio_tab.disable_save
		end

	fill_sratio (sratio_tab: EB_METRIC_RATIO_SCOPE_TAB; cell: CELL2 [EB_METRIC, XML_ELEMENT]) is
			-- Fill `tool.new_metric.new_metric_definition_dialog' for ratio of one metric over two scopes.
		require
			effective_sratio_tab: sratio_tab /= Void
			effective_cell: cell /= Void and then (cell.item1 /= Void and cell.item2 /= Void)
		local
			selected_metric: EB_METRIC_COMPOSITE
			definition, metric_el, num_el, den_el: XML_ELEMENT
			a_metric, num, den: STRING
		do
			selected_metric ?= cell.item1
			sratio_tab.name_field.set_text (selected_metric.name)
			sratio_tab.unit_field.set_text (selected_metric.unit)
			definition := element_by_name (cell.item2, "DEFINITION")
			metric_el ?= definition.item (1)
			num_el ?= definition.item (2)
			den_el ?= definition.item (3)
			a_metric := tool.file_handler.content_of_node (metric_el)
			num := tool.file_handler.content_of_node (num_el)
			den := tool.file_handler.content_of_node (den_el)
			sratio_tab.formula.put_i_th (a_metric, 1)
			sratio_tab.formula.put_i_th (num, 2)
			sratio_tab.formula.put_i_th (divide, 3)
			sratio_tab.formula.put_i_th (den, 4)
			sratio_tab.put_item_with_text (sratio_tab.metric_combobox, a_metric)
			sratio_tab.select_metric
			sratio_tab.put_item_with_text (sratio_tab.first_scope_combobox, num)
			sratio_tab.put_item_with_text (sratio_tab.second_scope_combobox, den)
			sratio_tab.set_displayed_metric (xml_string (cell.item2, "FORMULA"))
			sratio_tab.text_field.set_text (xml_string (cell.item2, "FORMULA"))
			if selected_metric.percentage then
				sratio_tab.percentage_button.enable_select
			else
				sratio_tab.percentage_button.disable_select
			end
			sratio_tab.disable_save
		end

	fill_derived (derived_tab: EB_METRIC_DERIVED_TAB; cell: CELL2 [EB_METRIC, XML_ELEMENT]) is
			-- Fill `tool.new_metric.new_metric_definition_dialog' for ratio of derived metric.
		require
			effective_derived_tab: derived_tab /= Void
			effective_cell: cell /= Void and then (cell.item1 /= Void and cell.item2 /= Void)
		local
			selected_metric: EB_METRIC_DERIVED
			definition: XML_ELEMENT
			and_op: BOOLEAN
		do
			selected_metric ?= cell.item1
			derived_tab.name_field.set_text (selected_metric.name)
			derived_tab.unit_field.set_text (selected_metric.unit)
			derived_tab.put_item_with_text (derived_tab.raw_metric_combobox, selected_metric.parent_name)
			definition := element_by_name (cell.item2, "DEFINITION")
			and_op := xml_boolean (definition, "And")
			if and_op then
				derived_tab.and_button.enable_select
			end
			if equal (selected_metric.parent_name, interface_names.metric_classes) then
				derived_tab.build_classes_panel
				enable_classes_buttons (derived_tab, definition)
			elseif equal (selected_metric.parent_name, interface_names.metric_dependents) then
				derived_tab.build_dependents_panel
				enable_dependents_buttons (derived_tab, definition)
			elseif equal (selected_metric.parent_name, interface_names.metric_features) then
				derived_tab.build_features_panel
				enable_features_buttons (derived_tab, definition)
			end
			derived_tab.set_agent_array (tool.file_handler.build_agent_array (definition, derived_tab.bf))
			derived_tab.disable_save
		end

	enable_classes_buttons (derived_tab: EB_METRIC_DERIVED_TAB; definition: XML_ELEMENT) is
			-- Select crietria on "classes" panel of `derived_tab'.
		require
			effective_derived_tab: derived_tab /= Void
			effective_definition: definition /= Void
		do
			if element_by_name (definition, "Deferred_class") /= Void then
				if xml_boolean (definition, "Deferred_class") then
					derived_tab.deferred_class.enable_select
				else
					derived_tab.effective_class.enable_select
				end
			else
				derived_tab.ignore_deferred_class.enable_select
			end
			if element_by_name (definition, "Invariant") /= Void then
				if xml_boolean (definition, "Invariant") then
					derived_tab.invariant_equi.enable_select
				else
					derived_tab.not_invariant_equi.enable_select
				end
			else
				derived_tab.ignore_invariant.enable_select
			end
			if element_by_name (definition, "Obsolete") /= Void then
				if xml_boolean (definition, "Obsolete") then
					derived_tab.obsolete_class.enable_select
				else
					derived_tab.not_obsolete_class.enable_select
				end
			else
				derived_tab.ignore_obsolete.enable_select
			end
		end

	enable_dependents_buttons (derived_tab: EB_METRIC_DERIVED_TAB; definition: XML_ELEMENT) is
			-- Select crietria on "dependents" panel of `derived_tab'.
		require
			effective_derived_tab: derived_tab /= Void
			effective_definition: definition /= Void
		do
			if element_by_name (definition, "Self") /= Void then
				if xml_boolean (definition, "Self") then
					derived_tab.self.enable_select
				else
					derived_tab.not_self.enable_select
				end
			end
			if element_by_name (definition, "D_or_i_clients") /= Void then
				if xml_boolean (definition, "D_or_i_clients") then
					derived_tab.direct_clients.enable_select
				else
					derived_tab.indirect_clients.enable_select
				end
			else
				derived_tab.ignore_clients.enable_select
			end
			if element_by_name (definition, "D_or_i_suppliers") /= Void then
				if xml_boolean (definition, "D_or_i_suppliers") then
					derived_tab.direct_suppliers.enable_select
				else
					derived_tab.indirect_suppliers.enable_select
				end
			else
				derived_tab.ignore_suppliers.enable_select
			end
			if element_by_name (definition, "D_or_i_heirs") /= Void then
				if xml_boolean (definition, "D_or_i_heirs") then
					derived_tab.direct_heirs.enable_select
				else
					derived_tab.indirect_heirs.enable_select
				end
			else
				derived_tab.ignore_heirs.enable_select
			end
			if element_by_name (definition, "D_or_i_parents") /= Void then
				if xml_boolean (definition, "D_or_i_parents") then
					derived_tab.direct_parents.enable_select
				else
					derived_tab.indirect_parents.enable_select
				end
			else
				derived_tab.ignore_parents.enable_select
			end
		end

	enable_features_buttons (derived_tab: EB_METRIC_DERIVED_TAB; definition: XML_ELEMENT) is
			-- Select crietria on "features" panel of `derived_tab'.
		require
			effective_derived_tab: derived_tab /= Void
			effective_definition: definition /= Void
		do
			if element_by_name (definition, "Attr_or_rout") /= Void then
				if xml_boolean (definition, "Attr_or_rout") then
					derived_tab.attr.enable_select
				else
					derived_tab.rout.enable_select
				end
			else
				derived_tab.ignore_attr_rout.enable_select
			end
			if element_by_name (definition, "Quer_or_comm") /= Void then
				if xml_boolean (definition, "Quer_or_comm") then
					derived_tab.quer.enable_select
				else
					derived_tab.comm.enable_select
				end
			else
				derived_tab.ignore_quer_comm.enable_select
			end
			if element_by_name (definition, "Function") /= Void then
				if xml_boolean (definition, "Function") then
					derived_tab.func.enable_select
				else
					derived_tab.not_func.enable_select
				end
			else
				derived_tab.ignore_func.enable_select
			end
			if element_by_name (definition, "Deferred_feat") /= Void then
				if xml_boolean (definition, "Deferred_feat") then
					derived_tab.deferred_feat.enable_select
				else
					derived_tab.effective_feat.enable_select
				end
			else
				derived_tab.ignore_deferred_feat.enable_select
			end
			if element_by_name (definition, "Exported") /= Void then
				if xml_boolean (definition, "Exported") then
					derived_tab.exported.enable_select
				else
					derived_tab.not_exported.enable_select
				end
			else
				derived_tab.ignore_exported.enable_select
			end
			if element_by_name (definition, "Pre_equi") /= Void then
				if xml_boolean (definition, "Pre_equi") then
					derived_tab.pre_equi.enable_select
				else
					derived_tab.not_pre_equi.enable_select
				end
			else
				derived_tab.ignore_pre_equi.enable_select
			end
			if element_by_name (definition, "Post_equi") /= Void then
				if xml_boolean (definition, "Post_equi") then
					derived_tab.post_equi.enable_select
				else
					derived_tab.not_post_equi.enable_select
				end
			else
				derived_tab.ignore_post_equi.enable_select
			end
			if element_by_name (definition, "Inherited") /= Void then
				if xml_boolean (definition, "Inherited") then
					derived_tab.inherited.enable_select
				else
					derived_tab.not_inherited.enable_select
				end
			else
				derived_tab.ignore_inherited.enable_select
			end
		end

	execute is
			-- Display `management_dialog'
			-- Reset needed objects.
		local
			x_pos, y_pos: INTEGER
		do
			x_pos := tool.development_window.window.x_position + 200
			y_pos := tool.development_window.window.y_position + 40
			if management_dialog = Void then
				build_management_dialog
			end
			management_dialog.set_position (x_pos, y_pos)
			if ev_list = Void then
				create ev_list
			else
				ev_list.wipe_out
			end
			fill_ev_list (ev_list)
			if import.importable_metric_list /= Void and import.current_metric_list /= Void then
				import.importable_metric_list.wipe_out
				import.current_metric_list.wipe_out
			end
			create deleted_metrics.make
			up_button.disable_sensitive
			down_button.disable_sensitive
			delete_button.disable_sensitive
			edit_button.disable_sensitive
			save_button.disable_sensitive
			delete_confirmation_shown := False
			management_dialog.show_modal_to_window (tool.development_window.window)
		end

end -- class EB_METRIC_MANAGEMENT_CMD

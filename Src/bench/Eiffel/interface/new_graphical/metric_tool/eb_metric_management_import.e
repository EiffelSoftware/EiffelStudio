indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_MANAGEMENT_IMPORT

inherit
	SHARED_XML_ROUTINES

create
	make
	
feature -- Initialization

	make (management_cmd: EB_METRIC_MANAGEMENT_CMD) is
			-- Initialikze `interface'.
		require
			valid_interface: management_cmd /= Void
		do
			interface := management_cmd
		end

feature -- Access

	interface: EB_METRIC_MANAGEMENT_CMD
		-- Parent interface.

	open_dialog: EV_FILE_OPEN_DIALOG
		-- Dialog to select file containing a set of metric definitions.

	formula_field_import: EV_TEXT_FIELD
		-- Text field to display selected metric's formula in `import_metrics_dialog'.

	unit_field_import: EV_TEXT_FIELD
		-- Text field to display selected metric's unit in `import_metrics_dialog'.

	name_field_rename: EV_TEXT_FIELD
		-- Text field to display new name for selected metric when importing.

	formula_field_rename: EV_TEXT_FIELD
		-- Text_field to display renamed metric's formula in `rename_imported_metric_dialog'.

	unit_field_rename: EV_TEXT_FIELD
		-- Text field to display renamed metric's unit in `rename_imported_metric_dialog'.

	add_button: EV_BUTTON
		-- Import selected metric to current system metrics.

	remove_button: EV_BUTTON
		-- Remove selected metric (if imported from selected file) from current system metrics.

	non_removable_metrics: LINKED_LIST [EB_METRIC]
		-- List of available non basic metrics in current system that have not been
		-- deleted (before exiting management dialog). They cannot be added to importable
		-- metrics of selected file.
		
	importable_metric_list: EV_LIST
		-- List of available and importable non basic metrics in selected file.
		
	current_metric_list: EV_LIST
		-- List of available non basic metrics in current system,
		-- and the imported one from selected file.

	import_metrics_dialog: EV_DIALOG
			-- Dialog to display importable metrics and to pick up the wished ones.
			
	rename_imported_metric_dialog: EV_DIALOG
			-- Dialog to rename metric when its name is already being used in current project.
			
	name_is_correct: BOOLEAN
		-- Is new name correct?
	
feature -- Dialogs

	build_import_metrics_dialog is
			-- Build `import_metric_dialog' to display importable metrics and to pick up the wished ones.
		local
			hb1: EV_HORIZONTAL_BOX
			vb, vb1, vb2: EV_VERTICAL_BOX
			label: EV_LABEL
			ev_any: EV_WIDGET
			ok_button, cancel_button: EV_BUTTON
			frame: EV_FRAME
		do
			create import_metrics_dialog
			import_metrics_dialog.set_title ("Select metrics")
			create vb1
			vb1.set_border_width (5)

				create hb1
				hb1.set_border_width (5)
					create frame.make_with_text ("New Metrics:")
					frame.set_minimum_size (180, 250)
						create vb
						vb.set_border_width (5)
							importable_metric_list.set_minimum_size (160, 215)
							vb.extend (importable_metric_list)
						frame.extend (vb)
					hb1.extend (frame)

					create vb
					vb.set_border_width (5)
					vb.set_padding (5)
						create {EV_CELL} ev_any
						vb.extend (ev_any)

						create add_button.make_with_text_and_action ("Add->", ~add_metric)
						add_button.set_minimum_size (60, 22)
						vb.extend (add_button)
						vb.disable_item_expand (add_button)

						create remove_button.make_with_text_and_action ("<-Remove", ~remove_metric)
						remove_button.set_minimum_size (60, 22)
						vb.extend (remove_button)
						vb.disable_item_expand (remove_button)

						create {EV_CELL} ev_any
						vb.extend (ev_any)
					hb1.extend (vb)
					hb1.disable_item_expand (vb)

					create frame.make_with_text ("Current Metrics:")
					frame.set_minimum_size (180, 250)
						create vb
						vb.set_border_width (5)
							current_metric_list.set_minimum_size (160, 215)
							vb.extend (current_metric_list)
						frame.extend (vb)
					hb1.extend (frame)

				vb1.extend (hb1)

				create hb1
				hb1.set_border_width (5)
					create vb2
						create label.make_with_text ("Formula of the selected metric:")
						label.align_text_left
						vb2.extend (label)
						vb2.disable_item_expand (label)

						create formula_field_import
						formula_field_import.disable_edit
						vb2.extend (formula_field_import)

						create label.make_with_text ("Unit of the selected metric:")
						label.align_text_left
						vb2.extend (label)
						vb2.disable_item_expand (label)

						create unit_field_import
						unit_field_import.disable_edit
						vb2.extend (unit_field_import)
					hb1.extend (vb2)
				vb1.extend (hb1)
				vb1.disable_item_expand (hb1)

				create hb1
				hb1.set_border_width (5)
				hb1.set_padding (5)
					create {EV_CELL} ev_any
					hb1.extend (ev_any)

					create ok_button.make_with_text_and_action ("OK", ~ok_import)
					ok_button.set_minimum_size (50, 22)
					hb1.extend (ok_button)
					hb1.disable_item_expand (ok_button)

					create cancel_button.make_with_text_and_action ("Cancel", ~cancel_import)
					cancel_button.set_minimum_size (50, 22)
					hb1.extend (cancel_button)
					hb1.disable_item_expand (cancel_button)

					create {EV_CELL} ev_any
					hb1.extend (ev_any)
				vb1.extend (hb1)
				vb1.disable_item_expand (hb1)

			import_metrics_dialog.extend (vb1)
			import_metrics_dialog.set_default_push_button (ok_button)
			import_metrics_dialog.set_default_cancel_button (cancel_button)
		end

	build_rename_imported_metric_dialog is
			-- Build `rename_imported_metric_dialog' to rename metric when its name is already being used in current project.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			label: EV_LABEL
			ev_any: EV_WIDGET
			ok_rename_button, cancel_rename_button: EV_BUTTON
		do
			create rename_imported_metric_dialog
			rename_imported_metric_dialog.set_title ("Rename metric")
			create vb
			vb.set_border_width (5)
			vb.set_padding (5)
			vb.set_minimum_size (200, 240)
				create label.make_with_text ("There is already a metric defined with the%N%
											%specified name. Please rename selected%N%
											%metric before importation.")
				vb.extend (label)
				vb.disable_item_expand (label)

				create {EV_CELL} ev_any
				vb.extend (ev_any)

				create label.make_with_text ("Name:")
				label.align_text_left
				vb.extend (label)
				vb.disable_item_expand (label)

				create name_field_rename
				vb.extend (name_field_rename)
				vb.disable_item_expand (name_field_rename)

				create label.make_with_text ("Formula:")
				label.align_text_left
				vb.extend (label)
				vb.disable_item_expand (label)

				create formula_field_rename
				formula_field_rename.disable_edit
				vb.extend (formula_field_rename)
				vb.disable_item_expand (formula_field_rename)

				create label.make_with_text ("Unit:")
				label.align_text_left
				vb.extend (label)
				vb.disable_item_expand (label)

				create unit_field_rename
				unit_field_rename.disable_edit
				vb.extend (unit_field_rename)
				vb.disable_item_expand (unit_field_rename)

				create {EV_CELL} ev_any
				ev_any.set_minimum_height (20)
				vb.extend (ev_any)
				vb.disable_item_expand (ev_any)

				create hb
					hb.set_padding (5)
					create {EV_CELL} ev_any
					hb.extend (ev_any)

					create ok_rename_button.make_with_text_and_action ("OK", ~ok_rename)
					ok_rename_button.set_minimum_width (30)
					hb.extend (ok_rename_button)

					create cancel_rename_button.make_with_text_and_action ("Cancel", ~cancel_rename)
					cancel_rename_button.set_minimum_width (30)
					hb.extend (cancel_rename_button)

					create {EV_CELL} ev_any
					hb.extend (ev_any)

				vb.extend (hb)
				vb.disable_item_expand (hb)

			rename_imported_metric_dialog.extend (vb)
			rename_imported_metric_dialog.set_default_push_button (ok_rename_button)
			rename_imported_metric_dialog.set_default_cancel_button (cancel_rename_button)
		end

feature -- Importation

	import_action is
			-- Open dialog to select file for metric importation.
		do
			create open_dialog
			open_dialog.set_filter ("*.xml")
			open_dialog.open_actions.extend (~import_file)
			open_dialog.show_modal_to_window (interface.management_dialog)
		end
	
	import_file is
			-- Read selected file's name.
		local
			file_name: STRING
		do
			file_name := open_dialog.file_name
			on_import (file_name, interface.management_dialog)			
		end		

	on_import (file_name: STRING; parent_dialog: EV_DIALOG) is
			-- Display dialog to allow metric importation.
		local
			file: PLAIN_TEXT_FILE
			list_item: EV_LIST_ITEM
			imported_metrics: LINKED_LIST [EB_METRIC]
			imported_xml_elements: LINKED_LIST [XML_ELEMENT]
			list_item_data: CELL2 [EB_METRIC, XML_ELEMENT]
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
			x_pos, y_pos: INTEGER
			retried: BOOLEAN
			error_dialog: EV_WARNING_DIALOG
		do
			if not retried then
				x_pos := interface.tool.development_window.window.x_position + 200
				y_pos := interface.tool.development_window.window.y_position + 40
				if file_name /= Void and then not file_name.is_empty then
					create file.make (file_name)
					if file.exists and then not file.is_directory then
						if importable_metric_list = Void then
							create importable_metric_list
							importable_metric_list.select_actions.extend (~enable_add)
						end
						importable_metric_list.wipe_out
						file.open_read
						create imported_metrics.make
						create imported_xml_elements.make
						interface.tool.file_handler.retrieve_metric (file, imported_metrics, imported_xml_elements)
						from
							imported_metrics.start
							imported_xml_elements.start
						until
							imported_metrics.after and
							imported_xml_elements.after
						loop
							create list_item.make_with_text (imported_metrics.item.name)
							create list_item_data.make (imported_metrics.item, imported_xml_elements.item)
							list_item.set_data (list_item_data)
							list_item.pointer_double_press_actions.extend (~double_click_add)
							list_item.set_pebble (list_item)
							list_item.drop_actions.extend (agent interface.drop_action_in_list (?, list_item))
							importable_metric_list.extend (list_item)
							imported_metrics.forth
							imported_xml_elements.forth
						end
						file.close
						if current_metric_list = Void then
							create current_metric_list
							current_metric_list.select_actions.extend (~enable_remove)
						end
						current_metric_list.wipe_out
						create non_removable_metrics.make
						from
							interface.ev_list.start
						until
							interface.ev_list.after
						loop
							create list_item.make_with_text (interface.ev_list.item.text)
							list_item.set_data (interface.ev_list.item.data)
							list_item.pointer_double_press_actions.extend (~double_click_remove)
							list_item.set_pebble (list_item)
							list_item.drop_actions.extend (agent interface.drop_action_in_list (?, list_item))
							current_metric_list.extend (list_item)
							cell ?= interface.ev_list.item.data
							non_removable_metrics.extend (cell.item1)
							interface.ev_list.forth
						end
						importable_metric_list.drop_actions.extend (agent interface.move_to_list (?, importable_metric_list))
						current_metric_list.drop_actions.extend (agent interface.move_to_list (?, current_metric_list))
						if import_metrics_dialog = Void then
							build_import_metrics_dialog
						end
						import_metrics_dialog.set_position (x_pos, y_pos)
						formula_field_import.remove_text
						unit_field_import.remove_text
						add_button.disable_sensitive
						remove_button.disable_sensitive
						import_metrics_dialog.show_modal_to_window (parent_dialog)
					end
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:%N" + interface.tool.file_manager.metric_file_name)
			error_dialog.show_modal_to_window (interface.management_dialog)
			retry
		end
		
	update_wished_list is
			-- Update `wished_metric_list' when `interface.tool.metrics' has changed.
		local
			imported: EV_LIST
			list_item: EV_LIST_ITEM
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
			i: INTEGER
		do
			from
				i := 1
				current_metric_list.start
			until
				i = non_removable_metrics.count + 1
			loop
				current_metric_list.remove
				i := i + 1
			end
--			imported := current_metric_list.ev_clone
			create imported
			from
				current_metric_list.start
			until
				current_metric_list.after
			loop
				list_item := current_metric_list.item
				current_metric_list.remove
				imported.extend (list_item)
			end
			non_removable_metrics.wipe_out
			from
				interface.ev_list.start
			until
				interface.ev_list.after
			loop
				create list_item.make_with_text (interface.ev_list.item.text)
				list_item.set_data (interface.ev_list.item.data)
				list_item.pointer_double_press_actions.extend (~double_click_remove)
				list_item.set_pebble (list_item)
				list_item.drop_actions.extend (agent interface.drop_action_in_list (?, list_item))
				current_metric_list.extend (list_item)
				cell ?= interface.ev_list.item.data
				non_removable_metrics.extend (cell.item1)
				interface.ev_list.forth
			end
--			current_metric_list.append (imported)
			from
				imported.start
			until
				imported.after
			loop
				list_item := imported.item
				imported.remove
				current_metric_list.extend (list_item)
			end
			current_metric_list.drop_actions.extend (agent interface.move_to_list (?, current_metric_list))
			
		end

	add_metric is
			-- Import selected metric from file to current system.
		require
			import_dialog_shown: import_metrics_dialog.is_displayed
			import_list_effective: importable_metric_list /= Void
			current_list_effective: current_metric_list /= Void
		local
			list_item: EV_LIST_ITEM
			basic_homonym: EB_METRIC_BASIC
			composite_homonym: EB_METRIC_COMPOSITE
			derived_homonym: EB_METRIC_DERIVED
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
			new_name: STRING
			name_attribute: XML_ATTRIBUTE
		do
			if importable_metric_list.selected_item /= Void then
				list_item := importable_metric_list.selected_item
				basic_homonym ?= interface.tool.metric (list_item.text)
				composite_homonym ?= interface.metric (list_item.text, interface.ev_list)
				derived_homonym ?= interface.metric (list_item.text, interface.ev_list)
				name_is_correct := basic_homonym = Void and composite_homonym = Void and derived_homonym = Void
				cell ?= list_item.data
				if not name_is_correct then
						-- dialog must be created..
					build_rename_imported_metric_dialog

					name_field_rename.set_text (cell.item1.name)
					formula_field_rename.set_text (xml_string (cell.item2, "FORMULA"))
					unit_field_rename.set_text (cell.item1.unit)
						-- modal mode is important.
					rename_imported_metric_dialog.show_modal_to_window (import_metrics_dialog)
					new_name := name_field_rename.text
				else
					new_name := cell.item1.name
				end
				if name_is_correct then
					importable_metric_list.prune (list_item)
					list_item.set_text (new_name)
					cell.item1.set_name (new_name)
					create name_attribute.make ("Name", new_name)
					cell.item2.attributes.replace (name_attribute, "Name")
					list_item.pointer_double_press_actions.wipe_out
					list_item.pointer_double_press_actions.extend (~double_click_remove)
					current_metric_list.extend (list_item)
					current_metric_list.last.enable_select
				end
			end
		end

	double_click_add (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Import selected metric from file to current system on double click.
		do
			if a_button = 1 and then add_button.is_sensitive then
				add_metric
			end
		end

	remove_metric is
			-- Cancel import for a previously selected metric.
		require
			import_dialog_shown: import_metrics_dialog.is_displayed
			import_list_effective: importable_metric_list /= Void
			current_list_effective: current_metric_list /= Void
		local
			list_item: EV_LIST_ITEM
		do
			list_item := current_metric_list.selected_item
			if list_item /= Void then
				list_item.pointer_double_press_actions.wipe_out
				list_item.pointer_double_press_actions.extend (~double_click_add)
				current_metric_list.prune (list_item)
				importable_metric_list.extend (list_item)
				importable_metric_list.last.enable_select
			end
		end

	double_click_remove (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Cancel import for a previously selected metric on double click.
		do
			if a_button = 1 and then remove_button.is_sensitive then
				remove_metric
			end
		end

	ok_rename is
			-- Action to be performed when user renames imported metric.
		require
			rename_dialog_shown: rename_imported_metric_dialog.is_displayed
		local
			new_name: STRING
			basic_homonym: EB_METRIC_BASIC
			composite_homonym: EB_METRIC_COMPOSITE
			derived_homonym: EB_METRIC_DERIVED
			error_dialog: EB_INFORMATION_DIALOG
		do
			new_name := name_field_rename.text
			basic_homonym ?= interface.tool.metric (new_name)
			composite_homonym ?= interface.metric (new_name, interface.ev_list)
			derived_homonym ?= interface.metric (new_name, interface.ev_list)
			name_is_correct := basic_homonym = Void and composite_homonym = Void and derived_homonym = Void
			if not name_is_correct then
				create error_dialog.make_with_text ("Name still refers to a previously%N%
													%defined metric")
				error_dialog.show_modal_to_window (rename_imported_metric_dialog)
			else
				rename_imported_metric_dialog.hide
			end
		end

	cancel_rename is
			-- Action to be performed when user cancels renaming imported metric.
		require
			rename_dialog_shown: rename_imported_metric_dialog.is_displayed
		do
			rename_imported_metric_dialog.hide
		end

	ok_import is
			-- Action to be performed after user has finished selection of imported metrics.
		require
			import_dialog_shown: import_metrics_dialog.is_displayed
		local
			i: EV_LIST_ITEM
		do
			interface.ev_list.wipe_out
			from
				current_metric_list.start
			until
				current_metric_list.after
			loop
				create i.make_with_text (current_metric_list.item.text)
				i.set_data (current_metric_list.item.data)
				i.set_pebble (i)
				i.drop_actions.extend (agent interface.drop_action_in_list (?, i))
				i.pointer_double_press_actions.extend (agent interface.double_click_edit)
				interface.ev_list.extend (i)
				current_metric_list.forth
			end
			import_metrics_dialog.hide
			if interface.management_dialog /= Void and then interface.management_dialog.is_displayed then
					-- Importation is also possible on archive comparison.
					-- In that case `interface.management_dialog' may not exist.
				interface.save_button.enable_sensitive
			end
		end

	cancel_import is
			-- Action to be performed when user cancels metric importation
		require
			import_dialog_shown: import_metrics_dialog.is_displayed
		do
			import_metrics_dialog.hide
		end

	enable_add is
			-- Enable `add_button' for metric importation on selecting item in `importable_metric_list'.
		require
			import_dialog_shown: import_metrics_dialog.is_displayed
		local
			selected_item: EV_LIST_ITEM
			formula, unit: STRING
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
		do
			add_button.enable_sensitive
			selected_item := importable_metric_list.selected_item
			cell ?= selected_item.data
			formula := xml_string (cell.item2, "FORMULA")
			unit := cell.item1.unit
			formula_field_import.set_text (formula)
			unit_field_import.set_text (unit)
		end

	enable_remove is
			-- Enable `remove_button' for canceling metric importation on selecting item in
			-- `current_metric_list' and only if selected metric used to be displayed in
			-- `importable_metric_list' (it is not possible to move a metric to selected
			-- file if it was previously not saved in that file).
		require
			import_dialog_shown: import_metrics_dialog.is_displayed
		local
			selected_item: EV_LIST_ITEM
			formula, unit: STRING
			cell: CELL2 [EB_METRIC, XML_ELEMENT]
		do
			selected_item := current_metric_list.selected_item
			cell ?= selected_item.data
			if not non_removable_metrics.has (cell.item1) then
				remove_button.enable_sensitive
			else
				remove_button.disable_sensitive
			end
			formula := xml_string (cell.item2, "FORMULA")
			unit := cell.item1.unit
			formula_field_import.set_text (formula)
			unit_field_import.set_text (unit)
		end
		
end -- class EB_METRIC_MANAGEMENT_IMPORT

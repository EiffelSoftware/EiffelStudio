indexing
	description: "Tab to compose a linear metric definition."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_LINEAR_TAB

inherit
	EB_METRIC_NEW_DEFINITION_TAB
		undefine
			default_create, is_equal, copy
		redefine
			preset
		end

	EV_VERTICAL_BOX

create
	make

feature -- Initialization

	make (i: EB_METRIC_NEW_DEFINITION_CMD) is
			-- Tab to compose a linear metric.
		require
			valid_interface: i /= Void
		local
			hb, hb_min: EV_HORIZONTAL_BOX
			vb1, vb_min: EV_VERTICAL_BOX
			hsep: EV_HORIZONTAL_SEPARATOR
			frame: EV_FRAME
			label: EV_LABEL
			ev_any: EV_WIDGET
		do
			interface := i
			create formula.make
			default_create
			set_padding (5)
			set_border_width (3)

					-- Metric name entry.			
				create hb
				hb.set_padding (5)
				hb.set_border_width (3)
					create label.make_with_text ("New metric name:")
					label.align_text_left
					label.set_minimum_width (85)
					hb.extend (label)
					hb.disable_item_expand (label)

					create name_field
					name_field.set_minimum_height (22)
					name_field.key_press_actions.extend (~dialog_key_press_action (?, name_field))
					name_field.key_press_string_actions.extend (~change_in_name)
					hb.extend (name_field)
				extend (hb)
				disable_item_expand (hb)

				create hb
				hb.set_padding (5)
				hb.set_border_width (3)
					create label.make_with_text ("New metric unit:")
					label.align_text_left
					label.set_minimum_width (85)
					hb.extend (label)
					hb.disable_item_expand (label)

					create unit_field
					unit_field.set_minimum_height (22)
					unit_field.disable_edit
					unit_field.key_press_actions.extend (~dialog_key_press_action (?, unit_field))
					hb.extend (unit_field)
				extend (hb)
				disable_item_expand (hb)

				create hsep
				extend (hsep)
				disable_item_expand (hsep)

				create frame.make_with_text ("Single term")
				create vb1
				vb1.set_padding (5)
				vb1.set_border_width (5)
					create hb
					hb.set_padding (8)
						create vb_min
						vb_min.set_padding (5)
							create label.make_with_text ("Coefficient:")
							label.align_text_left
							vb_min.extend (label)
							vb_min.disable_item_expand (label)

							create hb_min
							hb_min.set_padding (5)
								create coeff_field
								coeff_field.set_minimum_width (60)
								coeff_field.set_minimum_height (22)
								coeff_field.key_press_actions.extend (~dialog_key_press_action (?, coeff_field))
								hb_min.extend (coeff_field)

								create label.make_with_text ("x")
								hb_min.extend (label)
								hb_min.disable_item_expand (label)
							vb_min.extend (hb_min)
							vb_min.disable_item_expand (hb_min)
						hb.extend (vb_min)

						create vb_min
						vb_min.set_padding (5)
							create label.make_with_text ("Metric:")
							label.align_text_left
							vb_min.extend (label)
							vb_min.disable_item_expand (label)

							create hb_min
							hb_min.set_padding (5)
								create metric_combobox
								metric_combobox.set_minimum_width (140)
								interface.fill_metric_combobox (metric_combobox)
--								metric_combobox.set_text (metric_combobox.first.text)
								metric_combobox.disable_edit
								metric_combobox.key_press_actions.extend (~dialog_key_press_action (?, metric_combobox))
								hb_min.extend (metric_combobox)

								create plus_button.make_with_text_and_action ("+", ~add_action)
								plus_button.set_minimum_size (22, 22)
								plus_button.key_press_actions.extend (~dialog_key_press_action (?, plus_button))
								hb_min.extend (plus_button)
								hb_min.disable_item_expand (plus_button)
							vb_min.extend (hb_min)
						hb.extend (vb_min)
					vb1.extend (hb)
					vb1.disable_item_expand (hb)

					create label.make_with_text ("Formula:")
					label.align_text_left
					vb1.extend (label)
					vb1.disable_item_expand (label)

					create hb
					hb.set_padding (5)
						create definition_field
						definition_field.set_minimum_height (22)
						definition_field.disable_edit
						hb.extend (definition_field)

						metric_combobox.select_actions.extend (~display_formula_and_unit (metric_combobox, definition_field))

						create {EV_CELL} ev_any
						ev_any.set_minimum_size (22, 22)
						hb.extend (ev_any)
						hb.disable_item_expand (ev_any)
					vb1.extend (hb)
				frame.extend (vb1)
				extend (frame)
				disable_item_expand (frame)

				create frame.make_with_text ("Linear sum")
					create vb1
					vb1.set_border_width (5)
					create hb
					hb.set_padding (5)
						create text_field
						text_field.disable_edit
						text_field.key_press_actions.extend (~dialog_key_press_action (?, text_field))
						hb.extend (text_field)

						create vb_min
						vb_min.set_padding (5)
							create del_button
							del_button.select_actions.extend (~remove_action)
							del_button.set_minimum_size (22, 22)
							del_button.set_tooltip ("Remove last term")
							del_button.set_pixmap (Pixmaps.Icon_delete_small @ 1)
							del_button.key_press_actions.extend (~dialog_key_press_action (?, del_button))
							vb_min.extend (del_button)
							vb_min.disable_item_expand (del_button)

							create new_button
							new_button.select_actions.extend (~preset)
							new_button.set_tooltip ("New metric")
							new_button.set_minimum_size (22, 22)
							new_button.set_pixmap (Pixmaps.Icon_new_metric @ 1)
							new_button.key_press_actions.extend (~dialog_key_press_action (?, new_button))
							vb_min.extend (new_button)
							vb_min.disable_item_expand (new_button)

							create {EV_CELL} ev_any
							vb_min.extend (ev_any)
						hb.extend (vb_min)
						hb.disable_item_expand (vb_min)
					vb1.extend (hb)
				frame.extend (vb1)
				extend (frame)
			preset
			name_field.key_press_actions.extend (~following_widget (?, coeff_field))
			coeff_field.key_press_actions.extend (~following_widget (?, metric_combobox))
			metric_combobox.key_press_actions.extend (~following_widget (?, plus_button))
			plus_button.key_press_actions.extend (~following_widget (?, coeff_field))
		end

feature -- Access

	displayed_metric: STRING
		-- Formula of `Current' metric being entered by user.

	set_displayed_metric  (dm: STRING) is
			-- Assign `dm' to `displayed_metric'.
		do
			displayed_metric := dm
		end

	formula: LINKED_LIST [STRING]
		-- Representation of tokens constituting `Current' formula.
		-- (coefficients, operator + and *, previously defined metric names).

	text_field: EV_TEXT_FIELD
		-- Text field to display `displayed_metric'.
		
	coeff_field: EV_TEXT_FIELD
		-- Text field to display multiplying coefficient of single terms.
		
	definition_field: EV_TEXT_FIELD
		-- Text field to display definition of selected metric from `metric_combobox'.

	metric_combobox: EV_COMBO_BOX
		-- Combo box to display available metrics.

	plus: STRING is " + "
		-- Operator +.
		
	minus: STRING is " - "
		-- Operator -.
		
	multiply: STRING is " * "
		-- Operator *.
		
	plus_button: EV_BUTTON
		-- Button that allows adding single term to sum.
	 
	del_button: EV_BUTTON
		-- Button that allows deleting last entered term.
		
	new_button: EV_BUTTON
		-- Button that allows defining new linear metric by restting all fields.

	empty_formula: BOOLEAN
		-- Is `formula' empty?

feature -- Error rescue

	error: BOOLEAN is
			-- Is there any error in `Current' definition?
			-- Error could be an empty name or an empty formula or
			-- choosing a name previously used to define a metric.
		local
			basic_metric: EB_METRIC_BASIC
		do
			error_name := name_field.text = Void or else name_field.text.is_empty
			if not error_name then
				error_name := name_field.text.has ('<') or name_field.text.has ('>')
			end
			empty_formula := text_field.text = Void or else text_field.text.is_empty
			if not name_field.text.is_empty then
				basic_metric ?= interface.tool.metric (name_field.text)
				existing_basic_name := basic_metric /= Void
			end

			Result := error_name or empty_formula or existing_basic_name
		end
		
	throw_error is
			-- Must be called after `error' to display an information dialog.
		local
			error_dialog: EB_INFORMATION_DIALOG
			x_pos, y_pos: INTEGER
		do
			x_pos := interface.new_metric_definition_dialog.x_position + 40
			y_pos := interface.new_metric_definition_dialog.y_position + 80

			if error_name then
				create error_dialog.make_with_text ("Name is empty or has invalid%N%
													%characters (<, >).")
				error_dialog.set_position (x_pos, y_pos)
				error_dialog.show_modal_to_window (interface.new_metric_definition_dialog)
			elseif empty_formula then
				create error_dialog.make_with_text ("Metric definition is empty.")
				error_dialog.set_position (x_pos, y_pos)
				error_dialog.show_modal_to_window (interface.new_metric_definition_dialog)
			elseif existing_basic_name then
				create error_dialog.make_with_text ("There is already a basic metric%N%
											%with the same name. You cannot%N%
											%overwrite it.")
				error_dialog.set_position (x_pos, y_pos)
				error_dialog.show_modal_to_window (interface.new_metric_definition_dialog)
			end
		end

	something_to_save: BOOLEAN is
			-- Did user start defining new linear metric?
		do
			Result := (text_field.text /= Void and then not text_field.text.is_empty)
					or (name_field.text /= Void and then not name_field.text.is_empty)
		end

feature -- Metric constituents.

	new_metric: EB_METRIC_COMPOSITE is
			-- Build new metric regarding entered formula.
			-- Rely on `new_metric_element' that must be called before.
		require else
			correct_metric_definition: valid_metric_definition
		local
			a_name, a_unit: STRING
			tree: EB_METRIC_VALUE
		do
			a_name := name_field.text
			a_unit := unit_field.text
			tree := interface.tool.file_handler.build_operator (metric_definition, True, False, False, new_metric_successful)
			create Result.make (a_name, a_unit, tree, interface.tool, min_scope)
			Result.set_linear (True)
		ensure then
			metric_built: Result /= Void
			linear_metric: Result.is_linear and not Result.is_metric_ratio and not Result.is_scope_ratio
		end

	new_metric_element: XML_ELEMENT is
			-- Build a storable definition for the metric being saved.
		require else
			entered_formula: text_field.text /= Void and then not text_field.text.is_empty
			displayed_metric_set: displayed_metric /= Void and then not displayed_metric.is_empty
			formula_set: formula /= Void and then not formula.is_empty
		local
			a_name, a_unit: STRING
			xml_elements_def_list : LINKED_LIST [XML_ELEMENT]
			xml_attribute: XML_ATTRIBUTE
		do
			a_name := name_field.text
			a_unit := unit_field.text
			Result := interface.tool.file_manager.metric_element (a_name, a_unit, "Linear")
			Result.put_last (xml_node (Result, "FORMULA", displayed_metric))
			create metric_definition.make (Result, "DEFINITION")
				-- Fill metric_definition with convinient xml element in polish syntax.
			xml_elements_def_list := translate_formula_to_polish_syntax (formula, metric_definition)
			from
				xml_elements_def_list.start
			until
				xml_elements_def_list.after
			loop
				metric_definition.put_last (xml_elements_def_list.item)
				xml_elements_def_list.forth
			end
			if valid_metric_definition then
				Result.put_last (metric_definition)
				create xml_attribute.make ("Min_scope", to_scope (min_scope))
				Result.attributes.add_attribute (xml_attribute)
			end
		end

	valid_metric_definition: BOOLEAN is
			-- Does `formula' contain syntax errors?
			-- Check whether `metric_definition' is correctly built, and then
			-- rely on `new_metric_element' that must be called before.
		require else
			correct_metric_definition: metric_definition /= Void and then not metric_definition.is_empty
		local
			i: INTEGER
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			sub_node: XML_ELEMENT
			a_name, op: STRING
			metric: EB_METRIC
		do
			new_metric_successful := False
			Result := True
			a_cursor := metric_definition.new_cursor
			from
				a_cursor.start
				i := 1
			until
				a_cursor.after or Result = False
			loop
				sub_node ?= a_cursor.item
				if sub_node /= Void then
					a_name := sub_node.name
						Result := Result and (metric_definition.count = 3 or ((metric_definition.count - 3) \\ 4) = 0)
						if i <= 3 then
							inspect i 
								when 1 then
									Result := Result and equal (a_name, "PARAMETER") and not (element_by_name (metric_definition, "PARAMETER")).is_empty
									Result := Result and (interface.tool.file_handler.content_of_node (sub_node)).is_double
								when 2 then
									Result := Result and equal (a_name, "METRIC") and not (element_by_name (metric_definition, "METRIC")).is_empty
									metric := interface.tool.metric (interface.tool.file_handler.content_of_node (sub_node))
									Result := Result and metric /= Void
								when 3 then
									Result := Result and equal (a_name, "OPERATOR") and not (element_by_name (metric_definition, "OPERATOR")).is_empty
									op := interface.tool.file_handler.content_of_node (sub_node)
									Result := Result and equal (op, " * ")
							end
						else
							inspect i \\ 4
								when 0 then
									Result := Result and equal (a_name, "PARAMETER") and not (element_by_name (metric_definition, "PARAMETER")).is_empty
									Result := Result and (interface.tool.file_handler.content_of_node (sub_node)).is_double
								when 1 then
									Result := Result and equal (a_name, "METRIC") and not (element_by_name (metric_definition, "METRIC")).is_empty
									metric := interface.tool.metric (interface.tool.file_handler.content_of_node (sub_node))
									Result := Result and metric /= Void
								when 2 then
									Result := Result and equal (a_name, "OPERATOR") and not (element_by_name (metric_definition, "OPERATOR")).is_empty
									op := interface.tool.file_handler.content_of_node (sub_node)
									Result := Result and equal (op, " * ")
								when 3 then
									Result := Result and equal (a_name, "OPERATOR") and not (element_by_name (metric_definition, "OPERATOR")).is_empty
									op := interface.tool.file_handler.content_of_node (sub_node)
									Result := Result and equal (op, " + ")
							end
						end
					i := i + 1
				end
				a_cursor.forth
			end
			new_metric_successful := Result
		end

	translate_formula_to_polish_syntax (sub_formula: LINKED_LIST [STRING]; a_metric_definition: XML_ELEMENT): LINKED_LIST [XML_ELEMENT] is
			-- Make xml element for each item of `sub_formula' and reorder it into polish syntax.
		require
			correct_formula: sub_formula /= Void and then not sub_formula.is_empty
			empty_metric_definition: a_metric_definition /= Void and then a_metric_definition.is_empty
		local
			operator: STRING
			sub_list: LINKED_LIST [STRING]
		do
			create Result.make
			operator := ""
			from
				sub_formula.start
			until
				sub_formula.after
			loop
				if equal (sub_formula.item, plus) or equal (sub_formula.item, minus) then
					operator := clone (sub_formula.item)
					sub_formula.forth
					create sub_list.make
					from
					until
						(not sub_formula.off and then (equal (sub_formula.item, plus) or equal (sub_formula.item, minus)))
						or sub_formula.after
					loop
						sub_list.extend (sub_formula.item)
						sub_formula.forth
					end
					Result.append (translate_formula_to_polish_syntax (sub_list, a_metric_definition))
					Result.extend (xml_node (a_metric_definition, "OPERATOR", operator))
				elseif equal (sub_formula.item, multiply) then
					operator := clone (sub_formula.item)
					sub_formula.forth
				elseif sub_formula.item.is_double then
					Result.extend (xml_node (a_metric_definition, "PARAMETER", sub_formula.item))
					sub_formula.forth
					if not equal (operator, "") then
						Result.extend (xml_node (a_metric_definition, "OPERATOR", operator))
						operator := ""
					end
				elseif interface.tool.metric (sub_formula.item) /= Void then
					Result.extend (xml_node (a_metric_definition, "METRIC", sub_formula.item))
					sub_formula.forth
					if not equal (operator, "") then
						Result.extend (xml_node (a_metric_definition, "OPERATOR", operator))
						operator := ""
					end
				end
			end
		ensure
			list_built: not Result.is_empty
		end

feature -- Linear action

	display_formula_and_unit (a_combobox: EV_COMBO_BOX; a_definition_field: EV_TEXT_FIELD) is
			-- Display `a_combobox' selected item formula in `a_definition_field',
			-- and unit in `unit_field'.
		require
			existing_combobox: a_combobox /= Void
			existing_definition: a_definition_field /= Void
		local
			xml_location: XML_ELEMENT
			basic_metric: EB_METRIC_BASIC
			other_metric: EB_METRIC
			key: INTEGER
			corresponding_formula: STRING
		do
			basic_metric ?= interface.tool.metric (a_combobox.text)
			other_metric ?= interface.tool.metric (a_combobox.text)
			if basic_metric /= Void then
				corresponding_formula := "Basic metric"
				unit_field.set_text (basic_metric.unit)
			else
				key := interface.tool.metrics.index_of (other_metric, 1) - interface.tool.nb_basic_metrics
				xml_location ?= interface.tool.user_metrics_xml_list.i_th (key)
				corresponding_formula := xml_string (xml_location, "FORMULA")
				unit_field.set_text (other_metric.unit)
			end
			a_definition_field.set_text (corresponding_formula)
		ensure
			definition_set: a_definition_field.text /= Void and then not a_definition_field.text.is_empty
			unit_set: unit_field.text /= Void and then not unit_field.text.is_empty
		end

	display_single_term (is_first_term: BOOLEAN; coeff, metric: STRING) is
			-- Algorithm to simplify terms from "1 * metric" to "metric"
			-- or from "+ - n * metric" to " - n * metric".
		require
			existing_coeff: coeff /= Void and then not coeff.is_empty
			existing_metric: metric /= Void and then not metric.is_empty
		do
			if coeff.to_double.abs = 1 then
				if is_first_term and coeff.to_double < 0 then
					displayed_metric.append ("- " + metric)
				else
					displayed_metric.append (metric)
				end
			else
				if is_first_term and coeff.to_double < 0 then
					displayed_metric.append ("- ")
				end
				displayed_metric.append (coeff.to_double.abs.out + " x " + metric)
			end
		end

	add_action is
			-- Add single term to linear sum.
		require
			linear_metric: interface.is_linear
		local
			coeff, selected_metric: STRING
			a_metric: EB_METRIC
			x_pos, y_pos: INTEGER
			is_first_term: BOOLEAN
			term_error_dialog: EB_INFORMATION_DIALOG
		do
			coeff := coeff_field.text
			selected_metric := metric_combobox.text
			if not text_field.text.is_empty then
				displayed_metric := text_field.text
			end
			a_metric := interface.tool.metric (selected_metric)

			x_pos := interface.new_metric_definition_dialog.screen_x + 40
			y_pos := interface.new_metric_definition_dialog.screen_y + 40

			if (coeff /= Void and then coeff.is_double and then coeff.to_double /= 0)
			  and a_metric /= Void then
				keep_same_unit_metrics (a_metric)
				put_item_with_text (metric_combobox, selected_metric)
				min_scope := min_scope.max (a_metric.min_scope)

					-- Add single term to linear sum.
				if not formula.is_empty then
					formula.extend (plus)
					if coeff.to_double > 0 then
						displayed_metric.append (" + ")
					else
						displayed_metric.append (" - ")
					end
				end
				is_first_term := formula.is_empty
				formula.extend (coeff)
				formula.extend (multiply)
				formula.extend (selected_metric)
				display_single_term (is_first_term, coeff, selected_metric)
				text_field.set_text (displayed_metric)
			elseif coeff = Void or not coeff.is_double then
				create term_error_dialog.make_with_text ("Coefficient must be DOUBLE.%N%
										%Please enter a correct value.")
				term_error_dialog.set_position (x_pos, y_pos)
				term_error_dialog.show_modal_to_window (interface.new_metric_definition_dialog)
			elseif a_metric = Void then
				create term_error_dialog.make_with_text ("Selected metric has not been defined yet.%N%
										%Please select one from combo box.")
				term_error_dialog.set_position (x_pos, y_pos)
				term_error_dialog.show_modal_to_window (interface.new_metric_definition_dialog)
			end
			enable_save
		end

	keep_same_unit_metrics (a_metric: EB_METRIC) is
			-- Sort and keep in `metric_combobox' all metrics of same unit as `a_metric'.
		require
			existing_metric: a_metric /= Void
		local
			measure_item: EV_LIST_ITEM
		do
			metric_combobox.wipe_out
			from
				interface.tool.metrics.start
			until
				interface.tool.metrics.after
			loop
				if equal (interface.tool.metrics.item.unit, a_metric.unit) then
					create measure_item.make_with_text (interface.tool.metrics.item.name)
					metric_combobox.extend (measure_item)
				end
				interface.tool.metrics.forth
			end
		end

	remove_action is
		require else
			linear_tab_selected: interface.is_linear
			removable: formula /= Void and then (formula.is_empty or
						(formula.count > 0 implies (not displayed_metric.is_empty and not text_field.text.is_empty)))
		local
			i, ind, last_index, ct: INTEGER
			scope_info: EB_METRIC_SCOPE_INFO
		do
				-- There is at least one term in sum.
			if formula.count >= 3 then
				if formula.count > 3 then
						-- 4 items to remove: metric, "x", coeff, "+".
					ind := 4
				else
						-- No "+" to be removed, update combobox.
					ind := 3
					metric_combobox.wipe_out
					interface.fill_metric_combobox (metric_combobox)
					create scope_info
					min_scope := scope_info.Feature_scope
				end
				ct := displayed_metric.count
				last_index := (displayed_metric.last_index_of ('+', ct)).max (displayed_metric.last_index_of ('-', ct))
				from
					formula.finish
					i := 1
				until
					i > ind
				loop
					if last_index > 0 then
						displayed_metric.head (last_index - 1)
					else
						displayed_metric.wipe_out
					end
					formula.remove
					formula.back
					i := i + 1
				end
				if not displayed_metric.is_empty then
					text_field.set_text (displayed_metric)
				else
					text_field.remove_text
				end
			end
				-- Else, do nothing.

			enable_save
		ensure
			removed: formula.is_empty implies (displayed_metric.is_empty and (text_field.text = Void or else text_field.text.is_empty)) or
					(formula.count > 0 implies (not displayed_metric.is_empty and not text_field.text.is_empty))
		end

feature -- Update dialogs

	update_displayed_dialogs is
			-- Update metrics in `manage' and `new_metric' dialogs.
		require
			dialog_displayed: interface.new_metric_definition_dialog.is_displayed
		local
			selected_item: EV_LIST_ITEM
		do
			selected_item := metric_combobox.selected_item
			metric_combobox.wipe_out
			interface.fill_metric_combobox (metric_combobox)
			put_item_with_text (metric_combobox, selected_item.text)
		end

feature -- Reinitialize

	preset is
			-- Reset fields and useful objects.
		local
			scope_info: EB_METRIC_SCOPE_INFO
		do
			Precursor
			formula.wipe_out
			displayed_metric := ""
			text_field.remove_text
			enable_save
			metric_combobox.wipe_out
			interface.fill_metric_combobox (metric_combobox)
			coeff_field.set_text ("1")
			metric_combobox.selected_item.disable_select
			metric_combobox.first.enable_select
			definition_field.set_text ("Basic metric")
			unit_field.set_text (interface_names.metric_class_unit)
			create scope_info
			min_scope := scope_info.Feature_scope
		end

end -- class EB_METRIC_LINEAR_TAB

indexing
	description: "Tab to compose a ratio metric definition."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_RATIO_TAB

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
			-- Tab to compose a ratio of two metrics.
		require
			valid_interface: i /= Void
		local
			hb: EV_HORIZONTAL_BOX
			vb_min: EV_VERTICAL_BOX
			hsep: EV_HORIZONTAL_SEPARATOR
			frame: EV_FRAME
			label: EV_LABEL
			ev_any: EV_WIDGET
			scope_info: EB_METRIC_SCOPE_INFO
		do
			interface := i
			create formula.make
			displayed_metric := ""
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
					unit_field.set_text (interface_names.metric_ratio_unit) 
					unit_field.key_press_actions.extend (~dialog_key_press_action (?, unit_field))
					hb.extend (unit_field)
				extend (hb)
				disable_item_expand (hb)

				create hsep
				extend (hsep)
				disable_item_expand (hsep)

				create hb
				hb.set_padding (3)
				create frame.make_with_text ("Numerator")
					create vb_min
					vb_min.set_border_width (5)
					vb_min.set_padding (5)
						create label.make_with_text ("Metric:")
						label.align_text_left
						vb_min.extend (label)
						vb_min.disable_item_expand (label)

						create first_metric_combobox
						first_metric_combobox.set_minimum_width (140)
						interface.fill_metric_combobox (first_metric_combobox)
						first_metric_combobox.disable_edit
						first_metric_combobox.first.enable_select
						first_metric_combobox.select_actions.extend (~add_num_action)
						first_metric_combobox.key_press_actions.extend (~dialog_key_press_action (?, first_metric_combobox))
						vb_min.extend (first_metric_combobox)

						create label.make_with_text ("Formula:")
						label.align_text_left
						vb_min.extend (label)
						vb_min.disable_item_expand (label)

						create num_definition_field
						num_definition_field.disable_edit
						num_definition_field.set_minimum_width (140)
						vb_min.extend (num_definition_field)
						vb_min.disable_item_expand (num_definition_field)

						first_metric_combobox.select_actions.extend (~display_formula (first_metric_combobox, num_definition_field))

					frame.extend (vb_min)
				hb.extend (frame)

				create frame.make_with_text ("Denominator")
					create vb_min
					vb_min.set_border_width (5)
					vb_min.set_padding (5)
						create label.make_with_text ("Metric:")
						label.align_text_left
						vb_min.extend (label)
						vb_min.disable_item_expand (label)

						create second_metric_combobox
						second_metric_combobox.set_minimum_width (140)
						interface.fill_metric_combobox (second_metric_combobox)
						second_metric_combobox.disable_edit
						second_metric_combobox.first.enable_select
						second_metric_combobox.select_actions.extend (~add_den_action)
						second_metric_combobox.key_press_actions.extend (~dialog_key_press_action (?, second_metric_combobox))
						vb_min.extend (second_metric_combobox)

						create label.make_with_text ("Formula:")
						label.align_text_left
						vb_min.extend (label)
						vb_min.disable_item_expand (label)

						create den_definition_field
						den_definition_field.disable_edit
						den_definition_field.set_minimum_width (140)
						vb_min.extend (den_definition_field)

						second_metric_combobox.select_actions.extend (~display_formula (second_metric_combobox, den_definition_field))

					frame.extend (vb_min)
				hb.extend (frame)

				extend (hb)
				disable_item_expand (hb)

				create frame.make_with_text ("Ratio")
					create hb
					hb.set_border_width (5)
					hb.set_padding (5)

					create text_field
					text_field.disable_edit
					hb.extend (text_field)

					create vb_min
					vb_min.set_padding (5)
						create new_button
						new_button.select_actions.extend (~preset)
						new_button.set_minimum_size (22, 22)
						new_button.set_tooltip ("New metric")
						new_button.set_pixmap (Pixmaps.Icon_new_metric @ 1)
						new_button.key_press_actions.extend (~dialog_key_press_action (?, new_button))
						vb_min.extend (new_button)
						vb_min.disable_item_expand (new_button)

						create {EV_CELL} ev_any
						vb_min.extend (ev_any)
					
					hb.extend (vb_min)
					hb.disable_item_expand (vb_min)
				frame.extend (hb)
				extend (frame)

				create frame.make_with_text ("Percentage")
					create hb
					hb.set_border_width (5)
					hb.set_padding (5)

					create percentage_button
					percentage_button.select_actions.extend (~enable_save)
					hb.extend (percentage_button)
					hb.disable_item_expand (percentage_button)

					create label.make_with_text ("Display as percentage.")
					hb.extend (label)
					hb.disable_item_expand (label)

				frame.extend (hb)
				extend (frame)
				disable_item_expand (frame)

				formula.extend (first_metric_combobox.text)
				formula.extend (divide)
				formula.extend (second_metric_combobox.text)
				displayed_metric := first_metric_combobox.text + " / " +
									second_metric_combobox.text
				text_field.set_text (displayed_metric)
				if first_metric_combobox.selected_item /= Void then
					first_metric_combobox.selected_item.disable_select
				end
				num_definition_field.set_text ("Basic metric")
				if second_metric_combobox.selected_item /= Void then
					second_metric_combobox.selected_item.disable_select
				end

				create scope_info
				min_scope := scope_info.Feature_scope

				name_field.key_press_actions.extend (~following_widget (?, first_metric_combobox))
				first_metric_combobox.key_press_actions.extend (~following_widget (?, second_metric_combobox))
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

	num_definition_field: EV_TEXT_FIELD
		-- Text field to display definition of selected metric from `first_metric_combobox'.

	den_definition_field: EV_TEXT_FIELD
		-- Text field to display definition of selected metric from `second_metric_combobox'.

	first_metric_combobox: EV_COMBO_BOX
		-- Combo box to display available metrics for numerator definition.
		
	second_metric_combobox: EV_COMBO_BOX
		-- Combo box to display available metrics for denominator definition.

	new_button: EV_BUTTON
		-- Button that allows defining new linear metric by restting all fields.

	percentage_button: EV_CHECK_BUTTON
		-- Button that allows displaying measure for `Current' in percentage mode.

	percentage: BOOLEAN is
			-- Is `percentage_button' selected?
		do
			Result := percentage_button.is_selected
		end

	divide: STRING is " / "
		-- Operator /.
		
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
			if name_field.text /= Void then
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
			-- Did user start defining new ratio metric?
		do
			Result := (text_field.text /= Void and then not text_field.text.is_empty)
					or (name_field.text /= Void and then not name_field.text.is_empty)
		end

feature -- Metric constituents

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
			tree := interface.tool.file_handler.build_operator (metric_definition, False, True, False, new_metric_successful)
			create Result.make (a_name, a_unit, tree, interface.tool, min_scope)
			Result.set_metric_ratio (True)
			Result.set_percentage (percentage)
		ensure then
			metric_built: Result /= Void
			ratio_metric: Result.is_metric_ratio and not Result.is_linear and not Result.is_scope_ratio
		end

	new_metric_element: XML_ELEMENT is
			-- Build a storable definition for the metric being saved.
		require else
			entered_formula: text_field.text /= Void and then not not text_field.text.is_empty
			displayed_metric_set: displayed_metric /= Void and then not not displayed_metric.is_empty
			formula_set: formula /= Void and then not formula.is_empty
		local
			a_name, a_unit: STRING
			xml_elements_def_list : LINKED_LIST [XML_ELEMENT]
			xml_attribute: XML_ATTRIBUTE
		do
			a_name := name_field.text
			a_unit := unit_field.text
			Result := interface.tool.file_manager.metric_element (a_name, a_unit, "MRatio")
			create xml_attribute.make ("Percentage", percentage.out)
			Result.attributes.add_attribute (xml_attribute)
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
					Result := Result and metric_definition.count = 3
					inspect i 
						when 1 then
							Result := Result and equal (a_name, "METRIC") and not (element_by_name (metric_definition, "METRIC")).is_empty
							metric := interface.tool.metric (interface.tool.file_handler.content_of_node (sub_node))
							Result := Result and metric /= Void
						when 2 then
							Result := Result and equal (a_name, "METRIC") and not (element_by_name (metric_definition, "METRIC")).is_empty
							metric := interface.tool.metric (interface.tool.file_handler.content_of_node (sub_node))
							Result := Result and metric /= Void
						when 3 then
							Result := Result and equal (a_name, "OPERATOR") and not (element_by_name (metric_definition, "OPERATOR")).is_empty
							op := interface.tool.file_handler.content_of_node (sub_node)
							Result := Result and equal (op, " / ")
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
			metric_object: EB_METRIC
		do
			create Result.make
			operator := ""
			from
				sub_formula.start
			until
				sub_formula.after
			loop
				if equal (sub_formula.item, divide) then
					operator := clone (sub_formula.item)
					sub_formula.forth
				elseif interface.tool.metric (sub_formula.item) /= Void then
						-- Retrieve min_scope of metric_object.
					metric_object := interface.tool.metric (sub_formula.item)
					min_scope := min_scope.max (metric_object.min_scope)
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

feature -- Ratio action.

	add_num_action is
			-- Replace displayed numerator with `first_metric_combobox.text'
		local
			old_num: STRING
		do
			if first_metric_combobox.text /= Void then
				old_num := formula @ 1
				displayed_metric.tail (displayed_metric.count - old_num.count)
				formula.put_i_th (first_metric_combobox.text, 1)
				displayed_metric := first_metric_combobox.text + displayed_metric
				text_field.set_text (displayed_metric)
				enable_save
			end
		ensure
			num_changed: equal (formula @ 1, first_metric_combobox.text)
		end

	add_den_action is
			-- Replace displayed denominator with `second_metric_combobox.text'
		local
			old_den: STRING
		do
			if second_metric_combobox.text /= Void then
				old_den := formula @ 3
				displayed_metric.head (displayed_metric.count - old_den.count)
				formula.put_i_th (second_metric_combobox.text, 3)
				displayed_metric := displayed_metric + second_metric_combobox.text
				text_field.set_text (displayed_metric)
				enable_save
			end
		ensure
			den_changed: equal (formula @ 3, second_metric_combobox.text)
		end

	display_formula (a_combobox: EV_COMBO_BOX; a_definition_field: EV_TEXT_FIELD) is
			-- Display `a_combobox' selected item formula in `a_definition_field'.
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
			else
				key := interface.tool.metrics.index_of (other_metric, 1) - interface.tool.nb_basic_metrics
				xml_location ?= interface.tool.user_metrics_xml_list.i_th (key)
				corresponding_formula := xml_string (xml_location, "FORMULA")
			end
			a_definition_field.set_text (corresponding_formula)
			enable_save
		ensure
			definition_set: a_definition_field.text /= Void and then not a_definition_field.text.is_empty
		end

feature -- Update dialogs

	update_displayed_dialogs is
			-- Update metrics in `manage' and `new_metric' dialogs.
		require
			dialog_displayed: interface.new_metric_definition_dialog.is_displayed
		local
			first_selected_item, second_selected_item: EV_LIST_ITEM
		do
			first_selected_item := first_metric_combobox.selected_item
			second_selected_item := second_metric_combobox.selected_item
			first_metric_combobox.wipe_out
			interface.fill_metric_combobox (first_metric_combobox)
			put_item_with_text (first_metric_combobox, first_selected_item.text)
			second_metric_combobox.wipe_out
			interface.fill_metric_combobox (second_metric_combobox)
			put_item_with_text (second_metric_combobox, second_selected_item.text)
		end

feature -- Reinitialize

	preset is
			-- Reset fields and useful objects
		local
			scope_info: EB_METRIC_SCOPE_INFO
		do
			Precursor
			enable_save
			first_metric_combobox.wipe_out
			interface.fill_metric_combobox (first_metric_combobox)
			first_metric_combobox.first.enable_select
			num_definition_field.set_text ("Basic metric")
			second_metric_combobox.wipe_out
			interface.fill_metric_combobox (second_metric_combobox)
			second_metric_combobox.first.enable_select
			add_num_action
			add_den_action
			den_definition_field.set_text ("Basic metric")
			if percentage_button.is_selected then
				percentage_button.toggle
			end
			create scope_info
			min_scope := scope_info.Feature_scope
		end

end -- class EB_METRIC_RATIO_TAB

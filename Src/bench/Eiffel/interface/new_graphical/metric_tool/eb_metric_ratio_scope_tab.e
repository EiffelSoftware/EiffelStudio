indexing
	description: "Tab to compose a ratio metric definition over two scopes."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_RATIO_SCOPE_TAB

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
			-- Tab to compose a ratio metric over different scopes.
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

				create frame.make_with_text ("Metric")
					create vb_min
					vb_min.set_border_width (5)
					vb_min.set_padding (5)
						create metric_combobox
						metric_combobox.set_minimum_width (140)
						interface.fill_metric_combobox (metric_combobox)
						metric_combobox.first.enable_select
						metric_combobox.disable_edit
						metric_combobox.select_actions.extend (~select_metric)
						metric_combobox.key_press_actions.extend (~dialog_key_press_action (?, metric_combobox))
						vb_min.extend (metric_combobox)
						vb_min.disable_item_expand (metric_combobox)

						create label.make_with_text ("Formula:")
						label.align_text_left
						vb_min.extend (label)
						vb_min.disable_item_expand (label)

						create definition_field
						definition_field.disable_edit
						definition_field.set_minimum_width (140)
						vb_min.extend (definition_field)
						vb_min.disable_item_expand (definition_field)

						metric_combobox.select_actions.extend (~display_formula (metric_combobox, definition_field))

					frame.extend (vb_min)
				extend (frame)
				disable_item_expand (frame)

				create hb
				hb.set_padding (3)
				create frame.make_with_text ("Numerator")
					create vb_min
					vb_min.set_border_width (5)
					vb_min.set_padding (5)
						create label.make_with_text ("Scope:")
						label.align_text_left
						vb_min.extend (label)
						vb_min.disable_item_expand (label)

						create first_scope_combobox
						first_scope_combobox.set_minimum_width (140)
						fill_scope_combobox (first_scope_combobox)
						first_scope_combobox.disable_edit
						first_scope_combobox.select_actions.extend (~add_num_action)
						first_scope_combobox.key_press_actions.extend (~dialog_key_press_action (?, first_scope_combobox))
					vb_min.extend (first_scope_combobox)

					frame.extend (vb_min)
				hb.extend (frame)

				create frame.make_with_text ("Denominator")
					create vb_min
					vb_min.set_border_width (5)
					vb_min.set_padding (5)
						create label.make_with_text ("Scope:")
						label.align_text_left
						vb_min.extend (label)
						vb_min.disable_item_expand (label)

						create second_scope_combobox
						second_scope_combobox.set_minimum_width (140)
						fill_scope_combobox (second_scope_combobox)
						second_scope_combobox.select_actions.extend (~add_den_action)
						second_scope_combobox.key_press_actions.extend (~dialog_key_press_action (?, second_scope_combobox))
						second_scope_combobox.disable_edit
						vb_min.extend (second_scope_combobox)

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

				formula.extend (metric_combobox.first.text)
				formula.extend (first_scope_combobox.text)
				formula.extend (divide)
				formula.extend (second_scope_combobox.text)
				displayed_metric := metric_combobox.first.text + " (" + first_scope_combobox.text +
						 ") / " + metric_combobox.first.text + " (" + second_scope_combobox.text+ ")"
				text_field.set_text (displayed_metric)
				definition_field.set_text ("Basic metric")
				if metric_combobox.selected_item /= Void then
					metric_combobox.selected_item.disable_select
				end
				create scope_info
				min_scope := scope_info.System_scope

				name_field.key_press_actions.extend (~following_widget (?, metric_combobox))
				metric_combobox.key_press_actions.extend (~following_widget (?, first_scope_combobox))
				first_scope_combobox.key_press_actions.extend (~following_widget (?, second_scope_combobox))
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

	first_scope_combobox: EV_COMBO_BOX
		-- Combo box to display available scopes for numerator definition.
		
	second_scope_combobox: EV_COMBO_BOX
		-- Combo box to display available scopes for denominator definition.
		
	metric_combobox: EV_COMBO_BOX
		-- Combo box to display available metrics.

	text_field: EV_TEXT_FIELD
		-- Text field to display `displayed_metric'.

	definition_field: EV_TEXT_FIELD
		-- Text field to display definition of selected metric from `metric_combobox'.

	new_button: EV_BUTTON
		-- Button that allows defining new linear metric by restting all fields.

	percentage_button: EV_CHECK_BUTTON
		-- Button that allows displaying measure for `Current' in percentage mode.

	percentage: BOOLEAN is
			-- Is `percentage_button' selected?
		do
			Result := percentage_button.is_selected
		end

	empty_formula: BOOLEAN
		-- Is `formula' empty?

	divide: STRING is " / "
		-- Operator /.
		
feature -- Errors rescue

	error: BOOLEAN is
			-- Is there any error in `Current' definition?
			-- Error could be an empty name or an empty formula or
			-- choosing a name previously used to define a metric.
		local
			basic_metric: EB_METRIC_BASIC
			nm: STRING
		do
			nm := name_field.text
			error_name := nm = Void or else nm.is_empty
			if not error_name then
				error_name := nm.has ('<') or nm.has ('>')
			end
			empty_formula := text_field.text = Void or else text_field.text.is_empty
			if nm /= Void then
				basic_metric ?= interface.tool.metric (nm)
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
													%charaters (<, >).")
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
			Result := (not text_field.text.is_empty)
					or (not name_field.text.is_empty)
		end

feature -- Metric constituents

	new_metric: EB_METRIC_COMPOSITE is
			-- Build new metric regarding entered formula.
			-- Rely on `new_metric_element' that must be called before.
		require else
			correct_metric_definition: valid_metric_definition
		local
			a_name, a_unit, scope_num, scope_den: STRING
			tree: EB_METRIC_VALUE
			scope_element: XML_ELEMENT
		do
			a_name := name_field.text
			a_unit := unit_field.text
			tree := interface.tool.file_handler.build_operator (metric_definition, False, False, True, new_metric_successful)
			create Result.make (a_name, a_unit, tree, interface.tool, min_scope)
			Result.set_scope_ratio (True)
			Result.set_percentage (percentage)
			scope_element ?= metric_definition.item (2)
			scope_num := interface.tool.file_handler.content_of_node (scope_element)
			scope_element ?= metric_definition.item (3)
			scope_den := interface.tool.file_handler.content_of_node (scope_element)
			Result.set_scope_num (interface.tool.scope (scope_num))
			Result.set_scope_den (interface.tool.scope (scope_den))
		ensure then
			metric_built: Result /= Void
			ratio_metric: Result.is_scope_ratio and not Result.is_linear and not Result.is_metric_ratio
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
			Result := interface.tool.file_manager.metric_element (a_name, a_unit, "SRatio")
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
			scope: EB_METRIC_SCOPE
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
						Result := Result and metric_definition.count = 4
						inspect i 
							when 1 then
								Result := Result and equal (a_name, "METRIC") and not (element_by_name (metric_definition, "METRIC")).is_empty
								metric := interface.tool.metric (interface.tool.file_handler.content_of_node (sub_node))
								Result := Result and metric /= Void
							when 2 then
								Result := Result and equal (a_name, "SCOPE") and not (element_by_name (metric_definition, "SCOPE")).is_empty
								scope := interface.tool.scope (interface.tool.file_handler.content_of_node (sub_node))
								Result := Result and metric /= Void
							when 3 then
								Result := Result and equal (a_name, "SCOPE") and not (element_by_name (metric_definition, "SCOPE")).is_empty
								scope := interface.tool.scope (interface.tool.file_handler.content_of_node (sub_node))
								Result := Result and metric /= Void
							when 4 then
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
					if metric_object.min_scope > min_scope then
						min_scope := metric_object.min_scope
					end
					Result.extend (xml_node (a_metric_definition, "METRIC", sub_formula.item))
					sub_formula.forth
					if not equal (operator, "") then
						Result.extend (xml_node (a_metric_definition, "OPERATOR", operator))
						operator := ""
					end
				elseif interface.tool.scope (sub_formula.item) /= Void then
					min_scope := min_scope.min (interface.tool.scope (sub_formula.item).index)
					Result.extend (xml_node (a_metric_definition, "SCOPE", sub_formula.item))
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

feature -- Action

	fill_scope_combobox (combobox: EV_COMBO_BOX) is
			-- Adjust content regarding selected metric to display
			-- available scopes for metric calculation.
		require
			existing_combobox: combobox /= Void
			existing_metric: metric_combobox.text /= Void and then not metric_combobox.text.is_empty
		local
			scope_item: EV_LIST_ITEM
			selected_metric: EB_METRIC
			old_text: STRING
			scope_info: EB_METRIC_SCOPE_INFO
		do
			combobox.select_actions.block
			old_text := combobox.text
			create scope_info
			selected_metric := interface.tool.metric (metric_combobox.text)
			combobox.wipe_out
			from
				interface.tool.scopes.start
			until
				interface.tool.scopes.after
			loop
				if selected_metric.min_scope <= interface.tool.scopes.item.index
					and interface.tool.scopes.item.index /= scope_info.Archive_scope then
					create scope_item.make_with_text (interface.tool.scopes.item.name)
					combobox.extend (scope_item)
				end
				interface.tool.scopes.forth
			end
			combobox.select_actions.resume
			if combobox.selected_item /= Void then
				combobox.selected_item.disable_select
			end
			if has_old_text (combobox, old_text) then
				put_item_with_text (combobox, old_text)
			else
				combobox.first.enable_select
			end
		end

	has_old_text (combobox: EV_COMBO_BOX; old_text: STRING): BOOLEAN is
			-- Has `combobox' `old_text'?
			-- This is called whenever scopes changes to change displayed item
			-- if no longer included in `combobox'.
		require
			existing_combobox: combobox /= Void
		do
			from
				combobox.start
			until
				combobox.after
			loop
				Result := Result or equal (combobox.item.text, old_text)
				combobox.forth
			end
		end

	select_metric is
			-- Select metric in `metric_combobox' and adjust scope combo boxes
			-- to display scopes selected metric can be evaluated over.
			-- Adjust displayed formula.
		require
			metric_selected: not metric_combobox.text.is_empty
		do
			formula.put_i_th (metric_combobox.text, 1)
			fill_scope_combobox (first_scope_combobox)
			fill_scope_combobox (second_scope_combobox)
			add_num_action
			add_den_action
		ensure
			metric_changed: equal (formula @ 1, metric_combobox.text)
		end

	add_num_action is
			-- Replace displayed numerator with `first_scope_combobox.text'
		local
			ind: INTEGER
		do
			if not first_scope_combobox.text.is_empty then
				ind := displayed_metric.index_of (')', 1)
				displayed_metric.tail (displayed_metric.count - ind)
				formula.put_i_th (first_scope_combobox.text, 2)
				displayed_metric := metric_combobox.text + " (" + first_scope_combobox.text + ")" + displayed_metric
				text_field.set_text (displayed_metric)
				enable_save
			end
		ensure
			num_changed: equal (formula @ 2, first_scope_combobox.text)
		end

	add_den_action is
			-- Replace displayed denominator with `second_scope_combobox.text'
		local
			ind: INTEGER
		do
			if not second_scope_combobox.text.is_empty then
				ind := displayed_metric.index_of ('/', 1) + 1
				displayed_metric.head (ind)
				formula.put_i_th (second_scope_combobox.text, 4)
				displayed_metric := displayed_metric + metric_combobox.text + " (" + second_scope_combobox.text + ")"
				text_field.set_text (displayed_metric)
				enable_save
			end
		ensure
			den_changed: equal (formula @ 4, second_scope_combobox.text)
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
		end

feature -- Update dialogs

	update_displayed_dialogs is
			-- Update metrics in `manage' and `new_metric' dialogs.
		require
			dialog_displayed: interface.new_metric_definition_dialog.is_displayed
		local
			metric_item: EV_LIST_ITEM
		do
			metric_item := metric_combobox.selected_item
			metric_combobox.select_actions.block
			metric_combobox.wipe_out
			interface.fill_metric_combobox (metric_combobox)
			put_item_with_text (metric_combobox, metric_item.text)
			metric_combobox.select_actions.resume
		end

feature -- Reinitialize

	preset is
			-- Reset fields and useful objects
		local
			scope_info: EB_METRIC_SCOPE_INFO
		do
			Precursor
			enable_save
			definition_field.set_text ("Basic metric")
			metric_combobox.select_actions.block
			metric_combobox.wipe_out
			interface.fill_metric_combobox (metric_combobox)
			metric_combobox.first.enable_select
			metric_combobox.select_actions.resume
			fill_scope_combobox (first_scope_combobox)
			fill_scope_combobox (second_scope_combobox)

			add_num_action
			add_den_action
			if percentage_button.is_selected then
				percentage_button.toggle
			end
			create scope_info
			min_scope := scope_info.System_scope
		end

end -- class EB_METRIC_RATIO_SCOPE_TAB

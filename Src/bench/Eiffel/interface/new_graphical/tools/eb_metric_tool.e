indexing
	description: "Area in EB_CONTEXT_TOOL to display metrics calculation."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TOOL

inherit
	SHARED_WORKBENCH

	SHARED_XML_ROUTINES

	EB_CONSTANTS

	EB_METRIC_OBSERVER
		redefine
			recycle
		end

	EB_METRIC_SCOPE_INFO

create
	make

feature -- Initialization

	make (dw: EB_DEVELOPMENT_WINDOW; ctxt_tl: EB_CONTEXT_TOOL) is
			-- Initialize `Current'.
		local
			hb: EV_HORIZONTAL_BOX
		do
			create widget
			build_tool_bar
			create hb
			hb.extend (text_area)
			widget.extend (hb)
			widget.disable_item_expand (hb)
			create sep
			widget.extend (sep)
			widget.disable_item_expand (sep)
			widget.extend (multi_column_list)
			create file_handler.make (Current, file_manager)
			is_calculation_done := False
			is_file_loaded := False
			min_scope_available := System_scope
			default_archive := True
			archive_mode := "default"
			file_manager.add_observer (Current)
			development_window := dw
			context_tool := ctxt_tl
			multi_column_list.drop_actions.extend (context_tool~launch_stone)
		end

feature -- Implementation

	build_tool_bar is
			-- Build a tool bar for metrics.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			scope_label, metric_label, name_label, unit_label: EV_LABEL
			custom_toolbar: EB_TOOLBAR
			scope_item: EV_LIST_ITEM
			basic_metrics: EB_METRIC_BASIC_FACTORY
			available_scopes: EB_METRIC_SCOPE
			separ: EB_TOOLBARABLE_SEPARATOR
		do
				-- Insert comboboxes for setting metric's parameters.
			create hb

			create name_label.make_with_text ("Name ")
			hb.extend (name_label)
			hb.disable_item_expand (name_label)
			create vb
				create name
				name.set_minimum_size (70, 22)
				name.key_press_string_actions.extend (~enable_add)
				vb.extend (name)
				vb.disable_item_expand (name)
			hb.extend (vb)
			hb.disable_item_expand (vb)

			create scope_label.make_with_text (" Scope ")
			create scope_combobox
			scope_combobox.set_minimum_size (80, 26)
			scope_combobox.select_actions.extend (~scope_action)
			scope_combobox.disable_edit
			create scopes.make

				-- `available_scopes' is created just to call `list_of_scopes'.
			create available_scopes
			scopes := available_scopes.list_of_scopes

			hb.extend (scope_label)
			hb.disable_item_expand (scope_label)
			hb.extend (scope_combobox)
			hb.disable_item_expand (scope_combobox)

			create metric_label.make_with_text (" Metric ")
			create metric_field
			hb.extend (metric_label)
			hb.disable_item_expand (metric_label)

			create vb
				metric_field.set_minimum_size (140, 22)
				metric_field.set_text (interface_names.metric_classes)
				metric_field.pointer_button_release_actions.extend (~metric_field_display_metric_menu)
				metric_field.disable_edit
				vb.extend (metric_field)
				vb.disable_item_expand (metric_field)
			hb.extend (vb)
			hb.disable_item_expand (vb)

			create vb
				vb.set_border_width (1)
				create metric_button
				metric_button.set_pixmap (Pixmaps.Icon_down_triangle)
				metric_button.select_actions.extend (~display_metric_menu)
				metric_button.set_minimum_size (15, 20)
				vb.extend (metric_button)
				vb.disable_item_expand (metric_button)
			hb.extend (vb)
			hb.disable_item_expand (vb)

				-- `basic_metric' is created just to call features of EB_METRIC_BASIC.
			create basic_metrics

				-- unit of selected metric
			create unit_label.make_with_text ("Unit ")
			create unit_field
			hb.extend (unit_label)
			hb.disable_item_expand (unit_label)

			create vb
				unit_field.disable_edit
				unit_field.set_text (interface_names.metric_class_unit)
				unit_field.set_minimum_size (85, 22)
				vb.extend (unit_field)
				vb.disable_item_expand (unit_field)
			hb.extend (vb)
			hb.disable_item_expand (vb)

				-- Insert buttons in tool bar (calculate, add, delete, details).
			hb.extend (create {EV_CELL})
			create custom_toolbar
			create calculate.make (Current)
			calculate.enable_displayed
			custom_toolbar.extend (calculate)
			create add.make (Current)
			add.enable_displayed
			custom_toolbar.extend (add)
			add.disable_sensitive
			create delete.make (Current)
			delete.enable_displayed
			custom_toolbar.extend (delete)
			details_hidden := True
			create details.make (Current)
			custom_toolbar.extend (details)
			details.enable_displayed
			details.disable_sensitive

			create separ
			custom_toolbar.extend (separ)
			create new_metric.make (Current)
			new_metric.enable_displayed
			custom_toolbar.extend (new_metric)
			create manage.make (Current)
			manage.enable_displayed
			custom_toolbar.extend (manage)
			create archive.make (Current)
			custom_toolbar.extend (archive)
			archive.enable_displayed
			custom_toolbar.update_toolbar

			hb.extend (custom_toolbar.widget)
			hb.disable_item_expand (custom_toolbar.widget)

			widget.extend (hb)
			widget.disable_item_expand (hb)

			create sep
			widget.extend (sep)
			widget.disable_item_expand (sep)

			create metrics.make
			create user_metrics_xml_list.make
			metrics := basic_metrics.list_of_basic_metrics (Current)
			nb_basic_metrics := metrics.count
			raw_metric_list := basic_metrics.raw_metric_list
			derived_metric_list := basic_metrics.derived_metric_list

			scope_combobox.select_actions.block
			create scope_item.make_with_text (scope (interface_names.metric_this_system).name)
			scope_combobox.extend (scope_item)
			create scope_item.make_with_text (scope (interface_names.metric_this_archive).name)
			scope_combobox.extend (scope_item)
			scope_combobox.select_actions.resume
		end

	on_select is
			-- Load files when possible
		do
			is_shown := True
			if must_set_stone then
				set_stone (stone_to_set)
			end
			if widget.is_sensitive then
				file_handler.load_files
				enable_commands_in_toolbar
			end
			if is_recompiled then
				set_recompilation
				is_recompiled := False
			end
		end
	
	on_deselect is
			-- 
		require
			tool_built: development_window.metric_menu /= Void
		do
			is_shown := False
			development_window.metric_menu.disable_sensitive
		end

	set_focus is
			-- Give the focus to the metrics.
		require
			focusable: widget.is_displayed and widget.is_sensitive
		do
			name.set_focus
		end

feature -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Application main window.

	context_tool: EB_CONTEXT_TOOL
			-- Container of `Current'.

	sep: EV_HORIZONTAL_SEPARATOR
			-- Must be attribute instead of local variable because of hidding on details' display.

	name_index: INTEGER
			-- Current calculated metric's number (e.g. 7 for "Metric7").

	name: EV_TEXT_FIELD
			-- Text field to give a name to currently calculated metric.

	unit_field: EV_TEXT_FIELD
			-- Text field to display unit of selected metric.

	new_metric: EB_METRIC_NEW_DEFINITION_CMD
			-- Command to add new metric formula.

	calculate: EB_METRIC_CALCULATE_CMD
			-- Command to calculate current metric.

	add: EB_METRIC_ADD_CMD
			-- Command to add current metric to `multi_column_list'.

	delete: EB_METRIC_DELETE_CMD
			-- Command to delete selected metric(s) from `multi_column_list'.

	details: EB_METRIC_DETAILS_CMD
			-- Command to display details of current metric.

	archive: EB_METRIC_ARCHIVE_COMPARISON_CMD
			-- Command to display details of current metric.

	manage: EB_METRIC_MANAGEMENT_CMD
			-- Command to display interface for reordering, deleting, editing
			-- or importing metrics.
			
	file_handler: EB_METRIC_FILE_HANDLER
			-- Pointer to hanle `file_manager.metric_file'.
	
	calculate_cmd_in_menu: EV_MENU_ITEM
			-- Menu command to calculate current metric.

	add_cmd_in_menu: EV_MENU_ITEM
			-- Menu command to add current metric to `multi_column_list'.
	
	delete_cmd_in_menu: EV_MENU_ITEM
			-- Menu command to delete selected metric(s) from `multi_column_list'.
	
	details_cmd_in_menu: EV_MENU_ITEM
			-- Menu command to display details of current metric.

	new_metric_cmd_in_menu: EV_MENU_ITEM
			-- Menu command to add new metric formula.
	
	manage_cmd_in_menu: EV_MENU_ITEM
			-- Menu command to display interface for reordering, deleting, editing
			-- or importing metrics.

	archive_cmd_in_menu: EV_MENU_ITEM
			-- Menu command to display details of current metric.

feature -- Scope

	scope_combobox: EV_COMBO_BOX
			-- Combobox containing all possible scopes.

	selected_scope: STRING
			-- Currently selected scope.

	set_selected_scope (str: STRING) is
			-- Assign `str' to `selected_scope'.
		require
			correct_scope: str /= Void and then (scope (str) /= Void)
		do
			selected_scope := str
		ensure
			scope_set: scope (selected_scope) /= Void
		end

	scope (str: STRING): EB_METRIC_SCOPE is
			-- Return the scope object whose name is `str'.
		local
			cursor: CURSOR
		do
			cursor := scopes.cursor
			from
				scopes.start
			until
				scopes.after or Result /= Void
			loop
				if equal (scopes.item.name, str) then
					Result := scopes.item
				end
				scopes.forth
			end
			scopes.go_to (cursor)
		end

	scopes: LINKED_LIST [EB_METRIC_SCOPE]
		-- List of all scopes already defined. They are not necessarily displayed in
		-- `scope_combobox' at any time.

feature -- Metric

	enable_commands_in_toolbar is
			-- 
		local
			toolbar_menu: EV_MENU
		do
			toolbar_menu := development_window.metric_menu
			toolbar_menu.enable_sensitive
			from 
				toolbar_menu.start
			until
				toolbar_menu.after
			loop
				toolbar_menu.item.select_actions.wipe_out
				if equal (toolbar_menu.item.text, interface_names.metric_calculate) then
					toolbar_menu.item.select_actions.extend (agent calculate.execute)
					calculate_cmd_in_menu := toolbar_menu.item
				elseif equal (toolbar_menu.item.text, interface_names.metric_add) then
					toolbar_menu.item.select_actions.extend (agent add.execute)
					add_cmd_in_menu := toolbar_menu.item
					toolbar_menu.item.disable_sensitive
				elseif equal (toolbar_menu.item.text,interface_names.metric_delete) then
					toolbar_menu.item.select_actions.extend (agent delete.execute)
					delete_cmd_in_menu := toolbar_menu.item
				elseif equal (toolbar_menu.item.text, interface_names.metric_details) then
					toolbar_menu.item.select_actions.extend (agent details.execute)
					details_cmd_in_menu := toolbar_menu.item
					toolbar_menu.item.disable_sensitive
				elseif equal (toolbar_menu.item.text, interface_names.metric_new_metrics) then
					toolbar_menu.item.select_actions.extend (agent new_metric.execute)
					new_metric_cmd_in_menu := toolbar_menu.item
				elseif equal (toolbar_menu.item.text, interface_names.metric_management) then
					toolbar_menu.item.select_actions.extend (agent manage.execute)
					manage_cmd_in_menu := toolbar_menu.item
				elseif equal (toolbar_menu.item.text, interface_names.metric_archive) then
					toolbar_menu.item.select_actions.extend (agent archive.execute)
					archive_cmd_in_menu := toolbar_menu.item
				end
				toolbar_menu.forth
			end
		end

	metric_menu: EV_MENU
		-- Menu to display all available metrics.

	metric_menu_item (a_text: STRING): EV_MENU_ITEM is
			-- Find item whose text is `a_text' in `metric_menu'.
		require
			metric_menu_not_empty: metric_menu /= Void and then not metric_menu.is_empty
		local
			parent_menu: EV_MENU
		do
			from
				metric_menu.start
			until
				metric_menu.after or Result /= Void
			loop
				parent_menu ?= metric_menu.item
				if equal (metric_menu.item.text, a_text) then
					Result := metric_menu.item
				elseif parent_menu /= Void then
					from parent_menu.start until parent_menu.after or Result /= Void loop
						if equal (parent_menu.item.text, a_text) then
							Result := parent_menu
						end
						parent_menu.forth
					end
				end
				metric_menu.forth
			end
		end

	fill_metric_menu is
			-- Fill `metric_menu' with all available metrics.
		require
			effective_metrics: metrics /= Void and then not metrics.is_empty
			has_all_basic_metrics: metrics.count >= nb_basic_metrics
		local
			basic_metrics: EB_METRIC_BASIC_FACTORY
			metric_composite: EB_METRIC_COMPOSITE
			menu_item: EV_MENU_ITEM
		do
			create basic_metrics
			if metric_menu /= Void then
				metric_menu.destroy
			end
			metric_menu := basic_metrics.metric_menu
			from
				metrics.go_i_th (nb_basic_metrics + 1)
			until
				metrics.after
			loop
				metric_composite ?= metrics.item
				create menu_item.make_with_text (metrics.item.name)
				metric_menu.extend (menu_item)
				metrics.forth
			end
		end

	metric_button: EV_BUTTON
		-- Button to display `metric_menu'.

	metric_field: EV_TEXT_FIELD
		-- Field to display the currently selected metric.

	selected_metric: STRING
		-- Currently selected metric.

	set_selected_metric (str: STRING) is
			-- Assign `str' to `selected_metric'.
		require
			correct_metric: str /= Void and then (metric (str) /= Void)
		do
			selected_metric := str
		ensure
			metric_set: metric (selected_metric) /= Void
		end

	metric (str: STRING): EB_METRIC is
			-- Return metric object whose name is `str'.
		local
			cursor: CURSOR
		do
			cursor := metrics.cursor
			from
				metrics.start
			until
				metrics.after or Result /= Void
			loop
				if equal (metrics.item.name, str) then
					Result := metrics.item
				end
			metrics.forth
			end
			metrics.go_to (cursor)
		end

	metrics: LINKED_LIST [EB_METRIC]
		-- List of all metrics (basic or not) previously defined. They are not necessarily
		-- sensitive in `metric_menu' at any time.

	raw_metric_list: LINKED_LIST [EB_METRIC]
		-- List of basic metrics displayed in main menu of `metric_menu'.

	derived_metric_list: LINKED_LIST [EB_METRIC]
		-- List of basic metrics displayed in sub-menus of `metric_menu'.

	user_metrics_xml_list: LINKED_LIST [XML_ELEMENT]
		-- List of composite metric definitions, as stored in `file_manager.metric_file'.

	nb_basic_metrics: INTEGER
		-- Number of basic metrics.

	open_dialog: EV_FILE_OPEN_DIALOG
		-- Dialog to select an archive file.

	archive_for_measure: STRING
		-- Name of selected archive metric calculation will apply to.

feature -- Combo box and field action.

	display_metric_menu is
			-- Show `metric_menu'.
		do
			if scope (scope_combobox.text).index /= Archive_scope then
				adjust_metric (scope (scope_combobox.text).index)
			else
				fill_metric_menu
				enable_metric_menu (metric_menu)
			end
			metric_menu.show_at (metric_field, 0, metric_field.height)
		end

	metric_field_display_metric_menu (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Show `metric_menu' on left click on `metric_field'.
		do
			if button = 1 then
				display_metric_menu
			end
		end

	enable_metric_menu (a_menu: EV_MENU) is
			-- Assign an action to each item of `a_menu'.
		require
			concrete_menu: a_menu /= Void
		local
			sub_menu: EV_MENU
		do
			from
				a_menu.start
			until
				a_menu.after
			loop
				sub_menu ?= a_menu.item
				if sub_menu /= Void then
					enable_metric_menu (sub_menu)
				else
					a_menu.item.select_actions.extend (~metric_action (a_menu.item))
				end
				a_menu.forth
			end
		end

	metric_action (a_metric_menu_item: EV_MENU_ITEM) is
			-- Action to be performed on `metric_menu': set metric name in `metric_field,
			-- display unit, handle `details' button.
		require
			concrete_item: a_metric_menu_item /= Void
		local
			parent_menu: EV_MENU
		do
			if not equal (a_metric_menu_item.text, interface_names.metric_all) then
				metric_field.set_text (a_metric_menu_item.text)
			else
				parent_menu ?= a_metric_menu_item.parent
				if parent_menu /= Void then
					metric_field.set_text (parent_menu.text)
				end
			end
			unit_field.set_text (metric (metric_field.text).unit)
			selected_metric := metric_field.text
			calculate.handle_details
		end

	scope_action is
			-- Action to be performed on `scope_combobox': enable metrics regarding selected selected scope.
		local
			index: INTEGER
		do
			index := scope (scope_combobox.text).index
			if index < Archive_scope then
				adjust_metric (index)
			else
				select_archive_for_measure
				fill_metric_menu
				enable_metric_menu (metric_menu)
				from metric_menu.start until metric_menu.after loop
					metric_menu.item.enable_sensitive
					metric_menu.forth
				end
			end
		end

	adjust_metric (index: INTEGER) is
			-- Fix `metric_menu' items' sensitiveness regarding currently selected scope.
		require
			correct_range: index >= Feature_scope and index <= System_scope
		local
			metric_item: EV_MENU_ITEM
			composite_metric: EB_METRIC_COMPOSITE
			derived_metric: EB_METRIC_DERIVED
			enable_metric_selection: BOOLEAN
			index_in_menu: INTEGER
		do
			fill_metric_menu
			enable_metric_menu (metric_menu)
			from metric_menu.start until metric_menu.after loop
				metric_menu.item.disable_sensitive
				metric_menu.forth
			end

			from
				metrics.start
			until
				metrics.after
			loop
				composite_metric ?= metrics.item
				derived_metric ?= metrics.item
				enable_metric_selection := False
				if composite_metric /= Void then
					if composite_metric.is_scope_ratio then
						enable_metric_selection := min_scope_available <= composite_metric.min_scope
					else
						enable_metric_selection := index >= composite_metric.min_scope
					end
						-- Do not forget separator in `metric_menu'!
					index_in_menu := metrics.index_of (metrics.item, 1) - nb_basic_metrics
								+ raw_metric_list.count + 1
				elseif derived_metric /= Void then
					enable_metric_selection := index >= derived_metric.min_scope
					index_in_menu := metrics.index_of (metrics.item, 1) - nb_basic_metrics
								+ raw_metric_list.count + 1
				elseif raw_metric_list.has (metrics.item) then
					enable_metric_selection := index >= metrics.item.min_scope
					index_in_menu := raw_metric_list.index_of (metrics.item, 1)
				end

				if enable_metric_selection then
					metric_menu.i_th (index_in_menu).enable_sensitive
				else
				end
				metrics.forth
			end
			metric_item := metric_menu_item (metric_field.text)
			if metric_item = Void or else not metric_item.is_sensitive then
				display_first_sensitive_metric
			end
		end

	display_first_sensitive_metric is
			-- If currently displayed metric in `metric_field' is no longer available
			-- (because of a change in scope type or scope object), display first
			-- available metric.
		local
			is_first_sensitive: BOOLEAN
		do
			from
				metric_menu.start
			until
				is_first_sensitive or metric_menu.after
			loop
				if metric_menu.item.is_sensitive then
					metric_field.set_text (metric_menu.item.text)
					unit_field.set_text (metric (metric_menu.item.text).unit)
					is_first_sensitive := True
				end
				metric_menu.forth
			end
		ensure
			found_metric: not metric_field.text.is_empty 
		end

	adjust_scope (index: INTEGER) is
			-- Adjust `scope_combobox' regarding the stone dropped in context tool.
		require
			correct_range: index >= Feature_scope and index <= System_scope
		local
			metric_min_scope: INTEGER
			combobox_item: EV_LIST_ITEM
		do
			metric_min_scope := metric (metric_field.text).min_scope
			scope_combobox.wipe_out
			from
				scopes.start
			until
				scopes.after
			loop
				if index <= scopes.item.index then
					create combobox_item.make_with_text (scopes.item.name)
					scope_combobox.extend (combobox_item)
				end
				scopes.forth
			end
			adjust_metric (index)
		end

	enable_add (s: STRING) is
			-- Action to be performed on change of measure's name.
		do
			if s /= Void and then (not add.is_sensitive and is_calculation_done) then
				add.enable_sensitive
			end
		end

feature -- Archive

	default_archive: BOOLEAN
		-- Has no archive been selected ?
		-- (If True, comparison is made to `System', which is default archive).

	set_default_archive (bool: BOOLEAN) is
			-- Assign `bool' to `default_archive'.
		do
			default_archive := bool
		end

	archive_mode: STRING
		-- Comparison mode. Either "default", "difference" or "value".

	set_archive_mode (str: STRING) is
			-- Assign `str' to `archive_mode'
		require
			correct_mode: equal (str, "default") or equal (str, "difference") or equal (str, "value")
		do
			archive_mode := str
		ensure
			mode_set: equal (archive_mode, "default") or equal (archive_mode, "difference")
				or equal (archive_mode, "value")
		end

	select_archive_for_measure is
			-- Open dialog to load an archive file as a scope object for
			-- metric calculation.
		local
			current_directory: STRING
			ee: EXECUTION_ENVIRONMENT
		do
			create open_dialog
			open_dialog.set_filter ("*.xml")
			create ee
			current_directory := ee.current_working_directory
			open_dialog.open_actions.extend (~import_archive_for_measure)
			open_dialog.show_modal_to_window (development_window.window)
			ee.change_working_directory (current_directory)
		end

	import_archive_for_measure is
			-- Store archive name in `archive_for_measure'.
		do
			archive_for_measure := open_dialog.file_name
		end

feature -- Access

	widget: EV_VERTICAL_BOX
			-- Graphical object of `Current'.

	text_area: EV_TEXT_FIELD is
			-- Area to display calculated metrics.
		do
			if internal_text_area = Void then
				create internal_text_area
				internal_text_area.disable_edit
			end
			Result := internal_text_area
		end

	feature_stone: FEATURE_STONE
			-- Stone representing center feature.

	class_stone: CLASSI_STONE
			-- Stone representing center class.

	cluster_stone: CLUSTER_STONE
			-- Stone representing center cluster.	

	metric_result: DOUBLE
		-- Result when a metric calculation is done

	min_scope_available: INTEGER
		-- Index of the lower scope selectable in `scope_combobox'.

feature -- Status setting

	set_stone (a_stone: STONE) is
			-- Change the target of `Current'.
			--| The implementation is delayed for optimization purposes.
		do
			if not is_shown then
				stone_to_set := a_stone
				must_set_stone := True
			else
				must_set_stone := False
				stone_to_set := Void
				real_set_stone (a_stone)
			end
		end

feature -- Selected object

	selected_class: CLASS_C is
			-- Return class object when stone is feature or class.
		do
			 if class_stone /= Void and then class_stone.class_i.compiled_class /= Void then
				Result := class_stone.class_i.compiled_class
			elseif feature_stone /= Void then
				Result := feature_stone.e_feature.written_class
			end
		end

	selected_cluster: CLUSTER_I is 
			-- Return cluster object when stone is feature, class, or cluster.
		do
			if cluster_stone /= Void then
				Result := cluster_stone.cluster_i
			elseif class_stone /= Void then
				Result := class_stone.class_i.cluster
			elseif feature_stone /= Void then
				Result := feature_stone.e_feature.written_class.cluster
			end
		end

feature -- Metric retrieving and setting.
	
	fix_decimals_and_percentage (a_result: DOUBLE; a_percentage: BOOLEAN): STRING is
			-- Adjust decimal part: 3 digits when absolute value of`a_result' is less than 1.
			-- 2 whrn it is greater. Display `a_result' in percentage style if `a_percentage'.
		local
			format_integer: FORMAT_INTEGER
			format_double: FORMAT_DOUBLE
			displayed_result: REAL
			decimals, integer_result: INTEGER
		do
			if a_result = -123456 then
				Result := "Division by 0"
			else
				if not a_percentage then
					displayed_result := a_result
				else
					displayed_result := a_result * 100
				end
				
				if displayed_result.abs >=1 then
					decimals := 2
				else
					decimals := 3
				end
				if displayed_result.out.is_integer then
					create format_integer.make (16)
					integer_result := displayed_result.out.to_integer
					Result := format_integer.formatted (integer_result)
				else
					create format_double.make (16, decimals)
					Result := format_double.formatted (displayed_result)
				end
				if a_percentage then
					Result.append ("%%")
				end
			end
		end

feature -- Status report

	details_hidden: BOOLEAN
		-- Are details hidden?

	is_calculation_done: BOOLEAN
		-- Has calculation been done? Required to diplay or not details.

	is_recompiled: BOOLEAN
		-- Has system been recompiled?

	is_file_loaded: BOOLEAN
		-- Has `metric_file' been loaded?

feature -- Setting

	set_details_hidden (bool: BOOLEAN) is 
			-- Assign `bool' to `details_hidden'.
		do
			details_hidden := bool
		end

	set_calculation_done (bool: BOOLEAN) is 
			-- Assign `bool' to `is_calculation_done'.
		do
			is_calculation_done := bool
		end
	
	set_file_loaded (bool: BOOLEAN) is
			-- Assign `bool' to `is_file_loaded'.
		do
			is_file_loaded := bool
		end

	set_recompiled (bool: BOOLEAN) is
			-- Assign `bool' to `is_recompiled'.
		do
			is_recompiled := bool
			if context_tool.notebook.selected_item = widget and is_recompiled then
				set_recompilation
			end
		end

	set_recompilation is
			-- Add red_cross_pixmap to old compiled rows in `multi_column_list'.
		require
			file_manager_exists: file_manager /= Void
			system_recompiled: is_recompiled
		local
			a_cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			node: XML_ELEMENT
			old_attribute: XML_ATTRIBUTE
			retried: BOOLEAN
		do
			if not retried then
				if  file_manager.metric_file /= Void and then 
					file_manager.metric_file.exists
					and not file_handler.parser_problems then
					a_cursor := file_manager.measure_header.new_cursor
					from
						a_cursor.start
					until
						a_cursor.after
					loop
						node ?= a_cursor.item
						create old_attribute.make ("STATUS", "old")
						if node /= Void then
							node.attributes.replace (old_attribute, "STATUS")
						end
						a_cursor.forth
					end
					file_manager.store
					if file_manager.metric_file /= Void then
						file_manager.measure_notify_all
					end
					file_manager.set_recompiled (False)
				end
			end
		rescue
			retried := True
			retry
		end

	set_metric_result (real: DOUBLE) is
			-- Assign `real' to `metric_result'
		do
			metric_result := real
		end

	set_name_index (int: INTEGER) is
			-- Assign `int' to `name_index'.
		do
			name_index := int
		end

	set_min_scope_available (int: INTEGER) is
			-- Assign `int' to `min_scope_available'.
		do
			min_scope_available := int
		end

	initialize_name_index: INTEGER is
			-- Give a default name to next calculated metrics when metric interface is launched.
		local
			row: EV_MULTI_COLUMN_LIST_ROW
			row_name, metric_part, number_part: STRING
			number: INTEGER
		do
			from
				multi_column_list.start
			until
				multi_column_list.exhausted
			loop
				row := multi_column_list.item
				row_name := clone (row.i_th (1))
				if row_name.count >= 7 then
					metric_part := row_name.substring (1, 6)
					number_part := row_name.substring ( 7, row_name.count)
					if equal (metric_part, "Result") and then number_part.is_integer then
						number := number_part.to_integer
						if number > Result then
							Result := number
						end
					end
				end
				multi_column_list.forth
			end
			Result := Result + 1
		end

feature -- Displayed messages in column list form

	multi_column_list: EV_MULTI_COLUMN_LIST is
			-- Build a column list to display metric results.
		local
			title_array: ARRAY [STRING]
		do
			if internal_multi_column_list = Void then
				create title_array.make (1, 6)
				title_array.put ("Name", 1)
				title_array.put ("Scope type", 2)
				title_array.put ("Scope name", 3)
				title_array.put ("Metric", 4)
				title_array.put ("Result", 5)
				title_array.put ("Comparison to: ", 6)

				create internal_multi_column_list
				internal_multi_column_list.set_column_titles (title_array)
				internal_multi_column_list.align_text_right (5)

				--internal_multi_column_list.align_text_right (6)
				--| Last column is always expanded on gtk.

				internal_multi_column_list.pointer_button_press_actions.extend (~right_click_action)

			end
			Result := internal_multi_column_list
		ensure
			column_list_built: Result /= Void
			column_number: Result.column_count = 6
		end
		
	adjust_columns_size is
			-- Set minimal size for each column when `multi_column_list' is empty.
		require
			empty_column_list: multi_column_list.is_empty
		do
			multi_column_list.set_column_width (40, 1)
			multi_column_list.set_column_width (80, 2)
			multi_column_list.set_column_width (80, 3)
			multi_column_list.set_column_width (42, 4)
			multi_column_list.set_column_width (42, 5)
			multi_column_list.set_column_width (110, 6)		
		end

	right_click_action (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Action performed on right click on `multi_column_list'.
			-- Build a menu to update recorded measures.
		local
			menu: EV_MENU
			menu_item: EV_MENU_ITEM
		do
			if a_button = 3 then
				create menu
				create menu_item.make_with_text ("Update selected row(s)")
				menu_item.select_actions.extend (~update_selected_rows)
				menu.extend (menu_item)

				create menu_item.make_with_text ("Update all rows")
				menu_item.select_actions.extend (~update_all)
				menu.extend (menu_item)

				menu.show
			end
		end

	update_selected_rows is
			-- Update list of selected rows.
		local
			selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
		do
			selected_items := multi_column_list.selected_items
			if not selected_items.is_empty then
				from
					selected_items.start
				until
					selected_items.after
				loop
					update_row (selected_items.item)
					selected_items.forth
				end
			end
		end


	update_row (row: EV_MULTI_COLUMN_LIST_ROW) is
			-- Update `row' if old.
		require
			valid_row: row /= Void
			valid_count: row.count = multi_column_list.column_count
		local
			index_updated_row, n1, n2: INTEGER
			new_result: DOUBLE
			row_scope, row_stone_name, row_metric, row_status, class_name, feature_name, str: STRING
			row_stone_name_num, row_stone_name_den, row_scope_num, row_scope_den, archive_measure: STRING
			a_feature: E_FEATURE
			a_class: CLASS_C
			a_cluster: CLUSTER_I
			xml_element: XML_ELEMENT
			a_composite_metric: EB_METRIC_COMPOSITE
			a_metric: EB_METRIC
			a_percentage, retried: BOOLEAN
			a_scope: EB_METRIC_SCOPE
		do
			if not retried then
				development_window.window.set_pointer_style (development_window.Wait_cursor)
				text_area.remove_text

				index_updated_row := multi_column_list.index_of (row, 1)
				xml_element ?= file_manager.measure_header.item (index_updated_row)
				row_status := xml_element.attributes.item ("STATUS").value
				row_scope := row.i_th (2)
				row_stone_name := clone (row.i_th (3))
				row_metric := row.i_th (4)
				row_stone_name.to_lower
				if equal (row_status, "old") then
					a_composite_metric ?= metric (row_metric)
					if a_composite_metric /= Void and then a_composite_metric.is_scope_ratio then
						row_stone_name_num := row_stone_name.substring (1, row_stone_name.index_of ('/', 1) - 2)
						row_scope_num := row_scope.substring (1, row_scope.index_of ('/', 1) - 2)
						row_stone_name_den := row_stone_name.substring (row_stone_name.index_of ('/', 1) + 2, row_stone_name.count)
						row_scope_den := row_scope.substring (row_scope.index_of ('/', 1) +2, row_scope.count)
						if scope (row_scope_num).index <= scope (row_scope_den).index then
							a_scope := scope (row_scope_num)
							row_stone_name := row_stone_name_num
						else
							a_scope := scope (row_scope_den)
							row_stone_name := row_stone_name_den
						end					
					else
						a_scope := scope (row_scope)
					end
					inspect a_scope.index
					when Feature_scope then
						n1 := row_stone_name.index_of ('(', 1)
						n2 := row_stone_name.index_of (')', 1)
						feature_name := row_stone_name.substring (1, n1 - 2)
						class_name := row_stone_name.substring (n1 + 1, n2 - 1)
						a_feature := e_feature (feature_name, class_name)
						a_class := class_c (class_name)
						class_name.to_upper
						row_stone_name.keep_head (n1)
						row_stone_name.append (class_name + ")")
						a_cluster := a_class.cluster
					when Class_scope then
						a_class := class_c (row_stone_name)
						row_stone_name.to_upper
						a_cluster := a_class.cluster
					when Cluster_scope then
						a_cluster := cluster_i (row_stone_name)
					when System_scope then
					end
					if a_composite_metric /= Void and then a_composite_metric.is_scope_ratio then
						str := calculate.select_name_and_adjust_scope (a_composite_metric.scope_num,
												a_feature, a_class, a_cluster, system)
						str := calculate.select_name_and_adjust_scope (a_composite_metric.scope_den,
												a_feature, a_class, a_cluster, system)
					else
						str := calculate.select_name_and_adjust_scope (scope (row_scope),
												a_feature, a_class, a_cluster, system)
					end
					new_result := calculate.calculate_metric (metric (row_metric), scope (row_scope))
					a_percentage := a_composite_metric /= Void and then a_composite_metric.percentage
					row.put_i_th (new_result.out, 5)
					a_metric := metric (row_metric)

						-- Update if there was something pertinent in last column
					if not default_archive then
						archive_measure := archive.retrieve_archived_result (a_metric, archive.archived_file, archive.archived_root_element, archive_mode, new_result)
						row.put_i_th (archive_measure, 6)				
					end
								
					file_manager.update_row (row, index_updated_row)
					if not file_manager.metric_file.exists then
							-- Should not be called, if file does not exist, `multi_column_list' is emptied.
						file_manager.destroy_file_name
						set_file_loaded (False)
						file_handler.load_files
					end
					check file_manager.metric_file.exists end
					file_manager.store
					file_manager.measure_notify_all_but (Current)
					row.set_pixmap (Pixmaps.Icon_green_tick)
					row.put_i_th (fix_decimals_and_percentage (new_result, a_metric.percentage), 5)
				end
				progress_dialog.hide
				development_window.window.set_pointer_style (development_window.Standard_cursor)
				resize_column_list_to_content (multi_column_list)
			end
		rescue
			retried := True
			progress_dialog.hide
			progress_dialog.enable_cancel
			development_window.window.set_pointer_style (development_window.Standard_cursor)
			retry
		end

	update_all is
			-- Update all old rows.
		do
			from
				multi_column_list.start
			until
				multi_column_list.exhausted
			loop
				if multi_column_list.item /= Void then
					update_row (multi_column_list.item)
				end
				multi_column_list.forth
			end
		end

	resize_column_list_to_content (mcl: EV_MULTI_COLUMN_LIST) is
			-- Adjust column width to larger string included.
		require
			valid_column_list: mcl /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > mcl.column_count
			loop
				mcl.resize_column_to_content (i)
				i := i + 1
			end
		end

feature -- Correspondance: name-object.

	e_feature (feature_name, class_name: STRING): E_FEATURE is
			-- Resturn feature of name `feature_name' in class of name `class_name'.
		require
			correct_feature_name: feature_name /= Void and then not feature_name. is_empty
			correct_class_name: class_name /= Void and then not class_name. is_empty
		local
			feature_list: LIST [E_FEATURE]
			a_class: CLASS_C
			current_feature_name: STRING
		do
			a_class := class_c (class_name)
			feature_list := a_class.written_in_features
			from
				feature_list.start
			until
				feature_list.after or Result /= Void
			loop
				if feature_list.item /= Void then
					current_feature_name := feature_list.item.name
					if equal (current_feature_name, feature_name) then
						Result := feature_list.item
					end
				end
				feature_list.forth
			end
		end

	class_c (class_name: STRING): CLASS_C is
			-- Resturn class of name `class_name'.
		require
			correct_class_name: class_name /= Void and then not class_name. is_empty
		local
			array_classes: ARRAY [CLASS_C]
			i: INTEGER
		do
			array_classes := system.classes.sorted_classes
			from
				i := 1
			until
				i > array_classes.count or Result /= Void
			loop
				if array_classes.item (i) /= Void and then equal (array_classes.item (i).name, class_name) then 
					Result := array_classes.item (i)
				end
				i := i + 1
			end
		end

	cluster_i (cluster_name: STRING): CLUSTER_I is
			-- Resturn cluster of name `cluster_name'.
		require
			correct_cluster_name: cluster_name /= Void and then not cluster_name. is_empty
		local
			list_clusters: LINKED_LIST [CLUSTER_I]
		do
			list_clusters := universe.clusters
			from
				list_clusters.start
			until
				list_clusters.after
			loop
				if equal (list_clusters.item.cluster_name, cluster_name) then 
					Result := list_clusters.item
				end
				list_clusters.forth
			end
		end

feature -- Storing results.

	notify_measure is
			-- Notify current observer of changes related to metric results storage produced by other observer.
		do
			multi_column_list.wipe_out
			file_handler.retrieve_recorded_measures (file_manager.metric_file)
		end
	

	notify_new_metric (new_defined_metric: EB_METRIC; new_metric_element: XML_ELEMENT; overwrite: BOOLEAN; index: INTEGER) is
			-- Notify current observer when added new metric definition.
			-- Update changes in current observer when new metric had been defined.
		require else
			correct_metric: new_defined_metric /= Void
			correct_definition: new_metric_element /= Void
			correct_index: index >= 1 and index <= metrics.count + 1
		local
			i: INTEGER
			display_name: BOOLEAN
			new_composite_metric: EB_METRIC_COMPOSITE
		do
			new_composite_metric ?= new_defined_metric
			if not overwrite then
				check metric (new_defined_metric.name) = Void end
				if index <= user_metrics_xml_list.count then
					metrics.go_i_th (index + nb_basic_metrics - 1)
					user_metrics_xml_list.go_i_th (index - 1)
					metrics.put_right (new_defined_metric)
					user_metrics_xml_list.put_right (new_metric_element)
				else					
					metrics.extend (new_defined_metric)
					user_metrics_xml_list.extend (new_metric_element)
				end
				check metric (new_defined_metric.name) /= Void end
			else
				check metric (new_defined_metric.name) /= Void end
				i := metrics.index_of (metric (new_defined_metric.name), 1)
				metrics.put_i_th (new_defined_metric, i)
				user_metrics_xml_list.put_i_th (new_metric_element, i - nb_basic_metrics)
				check metric (new_defined_metric.name) /= Void end
			end
			if new_composite_metric /= Void then 
				display_name := (not new_composite_metric.is_scope_ratio and new_composite_metric.min_scope <= scope (scope_combobox.text).index)
					or (new_composite_metric.is_scope_ratio and then new_composite_metric.min_scope >= min_scope_available)
			else
				display_name := new_defined_metric.min_scope <= scope (scope_combobox.text).index
			end
			if display_name then
				metric_field.set_text (new_defined_metric.name)
				unit_field.set_text (new_defined_metric.unit)
			end
			update_displayed_dialogs
		end
		
	notify_management_metric (metric_list: LINKED_LIST [EB_METRIC]; xml_list: LINKED_LIST [XML_ELEMENT]) is
			-- The state of the manager has changed. Metrics have been changed. Update `Current'.
		local
			old_metric_displayed: EB_METRIC
		do
			check metric_list.count - nb_basic_metrics = xml_list.count end
			from
				metrics.go_i_th (nb_basic_metrics + 1)
				user_metrics_xml_list.start
			until
				metrics.after and
				user_metrics_xml_list.after
			loop
				metrics.remove
				user_metrics_xml_list.remove
			end
			from
				metric_list.go_i_th (nb_basic_metrics + 1)
				xml_list.start
			until
				metric_list.after and
				xml_list.after
			loop
				metrics.extend (metric_list.item)
				user_metrics_xml_list.extend (xml_list.item)
				metric_list.forth
				xml_list.forth
			end
			old_metric_displayed := metric (metric_field.text)
			if old_metric_displayed = Void then -- Metric has been removed.
				adjust_metric (scope (scope_combobox.text).index)
				display_first_sensitive_metric
				text_area.remove_text
			end
			update_displayed_dialogs
		end


	update_displayed_dialogs is
			-- Update metrics in `manage' and `new_metric' dialogs.
		local
			selected_item: EV_LIST_ITEM
			index_selected_item: INTEGER
		do
			if new_metric.new_metric_definition_dialog /= Void and then
				new_metric.new_metric_definition_dialog.is_displayed then
				
				new_metric.linear_tab.update_displayed_dialogs
				new_metric.ratio_metric_tab.update_displayed_dialogs
				new_metric.ratio_scope_tab.update_displayed_dialogs
			end
			if manage.management_dialog /= Void and then manage.management_dialog.is_displayed then
				selected_item := manage.ev_list.selected_item
				index_selected_item := manage.ev_list.index_of (selected_item, 1)
				manage.ev_list.wipe_out
				manage.fill_ev_list (manage.ev_list)
				if selected_item /= Void then
					manage.ev_list.i_th (index_selected_item).enable_select
				end
				if manage.import.import_metrics_dialog /= Void and then manage.import.import_metrics_dialog.is_displayed then
					manage.import.update_wished_list
				end
			end

		end

feature -- Dialog

	progress_dialog: EB_PROGRESS_DIALOG is
			-- Progress bar to be displayed whenever calculation takes a while.
		local
			x_pos, y_pos: INTEGER
		once
			create Result
			x_pos := development_window.window.x_position + 100
			y_pos := development_window.window.y_position + 100
			Result.set_position (x_pos, y_pos)
			Result.set_title ("Calculation")
			Result.set_message ("Calculating requested metric(s)...")
			Result.set_entity (interface_names.d_Compilation_class)
		end

feature -- Memory management

	recycle is
			-- Remove all references to `Current', and leave `Current' in an 
			-- unstable state, so that we know `Current' is not referenced any longer.
		do
			Precursor {EB_METRIC_OBSERVER}
			internal_text_area.destroy
			internal_multi_column_list.wipe_out
			internal_multi_column_list.destroy
			internal_text_area := Void
			internal_multi_column_list := Void
		end

feature {NONE} -- Implementation

	internal_text_area: EV_TEXT_FIELD
		-- Internal representation of `text_area'.

	internal_multi_column_list: EV_MULTI_COLUMN_LIST
		-- Internal representation of `multi_column_list'.

	is_shown: BOOLEAN
			-- Is `Current' currently displayed in the context tool?

	must_set_stone: BOOLEAN
			-- Do we need to set the stone when we are next displayed?

	stone_to_set: STONE
			-- Stone that should be set, but we wait until we are displayed to set it.

	real_set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		local
			new_feature_stone: FEATURE_STONE
			new_cluster_stone: CLUSTER_STONE
			new_class_stone: CLASSI_STONE
			new_scope: INTEGER
		do
			new_feature_stone ?= a_stone
			if new_feature_stone /= Void then
				if new_feature_stone.is_valid and then not 
					(
						feature_stone /= Void
							and then
						feature_stone.is_valid
							and then
						new_feature_stone.same_as (feature_stone)
					)
				then
					feature_stone := new_feature_stone
					class_stone := Void
					cluster_stone := Void
					new_scope := scope (interface_names.metric_this_feature).index
				end
			else
				new_class_stone ?= a_stone
				if new_class_stone /= Void then 
					if new_class_stone.is_valid and then not
						(
							class_stone /= Void
								and then
							class_stone.is_valid
								and then
							new_class_stone.same_as (class_stone)
						)
					then
						class_stone := new_class_stone
						feature_stone := Void
						cluster_stone := Void
						new_scope := scope (interface_names.metric_this_class).index
					end
				else
					new_cluster_stone ?= a_stone
					if new_cluster_stone /= Void then
						if not new_cluster_stone.same_as (cluster_stone) then
							cluster_stone := new_cluster_stone
							class_stone := Void
							feature_stone := Void
							new_scope := scope (interface_names.metric_this_cluster).index
						end
					else
						new_scope := scope (interface_names.metric_this_system).index
					end
				end
			end
			if new_scope /= 0 then
				min_scope_available := new_scope
				adjust_scope (min_scope_available)
				text_area.remove_text
				if details_hidden then
					details.disable_sensitive
					if details_cmd_in_menu /= Void then
						details_cmd_in_menu.disable_sensitive					
					end
				end
			end
		ensure
			correct_range: min_scope_available >= Feature_scope and min_scope_available <= System_scope
		end

end -- class EB_METRIC_TOOL

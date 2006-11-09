indexing
	description: "Object that represents a row to display a metric in metric import grid"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_IMPORT_GRID_ROW

inherit
	EB_GRID_ROW

	EB_METRIC_INTERFACE_PROVIDER

	HASHABLE

create
	make

feature{NONE} -- Implementation

	make (a_metric: like metric) is
			-- Initialize `metric' with `a_metric'.
		require
			a_metric_attached: a_metric /= Void
		do
			metric := a_metric
			create import_checkbox.make_with_boolean (False)
			import_checkbox.selected_changed_actions.extend (agent on_selection_change)
			original_name := metric.name.twin
			create name_editable_area.make_with_text (metric.name)
			name_editable_area.set_pixmap (metric_icon)
			name_editable_area.activate_actions.extend (agent on_name_editable_area_activated)
			name_editable_area.deactivate_actions.extend (agent on_name_editable_area_deactivated)
			create name_change_actions
			create selection_change_actions
		ensure
			metric_set: metric = a_metric
			name_set: name /= Void and then name.is_equal (metric.name)
			original_name_set: original_name /= Void and then original_name.is_equal (metric.name)
		end

feature -- Access

	name: STRING is
			-- Current name of `metric'.
			-- Can be different from `metric'.`name' because new name can be specified to resolve name crash.
		do
			Result := name_editable_area.text
		end

	metric: EB_METRIC
			-- Metric associated with Current row

	unit: QL_METRIC_UNIT is
			-- Unit of `metric'
		do
			Result := metric.unit
		ensure
			result_attached: Result /= Void
		end

	original_name: STRING
			-- Original name in `metric'

	description: STRING is
			-- Description of `metric'.
		do
			Result := metric.description
			if Result = Void then
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		end

	metric_icon: EV_PIXMAP is
			-- Pixmap used to diplay `metric' according to its type: basic, linear or ratio
		do
			Result := pixmap_from_metric (metric)
		ensure
			result_attached: Result /= Void
		end

	import_checkbox: MA_GRID_CHECK_BOX_ITEM
			-- Checkbox to indicate `metric' is selected to be imported

	name_editable_area: EV_GRID_EDITABLE_ITEM
			-- Editable area to edit `name'

	selection_change_actions: ACTION_SEQUENCE [TUPLE [EB_METRIC_IMPORT_GRID_ROW]]
			-- Actions to be performed when selection status in `import_checkbox' changes

	name_change_actions: ACTION_SEQUENCE [TUPLE [old_name: STRING; row: EB_METRIC_IMPORT_GRID_ROW]]
			-- Actions to be performed when text in `name_editable_area' changes

	hash_code: INTEGER is
			-- Hash code value
		local
			l_name: STRING
		do
			if hash_code_internal = 0 then
				l_name := original_name.as_lower
				l_name.left_adjust
				l_name.right_adjust
				hash_code_internal := l_name.hash_code
			end
			Result := hash_code_internal
		end

	hash_code_internal: INTEGER
			-- Implementation of `hash_code'

feature -- Status report

	has_name_crash: BOOLEAN is
			-- Does name crash occur under `name'?
			-- e.g., is there another metric whose name is `name' already in Current project?
		require
			row_binded: grid_row /= Void
		do
			Result := has_name_crash_internal
		ensure
			good_result: Result = has_name_crash_internal
		end

	is_selected: BOOLEAN is
			-- Is `metric' in Current row selected to be imported?
		do
			Result := import_checkbox.selected
		end

	has_warning: BOOLEAN
			-- Does Current metric have warning?
			-- i.e., Are there some of its recursively references not found or not selected?

feature -- Setting

	set_name_editable_area_text (a_text: STRING) is
			-- Set text of `name_editable_area_text' to `a_text'.
		require
			a_text_attached: a_text /= Void
		do
			name_editable_area.set_text (a_text)
		ensure
			text_set: name_editable_area.text.is_equal (a_text)
		end

feature -- Grid binding

	bind_row (a_row: EV_GRID_ROW; a_existing_metric_exist: BOOLEAN; a_missing_metrics_name: LIST [STRING]; a_unselected_metrics_name: LIST [STRING]) is
			-- Bind Current in `a_row'.
			-- If `a_existing_metric_exist' is True, that is, name crash occurs, `a_row' will be in invalid state.
		require
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent /= Void
		local
			l_unit_lbl: EV_GRID_LABEL_ITEM
			l_status_lbl: EV_GRID_LABEL_ITEM
			l_original_name_lbl: EV_GRID_LABEL_ITEM
			l_tooltip: STRING
			l_linear: EB_METRIC_LINEAR
			l_ratio: EB_METRIC_RATIO
			l_linear_expr_generator: EB_METRIC_LINEAR_EXPRESSION_GENERATOR
			l_ratio_expr_generator: EB_METRIC_RATIO_EXPRESSION_GENERATOR
			l_status_tooltip: STRING
			l_temp_str: STRING
		do
			a_row.clear
			has_name_crash_internal := a_existing_metric_exist
			has_warning := not a_missing_metrics_name.is_empty or not a_unselected_metrics_name.is_empty
			set_grid_row (a_row)
			a_row.set_item (1, import_checkbox)
			create l_status_lbl
			if has_name_crash then
				l_status_lbl.set_pixmap (pixmaps.icon_pixmaps.general_error_icon)
				l_status_lbl.set_tooltip (substituted_text (metric_names.wrn_metric_name_crash, <<"$name", metric.name>>))
			elseif not a_missing_metrics_name.is_empty or not a_unselected_metrics_name.is_empty then
				create l_status_tooltip.make (256)
				l_status_lbl.set_pixmap (pixmaps.icon_pixmaps.general_warning_icon)
				if not a_missing_metrics_name.is_empty then
					l_temp_str := concatenated_names (a_missing_metrics_name)
					l_status_tooltip.append (substituted_text (metric_names.wrn_referenced_metrics_missing, <<"$metrics", l_temp_str>>))
				end
				if not a_unselected_metrics_name.is_empty then
					if not l_status_tooltip.is_empty then
						l_status_tooltip.append (".%N")
					end
					l_temp_str := concatenated_names (a_unselected_metrics_name)
					l_status_tooltip.append (substituted_text (metric_names.wrn_referenced_metrics_not_selected, <<"$metrics", l_temp_str>>))
				end
				l_status_lbl.set_tooltip (l_status_tooltip)
			else
				l_status_lbl.set_pixmap (pixmaps.icon_pixmaps.general_tick_icon)
			end
			l_status_lbl.set_layout_procedure (agent status_layout)
			a_row.set_item (2, l_status_lbl)
			a_row.set_item (3, name_editable_area)
			create l_original_name_lbl.make_with_text (original_name)
			create l_tooltip.make (256)
			if not description.is_empty then
				l_tooltip.append (description)
			end
			create l_linear_expr_generator.make
			create l_ratio_expr_generator.make
			if not metric.is_basic then
				if not l_tooltip.is_empty then
					l_tooltip.append ("%N")
				end
				l_tooltip.append ("Expression: ")
				if metric.is_linear then
					l_linear ?= metric
					l_linear_expr_generator.set_metric (l_linear)
					l_linear_expr_generator.generate_expression
					l_tooltip.append (l_linear_expr_generator.string_representation.as_string_8)
				elseif metric.is_ratio then
					l_ratio ?= metric
					l_ratio_expr_generator.set_metric (l_ratio)
					l_ratio_expr_generator.generate_expression
					l_tooltip.append (l_ratio_expr_generator.string_representation.as_string_8)
				end
			end
			if not l_tooltip.is_empty then
				name_editable_area.set_tooltip (l_tooltip)
			end
			a_row.set_item (4, l_original_name_lbl)
			create l_unit_lbl.make_with_text (displayed_name (unit.name))
			l_unit_lbl.set_pixmap (pixmap_from_unit (unit))
			a_row.set_item (5, l_unit_lbl)
		end

	status_layout (a_item: EV_GRID_LABEL_ITEM; a_layout: EV_GRID_LABEL_ITEM_LAYOUT) is
			-- Set layout into `a_layout' for `a_item'.
		require
			a_item_attached: a_item /= Void
			a_layout_attached: a_layout /= Void
		local
			l_pixmap: EV_PIXMAP
		do
			l_pixmap := pixmaps.icon_pixmaps.general_tick_icon
			a_layout.set_pixmap_x ((a_item.width - l_pixmap.width) // 2)
			a_layout.set_pixmap_y ((a_item.height - l_pixmap.height) // 2)
		end

feature{NONE} -- Implementation

	has_name_crash_internal: BOOLEAN
			-- Internal implementation of `has_name_crashs'

	old_name: STRING
			-- Name before `name_editable_area' is activated

	concatenated_names (a_names: LIST [STRING]): STRING is
			-- String concatenating all names in `a_names' with ", "
		require
			a_names_attached: a_names /= Void
		do
			create Result.make (256)
			from
				a_names.start
				Result.append (a_names.item)
				a_names.forth
			until
				a_names.after
			loop
				Result.append (", ")
				Result.append (a_names.item)
				a_names.forth
			end
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Actions

	on_selection_change (a_checkbox: MA_GRID_CHECK_BOX_ITEM) is
			-- Action to be performed when selection status in `import_checkbox' changes
		require
			a_checkbox_attached: a_checkbox /= Void
		do
			if not selection_change_actions.is_empty then
				selection_change_actions.call ([Current])
			end
		end

	on_name_editable_area_activated	(a_popup_window: EV_POPUP_WINDOW) is
			-- Action to be performed when `name_editable_area' is activated
		do
			old_name := name_editable_area.text.twin
			if not name_editable_area.text_field.text.is_empty then
				name_editable_area.text_field.select_all
			end
		end

	on_name_editable_area_deactivated is
			-- Action to be performed when `name_editable_area' is deactivated
		do
			if not name_editable_area.text.is_case_insensitive_equal (old_name) then
				name_change_actions.call ([old_name.twin, Current])
			end
		end

invariant
	metric_attached: metric /= Void
	name_valid: name /= Void and then not name.is_empty
	original_name_attached: original_name /= Void
	import_checkbox_attached: import_checkbox /= Void
	name_change_actions_attached: name_change_actions /= Void

end

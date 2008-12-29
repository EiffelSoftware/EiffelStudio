note
	description: "Object that represents a row to display a metric in metric import grid"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_IMPORT_GRID_ROW

inherit
	EVS_GRID_ROW

	EB_METRIC_INTERFACE_PROVIDER

	HASHABLE

create
	make

feature{NONE} -- Implementation

	make (a_metric: like metric)
			-- Initialize `metric' with `a_metric'.
		require
			a_metric_attached: a_metric /= Void
		do
			metric := a_metric
			create import_checkbox
			import_checkbox.set_is_checked (False)
			import_checkbox.checked_changed_actions.extend (agent on_selection_change)
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

	name: STRING
			-- Current name of `metric'.
			-- Can be different from `metric'.`name' because new name can be specified to resolve name crash.
		do
			Result := name_editable_area.text
		end

	metric: EB_METRIC
			-- Metric associated with Current row

	unit: QL_METRIC_UNIT
			-- Unit of `metric'
		do
			Result := metric.unit
		ensure
			result_attached: Result /= Void
		end

	original_name: STRING
			-- Original name in `metric'

	description: STRING
			-- Description of `metric'.
		do
			Result := metric.description
			if Result = Void then
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		end

	metric_icon: EV_PIXMAP
			-- Pixmap used to diplay `metric' according to its type: basic, linear or ratio
		do
			Result := pixmap_from_metric (metric)
		ensure
			result_attached: Result /= Void
		end

	import_checkbox: EV_GRID_CHECKABLE_LABEL_ITEM
			-- Checkbox to indicate `metric' is selected to be imported

	name_editable_area: EV_GRID_EDITABLE_ITEM
			-- Editable area to edit `name'

	selection_change_actions: ACTION_SEQUENCE [TUPLE [EB_METRIC_IMPORT_GRID_ROW]]
			-- Actions to be performed when selection status in `import_checkbox' changes

	name_change_actions: ACTION_SEQUENCE [TUPLE [old_name: STRING; row: EB_METRIC_IMPORT_GRID_ROW]]
			-- Actions to be performed when text in `name_editable_area' changes

	hash_code: INTEGER
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

	has_name_crash: BOOLEAN
			-- Does name crash occur under `name'?
			-- e.g., is there another metric whose name is `name' already in Current project?
		require
			row_binded: grid_row /= Void
		do
			Result := has_name_crash_internal
		ensure
			good_result: Result = has_name_crash_internal
		end

	is_selected: BOOLEAN
			-- Is `metric' in Current row selected to be imported?
		do
			Result := import_checkbox.is_checked
		end

	has_warning: BOOLEAN
			-- Does Current metric have warning?
			-- i.e., Are there some of its recursively references not found or not selected?

feature -- Setting

	set_name_editable_area_text (a_text: STRING)
			-- Set text of `name_editable_area_text' to `a_text'.
		require
			a_text_attached: a_text /= Void
		do
			name_editable_area.set_text (a_text)
		ensure
			text_set: name_editable_area.text.is_equal (a_text)
		end

feature -- Grid binding

	bind_row (a_row: EV_GRID_ROW; a_existing_metric_exist: BOOLEAN; a_missing_metrics_name: LIST [STRING]; a_unselected_metrics_name: LIST [STRING])
			-- Bind Current in `a_row'.
			-- If `a_existing_metric_exist' is True, that is, name crash occurs, `a_row' will be in invalid state.
			-- `a_missing_metrics_name' is a list of metric names which are referenced by `metric' but not found.
			-- `a_unselected_metrics_name' is a list of metric names which are referencedd by `metric' and found but not selected.
		require
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent /= Void
			a_missing_metrics_name_attached: a_missing_metrics_name /= Void
			a_unselected_metrics_name_attached: a_unselected_metrics_name /= Void
		local
			l_unit_lbl: EV_GRID_LABEL_ITEM
		do
			a_row.clear
			has_name_crash_internal := a_existing_metric_exist
			has_warning := not a_missing_metrics_name.is_empty or not a_unselected_metrics_name.is_empty

			set_grid_row (a_row)
			a_row.set_item (1, import_checkbox)
			a_row.set_item (2, status_item (has_name_crash, a_missing_metrics_name, a_unselected_metrics_name))
			a_row.set_item (3, name_editable_area)
			a_row.set_item (4, origianl_metric_name_item)
			create l_unit_lbl.make_with_text (unit_name_table.item (unit))
			l_unit_lbl.set_pixmap (pixmap_from_unit (unit))
			a_row.set_item (5, l_unit_lbl)
		end

feature{NONE} -- Implementation

	has_name_crash_internal: BOOLEAN
			-- Internal implementation of `has_name_crashs'

	old_name: STRING
			-- Name before `name_editable_area' is activated

	status_item (a_name_crash: BOOLEAN; a_missing_metrics_name: LIST [STRING]; a_unselected_metrics_name: LIST [STRING]): EV_GRID_ITEM
			-- Status item to be binded in to current row.
			-- `a_name_crash' indicates if name crash exists.
			-- `a_missing_metrics_name' is a list of metric names which are referenced by `metric' but not found.
			-- `a_unselected_metrics_name' is a list of metric names which are referencedd by `metric' and found but not selected.			
		require
			a_missing_metrics_name_attached: a_missing_metrics_name /= Void
			a_unselected_metrics_name_attached: a_unselected_metrics_name /= Void
		local
			l_status_lbl: EV_GRID_LABEL_ITEM
			l_str_list: LINKED_LIST [STRING_GENERAL]
		do
			create l_status_lbl
			create l_str_list.make
			if a_name_crash then
					-- If name crash happends.
				l_status_lbl.set_pixmap (pixmaps.icon_pixmaps.general_error_icon)
				l_status_lbl.set_tooltip (metric_names.wrn_metric_name_crash (metric.name))
			elseif not a_missing_metrics_name.is_empty or not a_unselected_metrics_name.is_empty then
					-- If some referenced metrics for this to-be-imported metrics are not found or not selected.
				l_status_lbl.set_pixmap (pixmaps.icon_pixmaps.general_warning_icon)
				if not a_missing_metrics_name.is_empty then
					l_str_list.extend (metric_names.wrn_referenced_metrics_missing ((metric_names.concatenated_string (a_missing_metrics_name, metric_names.comma_separator))))
				end
				if not a_unselected_metrics_name.is_empty then
					l_str_list.extend (metric_names.wrn_referenced_metrics_not_selected (metric_names.concatenated_string (a_unselected_metrics_name, metric_names.comma_separator)))
				end
				l_status_lbl.set_tooltip (metric_names.concatenated_string (l_str_list, metric_names.new_line_separator))
			else
					-- If this metric is ready to be imported.
				l_status_lbl.set_pixmap (pixmaps.icon_pixmaps.general_tick_icon)
			end
			l_status_lbl.set_layout_procedure (agent center_pixmap_layout)

			Result := l_status_lbl
		ensure
			result_attached: Result /= Void
		end

	origianl_metric_name_item: EV_GRID_ITEM
			-- Origianal metric name item
		local
			l_str_list: LINKED_LIST [STRING_GENERAL]
			l_original_name_lbl: EV_GRID_LABEL_ITEM
		do
			create l_original_name_lbl.make_with_text (original_name)
			create l_str_list.make
			if not description.is_empty then
				l_str_list.extend (description)
			end
			if not metric.is_basic then
				l_str_list.extend (expression_of_metric)
			end
			if not l_str_list.is_empty then
				l_original_name_lbl.set_tooltip (metric_names.concatenated_string (l_str_list, metric_names.new_line_separator))
			end
			Result := l_original_name_lbl
		ensure
			result_attached: Result /= Void
		end

	expression_of_metric: STRING_GENERAL
			-- Expression of `metric'
			-- For example, if `metric' is linear, expression would like "Expression: 2 * metric1 + 3 * metric2".
		require
			metric_valid: metric.is_linear or metric.is_ratio
		local
			l_str_list: LINKED_LIST [STRING_GENERAL]
		do
			create l_str_list.make
			l_str_list.extend (metric_names.t_expression)
			if metric.is_linear or metric.is_ratio then
				rich_text_output.wipe_out
				expression_generator.generate_output (metric)
				l_str_list.extend (rich_text_output.string_representation)
			end
			Result := metric_names.concatenated_string (l_str_list, metric_names.space_separator)
		ensure
			result_attached: Result /= Void
		end

	expression_generator: EB_METRIC_EXPRESSION_GENERATOR
			--  Expression generator		
		do
			if expression_generator_internal = Void then
				create expression_generator_internal.make (rich_text_output)
			end
			Result := expression_generator_internal
		ensure
			result_attached: Result /= Void
		end

	rich_text_output: EB_METRIC_EXPRESSION_RICH_TEXT_OUTPUT
			-- Output from `expression_generator' in rich text format
		do
			if rich_text_output_internal = Void then
				create rich_text_output_internal.make
			end
			Result := rich_text_output_internal
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Actions

	on_selection_change (a_checkbox: EV_GRID_CHECKABLE_LABEL_ITEM)
			-- Action to be performed when selection status in `import_checkbox' changes
		require
			a_checkbox_attached: a_checkbox /= Void
		do
			if not selection_change_actions.is_empty then
				selection_change_actions.call ([Current])
			end
		end

	on_name_editable_area_activated	(a_popup_window: EV_POPUP_WINDOW)
			-- Action to be performed when `name_editable_area' is activated
		do
			old_name := name_editable_area.text.twin
			if not name_editable_area.text_field.text.is_empty then
				name_editable_area.text_field.select_all
			end
		end

	on_name_editable_area_deactivated
			-- Action to be performed when `name_editable_area' is deactivated
		do
			if not name_editable_area.text.is_case_insensitive_equal (old_name) then
				name_change_actions.call ([old_name.twin, Current])
			end
		end

	expression_generator_internal: like expression_generator
			-- Implementation of `expression_generator'

	rich_text_output_internal: like rich_text_output
			-- Implementation of `rich_text_output'

invariant
	metric_attached: metric /= Void
	name_valid: name /= Void and then not name.is_empty
	original_name_attached: original_name /= Void
	import_checkbox_attached: import_checkbox /= Void
	name_change_actions_attached: name_change_actions /= Void

note
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end

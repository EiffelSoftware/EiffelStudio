indexing
	description: "Names used in metric interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_NAMES

feature -- Text

	e_evaluate_metric: STRING is "Evaluate metric: "
	e_not_evaluated: STRING is "Not evaluated"
	e_evaluating: STRING is "Evaluating: "
	e_evaluating_value: STRING is "Evaluating..."
	e_undefined_value: STRING is "Undefined"
	e_value: STRING is "Value:"
	e_interrupted_by_user: STRING is "Interrupted by user"
	e_interrupted_by_compile: STRING is "Interrupted because Eiffel complication starts"
	e_no_metric_is_selected: STRING is "No metric is selected."

feature -- Titles

	t_expression: STRING is "Expression:"
	t_criterion: STRING is "Criterion"
	t_properties: STRING is "Properties"
	t_status: STRING is "Status:"
	t_ok: STRING is "OK"
	t_type: STRING is "type"
	t_value_of_reference: STRING is "Reference value"
	t_value_of_current: STRING is "Current value"
	t_difference: STRING is "Difference"
	t_ratio: STRING is "ratio"
	t_basic: STRING is "basic"
	t_linear: STRING is "linear"
	t_definition_tab: STRING is "Metric Definition"
	t_evaluation_tab: STRING is "Metric Evaluation"
	t_archive_tab: STRING is "Metric Archive"
	t_detail_result_tab: STRING is "Detailed Result"
	t_path: STRING is "Path"
	t_group: STRING is "Group"
	t_metrics: STRING is "Metrics"
	t_coefficient: STRING is "Coefficient"
	t_metric_valid: STRING is "Metric is valid"
	t_save_metric: STRING is "Current metric has been modified, save it?"
	t_discard_remove_prompt: STRING is "Do not ask me again and always remove selected metric"
	t_discard_save_prompt: STRING is "Do not ask me again and always save modified metric"
	t_name_cannot_be_empty: STRING is "Metric name is empty."
	t_metric_with_name: STRING is "Metric with name"
	t_metric_exists: STRING is "already exists."
	t_metric_not_saved: STRING is "Note: Metric is not saved."
	t_select_archive: STRING is "Select a metric archive file"
	t_metric_no_metric_selected: STRING is "No metric is selected"
	t_metric_is_not_valid: STRING is "is not valid"
	t_selected_metric: STRING is "Selected metric"
	t_selected_file_not_exists: STRING is "Specified file doesn't exist"
	t_selected_archive_not_valid: STRING is "Metric archive in specified file is not valid"
	t_metric: STRING is "metric"
	t_metric_name_can_not_be_empty: STRING is "Metric name cannot be empty"
	t_remove_metric: STRING is "Remove metric "
	t_no_archive_selected: STRING is "No metric archive is selected."
	t_archive_management: STRING is "Archive management"
	t_archive_comparison: STRING is "Archive comparison"
	t_location: STRING is "Location:"
	t_select_source_domain: STRING is "Select source domain:"
	t_select_metric: STRING is "Select metric:"
	t_select_reference_archive: STRING is "Select reference archive:"
	t_select_current_archive: STRING is "Select current archive:"
	t_archive_comparison_result: STRING is "Archive comparison result:"
	t_clean: STRING is "Clean"

feature -- Labels

	l_select_input_domain: STRING is "Select input domain:"
	l_select_metric: STRING is "Select metric:"

feature -- Tooltip

	f_show_detailed_result: STRING is "Run selected metric and show detailed result"
	f_quick_metric_definition: STRING is "Define quick metric"
	f_run: STRING is "Run selected metric"
	f_go_to_definition: STRING is "Go to definition"
	f_stop: STRING is "Stop metric evaluation"
	f_move_row_up: STRING is "Move selected row up"
	f_move_row_down: STRING is "Move selected row down"
	f_del_row: STRING is "Delete selected row"
	f_clear_rows: STRING is "Remove all rows"
	f_indent_with_and_criterion: STRING is "Indent selected row using an %"AND%" criterion"
	f_indent_with_or_criterion: STRING is "Indent selected row using an %"OR%" criterion"
	f_drop_metric_here: STRING is "Pick and drop metric here"
	f_reload_metrics: STRING is "Reload metrics"

	f_start_archive: STRING is "Start metric archive evaluation"
	f_stop_archive: STRING is "Stope metric archive evaluation"
	f_select_exist_archive_file: STRING is "Select an existing metric archive file"
	f_clean_archive: STRING is "Clean archive?"

	f_compare_archive: STRING is "Compare metric archive"
	f_select_current_archive: STRING is "Select current metric archive file"
	f_select_reference_archive: STRING is "Select reference metric archive file"
	f_select_userdefined_metrics: STRING is "Select user-defined metrics"
	f_select_predefined_metrics: STRING is "Select predefined metrics"
	f_group_metric_by_unit: STRING is "Group metrics by unit"

	f_add_scope: STRING is "Add scope"
	f_remove_scope: STRING is "Remove selected scope(s)"
	f_remove_all_scopes: STRING is "Remove all scopes"
	f_delayed_scope: STRING is "Delayed"

	f_save: STRING is "Save"
	f_new: STRING is "New metric"
	f_remove: STRING is "Remove current selected metric"
	f_domain_item_invalid: STRING is "Item invalid in current system";

indexing
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

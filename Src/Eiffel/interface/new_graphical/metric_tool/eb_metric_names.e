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
	t_selected_archive_not_valid: STRING is "Metric archive in specified file is not valid, it must be cleaned"
	t_metric: STRING is "metric"
	t_metric_name_can_not_be_empty: STRING is "Metric name cannot be empty"
	t_remove_metric: STRING is "Remove metric "
	t_no_archive_selected: STRING is "No metric archive is selected."
	t_archive_management: STRING is "Archive management"
	t_archive_comparison: STRING is "Archive comparison"
	t_location: STRING is "Location:"
	t_select_source_domain: STRING is "Select input domain:"
	t_select_metric: STRING is "Select metric:"
	t_select_reference_archive: STRING is "Select reference archive:"
	t_select_current_archive: STRING is "Select current archive:"
	t_archive_comparison_result: STRING is "Archive comparison result:"
	t_clean: STRING is "Clean"
	t_compare: STRING is "Compare"
	t_input_domain: STRING is "Input domain"
	t_result: STRING is "Results:"
	t_input_domain_title: STRING is "Input domain:"
	t_metric_criterion_definition: STRING is "Criterion definition:"
	t_select_domain_scope: STRING is "Select domain scope"
	t_predefined_text_not_editable: STRING is "Text not editable because current metric is predefined."
	t_text_not_editable: STRING is "Text not editable."
	t_metric_definition: STRING is "Metric definition"
	t_checking_metric_vadility: STRING is "Checking metric vadility"
	t_loading_metrics: STRING is "Loading metrics..."
	t_analysing_archive: STRING is "Analysing metric archive(s)..."
	t_saving_metrics: STRING is "Saving metrics..."
	t_removing_metrics: STRING is "Removing metrics..."
	t_result_not_up_to_date: STRING is "Current metric result may not be up-to-date"

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
	f_select_userdefined_metrics: STRING is "Select/deselect user-defined metrics"
	f_select_predefined_metrics: STRING is "Select/deselect predefined metrics"
	f_group_metric_by_unit: STRING is "Group metrics by unit"

	f_add_scope: STRING is "Add scope"
	f_remove_scope: STRING is "Remove selected scope(s)"
	f_remove_all_scopes: STRING is "Remove all scopes"
	f_delayed_scope: STRING is "Use input domain as criterion domain."

	f_save: STRING is "Save"
	f_new: STRING is "New metric"
	f_remove: STRING is "Remove current selected metric"
	f_domain_item_invalid: STRING is "Item invalid in current system"
	f_application_scope: STRING is "Add current application target scope"
	f_search_for_class: STRING is "Search for group/class/feature"
	f_filter_result: STRING is "Filter result which is not visible from input domain"
	f_pick_and_drop_items: STRING is "Pick and drop items like group/class/feature here"
	f_insert_text_here: STRING is "Insert text here"
	f_get_criterion_list: STRING is "Available criterion list";
	f_get_negation: STRING is "You can put %"not%" before a criterion name to negate it"
	f_open_metric_file_in_external_editor: STRING is "Open user defined metric file in external editor"
	f_create_new_metric_using_current_data: STRING is "Clone selected metric to a new metric"
	f_setup_criterion_domain: STRING is "Setup criterion domain properties"
	f_setup_criterion_text: STRING is "Setup criterion text properties"
	f_double_click_to_go_to_definition: STRING is "(Double click to go to definition)"
	f_display_in_percentage: STRING is "Display result in percentage? (Only applicable for ratio metrics)"
	f_add_linear_variable_metric: STRING is "Add selected metric"
	f_run_metric_again: STRING is "Evaluate metric again to get up-to-date result"
	f_auto_go_to_result: STRING is "Automatically go to result panel after metric evaluation?"
	f_press_esc_to_wipe_out: STRING is "Press ESC to wipe out";

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

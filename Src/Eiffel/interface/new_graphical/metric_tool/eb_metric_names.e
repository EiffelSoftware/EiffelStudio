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
	t_status: STRING is "Status"
	t_ok: STRING is "OK"
	t_cancel: STRING is "Cancel"
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
	t_path: STRING is "Location"
	t_group: STRING is "Group"
	t_metrics: STRING is "Metrics"
	t_coefficient: STRING is "Coefficient"
	t_metric_valid: STRING is "Metric is valid."
	t_save_metric: STRING is "Current metric has been modified, save it?"
	t_discard_remove_prompt: STRING is "Do not ask me again and always remove selected metric"
	t_discard_save_prompt: STRING is "Do not ask me again and always save modified metric"
	t_name_cannot_be_empty: STRING is "Metric name is empty."
	t_metric_with_name: STRING is "Metric with name"
	t_metric_exists: STRING is "already exists."
	t_metric_not_saved: STRING is "Note: Metric is not saved."
	t_select_archive: STRING is "Select a metric archive file"
	t_metric_no_metric_selected: STRING is "No metric is selected"
	t_metric_is_not_valid: STRING is "is invalid"
	t_selected_metric: STRING is "Selected metric"
	t_selected_file_not_exists: STRING is "Specified file doesn't exist"
	t_selected_archive_not_valid: STRING is "Metric archive in specified file is not valid, it must be cleaned"
	t_metric: STRING is "metric"
	t_metric_name_can_not_be_empty: STRING is "Metric name cannot be empty"
	t_remove_metric: STRING is "Remove metric "
	t_no_archive_selected: STRING is "No metric archive is selected."
	t_archive_management: STRING is "Archive Management"
	t_archive_comparison: STRING is "Archive Comparison"
	t_location: STRING is "Location:"
	t_select_source_domain: STRING is "Select input domain:"
	t_select_metric: STRING is "Select metric:"
	t_select_reference_archive: STRING is "Select reference archive (URL acceptable):"
	t_select_current_archive: STRING is "Select current archive (URL acceptable):"
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
	t_checking_metric_vadility: STRING is "Checking metric validity"
	t_loading_metrics: STRING is "Loading metrics..."
	t_analysing_archive: STRING is "Analyzing metric archive(s)..."
	t_saving_metrics: STRING is "Saving metrics..."
	t_removing_metrics: STRING is "Removing metrics..."
	t_result_not_up_to_date: STRING is "Current metric result may not be up-to-date"
	t_feature_version_setting: STRING is "Feature version setting:"
	t_only_current_version: STRING is "Only current version"
	t_descendant_version: STRING is "Current version and all its descendant versions"
	t_to_do: STRING is "To do:"
	t_close: STRING is "Close"
	t_metric_definition_error_wizard: STRING is "Metric definition error wizard"
	t_metric_archive_calculation_finished: STRING is "Metric archive calculation finished."
	t_import_metric_title: STRING is "Import Metrics"
	t_import_selected_metrics: STRING is "Import Selected Metrics"
	t_backup_user_defined_metrics: STRING is "Backup User-defined Metrics"
	t_metric_definition_file: STRING is "Metric Definition File:"
	t_load: STRING is "Load"
	t_import: STRING is "Import"
	t_metric_original_name: STRING is "Original metric name"
	t_metric_name: STRING is "Metric name"
	t_metric_description: STRING is "Description"
	t_metric_unit: STRING is "Unit"
	t_select_all_metrics: STRING is "Select All Metrics"
	t_deselect_all_metrics: STRING is "Deselect All Metrics"
	t_select_integral_metrics: STRING is "Select Integral Metrics"
	t_deselect_integral_metrics: STRING is "Deselect Integral Metrics"

	t_backup_metrics: STRING is "Backup user-defined metrics"
	t_select_file_for_backup: STRING is "Select a file for user-defined metrics backup:"
	t_backup: STRING is "Backup"
	t_importing_metrics: STRING is "Importing metrics..."
	t_metrics_imported: STRING is "Metric(s) imported."
	t_metric_backuped: STRING is "User-defined metrics backup finished."
	t_metrics_list: STRING is "Metric List:"

feature -- Labels

	l_select_input_domain: STRING is "Select input domain:"
	l_select_metric: STRING is "Select metric:"
	l_parse_error: STRING is "Parse error:"
	l_ratio_metric: STRING is "ratio metric"
	l_linear_metric: STRING is "linear metric"
	l_basic_metric: STRING is "basic metric"
	l_denominator_metric: STRING is "denominator metric"
	l_numerator_metric: STRING is "numerator metric"
	l_variable_metric: STRING is "variable metric"
	l_metric: STRING is "metric"
	l_metric_archive_node: STRING is "metric archive node"
	l_criterion: STRING is "criterion"

feature -- Tooltip

	f_show_detailed_result: STRING is "Run selected metric and show detailed result"
	f_quick_metric_definition: STRING is "Define quick metric"
	f_run: STRING is "Run selected metric (faster, but detailed result won't be available)"
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
	f_stop_archive: STRING is "Stop metric archive evaluation"
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
	f_press_esc_to_wipe_out: STRING is "Press ESC to wipe out"
	f_move_unit_up: STRING is "Move metric unit up.%N"
	f_move_unit_down: STRING is "Move metric unit down.%N"
	f_rearrange_unit: STRING is "Or you can pick a metric unit and drop it on another metric to rearrange their order."
	f_show_to_do_message: STRING is "Display a message about how to deal with the metric definition error"
	f_import_metrics: STRING is "Import metrics from file"

feature -- Error/warning message

	wrn_metric_name_exists_in_your_metrics (a_name: STRING_GENERAL): STRING_GENERAL is
			-- Warning message used when in metric import dialog, when a changed metric name causes name crash in a users metrics
		require
			a_name_attached: a_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Metric named %"" + a_name.as_string_32 + "%" already exists in your metrics."
		ensure
			result_attached: Result /= Void
		end

	wrn_referenced_metrics_not_selected (a_metric_names: STRING_GENERAL): STRING_GENERAL is
			-- Warning message used when in metric import dialog, when a metric is selected while some of its recursively referenced metrics are not selected
			-- `a_metic_names' is a list of concatenated metric names
		require
			a_metric_names_attached: a_metric_names /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Referenced metric(s): " + a_metric_names.as_string_32 + " not selected."
		ensure
			result_attached: Result /= Void
		end

	wrn_referenced_metrics_missing (a_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Warning message used when in metric import dialog, when a metric is selected while some of its recursively referenced metrics are not found	
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Referenced metric(s): " + a_metric_name.as_string_32 + " not found."
		ensure
			result_attached: Result /= Void
		end

	wrn_metric_name_crash (a_name: STRING_GENERAL): STRING_GENERAL is
			-- Warning message used when in metric import dialog, when a metric has name crash with an existing metric named `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "There is already a metric named " + a_name.as_string_32 + ".%NChange its name in %"Metric name%" column to make it importable.";
		ensure
			result_attached: Result /= Void
		end

	err_loading_predefined_metrics (a_real_error: STRING_GENERAL): STRING_GENERAL is
			-- Error message when loading predefined metrics
		require
			a_real_error_attached: a_real_error /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "When loading predefined metrics:%N" + a_real_error.as_string_32 + "%NPredefined metrics not loaded."
		ensure
			result_attached: Result /= Void
		end

	err_loading_userdefined_metrics (a_real_error: STRING_GENERAL): STRING_GENERAL is
			-- Error message when loading user-defined metrics
		require
			a_real_error_attached: a_real_error /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "When loading user-defined metrics:%N" + a_real_error.as_string_32 + "%NUser-defined metrics not loaded."
		ensure
			result_attached: Result /= Void
		end

	err_invalid_tag: STRING is "Invalid tag."
			-- Invalid tag error

	err_invalid_description_tag: STRING is "Invalid description tag."
			-- Invalid description tag error

	err_file_not_readable (a_file_name: STRING_GENERAL): STRING_GENERAL is
			-- File not readable error
		require
			a_file_name_attached: a_file_name /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Cannot open file: " + a_file_name.as_string_32 + "."
		ensure
			result_attached: Result /= Void
		end

	err_file_not_writable (a_file_name: STRING_GENERAL): STRING_GENERAL is
			-- File not writable error
		require
			a_file_name_attached: a_file_name /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Cannot write file: " + a_file_name.as_string_32 + "."
		ensure
			result_attached: Result /= Void
		end

	err_directory_creation_fail (a_dir_name: STRING_GENERAL): STRING_GENERAL is
			-- Directory creation fail error
		require
			a_dir_name_attached: a_dir_name /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Cannot create directroy: " + a_dir_name.as_string_32 + "."
		ensure
			result_attached: Result /= Void
		end

	err_too_many_criteria: STRING_GENERAL is
			-- Too many criteria error
		do
			create {STRING_32}Result.make (0)
			Result := "Too many crieria is specified in %"criterion%" section. Only one is expected."
		ensure
			result_attached: Result /= Void
		end

	err_too_many_domain: STRING_GENERAL is
			-- Too many domain error
		do
			create {STRING_32}Result.make (0)
			Result := "Too many %"domain%" section specified. Only one is expected."
		ensure
			result_attached: Result /= Void
		end
	err_too_many_criterion_section: STRING_GENERAL is
			-- Too many criterion section error
		do
			create {STRING_32}Result.make (0)
			Result := "Too many crierion section specified. Only one criterion section is expected."
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_exists_in_import_metric_list (a_new_metric_name, a_old_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Error message used when in metric import dialog, when a changed metric name causes name crash in listed metrics to be imported
		require
			a_new_metric_name_attached: a_new_metric_name /= Void
			a_old_metric_name_attached: a_old_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "There is already metric named %"" + a_new_metric_name.as_string_32 + "%" in import metric list.%NThe name %"" + a_new_metric_name.as_string_32 + "%" will be changed back to %"" + a_old_metric_name.as_string_32 + "%".";
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_missing_in_metric_definition: STRING_GENERAL is
			-- Error message given when metric name is missing
		do
			create {STRING_32} Result.make_from_string ("Metric name is missing in metric definition.")
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_missing_in_archive_node: STRING_GENERAL is
			-- Error message given when metric name is missing in archive node
		do
			create {STRING_32} Result.make_from_string ("Metric name is missing in metric archive node.")
		ensure
			result_attached: Result /= Void
		end

	err_duplicated_metric_name (a_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Duplicated metric name error
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Duplicated metric name %"" + a_metric_name.as_string_32 + "%" in metric definition."
		ensure
			result_attached: Result /= Void
		end

	err_numerator_metric_missing: STRING_GENERAL is
			-- Numerator metric missing error
		do
			create {STRING_32}Result.make (0)
			Result := "Numerator metric is missing."
		ensure
			result_attached: Result /= Void
		end

	err_denominator_metric_missing: STRING_GENERAL is
			-- Numerator metric missing error
		do
			create {STRING_32}Result.make (0)
			Result := "Denominator metric is missing."
		ensure
			result_attached: Result /= Void
		end

	err_uuid_missing: STRING_GENERAL is
			-- UUID missing error	
		do
			create {STRING_32} Result.make (0)
			Result := "UUID is missing."
		end

	err_invalid_attribute (a_attribute: STRING_GENERAL): STRING_GENERAL is
			-- Invalid attribute error
		require
			a_attribute_attached: a_attribute /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Invalid attribute %"" + a_attribute.as_string_32 + "%"."
		ensure
			result_attached: Result /= Void
		end

	err_invalid_tag_position (a_tag: STRING_GENERAL): STRING_GENERAL is
			-- Invalid tag error
		require
			a_tag_attached: a_tag /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Invalid tag/tag position %"" + a_tag.as_string_32 + "%"."
		ensure
			result_attached: Result /= Void
		end

	err_uuid_invalid (a_invalid_uuid: STRING_GENERAL): STRING_GENERAL is
			-- UUID invalid error
		require
			a_invalid_uuid_attached: a_invalid_uuid /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "UUID %"" + a_invalid_uuid.as_string_32 + "%" is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_name_missing: STRING_GENERAL is
			-- Variable metric name missing error
		do
			create {STRING_32}Result.make (0)
			Result := "Variable metric name is missing."
		ensure
			result_attached: Result /= Void
		end

	err_coefficient_missing: STRING_GENERAL is
			-- Coefficient missing error
		do
			create {STRING_32}Result.make (0)
			Result := "Coefficient of variable metric is missing."
		ensure
			result_attached: Result /= Void
		end

	err_coefficient_invalid (a_coefficient: STRING_GENERAL): STRING_GENERAL is
			-- Coefficient invalid error
		require
			a_coefficient_attached: a_coefficient /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Coefficient %"" + a_coefficient.as_string_32 + "%" of variable metric is invalid. A real number is expected."
		ensure
			result_attached: Result /= Void
		end

	err_case_sensitive_attr_missing: STRING_GENERAL is
			-- Case sensitive attribute missing error
		do
			create{STRING_32} Result.make (0)
			Result := "Attribute %"case_sensitive%" is missing."
		ensure
			result_attached: Result /= Void
		end

	err_regular_expression_attr_missing: STRING_GENERAL is
			-- Regular expression attribute missing error
		do
			create{STRING_32} Result.make (0)
			Result := "Attribute %"regular_expression%" is missing."
		ensure
			result_attached: Result /= Void
		end

	err_case_sensitive_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Case sensitive attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Value %"" + a_value.as_string_32 + "%" of attribute %"case_sensitive%" is invalid. A boolean is expected."
		ensure
			result_attached: Result /= Void
		end

	err_regular_expression_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Regular expression attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Value %"" + a_value.as_string_32 + "%" of attribute %"regular_expression%" is invalid. A boolean is expected."
		ensure
			result_attached: Result /= Void
		end

	err_criterion_name_missing: STRING_GENERAL is
			-- Criterion name missing error
		do
			create {STRING_32} Result.make (0)
			Result := "Criterion name is missing."
		ensure
			result_attached: Result /= Void
		end

	err_unit_name_missing: STRING_GENERAL is
			-- Unit name missing error
		do
			create {STRING_32} Result.make (0)
			Result := "Unit name is missing."
		ensure
			result_attached: Result /= Void
		end

	err_unit_name_invalid (a_unit_name: STRING_GENERAL): STRING_GENERAL is
			-- Unit name invalid error
		require
			a_unit_name_attached: a_unit_name /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Unit name %"" + a_unit_name.as_string_32 + "%" is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_negation_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Negation attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Value %"" + a_value.as_string_32 + "%" of attribute %"negation%" is invalid. A boolean is expected."
		ensure
			result_attached: Result /= Void
		end

	err_only_current_version_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Only current version attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Value %"" + a_value.as_string_32 + "%" of attribute %"only_current_version%" is invalid. A boolean is expected."
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_id_is_missing: STRING_GENERAL is
			-- Domain item id missing error
		do
			create {STRING_32} Result.make (0)
			Result := "Domain item id is missing."
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_type_is_missing: STRING_GENERAL is
			-- Domain item type missing error
		do
			create {STRING_32} Result.make (0)
			Result := "Domain item type is missing."
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_type_invalid (a_type: STRING_GENERAL): STRING_GENERAL is
			-- Domain item type invalid error
		require
			a_type_attached: a_type /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Domain item type %"" + a_type.as_string_32 + "%" is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_library_target_uuid_invalid (a_uuid: STRING_GENERAL): STRING_GENERAL is
			-- Library target UUID invalid error
		require
			a_uuid_attached: a_uuid /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Library target UUID %"" + a_uuid.as_string_32 + "%" is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_metric_type_missing: STRING_GENERAL is
			-- Metric type missing error
		do
			create {STRING_32} Result.make (0)
			Result := "Attribute %"type%" is missing ."
		ensure
			result_attached: Result /= Void
		end

	err_metric_type_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Metric type attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Value %"" + a_value.as_string_32 + "%" of attribute %"type%" is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_archive_time_missing: STRING_GENERAL is
			-- Archive time missing error
		do
			create {STRING_32} Result.make (0)
			Result := "Attribute %"time%" is missing."
		ensure
			result_attached: Result /= Void
		end

	err_archive_time_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Archive time attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Value %"" + a_value.as_string_32 + "%" of attribute %"time%" is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_archive_value_missing: STRING_GENERAL is
			-- Archive value missing error
		do
			create {STRING_32} Result.make (0)
			Result := "Archive value is missing."
		ensure
			result_attached: Result /= Void
		end

	err_archive_value_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Archive value attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Value %"" + a_value.as_string_32 + "%" of attribute %"value%" is invalid. A real number is expected."
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_missing: STRING_GENERAL is
			-- Variable metric missing error
		do
			create {STRING_32} Result.make (0)
			Result := "Variable metric is missng. At least one variable metric should be defined."
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_not_defined: STRING_GENERAL is
			-- Variable metric not defined error
		do
			create {STRING_32} Result.make (0)
			Result := "No definition for variable metric."
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_unit_not_correct (a_wrong_unit, a_right_unit: STRING_GENERAL): STRING_GENERAL is
			-- Variable metric unit not correct error
		require
			a_wrong_unit_attached: a_wrong_unit /= Void
			a_right_unit_attached: a_right_unit /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Unit %"" + a_wrong_unit.as_string_32 + "%" of variable metric is different from unit %"" + a_right_unit.as_string_32 + "%" of linear metric."
		ensure
			result_attached: Result /= Void
		end

	err_numerator_metric_not_defined (a_numerator: STRING_GENERAL): STRING_GENERAL is
			-- Numerator metric not defined error
		require
			a_numerator_attached: a_numerator /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Numerator metric %"" + a_numerator.as_string_32 + " is not defined."
		ensure
			result_attached: Result /= Void
		end

	err_denominator_metric_not_defined (a_denominator: STRING_GENERAL): STRING_GENERAL is
			-- Numerator metric not defined error
		require
			a_denominator_attached: a_denominator /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Denominator metric %"" + a_denominator.as_string_32 + " is not defined."
		ensure
			result_attached: Result /= Void
		end

	err_basic_metric_unit_not_correct (a_criterion_unit, a_metric_unit: STRING_GENERAL): STRING_GENERAL is
			-- Basic metric unit not correct error
		require
			a_criterion_unit_attached: a_criterion_unit /= Void
			a_metric_unit_attached: a_metric_unit /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Criterion unit %"" + a_criterion_unit.as_string_32 + "%" is different from basic metric unit %"" + a_metric_unit.as_string_32 + "%"."
		ensure
			result_attached: Result /= Void
		end

	err_criterion_not_exist (a_criterion_name, a_unit_name: STRING_GENERAL): STRING_GENERAL is
			-- Criterion doesn't exist error
		require
			a_criterion_name_attached: a_criterion_name /= Void
			a_unit_name_attached: a_unit_name /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Criterion %"" + a_criterion_name.as_string_32 + "%" of unit %"" + a_unit_name.as_string_32 + "%" doesn't exits."
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_not_exist: STRING_GENERAL is
			-- Domain item doesn't exits error
		do
			create {STRING_32}Result.make (0)
			Result := "No domain item defined. At least one domain item should be defined in a relation criterion."
		ensure
			result_attached: Result /= Void
		end

	err_text_in_text_criterion_empty: STRING_GENERAL is
			-- Text in text criterion empty error
		do
			create {STRING_32}Result.make (0)
			Result := "Text in text criterion is empty."
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_empty: STRING_GENERAL is
			-- Metric name is empty error
		do
			create {STRING_32}Result.make (0)
			Result := "Metric name is empty."
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_invalid (a_invalid_name: STRING_GENERAL): STRING_GENERAL is
			-- Metric name invalid error
		require
			a_invalid_name_attached: a_invalid_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Metric name %"" + a_invalid_name.as_string_32 + "%" is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_invalid_feature_domain_item (a_feature_name, a_domain_item_id: STRING_GENERAL): STRING_GENERAL is
			-- Invalid faeture domain item error
		require
			a_feature_name_attached: a_feature_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Feature `" + a_feature_name.as_string_32 + "' (ID = %"" + a_domain_item_id.as_string_32 + "%") is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_invalid_folder_domain_item (a_folder_name, a_domain_item_id: STRING_GENERAL): STRING_GENERAL is
			-- Invalid folder domain item error
		require
			a_folder_name_attached: a_folder_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Folder %"" + a_folder_name.as_string_32 + "%" (ID = %"" + a_domain_item_id.as_string_32 + "%") is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_invalid_group_domain_item (a_group_name, a_domain_item_id: STRING_GENERAL): STRING_GENERAL is
			-- Invalid group domain item error
		require
			a_group_name_attached: a_group_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Group %"" + a_group_name.as_string_32 + "%" (ID = %"" + a_domain_item_id.as_string_32 + "%") is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_invalid_class_domain_item (a_class_name, a_domain_item_id: STRING_GENERAL): STRING_GENERAL is
			-- Invalid class domain item error
		require
			a_class_name_attached: a_class_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			create {STRING_32}Result.make (0)
			Result := "Class %"" + a_class_name.as_string_32 + "%" (ID = %"" + a_domain_item_id.as_string_32 + "%") is invalid."
		ensure
			result_attached: Result /= Void
		end

	err_recursive_metric_definition (a_recursive_name: STRING_GENERAL): STRING_GENERAL is
			-- Recursive metric definition error
		require
			a_recursive_name_attached: a_recursive_name /= Void
		do
			Result := "Recursive definition for metric name %"" + a_recursive_name.as_string_32 + "%"."
		ensure
			result_attached: Result /= Void
		end

	err_metric_loading_error (a_real_error: STRING_GENERAL): STRING_GENERAL is
			-- Metric loading error.
		require
			a_real_error_attached: a_real_error /= Void
		do
			create {STRING_32} Result.make (0)
			Result := "Metrics loading error:%N" + a_real_error.as_string_32
		ensure
			result_attached: Result /= Void
		end


feature -- To do messages

	variable_metric_missing_to_do: STRING_GENERAL is
		do
			create {STRING_32} Result.make (0)
			Result := linear_metric_info + ("Make sure that at lease one variable metric is listed in a linear metric definition.").as_string_32
		ensure
			result_attached: Result /= Void
		end

	variable_metric_not_defined_to_do: STRING_GENERAL is
		do
			create {STRING_32} Result.make (0)
			Result := linear_metric_info + ("Make sure every variable metric referenced by a linear metric is defined.").as_string_32
		ensure
			result_attached: Result /= Void
		end

	variable_metric_unit_not_correct_to_do: STRING_GENERAL is
		do
			create {STRING_32} Result.make (0)
			Result := linear_metric_info + ("Make sure unit of every variable metric is same as that of the linear metric.").as_string_32
		ensure
			result_attached: Result /= Void
		end

	numerator_denominator_metric_not_defined_to_do: STRING_GENERAL is
		do
			create {STRING_32} Result.make (0)
			Result := ratio_metric_info + ("Make sure that numerator and denominator metric referenced by ratio metric are defined.").as_string_32
		ensure
			result_attached: Result /= Void
		end

	unit_in_basic_metric_not_same_to_do: STRING is "Make sure every (recursive) criterion in basic metric is of the same unit with that basic metric."
	criterion_not_exist_to_do: STRING is "Make sure that the criterion of given unit exists."
	domain_item_not_exists_to_do: STRING is "Make sure that at least one domain item is listed in a domain criterion."
	text_in_text_criterion_empty_to_do: STRING is "Make sure to specify a non-empty string for a text criterion."

	metric_name_empty_to_do: STRING_GENERAL is
		do
			create {STRING_32} Result.make (0)
			Result := metric_name_info + ("Make sure metric name is not empty and contains valid charactors.").as_string_32
		ensure
			result_attached: Result /= Void
		end

	recursive_definition_to_do: STRING is "In linear metric, make sure that every variable metric doesn't involve %Nrecursive metric.%NIn ratio metric, make sure that numerator metric or denominator metric %Ndoesn't involve recursive metric."

	metric_name_info: STRING_GENERAL is
			-- Information of metric name
		do
			create {STRING_32} Result.make (0)
			Result := "A valid metric name is a non-empty string which doesn't start with space, enter or tab, and doesn't end with space, enter or tab.%NMake sure specified metric name is valid."
		ensure
			result_attached: Result /= Void
		end

	linear_metric_info: STRING_GENERAL is
			-- Information of linear metric
		do
			create {STRING_32} Result.make (0)
			Result := "Linear metric is of the form:%N%N%Ta * metric1 + b * metric2 + c * metric3 + ...%N%Na, b, c are coefficients and %Nmetric1, metric2, metric3 are variable metrics.%N%N"
		ensure
			result_attached: Result /= Void
		end

	ratio_metric_info: STRING_GENERAL is
			-- Information of ratio metric
		do
			create {STRING_32} Result.make (0)
			Result := "Ratio metric is of the form:%N%N%TNumerator metric / Denominator metric%N%NNumerator metric and denominator metric can be of any valid unit.%N%N"
		ensure
			result_attached: Result /= Void
		end

	invalid_domain_item_info: STRING_GENERAL is
			-- Information of invalid domain item
		do
			create {STRING_32} Result.make (0)
			Result := "Make sure that every item specified in a domain is valid.%NFollowing are some reasons which can cause a domain item invalid:%N * Domain item ID is damaged or incorrect.%N * Domain item doesn't exist (Maybe due to removal/rename of a folder, group, class or feature).%N"
		ensure
			result_attached: Result /= Void
		end

feature -- Separator

	new_line_separator: STRING_GENERAL is
			-- New line separator
		do
			create {STRING_32}Result.make (0)
			Result := ("%N").as_string_32
		ensure
			result_attached: Result /= Void
		end

	comma_separator: STRING_GENERAL is
			-- Comma separator
		do
			create {STRING_32}Result.make (0)
			Result := (", ").as_string_32
		ensure
			result_attached: Result /= Void
		end

	space_separator: STRING_GENERAL is
			-- Space separator
		do
			create {STRING_32}Result.make (0)
			Result := (" ").as_string_32
		ensure
			result_attached: Result /= Void
		end

	location_separator: STRING_GENERAL is
			-- Space separator
		do
			create {STRING_32}Result.make (0)
			Result := (" : ").as_string_32
		ensure
			result_attached: Result /= Void
		end

feature -- Utilities

	quoted_name (a_name: STRING_GENERAL; a_prefix: STRING_GENERAL): STRING_GENERAL is
			-- Quoted name of `a_name'.
			-- If `a_prefix' is attached, add `a_prefix' before `a_name'.
			-- For example, when `a_name' is "Classes", and `a_prefix' is "metric",
			-- result will be: metric "Classes".
		require
			a_name_attached: a_name /= Void
		local
			l_temp_str: STRING_32
		do
			create l_temp_str.make (128)
			if a_prefix /= Void then
				l_temp_str.append (a_prefix)
				l_temp_str.append_character (' ')
			end
			l_temp_str.append ("%"")
			l_temp_str.append (a_name)
			l_temp_str.append ("%"")
			Result := l_temp_str
		ensure
			result_attached: Result /= Void
		end

	concatenated_string (a_str_list: LINEAR [STRING_GENERAL]; a_separator: STRING_GENERAL): STRING_GENERAL is
			-- Concatenated string of all strings from `a_str_list' with `a_separactor' separated in between			
			-- If `a_str_list' is empty, return Void.
		require
			a_str_list_attached: a_str_list /= Void
			a_separator_attached: a_separator /= Void
		local
			l_temp_str: STRING_32
		do
			create l_temp_str.make (128)
			if not a_str_list.is_empty then
				from
					a_str_list.start
					check a_str_list.item /= Void end
					l_temp_str.append (a_str_list.item)
					a_str_list.forth
				until
					a_str_list.after
				loop
					l_temp_str.append (a_separator)
					check a_str_list.item /= Void end
					l_temp_str.append (a_str_list.item)
					a_str_list.forth
				end
			end
			if not l_temp_str.is_empty then
				Result := l_temp_str
			end
		ensure
			good_result: Result /= Void implies not Result.is_empty
		end

	location_section (a_section_name, a_section_type: STRING_GENERAL): STRING_GENERAL is
			-- Location section.
			-- For example, if `a_section_name" is "Classes" and `a_section_type' is "basic metric",
			-- the result will be: basic metric "Classes".
		require
			a_section_name_attached: a_section_name /= Void
			a_section_type_attached: a_section_Type /= Void
		do
			Result := quoted_name (a_section_name, a_section_type)
		ensure
			result_attached: Result /= Void
		end

	location (a_location_section_array: ARRAY [STRING_GENERAL]): STRING_GENERAL is
			-- Location which is comprised of several location sections specified in `a_location_section_array'
			-- For example, if a_location_section_array' is <<basic metric "Classes", "criterion "is_effective">>,
			-- the result will be: in location basic metric "Classes" : criterion "is_effective".
		require
			a_location_section_array_valid:
				a_location_section_array /= Void and then not a_location_section_array.is_empty
		do
			Result := concatenated_string (a_location_section_array.linear_representation, location_separator)
		ensure
			result_attached: Result /= Void
		end

	metric_location_section (a_metric_name, a_metric_type_name: STRING_GENERAL): STRING_GENERAL is
			-- Location section of `a_metric_name' whose metric type is `a_metric_type_name'
		require
			a_metric_name_attached: a_metric_name /= Void
			a_metric_type_name_attached: a_metric_type_name /= Void
		do
			Result := location_section (a_metric_name, a_metric_type_name)
		ensure
			result_attached: Result /= Void
		end

	linear_metric_location_section (a_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Linear metric location section
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := metric_location_section (a_metric_name, l_linear_metric)
		ensure
			result_attached: Result /= Void
		end

	basic_metric_location_section (a_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Basic metric location section
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := metric_location_section (a_metric_name, l_basic_metric)
		ensure
			result_attached: Result /= Void
		end

	ratio_metric_location_section (a_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Ratio metric location section
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := metric_location_section (a_metric_name, l_ratio_metric)
		ensure
			result_attached: Result /= Void
		end

	criterion_location_section (a_criterion_name: STRING_GENERAL): STRING_GENERAL is
			-- Criterion location section
		require
			a_criterion_name_attached: a_criterion_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := location_section (a_criterion_name, l_criterion)
		ensure
			result_attached: Result /= Void
		end

	variable_metric_location (a_linear_metric_name, a_variable_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Variable metric location
		require
			a_variable_metric_name_attached: a_variable_metric_name /= Void
			a_linear_metric_name_attached: a_linear_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := location (<<location_section (a_linear_metric_name, l_linear_metric), location_section (a_variable_metric_name, l_variable_metric)>>)
		ensure
			result_attached: Result /= Void
		end

	criterion_location (a_basic_metric_name, a_criterion_name: STRING_GENERAL): STRING_GENERAL is
			-- Criterion location
		require
			a_basic_metric_name_attached: a_basic_metric_name /= Void
			a_criterion_name_attached: a_criterion_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := location (<<basic_metric_location_section (a_basic_metric_name), criterion_location_section (a_criterion_name)>>)
		ensure
			result_attached: Result /= Void
		end

	numerator_location (a_ratio_metric_name, a_numerator_name: STRING_GENERAL): STRING_GENERAL is
			-- Numerator metric local
		require
			a_numerator_name_attached: a_numerator_name /= Void
			a_ratio_metric_name_attached: a_ratio_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := location (<<ratio_metric_location_section (a_ratio_metric_name), location_section (a_numerator_name, l_numerator_metric)>>)
		ensure
			result_attached: Result /= Void
		end

	denominator_location (a_ratio_metric_name, a_denominator_name: STRING_GENERAL): STRING_GENERAL is
			-- Denominator metric local
		require
			a_denominator_name_attached: a_denominator_name /= Void
			a_ratio_metric_name_attached: a_ratio_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := location (<<ratio_metric_location_section (a_ratio_metric_name), location_section (a_denominator_name, l_denominator_metric)>>)
		ensure
			result_attached: Result /= Void
		end

	archive_location (a_archive_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Metric archive location
		require
			a_archive_metric_name_attached: a_archive_metric_name /= Void
		do
			create {STRING_32}Result.make (0)
			Result := location_section (a_archive_metric_name, l_metric_archive_node)
		ensure
			result_attached: Result /= Void
		end

	location_string (a_location: STRING_GENERAL): STRING_GENERAL is
			-- Location string
		require
			a_location_attached: a_location /= Void
		do
			create {STRING_32} Result.make (0)
			Result := " Location: " + a_location.as_string_32
		ensure
			result_attached: Result /= Void
		end

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

indexing
	description: "Names used in metric interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_NAMES

inherit
	SHARED_LOCALE

feature -- Text

	e_evaluate_metric: STRING_GENERAL is do Result := locale.translate ("Evaluate metric: ") end
	e_not_evaluated: STRING_GENERAL is do Result := locale.translate ("Not evaluated") end
	e_evaluating: STRING_GENERAL is do Result := locale.translate ("Evaluating: ") end
	e_evaluating_value: STRING_GENERAL is do Result := locale.translate ("Evaluating...") end
	e_undefined_value: STRING_GENERAL is do Result := locale.translate ("Undefined") end
	e_value: STRING_GENERAL is do Result := locale.translate ("Value:") end
	e_interrupted_by_user: STRING_GENERAL is do Result := locale.translate ("Interrupted by user") end
	e_interrupted_by_compile: STRING_GENERAL is do Result := locale.translate ("Interrupted because Eiffel complication starts") end
	e_no_metric_is_selected: STRING_GENERAL is do Result := locale.translate ("No metric is selected.") end

feature -- Titles

	t_expression: STRING_GENERAL is do Result := locale.translate ("Expression:") end
	t_criterion: STRING_GENERAL is do Result := locale.translate ("Criterion") end
	t_properties: STRING_GENERAL is do Result := locale.translate ("Properties") end
	t_status: STRING_GENERAL is do Result := locale.translate ("Status") end
	t_ok: STRING_GENERAL is do Result := locale.translate ("OK") end
	t_cancel: STRING_GENERAL is do Result := locale.translate ("Cancel") end
	t_type: STRING_GENERAL is do Result := locale.translate ("type") end
	t_value_of_reference: STRING_GENERAL is do Result := locale.translate ("Reference value") end
	t_value_of_current: STRING_GENERAL is do Result := locale.translate ("Current value") end
	t_difference: STRING_GENERAL is do Result := locale.translate ("Difference") end
	t_ratio: STRING_GENERAL is do Result := locale.translate ("ratio") end
	t_basic: STRING_GENERAL is do Result := locale.translate ("basic") end
	t_linear: STRING_GENERAL is do Result := locale.translate ("linear") end
	t_definition_tab: STRING_GENERAL is do Result := locale.translate ("Metric Definition") end
	t_evaluation_tab: STRING_GENERAL is do Result := locale.translate ("Metric Evaluation") end
	t_archive_tab: STRING_GENERAL is do Result := locale.translate ("Metric Archive") end
	t_detail_result_tab: STRING_GENERAL is do Result := locale.translate ("Detailed Result") end
	t_history_tab: STRING_GENERAL is do Result := locale.translate ("Metric History") end
	t_path: STRING_GENERAL is do Result := locale.translate ("Location") end
	t_group: STRING_GENERAL is do Result := locale.translate ("Group") end
	t_metrics: STRING_GENERAL is do Result := locale.translate ("Metrics") end
	t_coefficient: STRING_GENERAL is do Result := locale.translate ("Coefficient") end
	t_metric_valid: STRING_GENERAL is do Result := locale.translate ("Metric is valid.") end
	t_save_metric: STRING_GENERAL is do Result := locale.translate ("Current metric has been modified, save it?") end
	t_discard_remove_prompt: STRING_GENERAL is do Result := locale.translate ("Do not ask me again and always remove selected metric") end
	t_discard_save_prompt: STRING_GENERAL is do Result := locale.translate ("Do not ask me again and always save modified metric") end
	t_name_cannot_be_empty: STRING_GENERAL is do Result := locale.translate ("Metric name is empty.") end
	t_metric_with_name: STRING_GENERAL is do Result := locale.translate ("Metric with name") end
	t_metric_exists: STRING_GENERAL is do Result := locale.translate ("already exists.") end
	t_metric_not_saved: STRING_GENERAL is do Result := locale.translate ("Note: Metric is not saved.") end
	t_select_archive: STRING_GENERAL is do Result := locale.translate ("Select a metric archive file") end
	t_metric_no_metric_selected: STRING_GENERAL is do Result := locale.translate ("No metric is selected") end
	t_metric_is_not_valid: STRING_GENERAL is do Result := locale.translate ("is invalid") end
	t_selected_metric: STRING_GENERAL is do Result := locale.translate ("Selected metric") end
	t_selected_file_not_exists: STRING_GENERAL is do Result := locale.translate ("Specified file doesn't exist") end
	t_selected_archive_not_valid: STRING_GENERAL is do Result := locale.translate ("Metric archive in specified file is not valid, it must be cleaned") end
	t_metric: STRING_GENERAL is do Result := locale.translate ("metric") end
	t_metric_name_can_not_be_empty: STRING_GENERAL is do Result := locale.translate ("Metric name cannot be empty") end
	t_remove_metric: STRING_GENERAL is do Result := locale.translate ("Remove metric ") end
	t_no_archive_selected: STRING_GENERAL is do Result := locale.translate ("No metric archive is selected.") end
	t_archive_management: STRING_GENERAL is do Result := locale.translate ("Archive Management") end
	t_archive_comparison: STRING_GENERAL is do Result := locale.translate ("Archive Comparison") end
	t_location: STRING_GENERAL is do Result := locale.translate ("Location") end
	t_select_source_domain: STRING_GENERAL is do Result := locale.translate ("Select input domain:") end
	t_select_metric: STRING_GENERAL is do Result := locale.translate ("Select metric:") end
	t_select_reference_archive: STRING_GENERAL is do Result := locale.translate ("Select reference archive (URL acceptable):") end
	t_select_current_archive: STRING_GENERAL is do Result := locale.translate ("Select current archive (URL acceptable):") end
	t_archive_comparison_result: STRING_GENERAL is do Result := locale.translate ("Archive comparison result:") end
	t_clean: STRING_GENERAL is do Result := locale.translate ("Clean") end
	t_compare: STRING_GENERAL is do Result := locale.translate ("Compare") end
	t_input_domain: STRING_GENERAL is do Result := locale.translate ("Input domain") end
	t_result: STRING_GENERAL is do Result := locale.translate ("Results:") end
	t_input_domain_title: STRING_GENERAL is do Result := locale.translate ("Input domain:") end
	t_metric_criterion_definition: STRING_GENERAL is do Result := locale.translate ("Criterion definition:") end
	t_select_domain_scope: STRING_GENERAL is do Result := locale.translate ("Select domain scope") end
	t_predefined_text_not_editable: STRING_GENERAL is do Result := locale.translate ("Text not editable because current metric is predefined.") end
	t_text_not_editable: STRING_GENERAL is do Result := locale.translate ("Text not editable.") end
	t_metric_definition: STRING_GENERAL is do Result := locale.translate ("Metric definition") end
	t_checking_metric_vadility: STRING_GENERAL is do Result := locale.translate ("Checking metric validity") end
	t_loading_metrics: STRING_GENERAL is do Result := locale.translate ("Loading metrics...") end
	t_analysing_archive: STRING_GENERAL is do Result := locale.translate ("Analyzing metric archive(s)...") end
	t_saving_metrics: STRING_GENERAL is do Result := locale.translate ("Saving metrics...") end
	t_removing_metrics: STRING_GENERAL is do Result := locale.translate ("Removing metrics...") end
	t_result_not_up_to_date: STRING_GENERAL is do Result := locale.translate ("Current metric result may not be up-to-date") end
	t_feature_version_setting: STRING_GENERAL is do Result := locale.translate ("Feature version setting:") end
	t_only_current_version: STRING_GENERAL is do Result := locale.translate ("Only current version") end
	t_descendant_version: STRING_GENERAL is do Result := locale.translate ("Current version and all its descendant versions") end
	t_to_do: STRING_GENERAL is do Result := locale.translate ("To do:") end
	t_close: STRING_GENERAL is do Result := locale.translate ("Close") end
	t_metric_definition_error_wizard: STRING_GENERAL is do Result := locale.translate ("Metric definition error wizard") end
	t_metric_archive_calculation_finished: STRING_GENERAL is do Result := locale.translate ("Metric archive calculation finished.") end
	t_import_metric_title: STRING_GENERAL is do Result := locale.translate ("Import Metrics") end
	t_import_selected_metrics: STRING_GENERAL is do Result := locale.translate ("Import Selected Metrics") end
	t_backup_user_defined_metrics: STRING_GENERAL is do Result := locale.translate ("Backup User-defined Metrics") end
	t_metric_definition_file: STRING_GENERAL is do Result := locale.translate ("Metric Definition File:") end
	t_load: STRING_GENERAL is do Result := locale.translate ("Load") end
	t_import: STRING_GENERAL is do Result := locale.translate ("Import") end
	t_metric_original_name: STRING_GENERAL is do Result := locale.translate ("Original metric name") end
	t_metric_name: STRING_GENERAL is do Result := locale.translate ("Metric name") end
	t_metric_description: STRING_GENERAL is do Result := locale.translate ("Description") end
	t_metric_unit: STRING_GENERAL is do Result := locale.translate ("Unit") end
	t_select_all_metrics: STRING_GENERAL is do Result := locale.translate ("Select All Metrics") end
	t_deselect_all_metrics: STRING_GENERAL is do Result := locale.translate ("Deselect All Metrics") end
	t_select_integral_metrics: STRING_GENERAL is do Result := locale.translate ("Select Integral Metrics") end
	t_deselect_integral_metrics: STRING_GENERAL is do Result := locale.translate ("Deselect Integral Metrics") end

	t_backup_metrics: STRING_GENERAL is do Result := locale.translate ("Backup user-defined metrics") end
	t_select_file_for_backup: STRING_GENERAL is do Result := locale.translate ("Select a file for user-defined metrics backup:") end
	t_backup: STRING_GENERAL is do Result := locale.translate ("Backup") end
	t_importing_metrics: STRING_GENERAL is do Result := locale.translate ("Importing metrics...") end
	t_metrics_imported: STRING_GENERAL is do Result := locale.translate ("Metric(s) imported.") end
	t_metric_backuped: STRING_GENERAL is do Result := locale.translate ("User-defined metrics backup finished.") end
	t_metrics_list: STRING_GENERAL is do Result := locale.translate ("Metric List:") end
	t_short_line: STRING_GENERAL is do Result := locale.translate ("-") end
	t_archive_not_up_to_date: STRING_GENERAL is do Result := locale.translate ("Current archive value may not up-to-date") end
	err_input_domain_invalid: STRING_GENERAL is do Result := locale.translate ("Input domain invalid") end
	t_previous_value: STRING_GENERAL is do Result := locale.translate ("Previous value") end
	t_calculated_time: STRING_GENERAL is do Result := locale.translate ("Calculated time") end

	f_run_history_recalculation: STRING_GENERAL is do Result := locale.translate ("Recalculate selected metric(s)") end
	f_stop_history_recalculation: STRING_GENERAL is do Result := locale.translate ("Stop metric recalculation") end
	f_remove_history_node: STRING_GENERAL is do Result := locale.translate ("Remove selected metric history") end
	f_display_history_in_tree_view: STRING_GENERAL is do Result := locale.translate ("Display history in tree view?") end
	f_send_to_history: STRING_GENERAL is do Result := locale.translate ("Send last calculated metric value to history") end
	t_hide_old_archive: STRING_GENERAL is do Result := locale.translate ("Hide archives more than ") end
	t_days: STRING_GENERAL is do Result := locale.translate (" days old.") end
	f_keep_archive_detailed_result: STRING_GENERAL is do Result := locale.translate ("Keep detailed result when recalculating archive?") end
	f_keep_metric_detailed_result: STRING_GENERAL is do Result := locale.translate ("Keep detailed result when evaluating metric?") end
	f_remove_detailed_result: STRING_GENERAL is do Result := locale.translate ("Remove detailed result?") end
	t_detailed_result: STRING_GENERAL is do Result := locale.translate ("Result") end
	f_double_click_to_go_to_result_panel: STRING_GENERAL  is do Result := locale.translate ("Double click to go to result panel") end
	f_select_all_history: STRING_GENERAL is do Result := locale.translate ("Select all history items") end
	f_deselect_all_history: STRING_GENERAL is do Result := locale.translate ("Deselect all history items") end
	f_select_recalculatable_history: STRING_GENERAL is do Result := locale.translate ("Select recalculatable history items") end
	f_deselect_recalculatable_history: STRING_GENERAL is do Result := locale.translate ("Deselect recalculatable history items") end
	t_select_all_history: STRING_GENERAL is do Result := locale.translate ("Select All") end
	t_deselect_all_history: STRING_GENERAL is do Result := locale.translate ("Deselect All") end
	t_select_recalculatable_history: STRING_GENERAL is do Result := locale.translate ("Select Recalculatable") end
	t_deselect_recalculatable_history: STRING_GENERAL is do Result := locale.translate ("Deselect Recalculatable") end
	t_filter: STRING_GENERAL is do Result := locale.translate ("Filter") end
	t_setup_feature_domain: STRING_GENERAL is do Result := locale.translate ("Setup feature domain") end
	l_to_do_dialog: STRING_GENERAL is do Result := locale.translate ("To do information") end
	t_add_new_value_evaluator: STRING_GENERAL is do Result := locale.translate ("Add new value evaluator") end
	t_add_new_constant_value_retriever: STRING is do Result := locale.translate ("Add new constant value retriever") end
	t_remove_value_retriever: STRING_GENERAL is do Result := locale.translate ("Remove selected value retriever") end
	t_remove_all_value_retriever: STRING_GENERAL is do Result := locale.translate ("Remove all value retriever") end
	t_setup_value_criterion: STRING_GENERAL is do Result := locale.translate ("Setup value criterion") end
	t_match_all_of_the_following: STRING_GENERAL is do Result := locale.translate ("Match all") end
	t_match_any_of_the_following: STRING_GENERAL is do Result := locale.translate ("Match any") end
	t_select_tester: STRING_GENERAL is do Result := locale.translate ("Select metric value testers:") end
	l_domain: STRING_GENERAL is do Result := locale.translate ("domain") end
	l_error_message: STRING_GENERAL is do Result := locale.translate ("error message") end
	l_setup_metric_value_retriever: STRING_GENERAL is do Result := locale.translate ("Setup metric value retriever") end
	t_add_new_metric_value_retriever: STRING_GENERAL is do Result := locale.translate ("Add new metric value retriever") end

feature -- Titles for editor token

	te_input_domain: STRING is "Input domain"
	te_no_metric: STRING is "No metric"

feature -- Labels

	l_select_input_domain: STRING_GENERAL is do Result := locale.translate ("Select input domain:") end
	l_select_metric: STRING_GENERAL is do Result := locale.translate ("Select metric:") end
	l_parse_error: STRING_GENERAL is do Result := locale.translate ("Parse error:") end
	l_ratio_metric: STRING_GENERAL is do Result := locale.translate ("ratio metric") end
	l_linear_metric: STRING_GENERAL is do Result := locale.translate ("linear metric") end
	l_basic_metric: STRING_GENERAL is do Result := locale.translate ("basic metric") end
	l_denominator_metric: STRING_GENERAL is do Result := locale.translate ("denominator metric") end
	l_numerator_metric: STRING_GENERAL is do Result := locale.translate ("numerator metric") end
	l_variable_metric: STRING_GENERAL is do Result := locale.translate ("variable metric") end
	l_metric_archive_node: STRING_GENERAL is do Result := locale.translate ("metric archive node") end
	l_criterion: STRING_GENERAL is do Result := locale.translate ("criterion") end
	l_name_colon: STRING_GENERAL is do Result := locale.translate ("Name:") end
	l_type_colon: STRING_GENERAL is do Result := locale.translate ("Type:") end
	l_unit_colon: STRING_GENERAL is do Result := locale.translate ("Unit:") end
	l_description_colon: STRING_GENERAL is do Result := locale.translate ("Description:") end
	l_no_result_available: STRING_GENERAL is do Result := locale.translate ("No result available.") end
	l_metric_definition_file: STRING_GENERAL is do Result := locale.translate ("Metrics definition file:") end
	l_use_case_sensitive: STRING_GENERAL is do Result := locale.translate ("Case sensitive") end
	l_use_regular_expression: STRING_GENERAL is do Result := locale.translate ("Use regular expression") end
	l_constant_value: STRING_GENERAL is do Result := locale.translate ("constant value") end
	l_metric_value: STRING_GENERAL is do Result := locale.translate ("metric value") end
	l_value_tester: STRING_GENERAL is do Result := locale.translate ("value tester") end

feature -- Tooltip

	f_quick_metric_definition: STRING_GENERAL is do Result := locale.translate ("Define quick metric") end
	f_run: STRING_GENERAL is do Result := locale.translate ("Run selected metric") end
	f_go_to_definition: STRING_GENERAL is do Result := locale.translate ("Go to definition") end
	f_stop: STRING_GENERAL is do Result := locale.translate ("Stop metric evaluation") end
	f_move_row_up: STRING_GENERAL is do Result := locale.translate ("Move selected row up") end
	f_move_row_down: STRING_GENERAL is do Result := locale.translate ("Move selected row down") end
	f_del_row: STRING_GENERAL is do Result := locale.translate ("Delete selected row") end
	f_clear_rows: STRING_GENERAL is do Result := locale.translate ("Remove all rows") end
	f_indent_with_and_criterion: STRING_GENERAL is do Result := locale.translate ("Indent selected row using an %"AND%" criterion") end
	f_indent_with_or_criterion: STRING_GENERAL is do Result := locale.translate ("Indent selected row using an %"OR%" criterion") end
	f_drop_metric_here: STRING_GENERAL is do Result := locale.translate ("Pick and drop metric here") end
	f_reload_metrics: STRING_GENERAL is do Result := locale.translate ("Reload metrics") end

	f_start_archive: STRING_GENERAL is do Result := locale.translate ("Start metric archive evaluation") end
	f_stop_archive: STRING_GENERAL is do Result := locale.translate ("Stop metric archive evaluation") end
	f_select_exist_archive_file: STRING_GENERAL is do Result := locale.translate ("Select an existing metric archive file") end
	f_clean_archive: STRING_GENERAL is do Result := locale.translate ("Clean archive?") end

	f_compare_archive: STRING_GENERAL is do Result := locale.translate ("Compare metric archive") end
	f_select_current_archive: STRING_GENERAL is do Result := locale.translate ("Select current metric archive file") end
	f_select_reference_archive: STRING_GENERAL is do Result := locale.translate ("Select reference metric archive file") end
	f_select_userdefined_metrics: STRING_GENERAL is do Result := locale.translate ("Select/deselect user-defined metrics") end
	f_select_predefined_metrics: STRING_GENERAL is do Result := locale.translate ("Select/deselect predefined metrics") end
	f_group_metric_by_unit: STRING_GENERAL is do Result := locale.translate ("Group metrics by unit") end

	f_add_scope: STRING_GENERAL is do Result := locale.translate ("Add scope") end
	f_remove_scope: STRING_GENERAL is do Result := locale.translate ("Remove selected scope(s)") end
	f_remove_all_scopes: STRING_GENERAL is do Result := locale.translate ("Remove all scopes") end
	f_delayed_scope: STRING_GENERAL is do Result := locale.translate ("Use input domain as criterion domain.") end
	f_use_delayed_scope: STRING_GENERAL is do Result := locale.translate ("Use delayed domain") end
	f_save: STRING_GENERAL is do Result := locale.translate ("Save") end
	f_new: STRING_GENERAL is do Result := locale.translate ("New metric") end
	f_remove: STRING_GENERAL is do Result := locale.translate ("Remove current selected metric") end
	f_domain_item_invalid: STRING_GENERAL is do Result := locale.translate ("Item invalid in current system") end
	f_application_scope: STRING_GENERAL is do Result := locale.translate ("Add current application target scope") end
	f_search_for_class: STRING_GENERAL is do Result := locale.translate ("Search for group/class/feature") end
	f_filter_result: STRING_GENERAL is do Result := locale.translate ("Filter result which is not visible from input domain") end
	f_pick_and_drop_items: STRING_GENERAL is do Result := locale.translate ("Pick and drop items like group/class/feature here") end
	f_pick_and_drop_metric_and_items: STRING_GENERAL is do Result := locale.translate ("Pick and drop metrics or items like group/class/feature here") end
	f_insert_text_here: STRING_GENERAL is do Result := locale.translate ("Insert text here") end
	f_get_criterion_list: STRING_GENERAL is do Result := locale.translate ("Available criterion list") end;
	f_get_negation: STRING_GENERAL is do Result := locale.translate ("You can put %"not%" before a criterion name to negate it") end
	f_open_metric_file_in_external_editor: STRING_GENERAL is do Result := locale.translate ("Open user defined metric file in external editor") end
	f_create_new_metric_using_current_data: STRING_GENERAL is do Result := locale.translate ("Clone selected metric to a new metric") end
	f_setup_criterion_domain: STRING_GENERAL is do Result := locale.translate ("Setup criterion domain properties") end
	f_setup_criterion_text: STRING_GENERAL is do Result := locale.translate ("Setup criterion text properties") end
	f_double_click_to_go_to_definition: STRING_GENERAL is do Result := locale.translate ("(Double click to go to definition)") end
	f_display_in_percentage: STRING_GENERAL is do Result := locale.translate ("Display result in percentage? (Only applicable for ratio metrics)") end
	f_add_linear_variable_metric: STRING_GENERAL is do Result := locale.translate ("Add selected metric") end
	f_run_metric_again: STRING_GENERAL is do Result := locale.translate ("Evaluate metric again to get up-to-date result") end
	f_auto_go_to_result: STRING_GENERAL is do Result := locale.translate ("Automatically go to result panel after metric evaluation?") end
	f_press_esc_to_wipe_out: STRING_GENERAL is do Result := locale.translate ("Press ESC to wipe out") end
	f_move_unit_up: STRING_GENERAL is do Result := locale.translate ("Move metric unit up.%N") end
	f_move_unit_down: STRING_GENERAL is do Result := locale.translate ("Move metric unit down.%N") end
	f_rearrange_unit: STRING_GENERAL is do Result := locale.translate ("Or you can pick a metric unit and drop it on another metric to rearrange their order.") end
	f_show_to_do_message: STRING_GENERAL is do Result := locale.translate ("Display a message about how to deal with the metric definition error") end
	f_import_metrics: STRING_GENERAL is do Result := locale.translate ("Import metrics from file") end

	l_target_unit: STRING_GENERAL is do Result := locale.translate("Target") end
	l_group_unit: STRING_GENERAL is do Result := locale.translate("Group") end
	l_class_unit: STRING_GENERAL is do Result := locale.translate("Class") end
	l_feature_unit: STRING_GENERAL is do Result := locale.translate("Feature") end
	l_generic_unit: STRING_GENERAL is do Result := locale.translate("Generic") end
	l_assertion_unit: STRING_GENERAL is do Result := locale.translate("Assertion") end
	l_argument_unit: STRING_GENERAL is do Result := locale.translate("Argument") end
	l_line_unit: STRING_GENERAL is do Result := locale.translate("Line") end
	l_compilation_unit: STRING_GENERAL is do Result := locale.translate("Compilation") end
	l_local_unit: STRING_GENERAL is do Result := locale.translate("Local") end
	l_ratio_unit: STRING_GENERAL is do Result := locale.translate("Ratio") end

	l_retrieve_indirect_referenced_class (a_for_supplier: BOOLEAN): STRING_GENERAL is
		do
			if a_for_supplier then
				Result := locale.translate ("Retrieve indirect supplier classes")
			else
				Result := locale.translate ("Retrieve indirect client classes")
			end
		end

	l_retrieve_referenced_class (a_for_supplier: BOOLEAN): STRING_GENERAL is
		do
			if a_for_supplier then
				Result := locale.translate ("Retrieve supplier classes")
			else
				Result := locale.translate ("Retrieve client classes")
			end
		end

	l_retrieve_normally_referenced_class (a_for_supplier: BOOLEAN): STRING_GENERAL is
		do
			if a_for_supplier then
				Result := locale.translate ("Retrieve normally referenced supplier classes")
			else
				Result := locale.translate ("Retrieve normally referenced client classes")
			end
		end

	l_retrieve_only_syntacticall_referenced_class (a_for_supplier: BOOLEAN): STRING_GENERAL is
		do
			if a_for_supplier then
				Result := locale.translate ("Retrieve only syntactially referenced supplier classes")
			else
				Result := locale.translate ("Retrieve only syntactially referenced client classes")
			end
		end

	l_setup_referenced_class_dialog (a_for_supplier: BOOLEAN): STRING_GENERAL is
		do
			if a_for_supplier then
				Result := locale.translate ("Setup supplier classes")
			else
				Result := locale.translate ("Setup client classes")
			end
		end

	l_setup_domain_dialog: STRING_GENERAL is do Result := locale.translate ("Setup domain") end

	l_base_value: STRING_GENERAL is do Result := locale.translate ("Base value") end
	l_operator: STRING_GENERAL is do Result := locale.translate ("Operator") end

feature -- Error/warning message

	wrn_metric_name_exists_in_your_metrics (a_name: STRING_GENERAL): STRING_GENERAL is
			-- Warning message used when in metric import dialog, when a changed metric name causes name crash in a users metrics
		require
			a_name_attached: a_name /= Void
		do
			Result := locale.format_string (locale.translate ("Metric named %"$1%" already exists in your metrics."), [a_name])
		ensure
			result_attached: Result /= Void
		end

	wrn_referenced_metrics_not_selected (a_metric_names: STRING_GENERAL): STRING_GENERAL is
			-- Warning message used when in metric import dialog, when a metric is selected while some of its recursively referenced metrics are not selected
			-- `a_metic_names' is a list of concatenated metric names
		require
			a_metric_names_attached: a_metric_names /= Void
		do
			Result := locale.format_string (locale.translate ("Referenced metric(s): $1 not selected."), [a_metric_names])
		ensure
			result_attached: Result /= Void
		end

	wrn_referenced_metrics_missing (a_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Warning message used when in metric import dialog, when a metric is selected while some of its recursively referenced metrics are not found	
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			Result := locale.format_string (locale.translate ("Referenced metric(s): $1 not found."), [a_metric_name])
		ensure
			result_attached: Result /= Void
		end

	wrn_metric_name_crash (a_name: STRING_GENERAL): STRING_GENERAL is
			-- Warning message used when in metric import dialog, when a metric has name crash with an existing metric named `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			Result := locale.format_string (locale.translate ("There is already a metric named $1.%NChange its name in %"Metric name%" column to make it importable."), [a_name]);
		ensure
			result_attached: Result /= Void
		end

	err_loading_predefined_metrics (a_real_error: STRING_GENERAL): STRING_GENERAL is
			-- Error message when loading predefined metrics
		require
			a_real_error_attached: a_real_error /= Void
		do
			Result := locale.format_string (locale.translate ("When loading predefined metrics:%N$1%NPredefined metrics not loaded."), [a_real_error])
		ensure
			result_attached: Result /= Void
		end

	err_loading_userdefined_metrics (a_real_error: STRING_GENERAL): STRING_GENERAL is
			-- Error message when loading user-defined metrics
		require
			a_real_error_attached: a_real_error /= Void
		do
			Result := locale.format_string (locale.translate ("When loading user-defined metrics:%N$1%NUser-defined metrics not loaded."), [a_real_error])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_tag: STRING_GENERAL is do Result := locale.translate ("Invalid tag.") end
			-- Invalid tag error

	err_invalid_description_tag: STRING_GENERAL is do Result := locale.translate ("Invalid description tag.") end
			-- Invalid description tag error

	err_file_not_readable (a_file_name: STRING_GENERAL): STRING_GENERAL is
			-- File not readable error
		require
			a_file_name_attached: a_file_name /= Void
		do
			Result := locale.format_string (locale.translate ("Cannot open file: $1."), [a_file_name])
		ensure
			result_attached: Result /= Void
		end

	err_file_not_writable (a_file_name: STRING_GENERAL): STRING_GENERAL is
			-- File not writable error
		require
			a_file_name_attached: a_file_name /= Void
		do
			Result := locale.format_string (locale.translate ("Cannot write file: $1."), [a_file_name])
		ensure
			result_attached: Result /= Void
		end

	err_directory_creation_fail (a_dir_name: STRING_GENERAL): STRING_GENERAL is
			-- Directory creation fail error
		require
			a_dir_name_attached: a_dir_name /= Void
		do
			Result := locale.format_string (locale.translate ("Cannot create directroy: $1."), [a_dir_name])
		ensure
			result_attached: Result /= Void
		end

	err_too_many_criteria: STRING_GENERAL is
			-- Too many criteria error
		do
			Result := locale.translate ("Too many crieria is specified in %"criterion%" section. Only one is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_too_many_domain: STRING_GENERAL is
			-- Too many domain error
		do
			Result := locale.translate ("Too many %"domain%" section specified. Only one is expected.")
		ensure
			result_attached: Result /= Void
		end
	err_too_many_criterion_section: STRING_GENERAL is
			-- Too many criterion section error
		do
			Result := locale.translate ("Too many crierion section specified. Only one criterion section is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_exists_in_import_metric_list (a_new_metric_name, a_old_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Error message used when in metric import dialog, when a changed metric name causes name crash in listed metrics to be imported
		require
			a_new_metric_name_attached: a_new_metric_name /= Void
			a_old_metric_name_attached: a_old_metric_name /= Void
		do
			Result := locale.format_string (locale.translate ("There is already metric named %"$1%" in import metric list.%NThe name %"$2%" will be changed back to %"$3%"."), [a_new_metric_name, a_new_metric_name, a_old_metric_name])
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_missing_in_metric_definition: STRING_GENERAL is
			-- Error message given when metric name is missing
		do
			Result :=  locale.translate ("Metric name is missing in metric definition.")
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_missing_in_archive_node: STRING_GENERAL is
			-- Error message given when metric name is missing in archive node
		do
			Result :=  locale.translate ("Metric name is missing in metric archive node.")
		ensure
			result_attached: Result /= Void
		end

	err_duplicated_metric_name (a_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Duplicated metric name error
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			Result := locale.format_string (locale.translate ("Duplicated metric name %"$1%" in metric definition."), [a_metric_name])
		ensure
			result_attached: Result /= Void
		end

	err_numerator_metric_missing: STRING_GENERAL is
			-- Numerator metric missing error
		do
			Result := locale.translate ("Numerator metric is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_denominator_metric_missing: STRING_GENERAL is
			-- Numerator metric missing error
		do
			Result := locale.translate ("Denominator metric is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_uuid_missing: STRING_GENERAL is
			-- UUID missing error	
		do
			Result := locale.translate ("UUID is missing.")
		end

	err_invalid_attribute (a_attribute: STRING_GENERAL): STRING_GENERAL is
			-- Invalid attribute error
		require
			a_attribute_attached: a_attribute /= Void
		do
			Result := locale.format_string (locale.translate ("Invalid attribute %"$1%"."), [a_attribute])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_tag_position (a_tag: STRING_GENERAL): STRING_GENERAL is
			-- Invalid tag error
		require
			a_tag_attached: a_tag /= Void
		do
			Result := locale.format_string (locale.translate ("Invalid tag/tag position %"$1%"."), [a_tag])
		ensure
			result_attached: Result /= Void
		end

	err_uuid_invalid (a_invalid_uuid: STRING_GENERAL): STRING_GENERAL is
			-- UUID invalid error
		require
			a_invalid_uuid_attached: a_invalid_uuid /= Void
		do
			Result := locale.format_string (locale.translate ("UUID %"$1%" is invalid."), [a_invalid_uuid])
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_name_missing: STRING_GENERAL is
			-- Variable metric name missing error
		do
			Result := locale.translate ("Variable metric name is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_coefficient_missing: STRING_GENERAL is
			-- Coefficient missing error
		do
			Result := locale.translate ("Coefficient of variable metric is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_coefficient_invalid (a_coefficient: STRING_GENERAL): STRING_GENERAL is
			-- Coefficient invalid error
		require
			a_coefficient_attached: a_coefficient /= Void
		do
			Result := locale.format_string (locale.translate ("Coefficient %"$1%" of variable metric is invalid. A real number is expected."), [a_coefficient])
		ensure
			result_attached: Result /= Void
		end

	err_case_sensitive_attr_missing: STRING_GENERAL is
			-- Case sensitive attribute missing error
		do
			Result := locale.translate ("Attribute %"case_sensitive%" is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_regular_expression_attr_missing: STRING_GENERAL is
			-- Regular expression attribute missing error
		do
			Result := locale.translate ("Attribute %"regular_expression%" is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_case_sensitive_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Case sensitive attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Value %"$1%" of attribute %"case_sensitive%" is invalid. A boolean is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_regular_expression_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Regular expression attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Value %"$1%" of attribute %"regular_expression%" is invalid. A boolean is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_criterion_name_missing: STRING_GENERAL is
			-- Criterion name missing error
		do
			Result := locale.translate ("Criterion name is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_unit_name_missing: STRING_GENERAL is
			-- Unit name missing error
		do
			Result := locale.translate ("Unit name is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_unit_name_invalid (a_unit_name: STRING_GENERAL): STRING_GENERAL is
			-- Unit name invalid error
		require
			a_unit_name_attached: a_unit_name /= Void
		do
			Result := locale.format_string (locale.translate ("Unit name %"$1%" is invalid."), [a_unit_name])
		ensure
			result_attached: Result /= Void
		end

	err_negation_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Negation attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Value %"$1%" of attribute %"negation%" is invalid. A boolean is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_only_current_version_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Only current version attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Value %"$1%" of attribute %"only_current_version%" is invalid. A boolean is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_id_is_missing: STRING_GENERAL is
			-- Domain item id missing error
		do
			Result := locale.translate ("Domain item id is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_type_is_missing: STRING_GENERAL is
			-- Domain item type missing error
		do
			Result := locale.translate ("Domain item type is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_type_invalid (a_type: STRING_GENERAL): STRING_GENERAL is
			-- Domain item type invalid error
		require
			a_type_attached: a_type /= Void
		do
			Result := locale.format_string (locale.translate ("Domain item type %"$1%" is invalid."), [a_type])
		ensure
			result_attached: Result /= Void
		end

	err_library_target_uuid_invalid (a_uuid: STRING_GENERAL): STRING_GENERAL is
			-- Library target UUID invalid error
		require
			a_uuid_attached: a_uuid /= Void
		do
			Result := locale.format_string (locale.translate ("Library target UUID %"$1%" is invalid."), [a_uuid])
		ensure
			result_attached: Result /= Void
		end

	err_metric_type_missing: STRING_GENERAL is
			-- Metric type missing error
		do
			Result := locale.translate ("Attribute %"type%" is missing .")
		ensure
			result_attached: Result /= Void
		end

	err_metric_type_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Metric type attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Value %"$1%" of attribute %"type%" is invalid."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_archive_time_missing: STRING_GENERAL is
			-- Archive time missing error
		do
			Result := locale.translate ("Attribute %"time%" is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_archive_time_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Archive time attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Value %"$1%" of attribute %"time%" is invalid."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_archive_value_missing: STRING_GENERAL is
			-- Archive value missing error
		do
			Result := locale.translate ("Archive value is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_archive_value_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Archive value attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Value %"$1%" of attribute %"value%" is invalid. A real number is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_missing: STRING_GENERAL is
			-- Variable metric missing error
		do
			Result := locale.translate ("Variable metric is missng. At least one variable metric should be defined.")
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_not_defined: STRING_GENERAL is
			-- Variable metric not defined error
		do
			Result := locale.translate ("No definition for variable metric.")
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_unit_not_correct (a_wrong_unit, a_right_unit: STRING_GENERAL): STRING_GENERAL is
			-- Variable metric unit not correct error
		require
			a_wrong_unit_attached: a_wrong_unit /= Void
			a_right_unit_attached: a_right_unit /= Void
		do
			Result := locale.format_string (locale.translate ("Unit %"$1%" of variable metric is different from unit %"$2%" of linear metric."), [a_wrong_unit, a_right_unit])
		ensure
			result_attached: Result /= Void
		end

	err_numerator_metric_not_defined (a_numerator: STRING_GENERAL): STRING_GENERAL is
			-- Numerator metric not defined error
		require
			a_numerator_attached: a_numerator /= Void
		do
			Result := locale.format_string (locale.translate ("Numerator metric %"$1%" is not defined."), [a_numerator])
		ensure
			result_attached: Result /= Void
		end

	err_denominator_metric_not_defined (a_denominator: STRING_GENERAL): STRING_GENERAL is
			-- Numerator metric not defined error
		require
			a_denominator_attached: a_denominator /= Void
		do
			Result := locale.format_string (locale.translate ("Denominator metric %"$1%" is not defined."), [a_denominator])
		ensure
			result_attached: Result /= Void
		end

	err_basic_metric_unit_not_correct (a_criterion_unit, a_metric_unit: STRING_GENERAL): STRING_GENERAL is
			-- Basic metric unit not correct error
		require
			a_criterion_unit_attached: a_criterion_unit /= Void
			a_metric_unit_attached: a_metric_unit /= Void
		do
			Result := locale.format_string (locale.translate ("Criterion unit %"$1%" is different from basic metric unit %"$2%"."), [a_criterion_unit, a_metric_unit])
		ensure
			result_attached: Result /= Void
		end

	err_criterion_not_exist (a_criterion_name, a_unit_name: STRING_GENERAL): STRING_GENERAL is
			-- Criterion doesn't exist error
		require
			a_criterion_name_attached: a_criterion_name /= Void
			a_unit_name_attached: a_unit_name /= Void
		do
			Result := locale.format_string (locale.translate ("Criterion %"$1%" of unit %"$2%" doesn't exits."), [a_criterion_name, a_unit_name])
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_not_exist: STRING_GENERAL is
			-- Domain item doesn't exits error
		do
			Result := locale.translate ("No domain item defined. At least one domain item should be defined in a relation criterion.")
		ensure
			result_attached: Result /= Void
		end

	err_text_in_text_criterion_empty: STRING_GENERAL is
			-- Text in text criterion empty error
		do
			Result := locale.translate ("Text in text criterion is empty.")
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_empty: STRING_GENERAL is
			-- Metric name is empty error
		do
			Result := locale.translate ("Metric name is empty.")
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_invalid (a_invalid_name: STRING_GENERAL): STRING_GENERAL is
			-- Metric name invalid error
		require
			a_invalid_name_attached: a_invalid_name /= Void
		do
			Result := locale.format_string (locale.translate ("Metric name %"$1%" is invalid."), [a_invalid_name])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_feature_domain_item (a_feature_name, a_domain_item_id: STRING_GENERAL): STRING_GENERAL is
			-- Invalid faeture domain item error
		require
			a_feature_name_attached: a_feature_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			Result := locale.format_string (locale.translate ("Feature `$1' (ID = %"$2%") is invalid."), [a_feature_name, a_domain_item_id])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_folder_domain_item (a_folder_name, a_domain_item_id: STRING_GENERAL): STRING_GENERAL is
			-- Invalid folder domain item error
		require
			a_folder_name_attached: a_folder_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			Result := locale.format_string (locale.translate ("Folder %"$1%" (ID = %"$2%") is invalid."), [a_folder_name, a_domain_item_id])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_group_domain_item (a_group_name, a_domain_item_id: STRING_GENERAL): STRING_GENERAL is
			-- Invalid group domain item error
		require
			a_group_name_attached: a_group_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			Result := locale.format_string (locale.translate ("Group %"$1%" (ID = %"$2%") is invalid."), [a_group_name, a_domain_item_id])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_class_domain_item (a_class_name, a_domain_item_id: STRING_GENERAL): STRING_GENERAL is
			-- Invalid class domain item error
		require
			a_class_name_attached: a_class_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			Result := locale.format_string (locale.translate ("Class %"$1%" (ID = %"$2%") is invalid."), [a_class_name, a_domain_item_id])
		ensure
			result_attached: Result /= Void
		end

	err_recursive_metric_definition (a_recursive_name: STRING_GENERAL): STRING_GENERAL is
			-- Recursive metric definition error
		require
			a_recursive_name_attached: a_recursive_name /= Void
		do
			Result := locale.format_string (locale.translate ("Recursive definition for metric name %"$1%"."), [a_recursive_name])
		ensure
			result_attached: Result /= Void
		end

	err_metric_loading_error (a_real_error: STRING_GENERAL): STRING_GENERAL is
			-- Metric loading error.
		require
			a_real_error_attached: a_real_error /= Void
		do
			Result := locale.format_string (locale.translate ("Metrics loading error:%N$1"), [a_real_error])
		ensure
			result_attached: Result /= Void
		end

	err_metric_not_exist (a_type: STRING_GENERAL): STRING_GENERAL is
			-- Metric doesn't exist error
		require
			a_type_attached: a_type /= Void
			not_a_type_is_empty: not a_type.is_empty
		do
			Result := locale.format_string (locale.translate ("Metric of type %"$1%" doesn't exist or that metric is invalid."), [a_type])
		ensure
			result_attached: Result /= Void
		end

	err_filter_invalid (a_filter: STRING_GENERAL): STRING_GENERAL is
			-- Filter value invalid error
		require
			a_filter_attached: a_filter /= Void
		do
			Result := locale.format_string (locale.translate ("Filter value %"$1%" is invalid."), [a_filter])
		ensure
			result_attached: Result /= Void
		end

	err_numerator_coefficient_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Numerator metric coefficient invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Coefficient %"$1%" for numerator metric is invalid. A real number is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_denominator_coefficient_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
			-- Numerator metric coefficient invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Coefficient %"$1%" for denominator metric is invalid. A real number is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_denominator_coefficient_is_zero: STRING_GENERAL is do Result := locale.translate ("Coefficient for denominator metric is zero. A non-zero real numer is expected.") end

	err_normal_referenced_class_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Normal supplier/client class attribute %"$1%" is invalid. A boolean value is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_only_syntactically_referenced_class_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Only syntactically referenced supplier/client class attribute %"$1%" is invalid. A boolean value is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_indirect_referenced_class_attr_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.format_string (locale.translate ("Indirect supplier/client class attribute %"$1%" is invalid. A boolean value is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_missing: STRING_GENERAL is
			-- Metric name missing error
		do
			Result := locale.translate ("Metric name is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_too_many_tester: STRING_GENERAL is
			-- Too many tester sections error
		do
			Result := locale.translate ("Too many tester sections. Only one tester section is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_operator_missing: STRING_GENERAL is do Result := locale.translate ("Operator in value criterion is missing.") end

	err_operator_invalid (a_operator: STRING_GENERAL): STRING_GENERAL is
			-- Operator invalid error
		require
			a_operator_attached: a_operator /= Void
		do
			Result := locale.format_string (locale.translate ("Operator %"$1%" is invalid. One of the following operators is expected: %"=%", %"/=%", %"<%", %"<=%", %">%", %">=%""), [a_operator])
		ensure
			result_attached: Result /= Void
		end

	err_tester_relation_missing: STRING_GENERAL is do Result := locale.translate ("Relation for value tester is missing.") end

	err_tester_relation_invalid (a_relation: STRING_GENERAL): STRING_GENERAL is
			-- Tester relation invalid error
		require
			a_relation_attached: a_relation /= Void
		do
			Result := locale.format_string ("Value tester relation %"$1%" is invalid. An %"and%" or %"or%" relation is expected.", [a_relation])
		ensure
			result_attached: Result /= Void
		end

	err_no_value_tester_specified: STRING_GENERAL is do Result := locale.translate ("No value tester is specified.") end

	err_base_value_missing: STRING_GENERAL is do Result := locale.translate ("Base value of a value tester is missing.") end

	err_base_value_invalid (a_value: STRING_GENERAL): STRING_GENERAL is
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.translate ("Base value %"$1%" of a value tester is invalid. A real number is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_too_many_value_retriever: STRING_GENERAL is
		do
			Result := locale.translate ("Too many value retrievers nodes. Only one is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_domain_missing: STRING_GENERAL is do Result := locale.translate ("Domain is missing.") end
	err_value_tester_missing: STRING_GENERAL is do Result := locale.translate ("Value tester is missing.") end
	err_value_retriever_missing: STRING_GENERAL is do Result := locale.translate ("Value retriever is missing.") end

feature -- To do messages

	variable_metric_missing_to_do: STRING_GENERAL is
		do
			Result := linear_metric_info.as_string_32 + locale.translate ("Make sure that at lease one variable metric is listed in a linear metric definition.")
		ensure
			result_attached: Result /= Void
		end

	variable_metric_not_defined_to_do: STRING_GENERAL is
		do
			Result := linear_metric_info.as_string_32 + locale.translate ("Make sure every variable metric referenced by a linear metric is defined.")
		ensure
			result_attached: Result /= Void
		end

	variable_metric_unit_not_correct_to_do: STRING_GENERAL is
		do
			Result := linear_metric_info.as_string_32 + locale.translate ("Make sure unit of every variable metric is same as that of the linear metric.")
		ensure
			result_attached: Result /= Void
		end

	numerator_denominator_metric_not_defined_to_do: STRING_GENERAL is
		do
			Result := ratio_metric_info.as_string_32 + locale.translate ("Make sure that numerator and denominator metric referenced by ratio metric are defined.")
		ensure
			result_attached: Result /= Void
		end

	unit_in_basic_metric_not_same_to_do: STRING_GENERAL is do Result := locale.translate ("Make sure every (recursive) criterion in basic metric is of the same unit with that basic metric.") end
	criterion_not_exist_to_do: STRING_GENERAL is do Result := locale.translate ("Make sure that the criterion of given unit exists.") end
	domain_item_not_exists_to_do: STRING_GENERAL is do Result := locale.translate ("Make sure that at least one domain item is listed in a domain criterion.") end
	text_in_text_criterion_empty_to_do: STRING_GENERAL is do Result := locale.translate ("Make sure to specify a non-empty string for a text criterion.") end

	metric_name_empty_to_do: STRING_GENERAL is
		do
			Result := metric_name_info.as_string_32 + locale.translate ("Make sure metric name is not empty and contains valid charactors.")
		ensure
			result_attached: Result /= Void
		end

	recursive_definition_to_do: STRING_GENERAL is do Result := locale.translate ("In linear metric, make sure that every variable metric doesn't involve recursive metric.%NIn ratio metric, make sure that numerator metric or denominator metric doesn't involve recursive metric.") end
	make_sure_denominator_coefficient_non_zero_to_do: STRING_GENERAL is do Result := locale.translate ("Make sure coefficient for denominator metric is a non-zero real number.") end

	no_value_tester_specified_to_do: STRING_GENERAL is do Result := locale.translate ("Make sure that at least one value tester is specified.") end

	metric_name_info: STRING_GENERAL is
			-- Information of metric name
		do
			Result := locale.translate ("A valid metric name is a non-empty string which doesn't start with space, enter or tab, and doesn't end with space, enter or tab.%NMake sure specified metric name is valid.")
		ensure
			result_attached: Result /= Void
		end

	linear_metric_info: STRING_GENERAL is
			-- Information of linear metric
		do
			Result := locale.translate ("Linear metric is of the form:%N%N%Ta * metric1 + b * metric2 + c * metric3 + ...%N%Na, b, c are coefficients and %Nmetric1, metric2, metric3 are variable metrics.%N%N")
		ensure
			result_attached: Result /= Void
		end

	ratio_metric_info: STRING_GENERAL is
			-- Information of ratio metric
		do
			Result := locale.translate ("Ratio metric is of the form:%N%N%T (coefficient * Numerator metric) / (coefficient * Denominator metric)%N%NNumerator metric and denominator metric can be of any valid unit.%N%N")
		ensure
			result_attached: Result /= Void
		end

	invalid_domain_item_info: STRING_GENERAL is
			-- Information of invalid domain item
		do
			Result := locale.translate ("Make sure that every item specified in a domain is valid.%NFollowing are some reasons which can cause a domain item invalid:%N * Domain item ID is damaged or incorrect.%N * Domain item doesn't exist (Maybe due to removal/rename of a folder, group, class or feature).%N")
		ensure
			result_attached: Result /= Void
		end

	metric_invalid_to_do: STRING_GENERAL is
			-- Invalid metric to-do message
		do
			Result := locale.translate ("Make sure that referenced metric exists and is valid.")
		end

feature -- Separator

	new_line_separator: STRING_GENERAL is
			-- New line separator
		do
			Result := "%N"
		ensure
			result_attached: Result /= Void
		end

	comma_separator: STRING_GENERAL is
			-- Comma separator
		do
			Result := ", "
		ensure
			result_attached: Result /= Void
		end

	space_separator: STRING_GENERAL is
			-- Space separator
		do
			Result := " "
		ensure
			result_attached: Result /= Void
		end

	colon: STRING_GENERAL is
			-- Colon
		do
			Result := ":"
		ensure
			result_attached: Result /= Void
		end

	location_connector: STRING_GENERAL is
			-- Location connector
		do
			Result := " -> "
		ensure
			result_attached: Result /= Void
		end

feature -- Utilities

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
			Result := a_section_type.twin
			Result.append ("(")
			Result.append (a_section_name)
			Result.append (")")
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
			Result := concatenated_string (a_location_section_array.linear_representation, location_connector)
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
			Result := metric_location_section (a_metric_name, l_linear_metric)
		ensure
			result_attached: Result /= Void
		end

	basic_metric_location_section (a_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Basic metric location section
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			Result := metric_location_section (a_metric_name, l_basic_metric)
		ensure
			result_attached: Result /= Void
		end

	ratio_metric_location_section (a_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Ratio metric location section
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			Result := metric_location_section (a_metric_name, l_ratio_metric)
		ensure
			result_attached: Result /= Void
		end

	criterion_location_section (a_criterion_name: STRING_GENERAL): STRING_GENERAL is
			-- Criterion location section
		require
			a_criterion_name_attached: a_criterion_name /= Void
		do
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
			Result := location (<<ratio_metric_location_section (a_ratio_metric_name), location_section (a_denominator_name, l_denominator_metric)>>)
		ensure
			result_attached: Result /= Void
		end

	archive_location (a_archive_metric_name: STRING_GENERAL): STRING_GENERAL is
			-- Metric archive location
		require
			a_archive_metric_name_attached: a_archive_metric_name /= Void
		do
			Result := location_section (a_archive_metric_name, l_metric_archive_node)
		ensure
			result_attached: Result /= Void
		end

	location_string (a_location: STRING_GENERAL): STRING_GENERAL is
			-- Location string
		require
			a_location_attached: a_location /= Void
		do
			Result := coloned_string (t_location, True)
			Result.append (a_location)
		ensure
			result_attached: Result /= Void
		end

	visitable_name (a_visitable_type: STRING_GENERAL; a_visitable_name: STRING_GENERAL): STRING_GENERAL is
			-- Visitable name for a visitable whose type is `a_visitable_type' and name is `a_visitable_name'
			-- For example, type is "basic metric" and name is "Classes", we will get "basic metric (Classes)".
		require
			a_visitable_type_attached: a_visitable_type /= Void
			a_visitable_name_attached: a_visitable_name /= Void
		do
			Result := a_visitable_type.twin
			Result.append ("(")
			Result.append (a_visitable_name)
			Result.append (")")
		ensure
			result_attached: Result /= Void
		end

	coloned_string (a_string: STRING_GENERAL; a_first_letter_upper: BOOLEAN): STRING_GENERAL is
			-- String which is `a_string' suffixed with a colon
			-- If `a_first_letter_upper' is True, make sure the first letter of returned string is in upper case (if current locale permits).
		require
			a_string_attached: a_string /= Void
		do
			if a_first_letter_upper then
				Result := first_character_to_upper_case (a_string)
			else
				Result := a_string.twin
			end
			Result.append (colon)
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

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

	e_evaluate_metric: STRING_32 is do Result := locale.translation ("Evaluate metric: ") end
	e_not_evaluated: STRING_32 is do Result := locale.translation ("Not evaluated") end
	e_evaluating: STRING_32 is do Result := locale.translation ("Evaluating: ") end
	e_evaluating_value: STRING_32 is do Result := locale.translation ("Evaluating...") end
	e_undefined_value: STRING_32 is do Result := locale.translation ("Undefined") end
	e_value: STRING_32 is do Result := locale.translation ("Value:") end
	e_interrupted_by_user: STRING_32 is do Result := locale.translation ("Interrupted by user") end
	e_interrupted_by_compile: STRING_32 is do Result := locale.translation ("Interrupted because Eiffel complication starts") end
	e_no_metric_is_selected: STRING_32 is do Result := locale.translation ("No metric is selected.") end

	e_xml_files: STRING_32 is do Result := locale.translation ("XML files") end
	e_all_files: STRING_32 is do Result := locale.translation ("All files") end

feature -- Titles

	t_expression: STRING_32 is do Result := locale.translation ("Expression:") end
	t_criterion: STRING_32 is do Result := locale.translation ("Criterion") end
	t_properties: STRING_32 is do Result := locale.translation ("Properties") end
	t_status: STRING_32 is do Result := locale.translation ("Status") end
	t_ok: STRING_32 is do Result := locale.translation ("OK") end
	t_cancel: STRING_32 is do Result := locale.translation ("Cancel") end
	t_type: STRING_32 is do Result := locale.translation ("type") end
	t_value_of_reference: STRING_32 is do Result := locale.translation ("Reference value") end
	t_value_of_current: STRING_32 is do Result := locale.translation ("Current value") end
	t_difference: STRING_32 is do Result := locale.translation ("Difference") end
	t_ratio: STRING_32 is do Result := locale.translation ("ratio") end
	t_basic: STRING_32 is do Result := locale.translation ("basic") end
	t_linear: STRING_32 is do Result := locale.translation ("linear") end
	t_definition_tab: STRING_32 is do Result := locale.translation ("Metric Definition") end
	t_evaluation_tab: STRING_32 is do Result := locale.translation ("Metric Evaluation") end
	t_archive_tab: STRING_32 is do Result := locale.translation ("Metric Archive") end
	t_detail_result_tab: STRING_32 is do Result := locale.translation ("Detailed Result") end
	t_history_tab: STRING_32 is do Result := locale.translation ("Metric History") end
	t_path: STRING_32 is do Result := locale.translation ("Location") end
	t_group: STRING_32 is do Result := locale.translation ("Group") end
	t_metrics: STRING_32 is do Result := locale.translation ("Metrics") end
	t_coefficient: STRING_32 is do Result := locale.translation ("Coefficient") end
	t_metric_valid: STRING_32 is do Result := locale.translation ("Metric is valid.") end
	t_save_metric: STRING_32 is do Result := locale.translation ("Current metric has been modified, save it?") end
	t_discard_remove_prompt: STRING_32 is do Result := locale.translation ("always remove selected metric") end
	t_discard_save_prompt: STRING_32 is do Result := locale.translation ("always save modified metric") end
	t_name_cannot_be_empty: STRING_32 is do Result := locale.translation ("Metric name is empty.") end
	t_metric_with_name_already_exists (a_metric_name: STRING_GENERAL): STRING_32 is
		require
			a_metric_name_not_void: a_metric_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Metric with name '$1' already exists"), [a_metric_name])
		end
	t_metric_not_saved: STRING_32 is do Result := locale.translation ("Note: Metric is not saved.") end
	t_select_archive: STRING_32 is do Result := locale.translation ("Select a metric archive file") end
	t_metric_no_metric_selected: STRING_32 is do Result := locale.translation ("No metric is selected") end
	t_metric_is_not_valid: STRING_32 is do Result := locale.translation ("is invalid") end
	t_selected_metric: STRING_32 is do Result := locale.translation ("Selected metric") end
	t_selected_file_not_exists: STRING_32 is do Result := locale.translation ("Specified file doesn't exist") end
	t_selected_archive_not_valid: STRING_32 is do Result := locale.translation ("Metric archive in specified file is not valid, it must be cleaned") end
	t_metric: STRING_32 is do Result := locale.translation ("metric") end
	t_metric_name_can_not_be_empty: STRING_32 is do Result := locale.translation ("Metric name cannot be empty") end
	t_remove_metric (a_metric_name: STRING_GENERAL): STRING_32 is
		require
			a_metric_name_not_void: a_metric_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Remove metric '$1'?"), [a_metric_name])
		end
	t_no_archive_selected: STRING_32 is do Result := locale.translation ("No metric archive is selected.") end
	t_archive_management: STRING_32 is do Result := locale.translation ("Archive Management") end
	t_archive_comparison: STRING_32 is do Result := locale.translation ("Archive Comparison") end
	t_location: STRING_32 is do Result := locale.translation ("Location") end
	t_select_source_domain: STRING_32 is do Result := locale.translation ("Setup input domain:") end
	t_select_metric: STRING_32 is do Result := locale.translation ("Select metric:") end
	t_select_reference_archive: STRING_32 is do Result := locale.translation ("Select reference archive (URL acceptable):") end
	t_select_current_archive: STRING_32 is do Result := locale.translation ("Select current archive (URL acceptable):") end
	t_archive_comparison_result: STRING_32 is do Result := locale.translation ("Archive comparison result:") end
	t_clean: STRING_32 is do Result := locale.translation ("Clean") end
	t_compare: STRING_32 is do Result := locale.translation ("Compare") end
	t_input_domain: STRING_32 is do Result := locale.translation ("Input domain") end
	t_result: STRING_32 is do Result := locale.translation ("Results:") end
	t_input_domain_title: STRING_32 is do Result := locale.translation ("Input domain:") end
	t_metric_criterion_definition: STRING_32 is do Result := locale.translation ("Definition:") end
	t_select_domain_scope: STRING_32 is do Result := locale.translation ("Select domain scope") end
	t_predefined_text_not_editable: STRING_32 is do Result := locale.translation ("Text not editable because current metric is predefined.") end
	t_text_not_editable: STRING_32 is do Result := locale.translation ("Text not editable.") end
	t_metric_definition: STRING_32 is do Result := locale.translation ("Metric definition") end
	t_checking_metric_vadility: STRING_32 is do Result := locale.translation ("Checking metric validity") end
	t_loading_metrics: STRING_32 is do Result := locale.translation ("Loading metrics...") end
	t_analysing_archive: STRING_32 is do Result := locale.translation ("Analyzing metric archive(s)...") end
	t_saving_metrics: STRING_32 is do Result := locale.translation ("Saving metrics...") end
	t_removing_metrics: STRING_32 is do Result := locale.translation ("Removing metrics...") end
	t_result_not_up_to_date: STRING_32 is do Result := locale.translation ("Current metric result may not be up-to-date") end
	t_feature_version_setting: STRING_32 is do Result := locale.translation ("Feature version setting:") end
	t_only_current_version: STRING_32 is do Result := locale.translation ("Only current version") end
	t_descendant_version: STRING_32 is do Result := locale.translation ("Current version and all its descendant versions") end
	t_to_do: STRING_32 is do Result := locale.translation ("To do:") end
	t_close: STRING_32 is do Result := locale.translation ("Close") end
	t_metric_definition_error_wizard: STRING_32 is do Result := locale.translation ("Metric definition error wizard") end
	t_metric_archive_calculation_finished: STRING_32 is do Result := locale.translation ("Metric archive calculation finished.") end
	t_import_metric_title: STRING_32 is do Result := locale.translation ("Import Metrics") end
	t_import_selected_metrics: STRING_32 is do Result := locale.translation ("Import Selected Metrics") end
	t_backup_user_defined_metrics: STRING_32 is do Result := locale.translation ("Backup User-defined Metrics") end
	t_metric_definition_file: STRING_32 is do Result := locale.translation ("Metric Definition File:") end
	t_load: STRING_32 is do Result := locale.translation ("Load") end
	t_import: STRING_32 is do Result := locale.translation ("Import") end
	t_metric_original_name: STRING_32 is do Result := locale.translation ("Original metric name") end
	t_metric_name: STRING_32 is do Result := locale.translation ("Metric name") end
	t_metric_description: STRING_32 is do Result := locale.translation ("Description") end
	t_metric_unit: STRING_32 is do Result := locale.translation ("Unit") end
	t_select_all_metrics: STRING_32 is do Result := locale.translation ("Select All Metrics") end
	t_deselect_all_metrics: STRING_32 is do Result := locale.translation ("Deselect All Metrics") end
	t_select_integral_metrics: STRING_32 is do Result := locale.translation ("Select Integral Metrics") end
	t_deselect_integral_metrics: STRING_32 is do Result := locale.translation ("Deselect Integral Metrics") end

	t_backup_metrics: STRING_32 is do Result := locale.translation ("Backup user-defined metrics") end
	t_select_file_for_backup: STRING_32 is do Result := locale.translation ("Select a file for user-defined metrics backup:") end
	t_backup: STRING_32 is do Result := locale.translation ("Backup") end
	t_importing_metrics: STRING_32 is do Result := locale.translation ("Importing metrics...") end
	t_metrics_imported: STRING_32 is do Result := locale.translation ("Metric(s) imported.") end
	t_metric_backuped: STRING_32 is do Result := locale.translation ("User-defined metrics backup finished.") end
	t_metrics_list: STRING_32 is do Result := locale.translation ("Metric List:") end
	t_short_line: STRING_32 is do Result := locale.translation ("-") end
	t_archive_not_up_to_date: STRING_32 is do Result := locale.translation ("Current archive value may not up-to-date") end
	err_input_domain_invalid: STRING_32 is do Result := locale.translation ("Input domain invalid") end
	t_previous_value: STRING_32 is do Result := locale.translation ("Previous value") end
	t_calculated_time: STRING_32 is do Result := locale.translation ("Calculated time") end
	t_warning_check_failed: STRING_32 is do Result := locale.translation ("Warning check failed") end

	f_run_history_recalculation: STRING_32 is do Result := locale.translation ("Recalculate selected metric(s)") end
	f_stop_history_recalculation: STRING_32 is do Result := locale.translation ("Stop metric recalculation") end
	f_remove_history_node: STRING_32 is do Result := locale.translation ("Remove selected metric history") end
	f_display_history_in_tree_view: STRING_32 is do Result := locale.translation ("Display history in tree view?") end
	f_send_to_history: STRING_32 is do Result := locale.translation ("Send last calculated metric value to history") end
	t_hide_old_archive: STRING_32 is do Result := locale.translation ("Hide archives more than ") end
	t_days: STRING_32 is do Result := locale.translation (" days old.") end
	f_keep_archive_detailed_result: STRING_32 is do Result := locale.translation ("Keep detailed result when recalculating archive?%NIf yes, detailed result will be available by double clicking the icon in %"Result%" column in history result area after recalculation.") end
	f_keep_metric_detailed_result: STRING_32 is do Result := locale.translation ("Keep detailed result when evaluating metric?") end
	f_remove_detailed_result: STRING_32 is do Result := locale.translation ("Remove detailed result?") end
	t_detailed_result: STRING_32 is do Result := locale.translation ("Result") end
	f_double_click_to_go_to_result_panel: STRING_32  is do Result := locale.translation ("Double click to go to result panel") end
	f_select_all_history: STRING_32 is do Result := locale.translation ("Select all history items") end
	f_deselect_all_history: STRING_32 is do Result := locale.translation ("Deselect all history items") end
	f_select_recalculatable_history: STRING_32 is do Result := locale.translation ("Select recalculatable history items") end
	f_deselect_recalculatable_history: STRING_32 is do Result := locale.translation ("Deselect recalculatable history items") end
	t_select_all_history: STRING_32 is do Result := locale.translation ("Select All") end
	t_deselect_all_history: STRING_32 is do Result := locale.translation ("Deselect All") end
	t_select_recalculatable_history: STRING_32 is do Result := locale.translation ("Select Recalculatable") end
	t_deselect_recalculatable_history: STRING_32 is do Result := locale.translation ("Deselect Recalculatable") end
	t_filter: STRING_32 is do Result := locale.translation ("Filter") end
	t_setup_feature_domain: STRING_32 is do Result := locale.translation ("Setup feature domain") end
	l_to_do_dialog: STRING_32 is do Result := locale.translation ("To do information") end
	t_add_new_value_evaluator: STRING_32 is do Result := locale.translation ("Add new value evaluator") end
	t_add_new_constant_value_retriever: STRING is do Result := locale.translation ("Add new constant value retriever") end
	t_remove_value_retriever: STRING_32 is do Result := locale.translation ("Remove selected value retriever") end
	t_remove_all_value_retriever: STRING_32 is do Result := locale.translation ("Remove all value retriever") end
	t_setup_value_criterion: STRING_32 is do Result := locale.translation ("Setup value criterion") end
	t_match_all_of_the_following: STRING_32 is do Result := locale.translation ("Match all") end
	t_match_any_of_the_following: STRING_32 is do Result := locale.translation ("Match any") end
	t_select_tester: STRING_32 is do Result := locale.translation ("Select metric value testers:") end
	l_domain: STRING_32 is do Result := locale.translation ("domain") end
	l_error_message: STRING_32 is do Result := locale.translation ("error message") end
	l_setup_metric_value_retriever: STRING_32 is do Result := locale.translation ("Setup metric value retriever") end
	t_add_new_metric_value_retriever: STRING_32 is do Result := locale.translation ("Add new metric value retriever") end
	t_use_external_delayed: STRING_32 is do Result := locale.translation ("Use external delayed domain") end
	t_warning: STRING_32 is do Result := locale.translation ("Warning") end
	t_row: STRING_32 is do Result := locale.translation ("row") end
	t_column: STRING_32 is do Result := locale.translation ("column") end
	t_identical: STRING_32 is do Result := locale.translation ("Identity") end
	t_containing: STRING_32 is do Result := locale.translation ("Containing") end
	t_wildcard: STRING_32 is do Result := locale.translation ("Wildcard") end
	t_regexp: STRING_32 is do Result := locale.translation ("Regular expression") end
	t_matching_strategy: STRING_32 is do Result := locale.translation ("Matching Strategy") end
	t_clear_result: STRING_32 is do Result := locale.translation ("Clear detailed result") end
	t_case_sensitive: STRING_32 is do Result := locale.translation ("Case-sensitive") end
	t_case_insensitive: STRING_32 is do Result := locale.translation ("Case-insensitive") end
	l_external_command_tester: STRING_32 is do Result := locale.translation ("External command tester") end
	l_as_file_name: STRING_32 is do Result := locale.translation ("As file name?") end
	l_enabled: STRING_32 is do Result := locale.translation ("Enabled?") end
	l_exit_code: STRING_32 is do Result := locale.translation ("Exit code") end
	l_redirected_to_output: STRING_32 is do Result := locale.translation ("Redirected to output?") end
	l_setup_external_command: STRING_32 is do Result := locale.translation ("Setup external command for criterion") end

feature -- Titles for editor token

	te_input_domain: STRING is "Input domain"
	te_no_metric: STRING is "No metric"

feature -- Labels

	l_select_input_domain: STRING_32 is do Result := locale.translation ("Select input domain:") end
	l_select_metric: STRING_32 is do Result := locale.translation ("Select metric:") end
	l_parse_error: STRING_32 is do Result := locale.translation ("Parse error:") end
	l_ratio_metric: STRING_32 is do Result := locale.translation ("ratio metric") end
	l_linear_metric: STRING_32 is do Result := locale.translation ("linear metric") end
	l_basic_metric: STRING_32 is do Result := locale.translation ("basic metric") end
	l_denominator_metric: STRING_32 is do Result := locale.translation ("denominator metric") end
	l_numerator_metric: STRING_32 is do Result := locale.translation ("numerator metric") end
	l_variable_metric: STRING_32 is do Result := locale.translation ("variable metric") end
	l_metric_archive_node: STRING_32 is do Result := locale.translation ("metric archive node") end
	l_criterion: STRING_32 is do Result := locale.translation ("criterion") end
	l_name_colon: STRING_32 is do Result := locale.translation ("Name:") end
	l_type_colon: STRING_32 is do Result := locale.translation ("Type:") end
	l_unit_colon: STRING_32 is do Result := locale.translation ("Unit:") end
	l_description_colon: STRING_32 is do Result := locale.translation ("Description:") end
	l_no_result_available: STRING_32 is do Result := locale.translation ("No result available.") end
	l_metric_definition_file: STRING_32 is do Result := locale.translation ("Metrics definition file:") end
	l_use_case_sensitive: STRING_32 is do Result := locale.translation ("Case sensitive") end
	l_use_regular_expression: STRING_32 is do Result := locale.translation ("Use regular expression") end
	l_constant_value: STRING_32 is do Result := locale.translation ("constant value") end
	l_metric_value: STRING_32 is do Result := locale.translation ("metric value") end
	l_value_tester: STRING_32 is do Result := locale.translation ("value tester") end
	l_current: STRING_32 is do Result := locale.translation ("current") end
	l_current_version: STRING_32 is do Result := locale.translation ("current version") end
	l_desendent_versions: STRING_32 is do Result := locale.translation ("descendent versions") end
	l_direct: STRING_32 is do Result := locale.translation ("direct") end
	l_indirect: STRING_32 is do Result := locale.translation ("indirect") end
	l_normal_referenced: STRING_32 is do Result := locale.translation ("normal") end
	l_syntactical_referenced: STRING_32 is do Result := locale.translation ("syntactical") end
	l_empty_domain: STRING_32 is do Result := locale.translation ("empty domain") end
	l_use_external_delayed_domain: STRING_32 is do Result := locale.translation ("use external delayed domain") end
	l_no_value_tester: STRING_32 is do Result := locale.translation ("No value tester") end

feature -- Tooltip

	f_quick_metric_definition: STRING_32 is do Result := locale.translation ("Define quick metric (or drop a basic metric here as a template)") end
	f_run: STRING_32 is do Result := locale.translation ("Run selected metric%NRunnable when a metric is selected and input domain is set.") end
	f_go_to_definition: STRING_32 is do Result := locale.translation ("Go to definition") end
	f_stop: STRING_32 is do Result := locale.translation ("Stop metric evaluation") end
	f_move_row_up: STRING_32 is do Result := locale.translation ("Move selected row up") end
	f_move_row_down: STRING_32 is do Result := locale.translation ("Move selected row down") end
	f_del_row: STRING_32 is do Result := locale.translation ("Delete selected row") end
	f_clear_rows: STRING_32 is do Result := locale.translation ("Remove all rows") end
	f_indent_with_and_criterion: STRING_32 is do Result := locale.translation ("Indent selected row using an %"AND%" criterion") end
	f_indent_with_or_criterion: STRING_32 is do Result := locale.translation ("Indent selected row using an %"OR%" criterion") end
	f_drop_metric_here: STRING_32 is do Result := locale.translation ("Pick metric and drop here") end
	f_reload_metrics: STRING_32 is do Result := locale.translation ("Reload metrics") end

	f_start_archive: STRING_32 is do Result := locale.translation ("Start metric archive evaluation") end
	f_stop_archive: STRING_32 is do Result := locale.translation ("Stop metric archive evaluation") end
	f_select_exist_archive_file: STRING_32 is do Result := locale.translation ("Select an existing metric archive file") end
	f_clean_archive: STRING_32 is do Result := locale.translation ("Clean archive?") end

	f_compare_archive: STRING_32 is do Result := locale.translation ("Compare metric archive") end
	f_select_current_archive: STRING_32 is do Result := locale.translation ("Select current metric archive file") end
	f_select_reference_archive: STRING_32 is do Result := locale.translation ("Select reference metric archive file") end
	f_select_userdefined_metrics: STRING_32 is do Result := locale.translation ("Select/deselect user-defined metrics") end
	f_select_predefined_metrics: STRING_32 is do Result := locale.translation ("Select/deselect predefined metrics") end
	f_group_metric_by_unit: STRING_32 is do Result := locale.translation ("Group metrics by unit") end

	f_add_scope: STRING_32 is do Result := locale.translation ("Add scope") end
	f_remove_scope: STRING_32 is do Result := locale.translation ("Remove selected scope(s)") end
	f_remove_all_scopes: STRING_32 is do Result := locale.translation ("Remove all scopes") end
	f_delayed_scope: STRING_32 is do Result := locale.translation ("Use input domain as criterion domain.") end
	f_use_delayed_scope: STRING_32 is do Result := locale.translation ("Use delayed domain") end
	f_save: STRING_32 is do Result := locale.translation ("Save") end
	f_new: STRING_32 is do Result := locale.translation ("New metric") end
	f_remove: STRING_32 is do Result := locale.translation ("Remove current selected metric") end
	f_domain_item_invalid: STRING_32 is do Result := locale.translation ("Item invalid in current system") end
	f_application_scope: STRING_32 is do Result := locale.translation ("Add current application target scope") end
	f_search_for_class: STRING_32 is do Result := locale.translation ("Search for group/class/feature") end
	f_filter_result: STRING_32 is do Result := locale.translation ("Filter result which is not visible from input domain") end
	f_pick_and_drop_items: STRING_32 is do Result := locale.translation ("Pick items like group/class/feature and drop here") end
	f_pick_and_drop_metric_and_items: STRING_32 is do Result := locale.translation ("Pick metrics or items like group/class/feature and drop here") end
	f_insert_text_here: STRING_32 is do Result := locale.translation ("Insert text here") end
	f_get_criterion_list: STRING_32 is do Result := locale.translation ("Available criterion list") end;
	f_get_negation: STRING_32 is do Result := locale.translation ("You can put %"not%" before a criterion name to negate it") end
	f_open_metric_file_in_external_editor: STRING_32 is do Result := locale.translation ("Open user defined metric file in external editor") end
	f_create_new_metric_using_current_data: STRING_32 is do Result := locale.translation ("Clone selected metric to a new metric") end
	f_setup_criterion_domain: STRING_32 is do Result := locale.translation ("Setup criterion domain properties") end
	f_setup_criterion_text: STRING_32 is do Result := locale.translation ("Setup criterion text properties") end
	f_double_click_to_go_to_definition: STRING_32 is do Result := locale.translation ("(Double click to go to definition)") end
	f_display_in_percentage: STRING_32 is do Result := locale.translation ("Display result in percentage? (Only applicable for ratio metrics)") end
	f_add_linear_variable_metric: STRING_32 is do Result := locale.translation ("Add selected metric") end
	f_run_metric_again: STRING_32 is do Result := locale.translation ("Evaluate metric again to get up-to-date result") end
	f_auto_go_to_result: STRING_32 is do Result := locale.translation ("Automatically go to result panel after metric evaluation?") end
	f_press_esc_to_wipe_out: STRING_32 is do Result := locale.translation ("Press ESC to wipe out") end
	f_move_unit_up: STRING_32 is do Result := locale.translation ("Move metric unit up.%N") end
	f_move_unit_down: STRING_32 is do Result := locale.translation ("Move metric unit down.%N") end
	f_rearrange_unit: STRING_32 is do Result := locale.translation ("Or you can pick a metric unit and drop it on another metric to rearrange their order.") end
	f_show_to_do_message: STRING_32 is do Result := locale.translation ("Display a message about how to deal with the metric definition error") end
	f_import_metrics: STRING_32 is do Result := locale.translation ("Import metrics from file") end
	f_clear_defined_domain: STRING_32 is do Result := locale.translation ("Clear defined domain") end
	f_check_warning: STRING_32 is do Result := locale.translation ("Check defined warnings when archive is recalculated?") end

	l_target_unit: STRING_32 is do Result := locale.translation("Target") end
	l_group_unit: STRING_32 is do Result := locale.translation("Group") end
	l_class_unit: STRING_32 is do Result := locale.translation("Class") end
	l_feature_unit: STRING_32 is do Result := locale.translation("Feature") end
	l_generic_unit: STRING_32 is do Result := locale.translation("Generic") end
	l_assertion_unit: STRING_32 is do Result := locale.translation("Assertion") end
	l_argument_unit: STRING_32 is do Result := locale.translation("Argument") end
	l_line_unit: STRING_32 is do Result := locale.translation("Line") end
	l_compilation_unit: STRING_32 is do Result := locale.translation("Compilation") end
	l_local_unit: STRING_32 is do Result := locale.translation("Local") end
	l_ratio_unit: STRING_32 is do Result := locale.translation("Ratio") end

	l_retrieve_indirect_referenced_class (a_for_supplier: BOOLEAN): STRING_32 is
		do
			if a_for_supplier then
				Result := locale.translation ("Retrieve indirect supplier classes")
			else
				Result := locale.translation ("Retrieve indirect client classes")
			end
		end

	l_retrieve_referenced_class (a_for_supplier: BOOLEAN): STRING_32 is
		do
			if a_for_supplier then
				Result := locale.translation ("Retrieve supplier classes")
			else
				Result := locale.translation ("Retrieve client classes")
			end
		end

	l_retrieve_normally_referenced_class (a_for_supplier: BOOLEAN): STRING_32 is
		do
			if a_for_supplier then
				Result := locale.translation ("Retrieve normally referenced supplier classes")
			else
				Result := locale.translation ("Retrieve normally referenced client classes")
			end
		end

	l_retrieve_only_syntacticall_referenced_class (a_for_supplier: BOOLEAN): STRING_32 is
		do
			if a_for_supplier then
				Result := locale.translation ("Retrieve only syntactially referenced supplier classes")
			else
				Result := locale.translation ("Retrieve only syntactially referenced client classes")
			end
		end

	l_setup_referenced_class_dialog (a_for_supplier: BOOLEAN): STRING_32 is
		do
			if a_for_supplier then
				Result := locale.translation ("Setup supplier classes")
			else
				Result := locale.translation ("Setup client classes")
			end
		end

	l_setup_domain_dialog: STRING_32 is do Result := locale.translation ("Setup domain") end

	l_base_value: STRING_32 is do Result := locale.translation ("Base value") end
	l_operator: STRING_32 is do Result := locale.translation ("Operator") end
	t_drop_program_elements: STRING_32 is do Result := locale.translation ("Drop target/group/class/feature here") end

	f_metrics_in_archive (a_count: INTEGER): STRING_32 is
		do
			Result := locale.formatted_string (locale.plural_translation ("There is $1 metric in archive", "There are $1 metrics in archive", a_count), [a_count])
		end


feature -- Error/warning message

	wrn_metric_name_exists_in_your_metrics (a_name: STRING_GENERAL): STRING_32 is
			-- Warning message used when in metric import dialog, when a changed metric name causes name crash in a users metrics
		require
			a_name_attached: a_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Metric named %"$1%" already exists in your metrics."), [a_name])
		ensure
			result_attached: Result /= Void
		end

	wrn_referenced_metrics_not_selected (a_metric_names: STRING_GENERAL): STRING_32 is
			-- Warning message used when in metric import dialog, when a metric is selected while some of its recursively referenced metrics are not selected
			-- `a_metic_names' is a list of concatenated metric names
		require
			a_metric_names_attached: a_metric_names /= Void
		do
			Result := locale.formatted_string (locale.translation ("Referenced metric(s): $1 not selected."), [a_metric_names])
		ensure
			result_attached: Result /= Void
		end

	wrn_referenced_metrics_missing (a_metric_name: STRING_GENERAL): STRING_32 is
			-- Warning message used when in metric import dialog, when a metric is selected while some of its recursively referenced metrics are not found	
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Referenced metric(s): $1 not found."), [a_metric_name])
		ensure
			result_attached: Result /= Void
		end

	wrn_metric_name_crash (a_name: STRING_GENERAL): STRING_32 is
			-- Warning message used when in metric import dialog, when a metric has name crash with an existing metric named `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("There is already a metric named $1.%NChange its name in %"Metric name%" column to make it importable."), [a_name]);
		ensure
			result_attached: Result /= Void
		end

	err_loading_predefined_metrics (a_real_error: STRING_GENERAL): STRING_32 is
			-- Error message when loading predefined metrics
		require
			a_real_error_attached: a_real_error /= Void
		do
			Result := locale.formatted_string (locale.translation ("When loading predefined metrics:%N$1%NPredefined metrics not loaded."), [a_real_error])
		ensure
			result_attached: Result /= Void
		end

	err_loading_userdefined_metrics (a_real_error: STRING_GENERAL): STRING_32 is
			-- Error message when loading user-defined metrics
		require
			a_real_error_attached: a_real_error /= Void
		do
			Result := locale.formatted_string (locale.translation ("When loading user-defined metrics:%N$1%NUser-defined metrics not loaded."), [a_real_error])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_tag: STRING_32 is do Result := locale.translation ("Invalid tag.") end
			-- Invalid tag error

	err_invalid_description_tag: STRING_32 is do Result := locale.translation ("Invalid description tag.") end
			-- Invalid description tag error

	err_file_not_readable (a_file_name: STRING_GENERAL): STRING_32 is
			-- File not readable error
		require
			a_file_name_attached: a_file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cannot open file: $1."), [a_file_name])
		ensure
			result_attached: Result /= Void
		end

	err_file_not_writable (a_file_name: STRING_GENERAL): STRING_32 is
			-- File not writable error
		require
			a_file_name_attached: a_file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cannot write file: $1."), [a_file_name])
		ensure
			result_attached: Result /= Void
		end

	err_directory_creation_fail (a_dir_name: STRING_GENERAL): STRING_32 is
			-- Directory creation fail error
		require
			a_dir_name_attached: a_dir_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cannot create directory: $1."), [a_dir_name])
		ensure
			result_attached: Result /= Void
		end

	err_too_many_criteria: STRING_32 is
			-- Too many criteria error
		do
			Result := locale.translation ("Too many crieria is specified in %"criterion%" section. Only one is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_too_many_domain: STRING_32 is
			-- Too many domain error
		do
			Result := locale.translation ("Too many %"domain%" section specified. Only one is expected.")
		ensure
			result_attached: Result /= Void
		end
	err_too_many_criterion_section: STRING_32 is
			-- Too many criterion section error
		do
			Result := locale.translation ("Too many criterion sections specified. Only one criterion section is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_exists_in_import_metric_list (a_new_metric_name, a_old_metric_name: STRING_GENERAL): STRING_32 is
			-- Error message used when in metric import dialog, when a changed metric name causes name crash in listed metrics to be imported
		require
			a_new_metric_name_attached: a_new_metric_name /= Void
			a_old_metric_name_attached: a_old_metric_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("There is already metric named %"$1%" in import metric list.%NThe name %"$2%" will be changed back to %"$3%"."), [a_new_metric_name, a_new_metric_name, a_old_metric_name])
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_missing_in_metric_definition: STRING_32 is
			-- Error message given when metric name is missing
		do
			Result :=  locale.translation ("Metric name is missing in metric definition.")
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_missing_in_archive_node: STRING_32 is
			-- Error message given when metric name is missing in archive node
		do
			Result :=  locale.translation ("Metric name is missing in metric archive node.")
		ensure
			result_attached: Result /= Void
		end

	err_duplicated_metric_name (a_metric_name: STRING_GENERAL): STRING_32 is
			-- Duplicated metric name error
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Duplicated metric name %"$1%" in metric definition."), [a_metric_name])
		ensure
			result_attached: Result /= Void
		end

	err_numerator_metric_missing: STRING_32 is
			-- Numerator metric missing error
		do
			Result := locale.translation ("Numerator metric is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_denominator_metric_missing: STRING_32 is
			-- Numerator metric missing error
		do
			Result := locale.translation ("Denominator metric is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_uuid_missing: STRING_32 is
			-- UUID missing error	
		do
			Result := locale.translation ("UUID is missing.")
		end

	err_uuid_invalid (a_invalid_uuid: STRING_GENERAL): STRING_32 is
			-- UUID invalid error
		require
			a_invalid_uuid_attached: a_invalid_uuid /= Void
		do
			Result := locale.formatted_string (locale.translation ("UUID %"$1%" is invalid."), [a_invalid_uuid])
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_name_missing: STRING_32 is
			-- Variable metric name missing error
		do
			Result := locale.translation ("Variable metric name is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_coefficient_missing: STRING_32 is
			-- Coefficient missing error
		do
			Result := locale.translation ("Coefficient of variable metric is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_coefficient_invalid (a_coefficient: STRING_GENERAL): STRING_32 is
			-- Coefficient invalid error
		require
			a_coefficient_attached: a_coefficient /= Void
		do
			Result := locale.formatted_string (locale.translation ("Coefficient %"$1%" of variable metric is invalid. A real number is expected."), [a_coefficient])
		ensure
			result_attached: Result /= Void
		end

	err_case_sensitive_attr_missing: STRING_32 is
			-- Case sensitive attribute missing error
		do
			Result := locale.translation ("Attribute %"case_sensitive%" is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_regular_expression_attr_missing: STRING_32 is
			-- Regular expression attribute missing error
		do
			Result := locale.translation ("Attribute %"regular_expression%" is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_case_sensitive_attr_invalid (a_value: STRING_GENERAL): STRING_32 is
			-- Case sensitive attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"case_sensitive%" is invalid. A boolean is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_regular_expression_attr_invalid (a_value: STRING_GENERAL): STRING_32 is
			-- Regular expression attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"regular_expression%" is invalid. A boolean is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_criterion_name_missing: STRING_32 is
			-- Criterion name missing error
		do
			Result := locale.translation ("Criterion name is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_unit_name_missing: STRING_32 is
			-- Unit name missing error
		do
			Result := locale.translation ("Unit name is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_unit_name_invalid (a_unit_name: STRING_GENERAL): STRING_32 is
			-- Unit name invalid error
		require
			a_unit_name_attached: a_unit_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Unit name %"$1%" is invalid."), [a_unit_name])
		ensure
			result_attached: Result /= Void
		end

	err_negation_attr_invalid (a_value: STRING_GENERAL): STRING_32 is
			-- Negation attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"negation%" is invalid. A boolean is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_only_current_version_attr_invalid (a_value: STRING_GENERAL): STRING_32 is
			-- Only current version attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"only_current_version%" is invalid. A boolean is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_id_is_missing: STRING_32 is
			-- Domain item id missing error
		do
			Result := locale.translation ("Domain item id is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_type_is_missing: STRING_32 is
			-- Domain item type missing error
		do
			Result := locale.translation ("Domain item type is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_type_invalid (a_type: STRING_GENERAL): STRING_32 is
			-- Domain item type invalid error
		require
			a_type_attached: a_type /= Void
		do
			Result := locale.formatted_string (locale.translation ("Domain item type %"$1%" is invalid."), [a_type])
		ensure
			result_attached: Result /= Void
		end

	err_library_target_uuid_invalid (a_uuid: STRING_GENERAL): STRING_32 is
			-- Library target UUID invalid error
		require
			a_uuid_attached: a_uuid /= Void
		do
			Result := locale.formatted_string (locale.translation ("Library target UUID %"$1%" is invalid."), [a_uuid])
		ensure
			result_attached: Result /= Void
		end

	err_metric_type_missing: STRING_32 is
			-- Metric type missing error
		do
			Result := locale.translation ("Attribute %"type%" is missing .")
		ensure
			result_attached: Result /= Void
		end

	err_metric_type_invalid (a_value: STRING_GENERAL): STRING_32 is
			-- Metric type attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"type%" is invalid."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_archive_time_missing: STRING_32 is
			-- Archive time missing error
		do
			Result := locale.translation ("Attribute %"time%" is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_archive_time_invalid (a_value: STRING_GENERAL): STRING_32 is
			-- Archive time attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"time%" is invalid."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_archive_value_missing: STRING_32 is
			-- Archive value missing error
		do
			Result := locale.translation ("Archive value is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_archive_value_invalid (a_value: STRING_GENERAL): STRING_32 is
			-- Archive value attribute value invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"value%" is invalid. A real number is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_missing: STRING_32 is
			-- Variable metric missing error
		do
			Result := locale.translation ("Variable metric is missng. At least one variable metric should be defined.")
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_not_defined: STRING_32 is
			-- Variable metric not defined error
		do
			Result := locale.translation ("No definition for variable metric.")
		ensure
			result_attached: Result /= Void
		end

	err_variable_metric_unit_not_correct (a_wrong_unit, a_right_unit: STRING_GENERAL): STRING_32 is
			-- Variable metric unit not correct error
		require
			a_wrong_unit_attached: a_wrong_unit /= Void
			a_right_unit_attached: a_right_unit /= Void
		do
			Result := locale.formatted_string (locale.translation ("Unit %"$1%" of variable metric is different from unit %"$2%" of linear metric."), [a_wrong_unit, a_right_unit])
		ensure
			result_attached: Result /= Void
		end

	err_numerator_metric_not_defined (a_numerator: STRING_GENERAL): STRING_32 is
			-- Numerator metric not defined error
		require
			a_numerator_attached: a_numerator /= Void
		do
			Result := locale.formatted_string (locale.translation ("Numerator metric %"$1%" is not defined."), [a_numerator])
		ensure
			result_attached: Result /= Void
		end

	err_denominator_metric_not_defined (a_denominator: STRING_GENERAL): STRING_32 is
			-- Numerator metric not defined error
		require
			a_denominator_attached: a_denominator /= Void
		do
			Result := locale.formatted_string (locale.translation ("Denominator metric %"$1%" is not defined."), [a_denominator])
		ensure
			result_attached: Result /= Void
		end

	err_basic_metric_unit_not_correct (a_criterion_unit, a_metric_unit: STRING_GENERAL): STRING_32 is
			-- Basic metric unit not correct error
		require
			a_criterion_unit_attached: a_criterion_unit /= Void
			a_metric_unit_attached: a_metric_unit /= Void
		do
			Result := locale.formatted_string (locale.translation ("Criterion unit %"$1%" is different from basic metric unit %"$2%"."), [a_criterion_unit, a_metric_unit])
		ensure
			result_attached: Result /= Void
		end

	err_criterion_not_exist (a_criterion_name, a_unit_name: STRING_GENERAL): STRING_32 is
			-- Criterion doesn't exist error
		require
			a_criterion_name_attached: a_criterion_name /= Void
			a_unit_name_attached: a_unit_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Criterion %"$1%" of unit %"$2%" doesn't exist."), [a_criterion_name, a_unit_name])
		ensure
			result_attached: Result /= Void
		end

	err_domain_item_not_exist: STRING_32 is
			-- Domain item doesn't exists error
		do
			Result := locale.translation ("No domain item defined. At least one domain item should be defined in a relation criterion.")
		ensure
			result_attached: Result /= Void
		end

	err_text_in_text_criterion_empty: STRING_32 is
			-- Text in text criterion empty error
		do
			Result := locale.translation ("Text in text criterion is empty.")
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_empty: STRING_32 is
			-- Metric name is empty error
		do
			Result := locale.translation ("Metric name is empty.")
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_invalid (a_invalid_name: STRING_GENERAL): STRING_32 is
			-- Metric name invalid error
		require
			a_invalid_name_attached: a_invalid_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Metric name %"$1%" is invalid."), [a_invalid_name])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_feature_domain_item (a_feature_name, a_domain_item_id: STRING_GENERAL): STRING_32 is
			-- Invalid faeture domain item error
		require
			a_feature_name_attached: a_feature_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			Result := locale.formatted_string (locale.translation ("Feature `$1' (ID = %"$2%") is invalid."), [a_feature_name, a_domain_item_id])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_folder_domain_item (a_folder_name, a_domain_item_id: STRING_GENERAL): STRING_32 is
			-- Invalid folder domain item error
		require
			a_folder_name_attached: a_folder_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			Result := locale.formatted_string (locale.translation ("Folder %"$1%" (ID = %"$2%") is invalid."), [a_folder_name, a_domain_item_id])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_group_domain_item (a_group_name, a_domain_item_id: STRING_GENERAL): STRING_32 is
			-- Invalid group domain item error
		require
			a_group_name_attached: a_group_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			Result := locale.formatted_string (locale.translation ("Group %"$1%" (ID = %"$2%") is invalid."), [a_group_name, a_domain_item_id])
		ensure
			result_attached: Result /= Void
		end

	err_invalid_class_domain_item (a_class_name, a_domain_item_id: STRING_GENERAL): STRING_32 is
			-- Invalid class domain item error
		require
			a_class_name_attached: a_class_name /= Void
			a_domain_item_id_attached: a_domain_item_id /= Void
		do
			Result := locale.formatted_string (locale.translation ("Class %"$1%" (ID = %"$2%") is invalid."), [a_class_name, a_domain_item_id])
		ensure
			result_attached: Result /= Void
		end

	err_recursive_metric_definition (a_recursive_name: STRING_GENERAL): STRING_32 is
			-- Recursive metric definition error
		require
			a_recursive_name_attached: a_recursive_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Recursive definition for metric name %"$1%"."), [a_recursive_name])
		ensure
			result_attached: Result /= Void
		end

	err_metric_loading_error (a_real_error: STRING_GENERAL): STRING_32 is
			-- Metric loading error.
		require
			a_real_error_attached: a_real_error /= Void
		do
			Result := locale.formatted_string (locale.translation ("Metrics loading error:%N$1"), [a_real_error])
		ensure
			result_attached: Result /= Void
		end

	err_metric_not_exist (a_type: STRING_GENERAL): STRING_32 is
			-- Metric doesn't exist error
		require
			a_type_attached: a_type /= Void
			not_a_type_is_empty: not a_type.is_empty
		do
			Result := locale.formatted_string (locale.translation ("Metric of type %"$1%" doesn't exist or that metric is invalid."), [a_type])
		ensure
			result_attached: Result /= Void
		end

	err_filter_invalid (a_filter: STRING_GENERAL): STRING_32 is
			-- Filter value invalid error
		require
			a_filter_attached: a_filter /= Void
		do
			Result := locale.formatted_string (locale.translation ("Filter value %"$1%" is invalid."), [a_filter])
		ensure
			result_attached: Result /= Void
		end

	err_numerator_coefficient_invalid (a_value: STRING_GENERAL): STRING_32 is
			-- Numerator metric coefficient invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Coefficient %"$1%" for numerator metric is invalid. A real number is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_denominator_coefficient_invalid (a_value: STRING_GENERAL): STRING_32 is
			-- Numerator metric coefficient invalid error
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Coefficient %"$1%" for denominator metric is invalid. A real number is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_denominator_coefficient_is_zero: STRING_32 is do Result := locale.translation ("Coefficient for denominator metric is zero. A non-zero real number is expected.") end

	err_normal_referenced_class_attr_invalid (a_value: STRING_GENERAL): STRING_32 is
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of %"normal%" attribute is invalid. A boolean value is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_only_syntactically_referenced_class_attr_invalid (a_value: STRING_GENERAL): STRING_32 is
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Attribute %"$1%" is invalid. A boolean value is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_indirect_referenced_class_attr_invalid (a_value: STRING_GENERAL): STRING_32 is
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$1%" of attribute %"indirect%" is invalid. A boolean value is expected."), [a_value])
		ensure
			result_attached: Result /= Void
		end

	err_metric_name_missing: STRING_32 is
			-- Metric name missing error
		do
			Result := locale.translation ("Metric name is missing.")
		ensure
			result_attached: Result /= Void
		end

	err_too_many_tester: STRING_32 is
			-- Too many tester sections error
		do
			Result := locale.translation ("Too many %"value_tester%" sections. Only one is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_operator_missing: STRING_32 is do Result := locale.translation ("Operator in value criterion is missing.") end

	err_operator_invalid (a_operator: STRING_GENERAL): STRING_32 is
			-- Operator invalid error
		require
			a_operator_attached: a_operator /= Void
		do
			Result := locale.formatted_string (locale.translation ("Operator %"$1%" is invalid. One of the following operators is expected: %"=%", %"/=%", %"<%", %"<=%", %">%", %">=%""), [a_operator])
		ensure
			result_attached: Result /= Void
		end

	err_tester_relation_missing: STRING_32 is do Result := locale.translation ("Relation for value tester is missing.") end

	err_tester_relation_invalid (a_relation: STRING_GENERAL): STRING_32 is
			-- Tester relation invalid error
		require
			a_relation_attached: a_relation /= Void
		do
			Result := locale.formatted_string ("Value tester relation %"$1%" is invalid. An %"and%" or %"or%" relation is expected.", [a_relation])
		ensure
			result_attached: Result /= Void
		end

	err_no_value_tester_specified: STRING_32 is do Result := locale.translation ("No value tester is specified.") end

	err_base_value_missing: STRING_32 is do Result := locale.translation ("Base value of a value tester is missing.") end

	err_base_value_invalid (a_value: STRING_GENERAL): STRING_32 is
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.translation ("Base value %"$1%" of a value tester is invalid. A real number is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_too_many_value_retriever: STRING_32 is
		do
			Result := locale.translation ("Too many value retrievers nodes. Only one is expected.")
		ensure
			result_attached: Result /= Void
		end

	err_domain_missing: STRING_32 is do Result := locale.translation ("Domain is missing.") end
	err_value_tester_missing: STRING_32 is do Result := locale.translation ("Value tester is missing.") end
	err_value_retriever_missing: STRING_32 is do Result := locale.translation ("Value retriever is missing.") end
	err_use_external_delayed_invalid (a_value: STRING_GENERAL; a_attribute_name: STRING_GENERAL): STRING_32 is
		require
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string ("Value %"$1%" of attribute %"$2%" is invalid. A boolean is expected.", [a_value, a_attribute_name])
		ensure
			result_attached: Result /= Void
		end

	err_delayed_domain_item_appear: STRING_32 is do Result := locale.translation ("Delayed domain item appears.") end
	err_input_domain_item_appear: STRING_32 is do Result := locale.translation ("Input domain item appears.") end

	err_invalid_matching_strategy (a_invalid_strategy: STRING_GENERAL): STRING_32 is
		require
			a_invalid_strategy_attached: a_invalid_strategy /= Void
		do
			Result := locale.formatted_string (locale.translation ("Matching strategy %"$1%" is invalid."), [a_invalid_strategy])
		end

	err_archive_file_name_exists (a_file_name: STRING_GENERAL): STRING_32 is
		require
			a_file_name_attached: a_file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Remote file will be loaded in: $1.%NThis file already exists. Overwrite?"), [a_file_name])
		end

	err_unable_to_read_from_url (a_url: STRING_GENERAL): STRING_32 is
		require
			a_url_attached: a_url /= Void
		do
			Result := locale.formatted_string (locale.translation ("Unable to read remote file.%NPlease check URL: $1"), [a_url])
		end

	err_unable_to_load_archive_file (a_file_name: STRING_GENERAL): STRING_32 is
		require
			a_file_name_attached: a_file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Unable to load remote file in: $1%NPlease make sure file does not exits or is writable."), [a_file_name])
		end

	err_transfer_file (a_reason: STRING_GENERAL): STRING_32 is
		require
			a_reason_attached: a_reason /= Void
		do
			Result := locale.formatted_string (locale.translation ("Unable to transfer remote file.%NReason: $1"), [a_reason])
		end

	err_integer_attribute_invalid (a_attribute_name, a_value: STRING_GENERAL): STRING_32 is
			-- Integer attribute value invalid
		require
			a_attribute_name_attached: a_attribute_name /= Void
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$2%" of attribute %"$1%" is invalid. An integer is expected."), [a_attribute_name, a_value])
		ensure
			result_attached: Result /= Void
		end

	err_attribute_missing (a_attribute: STRING_GENERAL): STRING_32 is
			-- `a_attribute' missing error
		require
			a_attribute_attached: a_attribute /= Void
		do
			Result := locale.formatted_string (locale.translation ("Attribute %"$1%" is missing."), [a_attribute])
		ensure
			result_attached: Result /= Void
		end

	err_boolean_attribute_invalid (a_attribute_name, a_value: STRING_GENERAL): STRING_32 is
			-- Value `a_value' of boolean attribute `a_attribute_name' invalid error
		require
			a_attribute_name_attached: a_attribute_name /= Void
			a_value_attached: a_value /= Void
		do
			Result := locale.formatted_string (locale.translation ("Value %"$2%" of attribute %"$1%" is invalid. A boolean is expected."), [a_attribute_name, a_value])
		ensure
			result_attached: Result /= Void
		end

	err_too_many_sections (a_section_name: STRING_GENERAL): STRING_32 is
			-- Too many `a_section_name' sections error
		require
			a_section_name_attached: a_section_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Too many %"$1%" sections. Only one is expcted."), [a_section_name])
		ensure
			result_attached: Result /= Void
		end

	err_section_missing (a_section_name: STRING_GENERAL): STRING_32 is
			-- `a_section_name' section missing error
		require
			a_section_name_attached: a_section_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Section %"$1%" is missing."), [a_section_name])
		ensure
			result_attached: Result /= Void
		end

	err_external_command_empty: STRING_32 is do Result := locale.translation ("External command is not specified.") end

	err_external_command_file_not_specified (a_file_type: STRING_GENERAL): STRING_32 is
		require
			a_file_type_attached: a_file_type /= Void
		do
			Result := locale.formatted_string (locale.translation ("File as external command $1 is not specified."), [a_file_type])
		ensure
			result_attached: Result /= Void
		end

feature -- To do messages

	variable_metric_missing_to_do: STRING_32 is
		do
			Result := linear_metric_info.as_string_32 + locale.translation ("Make sure that at lease one variable metric is listed in a linear metric definition.")
		ensure
			result_attached: Result /= Void
		end

	variable_metric_not_defined_to_do: STRING_32 is
		do
			Result := linear_metric_info.as_string_32 + locale.translation ("Make sure every variable metric referenced by a linear metric is defined.")
		ensure
			result_attached: Result /= Void
		end

	variable_metric_unit_not_correct_to_do: STRING_32 is
		do
			Result := linear_metric_info.as_string_32 + locale.translation ("Make sure unit of every variable metric is same as that of the linear metric.")
		ensure
			result_attached: Result /= Void
		end

	numerator_denominator_metric_not_defined_to_do: STRING_32 is
		do
			Result := ratio_metric_info.as_string_32 + locale.translation ("Make sure that numerator and denominator metric referenced by ratio metric are defined.")
		ensure
			result_attached: Result /= Void
		end

	unit_in_basic_metric_not_same_to_do: STRING_32 is do Result := locale.translation ("Make sure every (recursive) criterion in basic metric is of the same unit with that basic metric.") end
	criterion_not_exist_to_do: STRING_32 is do Result := locale.translation ("Make sure that the criterion of given unit exists.") end
	domain_item_not_exists_to_do: STRING_32 is do Result := locale.translation ("Make sure that at least one domain item is listed in a domain criterion.") end
	text_in_text_criterion_empty_to_do: STRING_32 is do Result := locale.translation ("Make sure to specify a non-empty string for a text criterion.") end

	metric_name_empty_to_do: STRING_32 is
		do
			Result := metric_name_info.as_string_32 + locale.translation ("Make sure metric name is not empty and contains valid charactors.")
		ensure
			result_attached: Result /= Void
		end

	recursive_definition_to_do: STRING_32 is do Result := locale.translation ("In linear metric, make sure that every variable metric doesn't involve recursive metric.%NIn ratio metric, make sure that numerator metric or denominator metric doesn't involve recursive metric.") end
	make_sure_denominator_coefficient_non_zero_to_do: STRING_32 is do Result := locale.translation ("Make sure coefficient for denominator metric is a non-zero real number.") end

	no_value_tester_specified_to_do: STRING_32 is do Result := locale.translation ("Make sure that at least one value tester is specified.") end

	metric_name_info: STRING_32 is
			-- Information of metric name
		do
			Result := locale.translation ("A valid metric name is a non-empty string which doesn't start with space, enter or tab, and doesn't end with space, enter or tab.%NMake sure specified metric name is valid.")
		ensure
			result_attached: Result /= Void
		end

	linear_metric_info: STRING_32 is
			-- Information of linear metric
		do
			Result := locale.translation ("Linear metric is of the form:%N%N%Ta * metric1 + b * metric2 + c * metric3 + ...%N%Na, b, c are coefficients and %Nmetric1, metric2, metric3 are variable metrics.%N%N")
		ensure
			result_attached: Result /= Void
		end

	ratio_metric_info: STRING_32 is
			-- Information of ratio metric
		do
			Result := locale.translation ("Ratio metric is of the form:%N%N%T (coefficient * Numerator metric) / (coefficient * Denominator metric)%N%NNumerator metric and denominator metric can be of any valid unit.%N%N")
		ensure
			result_attached: Result /= Void
		end

	invalid_domain_item_info: STRING_32 is
			-- Information of invalid domain item
		do
			Result := locale.translation ("Make sure that every item specified in a domain is valid.%NFollowing are some reasons which can cause a domain item invalid:%N * Domain item ID is damaged or incorrect.%N * Domain item doesn't exist (Maybe due to removal/rename of a folder, group, class or feature).%N")
		ensure
			result_attached: Result /= Void
		end

	metric_invalid_to_do: STRING_32 is
			-- Invalid metric to-do message
		do
			Result := locale.translation ("Make sure that referenced metric exists and is valid.")
		end

	delayed_domain_item_appear_to_do: STRING_32 is do Result := locale.translation ("Remove delayed domain item.") end
	input_domain_item_appear_to_do: STRING_32 is do Result := locale.translation ("Remove input domain item.") end

feature -- Separator

	new_line_separator: STRING_32 is
			-- New line separator
		do
			Result := "%N"
		ensure
			result_attached: Result /= Void
		end

	comma_separator: STRING_32 is
			-- Comma separator
		do
			Result := ", "
		ensure
			result_attached: Result /= Void
		end

	space_separator: STRING_32 is
			-- Space separator
		do
			Result := " "
		ensure
			result_attached: Result /= Void
		end

	colon: STRING_32 is
			-- Colon
		do
			Result := ":"
		ensure
			result_attached: Result /= Void
		end

	location_connector: STRING_32 is
			-- Location connector
		do
			Result := " -> "
		ensure
			result_attached: Result /= Void
		end

	left_parenthesis: STRING_32 is
		do
			Result := "("
		ensure
			result_attached: Result /= Void
		end

	right_parenthesis: STRING_32 is
		do
			Result := ")"
		ensure
			result_attached: Result /= Void
		end

	left_arrow: STRING_32 is
		do
			Result := "<"
		ensure
			result_attached: Result /= Void
		end

	right_arrow: STRING_32 is
		do
			Result := ">"
		ensure
			result_attached: Result /= Void
		end

feature -- Utilities

	concatenated_string (a_str_list: LINEAR [STRING_GENERAL]; a_separator: STRING_GENERAL): STRING_32 is
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

	location_section (a_section_name, a_section_type: STRING_GENERAL): STRING_32 is
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

	location_string (a_location: STRING_GENERAL): STRING_32 is
			-- Location string
		require
			a_location_attached: a_location /= Void
		do
			Result := coloned_string (t_location, True)
			Result.append (space_separator)
			Result.append (a_location)
		ensure
			result_attached: Result /= Void
		end

	visitable_name (a_visitable_type: STRING_GENERAL; a_visitable_name: STRING_GENERAL): STRING_32 is
			-- Visitable name for a visitable whose type is `a_visitable_type' and name is `a_visitable_name'
			-- For example, type is "basic metric" and name is "Classes", we will get "basic metric (Classes)".
		require
			a_visitable_type_attached: a_visitable_type /= Void
			a_visitable_name_attached: a_visitable_name /= Void
		do
			Result := a_visitable_type.twin
			Result.append (left_parenthesis)
			Result.append (a_visitable_name)
			Result.append (right_parenthesis)
		ensure
			result_attached: Result /= Void
		end

	coloned_string (a_string: STRING_GENERAL; a_first_letter_upper: BOOLEAN): STRING_32 is
			-- String which is `a_string' suffixed with a colon
			-- If `a_first_letter_upper' is True, make sure the first letter of returned string is in upper case (if current locale permits).
		require
			a_string_attached: a_string /= Void
		do
			if a_first_letter_upper then
				Result := first_character_as_upper (a_string)
			else
				Result := a_string.twin
			end
			Result.append (colon)
		ensure
			result_attached: Result /= Void
		end

	xml_position (a_column: INTEGER; a_row: INTEGER): STRING_32 is
			-- Xml position: Column: `a_column', row: `a_row'
		do
			Result := coloned_string (t_column, True)
			Result.append (a_column.out)
			Result.append (comma_separator)
			Result.append (coloned_string (t_row, False))
			Result.append (a_row.out)
		ensure
			result_attached: Result /= Void
		end

	xml_location (a_element_type: STRING_GENERAL; a_element_name: STRING_GENERAL): STRING_32 is
			-- Xml location. `a_element_type' is the element name type. `a_element_name' is for better information.
			-- For example, if `a_element_type' is "basic_metric" and `a_element_name' is Void, Result would be "<basic_metric>",
			-- if `a_element_name' is "Classes", result would be "<basic_metric(Classes)>"
		require
			a_element_type_attached: a_element_type /= Void
			not_a_element_is_empty: not a_element_type.is_empty
		do
			Result := left_arrow.twin
			Result.append (a_element_type)
			if a_element_name /= Void then
				Result.append (left_parenthesis)
				Result.append (a_element_name)
				Result.append (right_parenthesis)
			end
			Result.append (right_arrow)
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


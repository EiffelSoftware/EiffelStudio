indexing
	description: "Names used in tty."
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_NAMES

inherit
	SHARED_LOCALE

feature -- Access

	yes_or_no: STRING is 										" [y|n] "
	arrow_class_name: STRING_GENERAL is 						do Result := locale.translate ("--> Class name: ") end
	arrow_feature_name: STRING_GENERAL is 						do Result := locale.translate ("--> Feature name: ") end
	arrow_filter_name: STRING_GENERAL is 						do Result := locale.translate ("--> Filter name: ") end
	arrow_profile_infomation_file_name: STRING_GENERAL is 		do Result := locale.translate ("--> Profile information file name (default: `profinfo'): ") end
	arrow_compile_type: STRING_GENERAL is 						do Result := locale.translate ("--> Compile type (default: `workbench'): ") end
	arrow_used_profiler: STRING_GENERAL is 						do Result := locale.translate ("--> Used profiler (default: `eiffel'): ") end
	arrow_subquery: STRING_GENERAL is							do Result := locale.translate ("--> Subquery: ") end
	arrow_arguments: STRING_GENERAL is							do Result := locale.translate ("--> Arguments: ") end
	arrow_operator_index_followed_by: STRING_GENERAL is			do Result := locale.translate ("--> Operator index followed by operator ('and' or 'or'): ") end
	arrow_please_enter_an_operator_index: STRING_GENERAL is 	do Result := locale.translate ("--> Please enter an operator index followed by an operator ('and' or 'or'): ") end
	arrow_operator_index: STRING_GENERAL is						do Result := locale.translate ("--> Operator index: ") end
	arrow_new_operator: STRING_GENERAL is						do Result := locale.translate ("--> New operator: ") end
	arrow_keep_assertions: STRING_GENERAL is					do Result := locale.translate ("--> Keep assertions") end
	arrow_subquery_index: STRING_GENERAL is						do Result := locale.translate ("--> Subquery index: ") end
	arrow_file_name: STRING_GENERAL is							do Result := locale.translate ("--> File name: ") end
	arrow_filenames: STRING_GENERAL is							do Result := locale.translate ("--> Filename(s): ") end
	command_arrow: STRING_GENERAL is							do Result := locale.translate ("Command => ") end
	want_to_update_new_compiler: STRING_GENERAL is 				do Result := locale.translate ("Do you want to update to new version of compiler?") end
	enter_name_for_configuration_file: STRING_GENERAL is 		do Result := locale.translate ("Enter name for configuration file: ") end
	project_contains_no_compilable_target: STRING_GENERAL is 	do Result := locale.translate ("This project contains no compilable target.") end
	has_more_than_one_target: STRING_GENERAL is 				do Result := locale.translate ("This project has more than one target: ") end
	can_not_choose_a_target: STRING_GENERAL is 					do Result := locale.translate ("You cannot choose a target because of the -stop/-batch option.") end
	select_the_target_you_want: STRING_GENERAL is 				do Result := locale.translate ("Select the target you want: ") end
	invalid_target: STRING_GENERAL is 							do Result := locale.translate ("Invalid target, select the target you want: ") end
	cannot_choose_name_because_of: STRING_GENERAL is 			do Result := locale.translate ("You cannot choose the name of the project location%Nbecause of the -stop/-batch option.%N") end
	enter_location_for_new_project: STRING_GENERAL is 			do Result := locale.translate ("Enter location for new project: ") end
	precompile_will_automtically_be_built: STRING_GENERAL is 	do Result := locale.translate ("Precompile will automatically be built%Nbecause of the -stop/-batch option.%N") end
	incorrect_options: STRING_GENERAL is 						do Result := locale.translate (": incorrect options%N") end
	usage: STRING_GENERAL is									do Result := locale.translate ("Usage:%N%T") end
	options: STRING_GENERAL is									do Result := locale.translate ("%NOptions:%N") end
	default_quick_melt_the_system: STRING_GENERAL is			do Result := locale.translate ("%Tdefault (no option): quick melt the system.%N%N") end
	disable: STRING_GENERAL is									do Result := locale.translate ("disable") end
	enable: STRING_GENERAL is									do Result := locale.translate ("enable") end
	no_previous_value: STRING_GENERAL is						do Result := locale.translate ("No previous value%N") end
	all_calees: STRING_GENERAL is								do Result := locale.translate ("All callees") end
	only_assignees: STRING_GENERAL is							do Result := locale.translate ("Only assignees") end
	only_creators: STRING_GENERAL is							do Result := locale.translate ("Only creators") end
	index_must_be_an_integer: STRING_GENERAL is					do Result := locale.translate ("Index must be an integer.%N") end
	operator_must_be: STRING_GENERAL is							do Result := locale.translate ("Operator must be 'and' or 'or'.%N") end
	there_is_no_item_available: STRING_GENERAL is				do Result := locale.translate ("There is no items available at this index.%N") end
	index_must_be_valid: STRING_GENERAL is						do Result := locale.translate ("Index must be valid.%N") end
	file_name: STRING_GENERAL is								do Result := locale.translate ("File name: ") end
	file_name_with_default: STRING_GENERAL is					do Result := locale.translate ("File name (`Ace.ace' is the default): ") end
	invalid_choices: STRING_GENERAL is							do Result := locale.translate ("Invalid choice%N%N") end
	include_parents: STRING_GENERAL is							do Result := locale.translate ("Include parents") end
	ready_for_queries: STRING_GENERAL is						do Result := locale.translate ("Ready for queries...") end
	an_error_occurred_while_loading_profiler: STRING_GENERAL is	do Result := locale.translate ("An error occurred while loading the configuration for your profiler.") end
	please_check_with_your_system_administator: STRING_GENERAL is do Result := locale.translate ("Please check with your system administrator whether your profiler is supported.") end
	file_already_exists: STRING_GENERAL is						do Result := locale.translate ("File already exists.%N") end
	no_active_queries: STRING_GENERAL is						do Result := locale.translate ("No active queries") end
	you_should_first_manipulate_the_subqueries: STRING_GENERAL is do Result := locale.translate ("You should first manipulate the subqueries") end
	query: STRING_GENERAL is									do Result := locale.translate ("Query:") end
	all_senders: STRING_GENERAL is								do Result := locale.translate ("All senders") end
	only_assigners: STRING_GENERAL is							do Result := locale.translate ("Only assigners") end
	all_subqueries: STRING_GENERAL is							do Result := locale.translate ("All subqueries:%N") end
	the_total_active_query: STRING_GENERAL is					do Result := locale.translate ("%NThe total active query:%N") end

	no_value_entered: STRING_GENERAL is
			do Result := locale.translate ("No value entered. Do you want to: %N%
			%D: delete the previous value%N%
			%K: keep the previous value (default)%N%
			%Option: ") end

	a_subquery_has_the_following_form: STRING_GENERAL is
			do Result := locale.translate ("A subquery has the following form: %
			%attribute operator value%N%N%
			%attribute is one of: featurename, calls, total, self, descendants, percentage%N%
			%operator is one of: < > <= >= = /= in%N%
			%value is one of: integer (for calls), string_with_wildcards (for featurename)%N%
			%%T%T real (for other attributes) or a bounded_value%N%
			%%T%T%TA string_with_wildcards is a string containing%N%T%T%T'*' or '?'%N%
			%%T%T%TA bounded_value is a value followed by '-' followed by%N%T%T%Ta value%N%
			%%T%T%T%TNo strings are allowed here.%N") end

	specify_the_ace_file: STRING_GENERAL is
			do Result := locale.translate ("Specify the Ace file: %N%
			%C: Cancel%N%
			%S: Specify file name%N%
			%T: Copy template%N%N%
			%Option: ") end

	finalizing_implies_some_c_compilation: STRING_GENERAL is
			do Result := locale.translate ("Finalizing implies some C compilation and linking.%
							%%NDo you want to do it now") end

	batch_mode (a_string: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Batch/Stop mode: saving new configuration format as '$1'."), [a_string])
		end

	save_new_configuration_as (a_str: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Save new configuration format as '$1'?"), [a_str])
		end

	target_does_not_exist (a_target: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Target `$1' does not exist or is not a compilable target.%NChoose among the following target(s): "), [a_target])
		end

	create_new_project_in (a_str: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Create new project in '$1'?"), [a_str])
		end

	new_enviroment_value_for (a_key: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("New environment value for $1 will be used%Nbecause of the -stop/-batch option.%N"), [a_key])
		end

	previous_value (a_value: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Previous value: `$1'%N"), [a_value])
		end

	unknow_menu (a_str: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Unknown menu $1.%N"), [a_str])
		end

	unknow_option (a_str: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Unknown option $1.%N"), [a_str])
		end

	ise_batch_version (a_wkname: STRING_GENERAL; a_version_number: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("==== ISE $1 - Interactive Batch Version (v$2) ====%N%N"), [a_wkname, a_version_number])
		end

	cannot_open (a_file: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Cannot open $1"), [a_file])
		end

	one_subqueries_is (a_column, a_operator, a_value: STRING_GENERAL; a_active: BOOLEAN): STRING_GENERAL is
		do
			if a_active then
				Result := locale.format_string (locale.translate ("$1 $2 $3 is active"), [a_column, a_operator, a_value])
			else
				Result := locale.format_string (locale.translate ("$1 $2 $3 is inactive"), [a_column, a_operator, a_value])
			end
		end

feature -- Errors

	err_press_return_to_resume: STRING_GENERAL is 					do Result := locale.translate ("Press <Return> to resume compilation or <Q> to quit") end
	err_too_many_arguments: STRING_GENERAL is 						do Result := locale.translate ("Too many arguments. The following arguments will be ignored:") end
	session_aborted: STRING_GENERAL is 								do Result := locale.translate ("ISE Eiffel: Session aborted%N") end
	exception_tag: STRING_GENERAL is 								do Result := locale.translate ("Exception tag: ") end
	cannot_create_file: STRING_GENERAL is 							do Result := locale.translate ("Cannot create file: ") end
	several_class_has_the_same_name: STRING_GENERAL is 				do Result := locale.translate ("Several classes have the same name:%N") end
	read_only_project_cannot_compile: STRING_GENERAL is 			do Result := locale.translate ("Read-only project: cannot compile.%N") end
	read_only_project_no_c_code_to_compile: STRING_GENERAL is 		do Result := locale.translate ("Read-only project: no C code to compile in F_code.%N") end
	the_resource_editor_is_not_set: STRING_GENERAL is				do Result := locale.translate ("The resource EDITOR is not set%N") end
	you_must_select_an_ace_file_first: STRING_GENERAL is			do Result := locale.translate ("You must select an Ace file first%N") end
	thers_is_no_output_to_save: STRING_GENERAL is					do Result := locale.translate ("There is no output to save.%N") end
	can_not_create_file: STRING_GENERAL is							do Result := locale.translate ("Cannot create file: ") end

	file_exists (a_file_name: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("File %"$1%" exists.%NPlease delete it first.%N"), [a_file_name])
		end

	class_is_not_in_the_universe (a_class: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("$1 is not in the universe%N"), [a_class])
		end

	class_is_not_a_valid_class_name (a_class: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("$1 is not a valid class name%N"), [a_class])
		end

	cluster_does_not_exit (a_cluster_name: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Cluster $1 does ot exist."), [a_cluster_name])
		end

	class_is_not_in_cluster (a_class: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("$1 is not in cluster."), [a_class])
		end

	class_is_not_in_the_system (a_class: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("$1 is not in the system%N"), [a_class])
		end

	you_must_now_run (a_script: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("You must now run %"$1%" in:%N%T"), [a_script])
		end

	error_could_not_write_to (a_file_name: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Error: could not write to $1%NPlease check permissions and disk space"), [a_file_name])
		end

	ace_file_cannot_be_read (a_fn: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Ace file `$1' cannot be read%N"), [a_fn])
		end

	ace_file_does_not_exist (a_fn: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Ace file `$1' does not exist%N"), [a_fn])
		end

	feature_is_not_of_class (a_f, a_class: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("$1 is not a feature of $2"), [a_f, a_class])
		end

	file_does_not_exist (a_file: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("$1: File does not exist!%N%N"), [a_file])
		end

	there_is_already_project_compiled_in (a_project_name: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("There is already a project compiled in %"$1%"%NIt needs to be deleted before a precompilation.%N"), [a_project_name])
		end

feature {NONE} -- Implementation

end

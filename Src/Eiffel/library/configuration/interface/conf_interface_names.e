indexing
	description: "Names and descriptions for configuration components."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_INTERFACE_NAMES

inherit
	CONF_CONSTANTS

feature {NONE}

	ellipsis_text: STRING is "..."

feature {NONE} -- Configuration

	configuration_title (a_system_name: STRING): STRING is
		do
			Result := "Project Settings ("+a_system_name+")"
		end

feature {NONE} -- Section names

	section_system: STRING is "System"
	section_target: STRING is "Target"
	section_assertions: STRING is "Assertions"
	section_groups: STRING is "Groups"
	section_warning: STRING is "Warning"
	section_debug: STRING is "Debug"
	section_external: STRING is "Externals"
	section_tasks: STRING is "Tasks"
	section_variables: STRING is "Variables"
	section_mapping: STRING is "Type mapping"
	section_general: STRING is "General"
	section_dotnet: STRING is ".NET"
	section_advanced: STRING is "Advanced"
	section_file_pattern: STRING is "File Pattern"

feature {NONE} -- System names and descriptions

	system_name_name: STRING is "Name"
	system_name_description: STRING is "Name of the system."
	system_description_name: STRING is "Description"
	system_description_description: STRING is "Description of the system."
	system_library_target_name: STRING is "Library target"
	system_library_target_description: STRING is "Target used if system is used as a library."
	system_uuid_name: STRING is "UUID"
	system_uuid_description: STRING is "Unique identifier for the system."
	system_targets_name: STRING is "Targets"
	system_targets_description: STRING is "Targets of the system."

feature {NONE} -- Target names and descriptions

	target_name_name: STRING is "Name"
	target_name_description: STRING is "Name of the target."
	target_description_name: STRING is "Description"
	target_description_description: STRING is "Description of the target."
	target_base_name: STRING is "Base target"
	target_base_description: STRING is "Base target of this target."
	target_abstract_name: STRING is "Abstract"
	target_abstract_description: STRING is "Is this an abstract target that can not be used to compile."
	target_compilation_type_name: STRING is "Compilation type"
	target_compilation_type_description: STRING is "Type of compilation."
	target_compilation_type_standard: STRING is "Standard (C/byte code)"
	target_compilation_type_dotnet: STRING is ".NET (msil)"
	target_executable_name: STRING is "Output name"
	target_executable_description: STRING is "Name of the generated binary."
	target_root_name: STRING is "Root"
	target_root_description: STRING is "Root cluster, class, feature of the system."
	target_version_name: STRING is "Version"
	target_version_description: STRING is "Version information."
	target_product_name: STRING is "Product"
	target_product_description: STRING is "Name of the product."
	target_company_name: STRING is "Company"
	target_company_description: STRING is "Name of the company."
	target_copyright_name: STRING is "Copyright"
	target_copyright_description: STRING is "Copyright of this product."
	target_trademark_name: STRING is "Trademark"
	target_trademark_description: STRING is "Trademark of this product."
	target_dialog_root_cluster: STRING is "Root cluster"
	target_dialog_root_class: STRING is "Root class"
	target_dialog_root_feature: STRING is "Root feature"
	target_dialog_root_all: STRING is "Compile all classes"
	target_file_rule_name: STRING is "File pattern"
	target_file_rule_description: STRING is "Regular expression that exclude/include subfolders and/or files."

	target_address_expression_name: STRING is "Address expression"
	target_address_expression_description: STRING is " "
	target_array_optimization_name: STRING is "Array optimization"
	target_array_optimization_description: STRING is " "
	target_check_generic_creation_constraint_name: STRING is "Check generic creation constraints"
	target_check_generic_creation_constraint_description: STRING is " "
	target_check_vape_name: STRING is "Check vape"
	target_check_vape_description: STRING is " "
	target_console_application_name: STRING is "Console application"
	target_console_application_description: STRING is " "
	target_cls_compliant_name: STRING is "CLS compliant"
	target_cls_compliant_description: STRING is " "
	target_dead_code_removal_name: STRING is "Dead code removal"
	target_dead_code_removal_description: STRING is " "
	target_dotnet_naming_convention_name: STRING is "Dotnet naming convention"
	target_dotnet_naming_convention_description: STRING is " "
	target_dynamic_runtime_name: STRING is "Dynamic runtime"
	target_dynamic_runtime_description: STRING is " "
	target_exception_trace_name: STRING is "Exception trace"
	target_exception_trace_description: STRING is " "
	target_full_type_checking_name: STRING is "Full type checking"
	target_full_type_checking_description: STRING is " "
	target_il_verifiable_name: STRING is "IL verifiable"
	target_il_verifiable_description: STRING is " "
	target_inlining_name: STRING is "Inlinining"
	target_inlining_description: STRING is " "
	target_inlining_size_name: STRING is "Inlining size"
	target_inlining_size_description: STRING is " "
	target_line_generation_name: STRING is "Line generation"
	target_line_generation_description: STRING is " "
	target_metadata_cache_path_name: STRING is "Metadata cache path"
	target_metadata_cache_path_description: STRING is " "
	target_msil_assembly_compatibility_name: STRING is "MSIL assembly compatibility"
	target_msil_assembly_compatibility_description: STRING is " "
	target_msil_classes_per_module_name: STRING is "MSIL classes per module"
	target_msil_classes_per_module_description: STRING is " "
	target_msil_clr_version_name: STRING is "MSIL CLR version"
	target_msil_clr_version_description: STRING is " "
	target_msil_culture_name: STRING is "MSIL culture"
	target_msil_culture_description: STRING is " "
	target_msil_generation_type_name: STRING is "MSIL generation type"
	target_msil_generation_type_description: STRING is " "
	target_msil_key_file_name_name: STRING is "MSIL key file"
	target_msil_key_file_name_description: STRING is "Choose a new, non existing filename to create a new key file."
	target_msil_use_optimized_precompile_name: STRING is "Use optimized precompile"
	target_msil_use_optimized_precompile_description: STRING is " "
	target_multithreaded_name: STRING is "Multithreaded"
	target_multithreaded_description: STRING is " "
	target_old_verbatim_strings_name: STRING is "Old verbatim strings"
	target_old_verbatim_strings_description: STRING is " "
	target_platform_name: STRING is "Platform"
	target_platform_description: STRING is "Override the detected platform to use in conditions."
	target_external_runtime_name: STRING is "External runtime"
	target_external_runtime_description: STRING is " "
	target_shared_library_definition_name: STRING is "Shared library definition"
	target_shared_library_definition_description: STRING is " "
	target_use_cluster_name_as_namespace_name: STRING is "Use cluster name as namespace"
	target_use_cluster_name_as_namespace_description: STRING is " "
	target_use_all_cluster_name_as_namespace_name: STRING is "Use recursive cluster name as namespace"
	target_use_all_cluster_name_as_namespace_description: STRING is " "
	target_force_32bits_name: STRING is "Force 32bits"
	target_force_32bits_description: STRING is "Force compilation for 32bits."

	external_location_name: STRING is "Location"
	external_location_description: STRING is "Location of the external."
	external_description_name: STRING is "Description"
	external_description_description: STRING is "Description of the external."
	external_condition_name: STRING is "Condition"
	external_condition_description: STRING is "Conditions for this external."

	external_include: STRING is "Include"
	external_object: STRING is "Object"
	external_make: STRING is "Makefile"
	external_resource: STRING is "Resource"

	external_include_tree: STRING is "Includes"
	external_object_tree: STRING is "Objects"
	external_make_tree: STRING is "Makefiles"
	external_resource_tree: STRING is "Resources"

	task_pre_tree: STRING is "Pre compilation tasks"
	task_post_tree: STRING is "Post compilatin tasks"

	task_pre: STRING is "pre compilation"
	task_post: STRING is "post compilation"
	task_command_name: STRING is "Command"
	task_command_description: STRING is "Command to execute."
	task_description_name: STRING is "Description"
	task_description_description: STRING is "Description of the task."
	task_working_directory_name: STRING is "Working directory"
	task_working_directory_description: STRING is "Directory where the command will be executed."
	task_succeed_name: STRING is "Must succeed"
	task_succeed_description: STRING is "Does this task have to finish successful for the compilation to continue?"
	task_condition_name: STRING is "Condition"
	task_condition_description: STRING is "Conditions for this task to be executed."

	group_cluster_tree: STRING is "Clusters"
	group_assembly_tree: STRING is "Assemblies"
	group_library_tree: STRING is "Libraries"
	group_precompile_tree: STRING is "Precompile"
	group_override_tree: STRING is "Overrides"

	group_cluster: STRING is "Cluster"
	group_assembly: STRING is "Assembly"
	group_library: STRING is "Library"
	group_precompile: STRING is "Precompile"
	group_override: STRING is "Override"

	group_type_name: STRING is "Type"
	group_type_description: STRING is "Type of the group."
	group_name_name: STRING is "Name"
	group_name_description: STRING is "Name of the group."
	group_description_name: STRING is "Description"
	group_description_description: STRING is "Description of the group."
	group_condition_name: STRING is "Condition"
	group_condition_description: STRING is "Conditions for this group to be used."
	group_readonly_name: STRING is "Readonly"
	group_readonly_description: STRING is "Is this group readonly?"
	group_location_name: STRING is "Location"
	group_location_description: STRING is "Location of this group."
	group_prefix_name: STRING is "Prefix"
	group_prefix_description: STRING is "Prefix which all classes in this group get."
	group_renaming_name: STRING is "Renaming"
	group_renaming_description: STRING is "Renaming of classes in this group."
	group_class_option_name: STRING is "Class options"
	group_class_option_description: STRING is "Class specific options."

	library_edit_configuration: STRING is "Edit library configuration"

	cluster_file_rule_name: STRING is "File pattern"
	cluster_file_rule_description: STRING is "Exclude/include file pattern."
	cluster_recursive_name: STRING is "Recursive"
	cluster_recursive_description: STRING is "Are subfolders recursively included?"
	cluster_dependencies_name: STRING is "Dependencies"
	cluster_dependencies_description: STRING is "Groups this cluster depends on."
	cluster_visible_name: STRING is "Visible classes"
	cluster_visible_description: STRING is "Classes visible for external code."
	cluster_mapping_name: STRING is "Type Mapping"
	cluster_mapping_description: STRING is "Special type mappings."

	assembly_name_name: STRING is "Assembly name"
	assembly_name_description: STRING is "Name of the assembly."
	assembly_culture_name: STRING is "Assembly culture"
	assembly_culture_description: STRING is "Culture of the assembly"
	assembly_version_name: STRING is "Assembly version"
	assembly_version_description: STRING is "Version of the assembly"
	assembly_public_key_token_name: STRING is "Assembly public key token"
	assembly_public_key_token_description: STRING is "Public key token of the assembly."

	override_override_name: STRING is "Overriding"
	override_override_description: STRING is "Groups this override is overriding."

feature {NONE} -- Option names and descriptions

	option_require_name: STRING is "Require"
	option_require_description: STRING is "Evaluate precondition assertions."
	option_ensure_name: STRING is "Ensure"
	option_ensure_description: STRING is "Evaluate postcondition assertions."
	option_check_name: STRING is "Check"
	option_check_description: STRING is "Evaluate check assertions."
	option_invariant_name: STRING is "Invariant"
	option_invariant_description: STRING is "Evaluate invariant assertions."
	option_loop_name: STRING is "Loop"
	option_loop_description: STRING is "Evaluate loop assertions."

	option_profile_name: STRING is "Profile"
	option_profile_description: STRING is "Generate profiling information."
	option_trace_name: STRING is "Trace"
	option_trace_description: STRING is ""
	option_optimize_name: STRING is "Optimize"
	option_optimize_description: STRING is ""

	option_namespace_name: STRING is ".NET Namespace"
	option_namespace_description: STRING is "Namespace for .NET"

	option_debug_name: STRING is "Enabled"
	option_debug_description: STRING is "Are debug clauses globally enabled?"
	option_unnamed_debug_name: STRING is "Unnamed debugs"

	option_warnings_name: STRING is "Enabled"
	option_warnings_description: STRING is "Are warnings enabled?"

	warning_names: HASH_TABLE [STRING, STRING] is
			-- Warning names.
		once
			create Result.make (10)
			Result.force ("unused locals", w_unused_local)
			Result.force ("obsolete classes", w_obsolete_class)
			Result.force ("obsolete features", w_obsolete_feature)
			Result.force ("onces in generics", w_once_in_generic)
			Result.force ("old syntax", w_syntax)
			Result.force ("old verbatim strings", w_old_verbatim_strings)
			Result.force ("same uuid", w_same_uuid)
			Result.force ("missing class export", w_export_class_missing)
			Result.force ("incompatible types equality", w_vweq)
			Result.force ("renaming unknown class", w_renaming_unknown_class)
			Result.force ("options unknown class.", w_option_unknown_class)
		end

	warning_descriptions: HASH_TABLE [STRING, STRING] is
			-- Warning descriptions.
		once
			create Result.make (10)
			Result.force ("Locals that are not used.", w_unused_local)
			Result.force ("Usage of obsolete classes.", w_obsolete_class)
			Result.force ("Usage of obsolete features.", w_obsolete_feature)
			Result.force ("Usage of onces in generics.", w_once_in_generic)
			Result.force ("Old syntax warning.", w_syntax)
			Result.force ("Usage of old verbatim strings warning.", w_old_verbatim_strings)
			Result.force ("Different files with the same uuid.", w_same_uuid)
			Result.force ("Missing class in export clause.", w_export_class_missing)
			Result.force ("Incompatible types in equality comparison.", w_vweq)
			Result.force ("Renaming of an unknown class.", w_renaming_unknown_class)
			Result.force ("Class options of an unknown class.", w_option_unknown_class)
		end

feature {NONE} -- Misc

	general_add: STRING is "Add"
	general_remove: STRING is "Remove"
	variables_name: STRING is "Name"
	variables_value: STRING is "Value"
	mapping_old_name: STRING is "Old name"
	mapping_new_name: STRING is "New name"

feature {NONE} -- Condition dialog

	dial_cond_platforms: STRING is "Platforms"
	dial_cond_platforms_exclude: STRING is "Exclude platform(s)"
	dial_cond_other: STRING is "Other"
	dial_cond_build: STRING is "Build"
	dial_cond_dotnet: STRING is ".NET"
	dial_cond_multithreaded: STRING is "Multithreaded"
	dial_cond_dynamic_runtime: STRING is "Dynamic runtime"
	dial_cond_version: STRING is "Version"
	dial_cond_version_compiler: STRING is "<= compiler version <= "
	dial_cond_version_clr: STRING is "<= MSIL CLR version <= "
	dial_cond_custom: STRING is "Custom"
	dial_cond_new_custom: STRING is "new"
	dial_cond_new_custom_value: STRING is "new_value"
	dial_cond_custom_variable: STRING is "Variable"
	dial_cond_custom_value: STRING is "Value"
	dial_cond_add_and_term: STRING is "Add and-term"
	dial_cond_remove_and_term: STRING is "Remove and-term"
	dial_cond_and_term_1: STRING is "And-term 1"
	dial_cond_and_term_x (a_number: INTEGER): STRING is
		do
			Result := "or And-term "+a_number.out
		end

feature {NONE} -- File rule dialog

	dialog_file_rule_excludes: STRING is "Excludes:"
	dialog_file_rule_includes: STRING is "Includes:"
	dialog_file_rule_description: STRING is "Description:"
	dialog_file_rule_condition: STRING is "Condition:"
	dialog_file_rule_edit_condition: STRING is "Edit condition"
	dialog_file_rule_add_rule: STRING is "Add rule"
	dialog_file_rule_remove_rule: STRING is "Remove rule"
	dialog_file_rule_file_rule_x (a_number: INTEGER): STRING is
		do
			Result := "File rule "+a_number.out
		end

feature {NONE} -- Visible dialog

	dialog_visible_name: STRING is "Name: "
	dialog_visible_renamed_name: STRING is "Renamed name: "
	dialog_visible_add_class: STRING is "+ Class"
	dialog_visible_add_feature: STRING is "+ Feature"
	dialog_visible_remove: STRING is "-"

feature {NONE} -- Renaming dialog

	dialog_renaming_old_name: STRING is "Old name"
	dialog_renaming_new_name: STRING is "New name"
	dialog_renaming_create_old: STRING is "OLD_NAME"
	dialog_renaming_create_new: STRING is "NEW_NAME"

feature {NONE} -- Create task dialog

	dialog_task_add: STRING is "Add new task"

feature {NONE} -- Create external dialog

	dialog_external_add: STRING is "Add new external"

feature {NONE} -- Create library dialog

	dialog_create_library_title: STRING is "Add library"
	dialog_create_library_defaults: STRING is "Default libraries"
	dialog_create_library_name: STRING is "Name"
	dialog_create_library_location: STRING is "Location"

feature {NONE} -- Create assembly dialog

	dialog_create_assembly_title: STRING is "Add assembly"
	dialog_create_assembly_name: STRING is "Name"
	dialog_create_assembly_location: STRING is "Location"
	dialog_create_assembly_a_name: STRING is "Assembly Name"
	dialog_create_assembly_a_version: STRING is "Assembly Version"
	dialog_create_assembly_a_culture: STRING is "Assembly Culture"
	dialog_create_assembly_a_key: STRING is "Assembly Key"

feature {NONE} -- Create cluster dialog

	dialog_create_cluster_title: STRING is "Add cluster"
	dialog_create_cluster_name: STRING is "Name"
	dialog_create_cluster_location: STRING is "Location"

feature {NONE} -- Create override dialog

	dialog_create_override_title: STRING is "Add override cluster"

feature {NONE} -- Class option dialog

	dialog_class_option_class_name: STRING is "Class name"


	remove_group_text: STRING is "Remove group"

feature {NONE} -- Validation warnings

	version_valid_format: STRING is "Version is not valid. It has to be in the form XXX.XXX.XXX.XXX"
	version_min_max: STRING is "Minimum version can not be greater than maximum version."
	library_target_override: STRING is "Library target can not be used because it contains overrides which is forbidden."
	target_move_up_extends: STRING is "Target can not be moved up because it extends the target that is above it."
	target_move_down_extends: STRING is "Target can not be moved down because the target below it extends this target."
	target_add_duplicate: STRING is "Can not add target because there is already a target with the same name."
	target_remove_library_target: STRING is "Target can not be rmeoved because it is the library target."
	target_remove_extends (other_target: STRING): STRING is
		do
			Result := "Target can not be removed because "+other_target+" extends it."
		end

	target_name_duplicate: STRING is "Can not rename target because there is already a target with the new name."
	root_no_class: STRING is "Can not specify root cluster or root feature without a root class. Use all classes, specify a root class or specify nothing."
	cluster_dependency_group_not_exist: STRING is "Can not add dependency. There is no group with this name."
	override_group_not_exist: STRING is "Can not add override. There is no group with this name."
	group_already_exists (a_group: STRING): STRING is
		require
			a_group_not_void: a_group /= Void
		do
			Result := "There is already a group with name "+a_group+"."
		end

	assembly_no_location: STRING is "No location specified."

end

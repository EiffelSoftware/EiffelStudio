indexing
	description: "Names and descriptions for configuration components."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_INTERFACE_NAMES

inherit
	CONF_CONSTANTS

feature -- Configuration

	configuration_title (a_system_name: STRING): STRING is
		do
			Result := "Project Settings ("+a_system_name+")"
		end

feature -- Section names

	section_system: STRING is "System"
	section_target (a_target: STRING): STRING is
		do
			Result := "Target: "+a_target
		end
	section_assertions: STRING is "Assertions"
	section_groups: STRING is "Groups"
	section_warning: STRING is "Warnings"
	section_debug: STRING is "Debug"
	section_external: STRING is "Externals"
	section_tasks: STRING is "Tasks"
	section_variables: STRING is "Variables"
	section_mapping: STRING is "Type mapping"
	section_general: STRING is "General"
	section_dotnet: STRING is ".NET"
	section_advanced: STRING is "Advanced"
	section_file_pattern: STRING is "File Pattern"

	selection_tree_select_node: STRING is "Please select a subnode."

feature -- Section actions

	menu_properties: STRING is "Properties"
	menu_edit_config: STRING is "Edit configuration"
	add_target: STRING is "Add target"

feature -- System names and descriptions

	system_name_name: STRING is "Name"
	system_name_description: STRING is "Name of the system."
	system_description_name: STRING is "Description"
	system_description_description: STRING is "Description of the system."
	system_library_target_name: STRING is "Library target"
	system_library_target_description: STRING is "Target used if system is used as a library."
	system_file_name: STRING is "File name"
	system_file_description: STRING is "Location of the configuration file."
	system_uuid_name: STRING is "UUID"
	system_uuid_description: STRING is "Universal unique identifier for the system."

feature -- Target names and descriptions

	target_name_name: STRING is "Name"
	target_name_description: STRING is "Name of the target."
	target_description_name: STRING is "Description"
	target_description_description: STRING is "Description of the target."
	target_abstract_name: STRING is "Abstract"
	target_abstract_description: STRING is "Is this an abstract target that cannot be used to compile?"
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
	target_dialog_root_all: STRING is "Compile all classes?"
	target_file_rule_name: STRING is "File pattern"
	target_file_rule_description: STRING is "Regular expressions which exclude/include subfolders and/or files."

	target_address_expression_name: STRING is "Address expression"
	target_address_expression_description: STRING is "Are simplified address expressions enabled?"
	target_automatic_backup_name: STRING is "Automatic backup"
	target_automatic_backup_description: STRING is "Automatically generate a backup during recompilation?"
	target_check_vape_name: STRING is "Check vape"
	target_check_vape_description: STRING is "Enforce VAPE validity constraint?"
	target_console_application_name: STRING is "Console application"
	target_console_application_description: STRING is "Is the project a console application?"
	target_cls_compliant_name: STRING is "CLS compliant"
	target_cls_compliant_description: STRING is "Should generated assemblies be marked as CLS compliant?"
	target_dead_code_removal_name: STRING is "Dead code removal"
	target_dead_code_removal_description: STRING is "Should unused code be removed?"
	target_dotnet_naming_convention_name: STRING is ".NET naming convention"
	target_dotnet_naming_convention_description: STRING is "Should names follow the .NET naming convention?"
	target_dynamic_runtime_name: STRING is "Dynamic runtime"
	target_dynamic_runtime_description: STRING is "Should the generated executable use a shared library of the runtime?"
	target_exception_trace_name: STRING is "Exception trace"
	target_exception_trace_description: STRING is "Should a complete exception trace be generated in the finalized version?"
	target_il_verifiable_name: STRING is "IL verifiable"
	target_il_verifiable_description: STRING is "Should the generated binary be IL verifiable?"
	target_inlining_name: STRING is "Inlinining"
	target_inlining_description: STRING is "Should inlining be enabled?"
	target_inlining_size_name: STRING is "Inlining size"
	target_inlining_size_description: STRING is "Maximal number of instructions in a feature for the feature to be inlined."
	target_line_generation_name: STRING is "Line generation"
	target_line_generation_description: STRING is "Generate extra information for external debuggers?"
	target_metadata_cache_path_name: STRING is "Metadata cache path"
	target_metadata_cache_path_description: STRING is "Location where information about external assemblies is stored."
	target_msil_classes_per_module_name: STRING is "MSIL classes per module"
	target_msil_classes_per_module_description: STRING is "Number of classes generated per .NET module during incremental compilation. Increasing this value will slow down the incremental recompilation, but speed up the time to load the assembly while debugging in workbench mode."
	target_msil_clr_version_name: STRING is "MSIL CLR version"
	target_msil_clr_version_description: STRING is "Version of the .NET runtime to use."
	target_msil_generation_type_name: STRING is "Generation type"
	target_msil_generation_type_description: STRING is "Type of binary to generate."
	target_msil_key_file_name_name: STRING is "Signing key"
	target_msil_key_file_name_description: STRING is "Key to be able to add the generated binary to the Global Assembly Cache (GAC). %NChose a new, non existing filename to create a new key file."
	target_msil_use_optimized_precompile_name: STRING is "Use optimized precompile"
	target_msil_use_optimized_precompile_description: STRING is "Use an optimized version of a precompile?"
	target_multithreaded_name: STRING is "Multithreaded"
	target_multithreaded_description: STRING is "Generate a multithreaded application?"
	target_old_verbatim_strings_name: STRING is "Old verbatim strings"
	target_old_verbatim_strings_description: STRING is "Use the old format for verbatim strings?"
	target_platform_name: STRING is "Platform"
	target_platform_description: STRING is "Override the detected platform to use in conditions."
	target_shared_library_definition_name: STRING is "Shared library definition"
	target_shared_library_definition_description: STRING is "Specify the file the compiler uses to generate the exported functions."
	target_library_root_name: STRING is "Library root"
	target_library_root_description: STRING is "Absolute path to use as base for relative paths."
	target_use_cluster_name_as_namespace_name: STRING is "Use cluster name as namespace"
	target_use_cluster_name_as_namespace_description: STRING is "Should cluster names be used as namespaces?"
	target_use_all_cluster_name_as_namespace_name: STRING is "Use recursive cluster name as namespace"
	target_use_all_cluster_name_as_namespace_description: STRING is "Should names of folders in recursive clusters be used as namespaces?"
	target_force_32bits_name: STRING is "Force 32bits"
	target_force_32bits_description: STRING is "Force compilation for 32bits?"

	target_edit_manually: STRING is "Manually edit configuration"

	external_location_name: STRING is "Location"
	external_location_description: STRING is "Location of the external."
	external_description_name: STRING is "Description"
	external_description_description: STRING is "Description of the external."
	external_condition_name: STRING is "Condition"
	external_condition_description: STRING is "Conditions for this external."

	external_include: STRING is "Include"
	external_object: STRING is "Object"
	external_library: STRING is "Library"
	external_make: STRING is "Makefile"
	external_resource: STRING is "Resource"

	external_include_tree: STRING is "Includes"
	external_object_tree: STRING is "Objects"
	external_library_tree: STRING is "Libraries"
	external_make_tree: STRING is "Makefiles"
	external_resource_tree: STRING is "Resources"

	external_add_include: STRING is "Add include"
	external_add_object: STRING is "Add object"
	external_add_library: STRING is "Add library"
	external_add_make: STRING is "Add make"
	external_add_resource: STRING is "Add resource"

	task_pre_tree: STRING is "Pre compilation tasks"
	task_post_tree: STRING is "Post compilation tasks"

	task_pre: STRING is "pre compilation"
	task_post: STRING is "post compilation"
	task_type_name: STRING is "Type"
	task_type_description: STRING is "Type of the task."
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
	task_add_pre: STRING is "Add pre compilation task"
	task_add_post: STRING is "Add post compilation task"

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
	group_class_option_name: STRING is "Class Options"
	group_class_option_description: STRING is "Class specific options."
	group_add_cluster: STRING is "Add cluster"
	group_add_subcluster: STRING is "Add subcluster"
	group_add_override: STRING is "Add override"
	group_add_assembly: STRING is "Add assembly"
	group_add_library: STRING is "Add library"
	group_add_precompile: STRING is "Add precompile"

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
	assembly_culture_description: STRING is "Culture of the assembly."
	assembly_version_name: STRING is "Assembly version"
	assembly_version_description: STRING is "Version of the assembly."
	assembly_public_key_token_name: STRING is "Assembly public key token"
	assembly_public_key_token_description: STRING is "Public key token of the assembly."

	override_override_name: STRING is "Overriding"
	override_override_description: STRING is "Groups this override is overriding."
	class_option_class_name: STRING is "Name"
	class_option_file_name: STRING is "Location"
	properties_class_name: STRING is "Class"
	properties_target_name: STRING is "Target"

feature -- Option names and descriptions

	option_require_name: STRING is "Require"
	option_require_description: STRING is "Evaluate precondition assertions?"
	option_ensure_name: STRING is "Ensure"
	option_ensure_description: STRING is "Evaluate postcondition assertions?"
	option_check_name: STRING is "Check"
	option_check_description: STRING is "Evaluate check assertions?"
	option_invariant_name: STRING is "Invariant"
	option_invariant_description: STRING is "Evaluate invariant assertions?"
	option_loop_name: STRING is "Loop"
	option_loop_description: STRING is "Evaluate loop assertions?"

	option_profile_name: STRING is "Profile"
	option_profile_description: STRING is "Generate profiling information?"
	option_trace_name: STRING is "Trace"
	option_trace_description: STRING is "Display name of all called features during execution?"

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
			Result.force ("Unused locals", w_unused_local)
			Result.force ("Obsolete classes", w_obsolete_class)
			Result.force ("Obsolete features", w_obsolete_feature)
			Result.force ("Onces in generics", w_once_in_generic)
			Result.force ("Old syntax", w_syntax)
			Result.force ("Old verbatim strings", w_old_verbatim_strings)
			Result.force ("Same uuid", w_same_uuid)
			Result.force ("Missing class export", w_export_class_missing)
			Result.force ("Incompatible types equality", w_vweq)
			Result.force ("Assignment on formal/expanded", w_vjrv)
			Result.force ("Renaming unknown class", w_renaming_unknown_class)
			Result.force ("Options unknown class", w_option_unknown_class)
		end

	warning_descriptions: HASH_TABLE [STRING, STRING] is
			-- Warning descriptions.
		once
			create Result.make (10)
			Result.force ("Warn about locals that are not used?", w_unused_local)
			Result.force ("Warn about usage of obsolete classes?", w_obsolete_class)
			Result.force ("Warn about usage of obsolete features?", w_obsolete_feature)
			Result.force ("Warn about usage of onces in generics?", w_once_in_generic)
			Result.force ("Warn about usage of old syntax?", w_syntax)
			Result.force ("Warn about usage of old verbatim strings?", w_old_verbatim_strings)
			Result.force ("Warn about different files with the same UUID?", w_same_uuid)
			Result.force ("Warn about missing classes in export clauses?", w_export_class_missing)
			Result.force ("Warn about incompatible types in equality comparisons?", w_vweq)
			Result.force ("Warn about assignment attempts on formal or expanded targets?", w_vjrv)
			Result.force ("Warn about renamings of unknown classes?", w_renaming_unknown_class)
			Result.force ("Warn about class options of unknown classes?", w_option_unknown_class)
		end

feature -- Misc

	general_add: STRING is "Add"
	general_remove: STRING is "Remove"
	variables_name: STRING is "Name"
	variables_value: STRING is "Value"
	mapping_old_name: STRING is "Old name"
	mapping_new_name: STRING is "New name"
	remove_target (a_target: STRING): STRING is
		do
			Result := "Are you sure you want to remove "+a_target+"?"
		end

	target_remove_group (a_group: STRING): STRING is
		do
			Result := "Are you sure you want to remove "+a_group+"?"
		end
	target_remove_group_children (a_group: STRING): STRING is
		do
			Result := a_group+" can not be removed because it has subclusters."
		end
	target_remove_external (a_external: STRING): STRING is
		do
			Result := "Are you sure you want to remove "+a_external+"?"
		end
	target_remove_task (a_task: STRING): STRING is
		do
			Result := "Are you sure you want to remove "+a_task+"?"
		end

feature -- Condition dialog

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

feature -- File rule dialog

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

feature -- Visible dialog

	dialog_visible_name: STRING is "Name: "
	dialog_visible_renamed_name: STRING is "Renamed name: "
	dialog_visible_add_class: STRING is "Add class"
	dialog_visible_add_feature: STRING is "Add feature"
	dialog_visible_remove: STRING is "Remove"

feature -- Renaming dialog

	dialog_renaming_old_name: STRING is "Old name"
	dialog_renaming_new_name: STRING is "New name"
	dialog_renaming_create_old: STRING is "OLD_NAME"
	dialog_renaming_create_new: STRING is "NEW_NAME"

feature -- Create task dialog

	dialog_task_add: STRING is "Add new task"

feature -- Create external dialog

	dialog_external_add: STRING is "Add new external"

feature -- Create library dialog

	dialog_create_library_title: STRING is "Add library"
	dialog_create_library_defaults: STRING is "Default libraries"
	dialog_create_library_name: STRING is "Name"
	dialog_create_library_location: STRING is "Location"

feature -- Create precompile dialog

	dialog_create_precompile_title: STRING is "Add precompile"
	dialog_create_precompile_defaults: STRING is "Default precompiles"
	dialog_create_precompile_name: STRING is "Name"
	dialog_create_precompile_location: STRING is "Location"

feature -- Create assembly dialog

	dialog_create_assembly_found: STRING is "Assemblies"
	dialog_create_assembly_title: STRING is "Add assembly"
	dialog_create_assembly_name: STRING is "Name"
	dialog_create_assembly_location: STRING is "Location"
	dialog_create_assembly_a_name: STRING is "Assembly Name"
	dialog_create_assembly_a_version: STRING is "Assembly Version"
	dialog_create_assembly_a_culture: STRING is "Assembly Culture"
	dialog_create_assembly_a_key: STRING is "Assembly Key"

feature -- Create cluster dialog

	dialog_create_cluster_title: STRING is "Add cluster"
	dialog_create_cluster_name: STRING is "Name"
	dialog_create_cluster_location: STRING is "Location"

feature -- Create override dialog

	dialog_create_override_title: STRING is "Add override cluster"

feature -- Class option dialog

	dialog_class_option_class_name: STRING is "Class name"


	remove_group_text: STRING is "Remove group"

feature -- Validation warnings

	version_valid_format: STRING is "Version is not valid. It has to be in the form XXX.XXX.XXX.XXX"
	version_min_max: STRING is "Minimum version cannot be greater than maximum version."
	library_target_override: STRING is "Library target cannot be used because it contains overrides which is forbidden."
	target_add_duplicate: STRING is "Cannot add target because there is already a target with the same name."
	target_remove_library_target: STRING is "Target cannot be removed because it is the library target."
	target_remove_last: STRING is "Target cannot be removed because it is the last target."
	target_remove_extends (other_target: STRING): STRING is
		do
			Result := "Target cannot be removed because "+other_target+" extends it."
		end

	target_name_duplicate: STRING is "Cannot rename target because there is already a target with the new name."
	group_name_duplicate: STRING is "Cannot rename group because there is already a target with the new name."
	root_no_class: STRING is "Cannot specify root cluster or root feature without a root class. Use all classes, specify a root class or specify nothing."
	root_invalid_class: STRING is "Root class name is invalid."
	root_invalid_feature: STRING is "Root feature name is invalid."
	cluster_dependency_group_not_exist: STRING is "Cannot add dependency. There is no group with this name."
	override_group_not_exist: STRING is "Cannot add override. There is no group with this name."
	group_already_exists (a_group: STRING): STRING is
		require
			a_group_not_void: a_group /= Void
		do
			Result := "There is already a group with name "+a_group+"."
		end

	assembly_no_location: STRING is "No location specified."

feature -- Parse errors

	e_parse_invalid_tag (a_tag: STRING): STRING is
		do
			Result := "Invalid tag/tag position '"+a_tag+"'"
		end
	e_parse_invalid_value (an_attribute: STRING): STRING is
		do
			Result := "Invalid (empty) value for '"+an_attribute+"'"
		end
	e_parse_invalid_attribute (an_attribute: STRING): STRING is
		do
			Result := "Invalid attribute '"+an_attribute+"'"
		end
	e_parse_invalid_content (a_content: STRING): STRING is
		do
			Result := "Invalid content: "+a_content
		end

	e_parse_incorrect_system_no_name: STRING is "Incorrect system tag, no name specified."
	e_parse_incorrect_system_invalid_uuid (a_name: STRING): STRING is
		do
			Result := "Incorrect system tag "+a_name+" invalid uuid specified."
		end

	e_parse_multiple_target_with_name (a_target: STRING): STRING is
		do
			Result := "Multiple targets with name "+a_target+"."
		end

	e_parse_incorrect_target_parent (a_parent, a_target: STRING): STRING is
		do
			Result := "Missing parent target: "+a_parent+" in target"+a_target
		end
	e_parse_incorrect_target_no_name: STRING is "Target without a name specified."

	e_parse_incorrect_root_all: STRING is "Invalid value for all_classes attribute in root tag."
	e_parse_incorrect_root: STRING is "Invalid root tag."

	e_parse_incorrect_setting_no_name: STRING is "Invalid setting tag, no name specified."
	e_parse_incorrect_setting (a_setting: STRING): STRING is
		do
			Result := "Invalid setting tag "+a_setting
		end

	e_parse_incorrect_file_rule: STRING is "Invalid file_rule tag."

	e_parse_incorrect_external: STRING is "Invalid external tag."

	e_parse_incorrect_action_invalid (an_action: STRING): STRING is
		do
			Result := "Invalid action tag "+an_action+"."
		end
	e_parse_incorrect_action_succeed (an_action: STRING): STRING is
		do
			Result := "Non boolean value for succeed attribute of action "+an_action+"."
		end
	e_parse_incorrect_action_no_command: STRING is
		do
			Result := "Invalid action tag."
		end

	e_parse_incorrect_variable_no_name: STRING is "Invalid variable tag."
	e_parse_incorrect_variable (a_variable: STRING): STRING is
		do
			Result := "Invalid variable tag "+a_variable+"."
		end

	e_parse_incorrect_library_no_name: STRING is "Invalid library tag."
	e_parse_incorrect_library (a_library: STRING): STRING is
		do
			Result := "Invalid library tag "+a_library+"."
		end
	e_parse_incorrect_library_conflict (a_group: STRING): STRING is
		do
			Result := "Invalid library tag there is already a group with the name "+a_group+"."
		end

	e_parse_incorrect_precompile_no_name: STRING is "Invalid precompile tag."
	e_parse_incorrect_precompile (a_precompile: STRING): STRING is
		do
			Result := "Invalid precompile tag "+a_precompile+"."
		end
	e_parse_incorrect_precompile_conflict (a_group: STRING): STRING is
		do
			Result := "Invalid precompile tag there is already a group with the name "+a_group+"."
		end
	e_parse_incorrect_precompile_multiple (a_precompile, an_other_precompile: STRING): STRING is
		do
			Result := "Invalid precompile tag "+a_precompile+", there is already another precompile specified "+an_other_precompile+"."
		end

	e_parse_incorrect_assembly_no_name: STRING is "Invalid assembly tag no name specified."
	e_parse_incorrect_assembly (an_assembly: STRING): STRING is
		do
			Result := "Invalid assembly tag "+an_assembly+" no location specified."
		end
	e_parse_incorrect_assembly_conflict (a_group: STRING): STRING is
		do
			Result := "Invalid assembly tag there is already a group with the name "+a_group+"."
		end

	e_parse_incorrect_cluster_no_name: STRING is "Invalid cluster tag no name specified."
	e_parse_incorrect_cluster (a_cluster: STRING): STRING is
		do
			Result := "Invalid cluster tag "+a_cluster+" no location specified."
		end
	e_parse_incorrect_cluster_conflict (a_group: STRING): STRING is
		do
			Result := "Invalid cluster tag there is already a group with the name "+a_group+"."
		end

	e_parse_incorrect_override_no_name: STRING is "Invalid override tag no name specified."
	e_parse_incorrect_override (an_override: STRING): STRING is
		do
			Result := "Invalid override tag "+an_override+" no location specified."
		end
	e_parse_incorrect_override_conflict (a_group: STRING): STRING is
		do
			Result := "Invalid override tag there is already a group with the name "+a_group+"."
		end

	e_parse_incorrect_debug_no_name: STRING is "Invalid debug tag."
	e_parse_incorrect_debug (a_debug: STRING): STRING is
		do
			Result := "Invalid debug tag "+a_debug+"."
		end

	e_parse_incorrect_warning_no_name: STRING is "Invalid warning tag."
	e_parse_incorrect_warning (a_warning: STRING): STRING is
		do
			Result := "Invalid warning tag "+a_warning+"."
		end

	e_parse_incorrect_renaming_no_name: STRING is "Invalid renaming tag."
	e_parse_incorrect_renaming_no_new (an_old: STRING): STRING is
		do
			Result := "Invalid renaming tag, no new name specified for "+an_old+"."
		end
	e_parse_incorrect_renaming_no_old (a_new: STRING): STRING is
		do
			Result := "Invalid renaming tag, no old name specified for "+a_new+"."
		end

	e_parse_incorrect_class_opt: STRING is "Invalid class_option tag."

	e_parse_incorrect_visible (a_parent: STRING): STRING is
		do
			Result := "Invalid visible tag on "+a_parent+"."
		end

	e_parse_incorrect_uses (a_group: STRING): STRING is
		do
			Result := "Invalid overrides tag in group "+a_group+"."
		end

	e_parse_incorrect_overrides (a_group: STRING): STRING is
		do
			Result := "Invalid overrides tag in group "+a_group+"."
		end

	e_parse_incorrect_condition: STRING is "Invalid condition tag."

	e_parse_incorrect_platform_mult: STRING is "Cannot have multiple platform specifications in one condition."
	e_parse_incorrect_platform_conflict: STRING is "Value and exclude attribute in platform condition cannot appear at the same time."
	e_parse_incorrect_platform_none: STRING is "No value or excluded-value specified in platform condition."
	e_parse_incorrect_platform (a_platform: STRING): STRING is
		do
			Result := "Invalid platform "+a_platform+"."
		end

	e_parse_incorrect_build_mult: STRING is "Cannot have multiple build specifications in one condition."
	e_parse_incorrect_build_conflict: STRING is "Value and exclude attribute in build condition cannot appear at the same time."
	e_parse_incorrect_build_none: STRING is "No value or excluded-value specified in build condition."
	e_parse_incorrect_build (a_build: STRING): STRING is
		do
			Result := "Invalid build "+a_build+"."
		end

	e_parse_incorrect_multithreaded: STRING is "No valid value specified in multithreaded condition."
	e_parse_incorrect_dotnet: STRING is "No valid value specified in dotnet condition."
	e_parse_incorrect_dynamic_runtime: STRING is "No valid value specified in dynamic runtime condition."

	e_parse_incorrect_version_min (a_version: STRING): STRING is
		do
			Result := "Invalid minimum version number in version condition: "+a_version
		end
	e_parse_incorrect_version_max (a_version: STRING): STRING is
		do
			Result := "Invalid maximum version number in version condition: "+a_version
		end
	e_parse_incorrect_version_no_type: STRING is "No version type specified in version condition."
	e_parse_incorrect_version_no_version (a_version: STRING): STRING is
		do
			Result := "No minimum or maximum version in version condition "+a_version+" specified."
		end
	e_parse_incorrect_version_type (a_type: STRING): STRING is
		do
			Result := "Invalid version type "+a_type+" in version condition."
		end
	e_parse_incorrect_version_min_max (a_type: STRING): STRING is
		do
			Result := "Minimum version cannot be greater than maximum version in version condition "+a_type+"."
		end

	e_parse_incorrect_custom_no_name: STRING is "No name attribute in custom condition."
	e_parse_incorrect_custom_none (a_custom: STRING): STRING is
		do
			Result := "No value or excluded-value specified in custom condition "+a_custom+"."
		end
	e_parse_incorrect_custom_conflict (a_custom: STRING): STRING is
		do
			Result := "Value and exclude attribute in custom condition "+a_custom+" cannot appear at the same time."
		end

	e_parse_incorrect_mapping: STRING is "Invalid mapping tag."

	e_parse_incorrect_description: STRING is "Invalid description tag.";

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

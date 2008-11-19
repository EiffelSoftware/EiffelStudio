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
		export
			{NONE} all
		end

	SHARED_LOCALE

feature -- Configuration

	configuration_title (a_system_name: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Project Settings ($1)"), [a_system_name])
		end

	browse: STRING_GENERAL is do Result := locale.translation ("Browse...")	end

feature -- Section names

	section_system: STRING_GENERAL is do Result := locale.translation ("System")	end
	section_target (a_target: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Target: $1"), [a_target])
		end
	section_assertions: STRING_GENERAL is do Result := locale.translation ("Assertions")	end
	section_groups: STRING_GENERAL is do Result := locale.translation ("Groups")	end
	section_warning: STRING_GENERAL is do Result := locale.translation ("Warnings")	end
	section_debug: STRING_GENERAL is do Result := locale.translation ("Debug")	end
	section_external: STRING_GENERAL is do Result := locale.translation ("Externals")	end
	section_tasks: STRING_GENERAL is do Result := locale.translation ("Tasks")	end
	section_variables: STRING_GENERAL is do Result := locale.translation ("Variables")	end
	section_mapping: STRING_GENERAL is do Result := locale.translation ("Type Mapping")	end
	section_general: STRING_GENERAL is do Result := locale.translation ("General")	end
	section_dotnet: STRING_GENERAL is do Result := locale.translation (".NET")	end
	section_advanced: STRING_GENERAL is do Result := locale.translation ("Advanced")	end

	selection_tree_select_node: STRING_GENERAL is do Result := locale.translation ("Please select a sub node.")	end

feature -- Section actions

	menu_properties: STRING_GENERAL is do Result := locale.translation ("Properties")	end
	menu_edit_config: STRING_GENERAL is do Result := locale.translation ("Edit Configuration")	end
	add_target: STRING_GENERAL is do Result := locale.translation ("Add Target")	end

feature -- General names and descriptions

	file_rule_name: STRING_GENERAL is do Result := locale.translation ("Exclude Rules")	end
	file_rule_description: STRING_GENERAL is do Result := locale.translation ("Regular expressions which exclude/include sub folders and/or files.")	end

feature -- System names and descriptions

	system_name_name: STRING_GENERAL is do Result := locale.translation ("Name")	end
	system_name_description: STRING_GENERAL is do Result := locale.translation ("Name of the system.")	end
	system_description_name: STRING_GENERAL is do Result := locale.translation ("Description")	end
	system_description_description: STRING_GENERAL is do Result := locale.translation ("Description of the system.")	end
	system_library_target_name: STRING_GENERAL is do Result := locale.translation ("Library Target")	end
	system_library_target_description: STRING_GENERAL is do Result := locale.translation ("Target used if system is used as a library.")	end
	system_readonly_name: STRING_GENERAL is do Result := locale.translation ("Library Readonly")	end
	system_readonly_description: STRING_GENERAL is do Result := locale.translation ("Is this system read only per default if it is used as a library?")	end
	system_file_name: STRING_GENERAL is do Result := locale.translation ("File Name")	end
	system_file_description: STRING_GENERAL is do Result := locale.translation ("Location of the configuration file.")	end
	system_uuid_name: STRING_GENERAL is do Result := locale.translation ("UUID")	end
	system_uuid_description: STRING_GENERAL is do Result := locale.translation ("Universal unique identifier for the system.")	end

feature -- Target names and descriptions

	target_name_name: STRING_GENERAL is do Result := locale.translation ("Name")	end
	target_name_description: STRING_GENERAL is do Result := locale.translation ("Name of the target.")	end
	target_description_name: STRING_GENERAL is do Result := locale.translation ("Description")	end
	target_description_description: STRING_GENERAL is do Result := locale.translation ("Description of the target.")	end
	target_abstract_name: STRING_GENERAL is do Result := locale.translation ("Abstract")	end
	target_abstract_description: STRING_GENERAL is do Result := locale.translation ("Is this an abstract target that cannot be used to compile?")	end
	target_compilation_type_name: STRING_GENERAL is do Result := locale.translation ("Compilation Type")	end
	target_compilation_type_description: STRING_GENERAL is do Result := locale.translation ("Type of compilation.")	end
	target_compilation_type_standard: STRING_GENERAL is do Result := locale.translation ("Standard (C/byte code)")	end
	target_compilation_type_dotnet: STRING_GENERAL is do Result := locale.translation (".NET (msil)")	end
	target_executable_name: STRING_GENERAL is do Result := locale.translation ("Output Name")	end
	target_executable_description: STRING_GENERAL is do Result := locale.translation ("Name of the generated binary.")	end
	target_root_name: STRING_GENERAL is do Result := locale.translation ("Root")	end
	target_root_description: STRING_GENERAL is do Result := locale.translation ("Root cluster, class, feature of the system.")	end
	target_version_name: STRING_GENERAL is do Result := locale.translation ("Version")	end
	target_version_description: STRING_GENERAL is do Result := locale.translation ("Version information.")	end
	target_product_name: STRING_GENERAL is do Result := locale.translation ("Product")	end
	target_company_name: STRING_GENERAL is do Result := locale.translation ("Company")	end
	target_copyright_name: STRING_GENERAL is do Result := locale.translation ("Copyright")	end
	target_trademark_name: STRING_GENERAL is do Result := locale.translation ("Trademark")	end
	target_dialog_root_cluster: STRING_GENERAL is do Result := locale.translation ("Root Cluster")	end
	target_dialog_root_class: STRING_GENERAL is do Result := locale.translation ("Root Class")	end
	target_dialog_root_feature: STRING_GENERAL is do Result := locale.translation ("Root Procedure")	end
	target_dialog_root_all: STRING_GENERAL is do Result := locale.translation ("Compile All Classes?")	end

	target_address_expression_name: STRING_GENERAL is do Result := locale.translation ("Address Expression")	end
	target_address_expression_description: STRING_GENERAL is do Result := locale.translation ("Are simplified address expressions enabled?")	end
	target_automatic_backup_name: STRING_GENERAL is do Result := locale.translation ("Automatic Backup")	end
	target_automatic_backup_description: STRING_GENERAL is do Result := locale.translation ("Automatically generate a backup during recompilation?")	end
	target_check_for_void_target_name: STRING_GENERAL is do Result := locale.translation ("Check for Void target")	end
	target_check_for_void_target_description: STRING_GENERAL is do Result := locale.translation ("Throw a call on Void target exception?")	end
	target_check_vape_name: STRING_GENERAL is do Result := locale.translation ("Check VAPE")	end
	target_check_vape_description: STRING_GENERAL is do Result := locale.translation ("Enforce VAPE validity constraint?")	end
	target_console_application_name: STRING_GENERAL is do Result := locale.translation ("Console Application")	end
	target_console_application_description: STRING_GENERAL is do Result := locale.translation ("Is the project a console application?")	end
	target_cls_compliant_name: STRING_GENERAL is do Result := locale.translation ("CLS Compliant")	end
	target_cls_compliant_description: STRING_GENERAL is do Result := locale.translation ("Should generated assemblies be marked as CLS compliant?")	end
	target_dead_code_removal_name: STRING_GENERAL is do Result := locale.translation ("Dead Code Removal")	end
	target_dead_code_removal_description: STRING_GENERAL is do Result := locale.translation ("Should unused code be removed?")	end
	target_dotnet_naming_convention_name: STRING_GENERAL is do Result := locale.translation (".NET Naming Convention")	end
	target_dotnet_naming_convention_description: STRING_GENERAL is do Result := locale.translation ("Should names follow the .NET naming convention?")	end
	target_dynamic_runtime_name: STRING_GENERAL is do Result := locale.translation ("Dynamic Runtime")	end
	target_dynamic_runtime_description: STRING_GENERAL is do Result := locale.translation ("Should the generated executable use a shared library of the runtime?")	end
	target_enforce_unique_class_names_name: STRING_GENERAL is do Result := locale.translation ("Enforce unique class names")	end
	target_enforce_unique_class_names_description: STRING_GENERAL is do Result := locale.translation ("Enforce all class names to be system wide unique?")	end
	target_exception_trace_name: STRING_GENERAL is do Result := locale.translation ("Exception Trace")	end
	target_exception_trace_description: STRING_GENERAL is do Result := locale.translation ("Should a complete exception trace be generated in the finalized version?")	end
	target_il_verifiable_name: STRING_GENERAL is do Result := locale.translation ("IL Verifiable")	end
	target_il_verifiable_description: STRING_GENERAL is do Result := locale.translation ("Should the generated binary be IL verifiable?")	end
	target_inlining_name: STRING_GENERAL is do Result := locale.translation ("Inlining")	end
	target_inlining_description: STRING_GENERAL is do Result := locale.translation ("Should inlining be enabled?")	end
	target_inlining_size_name: STRING_GENERAL is do Result := locale.translation ("Inlining Size")	end
	target_inlining_size_description: STRING_GENERAL is do Result := locale.translation ("Maximal number of instructions in a feature for the feature to be inlined.")	end
	target_line_generation_name: STRING_GENERAL is do Result := locale.translation ("Line Generation")	end
	target_line_generation_description: STRING_GENERAL is do Result := locale.translation ("Generate extra information for external debuggers?")	end
	target_metadata_cache_path_name: STRING_GENERAL is do Result := locale.translation ("Metadata Cache Path")	end
	target_metadata_cache_path_description: STRING_GENERAL is do Result := locale.translation ("Location where information about external assemblies is stored.")	end
	target_msil_classes_per_module_name: STRING_GENERAL is do Result := locale.translation ("Classes per Module")	end
	target_msil_classes_per_module_description: STRING_GENERAL is do Result := locale.translation ("Number of classes generated per .NET module during incremental compilation. Increasing this value will slow down the incremental recompilation, but speed up the time to load the assembly while debugging in workbench mode.")	end
	target_msil_clr_version_name: STRING_GENERAL is do Result := locale.translation (".NET Runtime Version")	end
	target_msil_clr_version_description: STRING_GENERAL is do Result := locale.translation ("Version of the .NET runtime to use.")	end
	target_msil_generation_type_name: STRING_GENERAL is do Result := locale.translation ("Generation Type")	end
	target_msil_generation_type_description: STRING_GENERAL is do Result := locale.translation ("Type of binary to generate.")	end
	target_msil_key_file_name_name: STRING_GENERAL is do Result := locale.translation ("Signing Key")	end
	target_msil_key_file_name_description: STRING_GENERAL is do Result := locale.translation ("Key to be able to add the generated binary to the Global Assembly Cache (GAC). %NChose a new, non existing filename to create a new key file.")	end
	target_msil_use_optimized_precompile_name: STRING_GENERAL is do Result := locale.translation ("Use Optimized Precompile")	end
	target_msil_use_optimized_precompile_description: STRING_GENERAL is do Result := locale.translation ("Use an optimized version of a precompile?")	end
	target_multithreaded_name: STRING_GENERAL is do Result := locale.translation ("Multithreaded")	end
	target_multithreaded_description: STRING_GENERAL is do Result := locale.translation ("Generate a multithreaded application?")	end
	target_old_verbatim_strings_name: STRING_GENERAL is do Result := locale.translation ("Old Verbatim Strings")	end
	target_old_verbatim_strings_description: STRING_GENERAL is do Result := locale.translation ("Use the old format for verbatim strings?")	end
	target_platform_name: STRING_GENERAL is do Result := locale.translation ("Platform")	end
	target_platform_description: STRING_GENERAL is do Result := locale.translation ("Override the detected platform to use in conditions.")	end
	target_shared_library_definition_name: STRING_GENERAL is do Result := locale.translation ("Shared Library Definition")	end
	target_shared_library_definition_description: STRING_GENERAL is do Result := locale.translation ("Specify the file the compiler uses to generate the exported functions.")	end
	target_library_root_name: STRING_GENERAL is do Result := locale.translation ("Library Root")	end
	target_library_root_description: STRING_GENERAL is do Result := locale.translation ("Absolute path to use as base for relative paths.")	end
	target_use_cluster_name_as_namespace_name: STRING_GENERAL is do Result := locale.translation ("Use Cluster Name as Namespace")	end
	target_use_cluster_name_as_namespace_description: STRING_GENERAL is do Result := locale.translation ("Should cluster names be used as namespaces?")	end
	target_use_all_cluster_name_as_namespace_name: STRING_GENERAL is do Result := locale.translation ("Use Recursive Cluster Name as Namespace")	end
	target_use_all_cluster_name_as_namespace_description: STRING_GENERAL is do Result := locale.translation ("Should names of folders in recursive clusters be used as namespaces?")	end
	target_force_32bits_name: STRING_GENERAL is do Result := locale.translation ("Force 32bits")	end
	target_force_32bits_description: STRING_GENERAL is do Result := locale.translation ("Force compilation for 32bits?")	end

	target_edit_manually: STRING_GENERAL is do Result := locale.translation ("Manually Edit Configuration")	end

	external_location_name: STRING_GENERAL is do Result := locale.translation ("Location")	end
	external_location_description: STRING_GENERAL is do Result := locale.translation ("Location of the external.")	end
	external_description_name: STRING_GENERAL is do Result := locale.translation ("Description")	end
	external_description_description: STRING_GENERAL is do Result := locale.translation ("Description of the external.")	end
	external_condition_name: STRING_GENERAL is do Result := locale.translation ("Condition")	end
	external_condition_description: STRING_GENERAL is do Result := locale.translation ("Conditions for this external.")	end

	external_include: STRING_GENERAL is do Result := locale.translation ("Include")	end
	external_object: STRING_GENERAL is do Result := locale.translation ("Object")	end
	external_library: STRING_GENERAL is do Result := locale.translation ("Library")	end
	external_make: STRING_GENERAL is do Result := locale.translation ("Makefile")	end
	external_resource: STRING_GENERAL is do Result := locale.translation ("Resource")	end

	external_include_tree: STRING_GENERAL is do Result := locale.translation ("Includes")	end
	external_object_tree: STRING_GENERAL is do Result := locale.translation ("Objects")	end
	external_library_tree: STRING_GENERAL is do Result := locale.translation ("Libraries")	end
	external_make_tree: STRING_GENERAL is do Result := locale.translation ("Makefiles")	end
	external_resource_tree: STRING_GENERAL is do Result := locale.translation ("Resources")	end

	external_add_include: STRING_GENERAL is do Result := locale.translation ("Add Include")	end
	external_add_object: STRING_GENERAL is do Result := locale.translation ("Add Object")	end
	external_add_library: STRING_GENERAL is do Result := locale.translation ("Add Library")	end
	external_add_make: STRING_GENERAL is do Result := locale.translation ("Add Make")	end
	external_add_resource: STRING_GENERAL is do Result := locale.translation ("Add Resource")	end

	task_pre_tree: STRING_GENERAL is do Result := locale.translation ("Pre Compilation Tasks")	end
	task_post_tree: STRING_GENERAL is do Result := locale.translation ("Post Compilation Tasks")	end

	task_pre: STRING_GENERAL is do Result := locale.translation ("Pre Compilation")	end
	task_post: STRING_GENERAL is do Result := locale.translation ("Post Compilation")	end
	task_type_name: STRING_GENERAL is do Result := locale.translation ("Type")	end
	task_type_description: STRING_GENERAL is do Result := locale.translation ("Type of the task.")	end
	task_command_name: STRING_GENERAL is do Result := locale.translation ("Command")	end
	task_command_description: STRING_GENERAL is do Result := locale.translation ("Command to execute.")	end
	task_description_name: STRING_GENERAL is do Result := locale.translation ("Description")	end
	task_description_description: STRING_GENERAL is do Result := locale.translation ("Description of the task.")	end
	task_working_directory_name: STRING_GENERAL is do Result := locale.translation ("Working Directory")	end
	task_working_directory_description: STRING_GENERAL is do Result := locale.translation ("Directory where the command will be executed.")	end
	task_succeed_name: STRING_GENERAL is do Result := locale.translation ("Must succeed")	end
	task_succeed_description: STRING_GENERAL is do Result := locale.translation ("Does this task have to finish successful for the compilation to continue?")	end
	task_condition_name: STRING_GENERAL is do Result := locale.translation ("Condition")	end
	task_condition_description: STRING_GENERAL is do Result := locale.translation ("Conditions for this task to be executed.")	end
	task_add_pre: STRING_GENERAL is do Result := locale.translation ("Add Pre Compilation Task")	end
	task_add_post: STRING_GENERAL is do Result := locale.translation ("Add Post Compilation Task")	end

	group_cluster_tree: STRING_GENERAL is do Result := locale.translation ("Clusters")	end
	group_assembly_tree: STRING_GENERAL is do Result := locale.translation ("Assemblies")	end
	group_library_tree: STRING_GENERAL is do Result := locale.translation ("Libraries")	end
	group_precompile_tree: STRING_GENERAL is do Result := locale.translation ("Precompile")	end
	group_override_tree: STRING_GENERAL is do Result := locale.translation ("Overrides")	end

	group_cluster: STRING_GENERAL is do Result := locale.translation ("Cluster")	end
	group_assembly: STRING_GENERAL is do Result := locale.translation ("Assembly")	end
	group_library: STRING_GENERAL is do Result := locale.translation ("Library")	end
	group_precompile: STRING_GENERAL is do Result := locale.translation ("Precompile")	end
	group_override: STRING_GENERAL is do Result := locale.translation ("Override")	end

	group_type_name: STRING_GENERAL is do Result := locale.translation ("Type")	end
	group_type_description: STRING_GENERAL is do Result := locale.translation ("Type of the group.")	end
	group_name_name: STRING_GENERAL is do Result := locale.translation ("Name")	end
	group_name_description: STRING_GENERAL is do Result := locale.translation ("Name of the group.")	end
	group_description_name: STRING_GENERAL is do Result := locale.translation ("Description")	end
	group_description_description: STRING_GENERAL is do Result := locale.translation ("Description of the group.")	end
	group_condition_name: STRING_GENERAL is do Result := locale.translation ("Condition")	end
	group_condition_description: STRING_GENERAL is do Result := locale.translation ("Conditions for this group to be used.")	end
	group_readonly_name: STRING_GENERAL is do Result := locale.translation ("Read Only")	end
	group_readonly_description: STRING_GENERAL is do Result := locale.translation ("Is this group read only?")	end
	group_location_name: STRING_GENERAL is do Result := locale.translation ("Location")	end
	group_location_description: STRING_GENERAL is do Result := locale.translation ("Location of this group.")	end
	group_prefix_name: STRING_GENERAL is do Result := locale.translation ("Prefix")	end
	group_prefix_description: STRING_GENERAL is do Result := locale.translation ("Prefix which all classes in this group get.")	end
	group_renaming_name: STRING_GENERAL is do Result := locale.translation ("Renaming")	end
	group_renaming_description: STRING_GENERAL is do Result := locale.translation ("Renaming of classes in this group.")	end
	group_class_option_name: STRING_GENERAL is do Result := locale.translation ("Class Options")	end
	group_class_option_description: STRING_GENERAL is do Result := locale.translation ("Class specific options.")	end
	group_eifgens_location_name: STRING_GENERAL is do Result := locale.translation ("EIFGENs location")	end
	group_eifgens_location_description: STRING_GENERAL is do Result := locale.translation ("Directory where the EIFGENs folder is.")	end
	group_add_cluster: STRING_GENERAL is do Result := locale.translation ("Add Cluster")	end
	group_add_subcluster: STRING_GENERAL is do Result := locale.translation ("Add Sub cluster")	end
	group_add_override: STRING_GENERAL is do Result := locale.translation ("Add Override")	end
	group_add_assembly: STRING_GENERAL is do Result := locale.translation ("Add Assembly")	end
	group_add_library: STRING_GENERAL is do Result := locale.translation ("Add Library")	end
	group_add_precompile: STRING_GENERAL is do Result := locale.translation ("Add Precompile")	end

	library_edit_configuration: STRING_GENERAL is do Result := locale.translation ("Edit Library Configuration")	end
	library_use_application_options_name: STRING_GENERAL is do Result := locale.translation ("Use Application Options")	end
	library_use_application_options_description: STRING_GENERAL is do Result := locale.translation ("Should this library use options from the application instead of from the library?")	end

	cluster_recursive_name: STRING_GENERAL is do Result := locale.translation ("Recursive")	end
	cluster_recursive_description: STRING_GENERAL is do Result := locale.translation ("Are sub folders recursively included?")	end
	cluster_hidden_name: STRING_GENERAL is do Result := locale.translation ("Hidden")	end
	cluster_hidden_description: STRING_GENERAL is do Result := locale.translation ("Is this a hidden cluster that can not be used if the system is used as a library?")	end
	cluster_dependencies_name: STRING_GENERAL is do Result := locale.translation ("Dependencies")	end
	cluster_dependencies_description: STRING_GENERAL is do Result := locale.translation ("Groups this cluster depends on.")	end
	cluster_visible_name: STRING_GENERAL is do Result := locale.translation ("Visible Classes")	end
	cluster_visible_description: STRING_GENERAL is do Result := locale.translation ("Classes visible for external code.")	end
	cluster_mapping_name: STRING_GENERAL is do Result := locale.translation ("Type Mapping")	end
	cluster_mapping_description: STRING_GENERAL is do Result := locale.translation ("Special type mappings.")	end

	assembly_name_name: STRING_GENERAL is do Result := locale.translation ("Assembly Name")	end
	assembly_name_description: STRING_GENERAL is do Result := locale.translation ("Full name of the assembly as found in the GAC.")	end
	assembly_culture_name: STRING_GENERAL is do Result := locale.translation ("Assembly Culture")	end
	assembly_culture_description: STRING_GENERAL is do Result := locale.translation ("Culture of the assembly.")	end
	assembly_version_name: STRING_GENERAL is do Result := locale.translation ("Assembly Version")	end
	assembly_version_description: STRING_GENERAL is do Result := locale.translation ("Version of the assembly.")	end
	assembly_public_key_token_name: STRING_GENERAL is do Result := locale.translation ("Assembly Public Key Token")	end
	assembly_public_key_token_description: STRING_GENERAL is do Result := locale.translation ("Public key token that identifies the asssembly.")	end

	override_override_name: STRING_GENERAL is do Result := locale.translation ("Overriding")	end
	override_override_description: STRING_GENERAL is do Result := locale.translation ("Groups this override is overriding.")	end
	class_option_class_name: STRING_GENERAL is do Result := locale.translation ("Name")	end
	class_option_file_name: STRING_GENERAL is do Result := locale.translation ("Location")	end
	properties_class_name: STRING_GENERAL is do Result := locale.translation ("Class")	end
	properties_target_name: STRING_GENERAL is do Result := locale.translation ("Target")	end

feature -- Option names and descriptions

	option_require_name: STRING_GENERAL is do Result := locale.translation ("Require")	end
	option_require_description: STRING_GENERAL is do Result := locale.translation ("Evaluate precondition assertions?")	end
	option_ensure_name: STRING_GENERAL is do Result := locale.translation ("Ensure")	end
	option_ensure_description: STRING_GENERAL is do Result := locale.translation ("Evaluate postcondition assertions?")	end
	option_check_name: STRING_GENERAL is do Result := locale.translation ("Check")	end
	option_check_description: STRING_GENERAL is do Result := locale.translation ("Evaluate check assertions?")	end
	option_invariant_name: STRING_GENERAL is do Result := locale.translation ("Invariant")	end
	option_invariant_description: STRING_GENERAL is do Result := locale.translation ("Evaluate invariant assertions?")	end
	option_loop_name: STRING_GENERAL is do Result := locale.translation ("Loop")	end
	option_loop_description: STRING_GENERAL is do Result := locale.translation ("Evaluate loop assertions?")	end
	option_sup_require_name: STRING_GENERAL is do Result := locale.translation ("Supplier Precondition")	end
	option_sup_require_description: STRING_GENERAL is do Result := locale.translation ("Evaluate precondition assertions of suppliers?")	end

	option_profile_name: STRING_GENERAL is do Result := locale.translation ("Profile")	end
	option_profile_description: STRING_GENERAL is do Result := locale.translation ("Generate profiling information?")	end
	option_trace_name: STRING_GENERAL is do Result := locale.translation ("Trace")	end
	option_trace_description: STRING_GENERAL is do Result := locale.translation ("Display name of all called features during execution?")	end
	option_full_class_checking_name: STRING_GENERAL is do Result := locale.translation ("Full Class Checking")	end
	option_full_class_checking_description: STRING_GENERAL is do Result := locale.translation ("Are features of parent classes rechecked in current class?")	end

	option_msil_application_optimize_name: STRING_GENERAL is do Result := locale.translation ("Apply Application Optimizations")	end
	option_msil_application_optimize_description: STRING_GENERAL is do Result := locale.translation ("Specifies if any applicable application-orientated optimizations should be applied to a finalized compilation.")	end

	option_namespace_name: STRING_GENERAL is do Result := locale.translation (".NET Namespace")	end
	option_namespace_description: STRING_GENERAL is do Result := locale.translation ("Namespace for .NET")	end

	option_debug_name: STRING_GENERAL is do Result := locale.translation ("Enabled")	end
	option_debug_description: STRING_GENERAL is do Result := locale.translation ("Are debug clauses globally enabled?")	end
	option_unnamed_debug_name: STRING_GENERAL is do Result := locale.translation ("Unnamed Debugs")	end

	option_warnings_name: STRING_GENERAL is do Result := locale.translation ("Enabled")	end
	option_warnings_description: STRING_GENERAL is do Result := locale.translation ("Are warnings enabled?")	end

	option_cat_call_detection_name: STRING_GENERAL is do Result := locale.translation ("Cat call detection (experimental)") end
	option_cat_call_detection_description: STRING_GENERAL is do Result := locale.translation ("Are all feature calls checked if they are a potential cat-call?") end

	option_is_attached_by_default_name: STRING_GENERAL do Result := locale.translation ("Are types attached by default?") end
	option_is_attached_by_default_description: STRING_GENERAL do Result := locale.translation ("Are types without explicit attachment mark considered attached?") end

	option_is_void_safe_name: STRING_GENERAL do Result := locale.translation ("Is source code void safe?") end
	option_is_void_safe_description: STRING_GENERAL do Result := locale.translation ("Shall feature calls on targets of detachable types be reported as errors?") end

	option_syntax_level_name: STRING_GENERAL do Result := locale.translation ("Syntax level") end
	option_syntax_level_description: STRING_GENERAL do Result := locale.translation ("Variant of syntax used in source code") end
	option_syntax_level_obsolete_name: STRING_GENERAL do Result := locale.translation ("Obsolete syntax") end
	option_syntax_level_transitional_name: STRING_GENERAL do Result := locale.translation ("Transitional syntax") end
	option_syntax_level_standard_name: STRING_GENERAL do Result := locale.translation ("Standard syntax") end

	warning_names: HASH_TABLE [STRING_GENERAL, STRING] is
			-- Warning names.
		once
			create Result.make (10)
			Result.force (locale.translation ("Unused Locals"), w_unused_local)
			Result.force (locale.translation ("Obsolete Classes"), w_obsolete_class)
			Result.force (locale.translation ("Obsolete Features"), w_obsolete_feature)
			Result.force (locale.translation ("Old Syntax"), w_syntax)
			Result.force (locale.translation ("Same UUID"), w_same_uuid)
			Result.force (locale.translation ("Missing Class Export"), w_export_class_missing)
			Result.force (locale.translation ("Incompatible Types Equality"), w_vweq)
			Result.force (locale.translation ("Assignment on Formal/Expanded"), w_vjrv)
			Result.force (locale.translation ("Renaming Unknown Class"), w_renaming_unknown_class)
			Result.force (locale.translation ("Options Unknown Class"), w_option_unknown_class)
			Result.force (locale.translation ("Classname/filename mismatch"), w_classname_filename_mismatch)
		end

	warning_descriptions: HASH_TABLE [STRING_GENERAL, STRING] is
			-- Warning descriptions.
		once
			create Result.make (10)
			Result.force (locale.translation ("Warn about locals that are not used?"), w_unused_local)
			Result.force (locale.translation ("Warn about usage of obsolete classes?"), w_obsolete_class)
			Result.force (locale.translation ("Warn about usage of obsolete features?"), w_obsolete_feature)
			Result.force (locale.translation ("Warn about usage of old syntax?"), w_syntax)
			Result.force (locale.translation ("Warn about different files with the same UUID?"), w_same_uuid)
			Result.force (locale.translation ("Warn about missing classes in export clauses (VTCM)?"), w_export_class_missing)
			Result.force (locale.translation ("Warn about incompatible types in equality comparisons (VWEQ)?"), w_vweq)
			Result.force (locale.translation ("Warn about assignment attempts on formal or expanded targets (VJRV)?"), w_vjrv)
			Result.force (locale.translation ("Warn about renamings of unknown classes?"), w_renaming_unknown_class)
			Result.force (locale.translation ("Warn about class options of unknown classes?"), w_option_unknown_class)
			Result.force (locale.translation ("Warn about classes where the filename does not match the classname?"), w_classname_filename_mismatch)
		end

feature -- Misc

	general_add: STRING_GENERAL is do Result := locale.translation ("Add")	end
	general_remove: STRING_GENERAL is do Result := locale.translation ("Remove")	end
	variables_name: STRING_GENERAL is do Result := locale.translation ("Name")	end
	variables_value: STRING_GENERAL is do Result := locale.translation ("Value")	end
	mapping_old_name: STRING_GENERAL is do Result := locale.translation ("Old Name")	end
	mapping_new_name: STRING_GENERAL is do Result := locale.translation ("New Name")	end
	remove_target (a_target: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove $1?"), [a_target])
		end

	target_remove_group (a_group: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove $1 and any children of it?"), [a_group])
		end
	target_remove_library (a_group: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove the reference to $1?"), [a_group])
		end
	target_remove_external (a_external: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove $1?"), [a_external])
		end
	target_remove_task (a_task: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove $1?"), [a_task])
		end

feature -- Condition dialog

	dial_cond_platforms: STRING_GENERAL is do Result := locale.translation ("Platforms")	end
	dial_cond_platforms_exclude: STRING_GENERAL is do Result := locale.translation ("Exclude platform(s)")	end
	dial_cond_other: STRING_GENERAL is do Result := locale.translation ("Other")	end
	dial_cond_build: STRING_GENERAL is do Result := locale.translation ("Build")	end
	dial_cond_dotnet: STRING_GENERAL is do Result := locale.translation (".NET")	end
	dial_cond_multithreaded: STRING_GENERAL is do Result := locale.translation ("Multithreaded")	end
	dial_cond_dynamic_runtime: STRING_GENERAL is do Result := locale.translation ("Dynamic runtime")	end
	dial_cond_version: STRING_GENERAL is do Result := locale.translation ("Version")	end
	dial_cond_version_compiler: STRING_GENERAL is do Result := locale.translation ("<= compiler version <= ")	end
	dial_cond_version_clr: STRING_GENERAL is do Result := locale.translation ("<= MSIL CLR version <= ")	end
	dial_cond_custom: STRING_GENERAL is do Result := locale.translation ("Custom")	end
	dial_cond_new_custom: STRING_GENERAL is do Result := locale.translation ("new")	end
	dial_cond_new_custom_value: STRING_GENERAL is do Result := locale.translation ("new_value")	end
	dial_cond_custom_variable: STRING_GENERAL is do Result := locale.translation ("Variable")	end
	dial_cond_custom_value: STRING_GENERAL is do Result := locale.translation ("Value")	end
	dial_cond_add_and_term: STRING_GENERAL is do Result := locale.translation ("Add and-term")	end
	dial_cond_remove_and_term: STRING_GENERAL is do Result := locale.translation ("Remove and-term")	end
	dial_cond_and_term_1: STRING_GENERAL is do Result := locale.translation ("And-term 1")	end
	dial_cond_and_term_x (a_number: INTEGER): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("or And-term $1"), [a_number.out])
		end

feature -- File rule dialog

	dialog_file_rule_excludes: STRING_GENERAL is do Result := locale.translation ("Excludes:")	end
	dialog_file_rule_includes: STRING_GENERAL is do Result := locale.translation ("Includes:")	end
	dialog_file_rule_description: STRING_GENERAL is do Result := locale.translation ("Description:")	end
	dialog_file_rule_condition: STRING_GENERAL is do Result := locale.translation ("Condition:")	end
	dialog_file_rule_edit_condition: STRING_GENERAL is do Result := locale.translation ("Edit condition")	end
	dialog_file_rule_add_rule: STRING_GENERAL is do Result := locale.translation ("Add rule")	end
	dialog_file_rule_remove_rule: STRING_GENERAL is do Result := locale.translation ("Remove rule")	end
	dialog_file_rule_file_rule_x (a_number: INTEGER): STRING is
		do
			Result := locale.formatted_string (locale.translation ("File rule $1"), [a_number.out])
		end

feature -- Visible dialog

	dialog_visible_name: STRING_GENERAL is do Result := locale.translation ("Name: ")	end
	dialog_visible_renamed_name: STRING_GENERAL is do Result := locale.translation ("Renamed name: ")	end
	dialog_visible_add_class: STRING_GENERAL is do Result := locale.translation ("Add class")	end
	dialog_visible_add_feature: STRING_GENERAL is do Result := locale.translation ("Add feature")	end
	dialog_visible_remove: STRING_GENERAL is do Result := locale.translation ("Remove")	end

feature -- Renaming dialog

	dialog_renaming_old_name: STRING_GENERAL is do Result := locale.translation ("Old name")	end
	dialog_renaming_new_name: STRING_GENERAL is do Result := locale.translation ("New name")	end
	dialog_renaming_create_old: STRING_GENERAL is do Result := locale.translation ("OLD_NAME")	end
	dialog_renaming_create_new: STRING_GENERAL is do Result := locale.translation ("NEW_NAME")	end

feature -- Create task dialog

	dialog_task_add: STRING_GENERAL is do Result := locale.translation ("Add new task")	end

feature -- Create external dialog

	dialog_external_add: STRING_GENERAL is do Result := locale.translation ("Add new external")	end

feature -- Create library dialog

	dialog_create_library_title: STRING_GENERAL is do Result := locale.translation ("Add Library")	end
	dialog_create_library_defaults: STRING_GENERAL is do Result := locale.translation ("Default libraries")	end
	dialog_create_library_name: STRING_GENERAL is do Result := locale.translation ("Name")	end
	dialog_create_library_location: STRING_GENERAL is do Result := locale.translation ("Location")	end

feature -- Create precompile dialog

	dialog_create_precompile_title: STRING_GENERAL is do Result := locale.translation ("Add Precompile")	end
	dialog_create_precompile_defaults: STRING_GENERAL is do Result := locale.translation ("Default precompiles")	end
	dialog_create_precompile_name: STRING_GENERAL is do Result := locale.translation ("Name")	end
	dialog_create_precompile_location: STRING_GENERAL is do Result := locale.translation ("Location")	end

feature -- Create assembly dialog

	dialog_create_assembly_found: STRING_GENERAL is do Result := locale.translation ("Assemblies")	end
	dialog_create_assembly_title: STRING_GENERAL is do Result := locale.translation ("Add Assembly")	end
	dialog_create_assembly_name: STRING_GENERAL is do Result := locale.translation ("Name")	end
	dialog_create_assembly_location: STRING_GENERAL is do Result := locale.translation ("Location")	end
	dialog_create_assembly_a_name: STRING_GENERAL is do Result := locale.translation ("Assembly Name")	end
	dialog_create_assembly_a_version: STRING_GENERAL is do Result := locale.translation ("Assembly Version")	end
	dialog_create_assembly_a_culture: STRING_GENERAL is do Result := locale.translation ("Assembly Culture")	end
	dialog_create_assembly_a_key: STRING_GENERAL is do Result := locale.translation ("Assembly Key")	end

feature -- Create cluster dialog

	dialog_create_cluster_title: STRING_GENERAL is do Result := locale.translation ("Add Cluster")	end
	dialog_create_cluster_name: STRING_GENERAL is do Result := locale.translation ("Name")	end
	dialog_create_cluster_location: STRING_GENERAL is do Result := locale.translation ("Location")	end

feature -- Create override dialog

	dialog_create_override_title: STRING_GENERAL is do Result := locale.translation ("Add Override Cluster")	end

feature -- Class option dialog

	dialog_class_option_class_name: STRING_GENERAL is do Result := locale.translation ("Class name")	end

	remove_group_text: STRING_GENERAL is do Result := locale.translation ("Remove group")	end

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

	target_name_invalid: STRING is "Cannot rename target because the name is invalid."
	target_name_duplicate: STRING is "Cannot rename target because there is already a target with the new name."
	target_name_empty: STRING is "Cannot rename target because the name is empty."
	group_name_invalid: STRING is "Cannot rename group because the name is not valid."
	group_name_duplicate: STRING is "Cannot rename group because there is already a target with the new name."
	group_name_empty: STRING is "Cannot rename group because the name is empty."
	root_no_class: STRING is "Cannot specify root cluster or root procedure without a root class. Use all classes, specify a root class or specify nothing."
	root_none: STRING is "Root class has to be specified if the target is not extended by another target."
	root_invalid_cluster: STRING is "Root cluster name is invalid."
	root_invalid_class: STRING is "Root class name is invalid."
	root_invalid_feature: STRING is "Root procedure name is invalid."
	cluster_dependency_group_not_exist: STRING is "Cannot add dependency. There is no group with this name."
	override_group_not_exist: STRING is "Cannot add override. There is no group with this name."
	invalid_group_name: STRING is "The name of the group is invalid."
	group_already_exists (a_group: STRING): STRING is
		require
			a_group_not_void: a_group /= Void
		do
			Result := "There is already a group with name "+a_group+"."
		end

	assembly_no_location: STRING is "No location specified."

feature -- Parse errors

	e_internal_parse_error: STRING is "Cannot parse configuration file. Unknown internal error."

	e_parse_invalid_tag (a_tag: STRING): STRING is
		do
			Result := "Invalid tag/tag position '"+a_tag+"'"
		end
	e_parse_invalid_value (an_attribute: STRING): STRING is
		do
			Result := "Invalid or empty value for '"+an_attribute+"'"
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
	e_parse_incorrect_system_name (a_system: STRING): STRING is
		do
			Result := "Invalid system name "+a_system+"."
		end

	e_parse_incorrect_system_invalid_uuid (a_name: STRING): STRING is
		do
			Result := "Incorrect system tag "+a_name+" invalid UUID specified."
		end

	e_parse_multiple_target_with_name (a_target: STRING): STRING is
		do
			Result := "Multiple targets with name "+a_target+"."
		end

	e_parse_incorrect_target_parent (a_parent, a_target: STRING): STRING is
		do
			Result := "Missing parent target: "+a_parent+" in target "+a_target
		end
	e_parse_incorrect_target_no_name: STRING is "Target without a name specified."
	e_parse_incorrect_target_invalid_name (a_target: STRING): STRING is
		do
			Result := "Invalid target name "+a_target+"."
		end

	e_parse_incorrect_root_all: STRING is "Invalid value for all_classes attribute in root tag."
	e_parse_incorrect_root: STRING is "Invalid root tag."
	e_parse_incorrect_root_cluster: STRING is "Invalid root cluster."
	e_parse_incorrect_root_class: STRING is "Invalid root class."
	e_parse_incorrect_root_feature: STRING is "Invalid root procedure."

	e_parse_incorrect_setting_no_name: STRING is "Invalid setting tag, no name specified."
	e_parse_incorrect_setting (a_setting: STRING): STRING is
		do
			Result := "Invalid setting tag "+a_setting
		end
	e_parse_incorrect_setting_value	(a_setting: STRING): STRING is
		do
			Result := "Invalid value for setting "+a_setting
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
	e_parse_incorrect_library_name (a_group: STRING): STRING is
		do
			Result := "Invalid library name "+a_group+"."
		end
	e_parse_incorrect_library (a_library: STRING): STRING is
		do
			Result := "Invalid library tag "+a_library+"."
		end
	e_parse_incorrect_library_conflict (a_group: STRING): STRING is
		do
			Result := "Invalid library tag there is already a group with the name "+a_group+"."
		end

	e_parse_incorrect_precompile_no_name: STRING is "Invalid precompile tag."
	e_parse_incorrect_precompile_name (a_group: STRING): STRING is
		do
			Result := "Invalid precompile name "+a_group+"."
		end
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
	e_parse_incorrect_assembly_name (a_group: STRING): STRING is
		do
			Result := "Invalid assembly name "+a_group+"."
		end
	e_parse_incorrect_assembly (an_assembly: STRING): STRING is
		do
			Result := "Invalid assembly tag "+an_assembly+" no location specified."
		end
	e_parse_incorrect_assembly_conflict (a_group: STRING): STRING is
		do
			Result := "Invalid assembly tag there is already a group with the name "+a_group+"."
		end

	e_parse_incorrect_cluster_no_name: STRING is "Invalid cluster tag no name specified."
	e_parse_incorrect_cluster_name (a_group: STRING): STRING is
		do
			Result := "Invalid cluster name "+a_group+"."
		end
	e_parse_incorrect_cluster (a_cluster: STRING): STRING is
		do
			Result := "Invalid cluster tag "+a_cluster+" no location specified."
		end
	e_parse_incorrect_cluster_conflict (a_group: STRING): STRING is
		do
			Result := "Invalid cluster tag there is already a group with the name "+a_group+"."
		end

	e_parse_incorrect_override_no_name: STRING is "Invalid override tag no name specified."
	e_parse_incorrect_override_name (a_group: STRING): STRING is
		do
			Result := "Invalid override name "+a_group+"."
		end
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
	e_parse_incorrect_visible_feature (a_feature: STRING): STRING is
		do
			Result := "Incorrect feature name "+a_feature+" in visible clause ."
		end
	e_parse_incorrect_visible_class (a_class: STRING): STRING is
		do
			Result := "Incorrect class name "+a_class+" in visible clause ."
		end

	e_parse_incorrect_uses (a_group: STRING): STRING is
		do
			Result := "Invalid uses tag in group "+a_group+"."
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
	e_parse_incorrect_dotnet: STRING is "No valid value specified in .NET condition."
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

feature -- Boolean values

	boolean_true: STRING_GENERAL is do Result := locale.translation ("True") end

	boolean_false: STRING_GENERAL is do Result := locale.translation ("False") end

	boolean_values: HASH_TABLE [BOOLEAN, STRING_GENERAL] is
			-- Boolean values mapping
		once
			create Result.make (2)
			Result.force (True, boolean_true)
			Result.force (False, boolean_false)
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

note
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

	configuration_title (a_system_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Project Settings ($1)"), [a_system_name])
		end

	readonly_warning: STRING_32
		do
			Result := locale.translation (" -- Readonly (Changes will not be saved.)")
		end

	browse: STRING_32 do Result := locale.translation ("Browse...")	end

feature -- Section names

	section_system: STRING_32 do Result := locale.translation ("System")	end
	section_target (a_target: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Target: $1"), [a_target])
		end
	section_assertions: STRING_32 do Result := locale.translation ("Assertions")	end
	section_groups: STRING_32 do Result := locale.translation ("Groups")	end
	section_warning: STRING_32 do Result := locale.translation ("Warnings")	end
	section_debug: STRING_32 do Result := locale.translation ("Debug")	end
	section_external: STRING_32 do Result := locale.translation ("Externals")	end
	section_tasks: STRING_32 do Result := locale.translation ("Tasks")	end
	section_variables: STRING_32 do Result := locale.translation ("Variables")	end
	section_mapping: STRING_32 do Result := locale.translation ("Type Mapping")	end

	section_general: STRING_32 do Result := locale.translation ("General")	end
	section_capability: STRING_32 do Result := locale.translation ("Capability")	end
	section_language: STRING_32 do Result := locale.translation ("Language")	end
	section_execution: STRING_32 do Result := locale.translation ("Execution")	end
	section_optimization: STRING_32 do Result := locale.translation ("Optimization")	end
	section_sources: STRING_32 do Result := locale.translation ("Sources")	end
	section_dotnet: STRING_32 do Result := locale.translation (".NET")	end
	section_advanced: STRING_32 do Result := locale.translation ("Advanced")	end

	selection_tree_select_node: STRING_32 do Result := locale.translation ("Please select a sub node.")	end

feature -- Section actions

	menu_properties: STRING_32 do Result := locale.translation ("Properties")	end
	menu_edit_config: STRING_32 do Result := locale.translation ("Edit Configuration")	end
	add_target: STRING_32 do Result := locale.translation ("Add Target")	end
	add_remote_target: STRING_32 do Result := locale.translation ("Add Remote Target")	end

feature -- General names and descriptions

	file_rule_name: STRING_32 do Result := locale.translation ("Exclude Rules")	end
	file_rule_description: STRING_32 do Result := locale.translation ("Regular expressions which exclude/include sub folders and/or files.")	end

feature -- System names and descriptions

	system_name_name: STRING_32 do Result := locale.translation ("Name")	end
	system_name_description: STRING_32 do Result := locale.translation ("Name of the system.")	end
	system_description_name: STRING_32 do Result := locale.translation ("Description")	end
	system_description_description: STRING_32 do Result := locale.translation ("Description of the system.")	end
	system_library_target_name: STRING_32 do Result := locale.translation ("Library Target")	end
	system_library_target_description: STRING_32 do Result := locale.translation ("Target used if system is used as a library.")	end
	system_readonly_name: STRING_32 do Result := locale.translation ("Library Readonly")	end
	system_readonly_description: STRING_32 do Result := locale.translation ("Is this system read only per default if it is used as a library?")	end
	system_file_name: STRING_32 do Result := locale.translation ("File Name")	end
	system_file_description: STRING_32 do Result := locale.translation ("Location of the configuration file.")	end
	system_uuid_name: STRING_32 do Result := locale.translation ("UUID")	end
	system_uuid_description: STRING_32 do Result := locale.translation ("Universal unique identifier for the system.")	end

feature -- Target names and descriptions

	target_name_name: STRING_32 do Result := locale.translation ("Name")	end
	target_name_description: STRING_32 do Result := locale.translation ("Name of the target.")	end
	target_location_name: STRING_32 do Result := locale.translation ("Location") end
	target_location_description: STRING_32 do Result := locale.translation ("Location of the target system.")	end
	target_description_name: STRING_32 do Result := locale.translation ("Description")	end
	target_description_description: STRING_32 do Result := locale.translation ("Description of the target.")	end
	target_abstract_name: STRING_32 do Result := locale.translation ("Abstract")	end
	target_abstract_description: STRING_32 do Result := locale.translation ("Is this an abstract target that cannot be used to compile?")	end
	target_compilation_type_name: STRING_32 do Result := locale.translation ("Compilation Type")	end
	target_compilation_type_description: STRING_32 do Result := locale.translation ("Type of compilation.")	end
	target_compilation_type_standard: STRING_32 do Result := locale.translation ("Standard (C/byte code)")	end
	target_compilation_type_dotnet: STRING_32 do Result := locale.translation (".NET (msil)")	end
	target_executable_name: STRING_32 do Result := locale.translation ("Output Name")	end
	target_executable_description: STRING_32 do Result := locale.translation ("Name of the generated binary.")	end
	target_root_name: STRING_32 do Result := locale.translation ("Root")	end
	target_root_description: STRING_32 do Result := locale.translation ("Root cluster, class, feature of the system.")	end
	target_version_name: STRING_32 do Result := locale.translation ("Version")	end
	target_version_description: STRING_32 do Result := locale.translation ("Version information.")	end
	target_product_name: STRING_32 do Result := locale.translation ("Product")	end
	target_company_name: STRING_32 do Result := locale.translation ("Company")	end
	target_copyright_name: STRING_32 do Result := locale.translation ("Copyright")	end
	target_trademark_name: STRING_32 do Result := locale.translation ("Trademark")	end
	target_dialog_root_cluster: STRING_32 do Result := locale.translation ("Root Cluster")	end
	target_dialog_root_class: STRING_32 do Result := locale.translation ("Root Class")	end
	target_dialog_root_feature: STRING_32 do Result := locale.translation ("Root Procedure")	end
	target_dialog_root_all: STRING_32 do Result := locale.translation ("Compile All Classes?")	end

	target_absent_explicit_assertion_name: STRING_32 do Result := locale.translation ("Absent Explicit Assertion")	end
	target_absent_explicit_assertion_description: STRING_32 do Result := locale.translation ("[
			Are some assertions inferred automatically?
			This experimental setting causes much longer (re-)compilation.
		]")	end
	target_address_expression_name: STRING_32 do Result := locale.translation ("Address Expression")	end
	target_address_expression_description: STRING_32 do Result := locale.translation ("Are simplified address expressions enabled?")	end
	target_automatic_backup_name: STRING_32 do Result := locale.translation ("Automatic Backup")	end
	target_automatic_backup_description: STRING_32 do Result := locale.translation ("Automatically generate a backup during recompilation?")	end
	target_check_for_void_target_name: STRING_32 do Result := locale.translation ("Check for Void target")	end
	target_check_for_void_target_description: STRING_32 do Result := locale.translation ("Throw a call on Void target exception?")	end
	target_check_vape_name: STRING_32 do Result := locale.translation ("Check VAPE")	end
	target_check_vape_description: STRING_32 do Result := locale.translation ("Enforce VAPE validity constraint?")	end
	target_console_application_name: STRING_32 do Result := locale.translation ("Console Application")	end
	target_console_application_description: STRING_32 do Result := locale.translation ("Is the project a console application?")	end
	target_cls_compliant_name: STRING_32 do Result := locale.translation ("CLS Compliant")	end
	target_cls_compliant_description: STRING_32 do Result := locale.translation ("Should generated assemblies be marked as CLS compliant?")	end
	target_dead_code_removal_name: STRING_32 do Result := locale.translation ("Dead Code Removal")	end
	target_dead_code_removal_description: STRING_32 do Result := locale.translation ("Should unused code be removed?")	end
	target_dotnet_naming_convention_name: STRING_32 do Result := locale.translation (".NET Naming Convention")	end
	target_dotnet_naming_convention_description: STRING_32 do Result := locale.translation ("Should names follow the .NET naming convention?")	end
	target_dynamic_runtime_name: STRING_32 do Result := locale.translation ("Dynamic Runtime")	end
	target_dynamic_runtime_description: STRING_32 do Result := locale.translation ("Should the generated executable use a shared library of the runtime?")	end
	target_enforce_unique_class_names_name: STRING_32 do Result := locale.translation ("Enforce unique class names")	end
	target_enforce_unique_class_names_description: STRING_32 do Result := locale.translation ("Enforce all class names to be system wide unique?")	end
	target_exception_trace_name: STRING_32 do Result := locale.translation ("Exception Trace")	end
	target_exception_trace_description: STRING_32 do Result := locale.translation ("Should a complete exception trace be generated in the finalized version?")	end
	target_il_verifiable_name: STRING_32 do Result := locale.translation ("IL Verifiable")	end
	target_il_verifiable_description: STRING_32 do Result := locale.translation ("Should the generated binary be IL verifiable?")	end
	target_inlining_name: STRING_32 do Result := locale.translation ("Inlining")	end
	target_inlining_description: STRING_32 do Result := locale.translation ("Should inlining be enabled?")	end
	target_inlining_size_name: STRING_32 do Result := locale.translation ("Inlining Size")	end
	target_inlining_size_description: STRING_32 do Result := locale.translation ("Maximal number of instructions in a feature for the feature to be inlined.")	end
	target_line_generation_name: STRING_32 do Result := locale.translation ("Line Generation")	end
	target_line_generation_description: STRING_32 do Result := locale.translation ("Generate extra information for external debuggers?")	end
	target_metadata_cache_path_name: STRING_32 do Result := locale.translation ("Metadata Cache Path")	end
	target_metadata_cache_path_description: STRING_32 do Result := locale.translation ("Location where information about external assemblies is stored.")	end
	target_msil_classes_per_module_name: STRING_32 do Result := locale.translation ("Classes per Module")	end
	target_msil_classes_per_module_description: STRING_32 do Result := locale.translation ("Number of classes generated per .NET module during incremental compilation. Increasing this value will slow down the incremental recompilation, but speed up the time to load the assembly while debugging in workbench mode.")	end
	target_msil_clr_version_name: STRING_32 do Result := locale.translation (".NET Runtime Version")	end
	target_msil_clr_version_description: STRING_32 do Result := locale.translation ("Version of the .NET runtime to use.")	end
	target_msil_generation_type_name: STRING_32 do Result := locale.translation ("Generation Type")	end
	target_msil_generation_type_description: STRING_32 do Result := locale.translation ("Type of binary to generate.")	end
	target_msil_key_file_name_name: STRING_32 do Result := locale.translation ("Signing Key")	end
	target_msil_key_file_name_description: STRING_32 do Result := locale.translation ("Key to be able to add the generated binary to the Global Assembly Cache (GAC). %NChose a new, non existing filename to create a new key file.")	end
	target_msil_use_optimized_precompile_name: STRING_32 do Result := locale.translation ("Use Optimized Precompile")	end
	target_msil_use_optimized_precompile_description: STRING_32 do Result := locale.translation ("Use an optimized version of a precompile?")	end
	target_old_verbatim_strings_name: STRING_32 do Result := locale.translation ("Old Verbatim Strings")	end
	target_old_verbatim_strings_description: STRING_32 do Result := locale.translation ("Use the old format for verbatim strings?")	end
	target_platform_name: STRING_32 do Result := locale.translation ("Platform")	end
	target_platform_description: STRING_32 do Result := locale.translation ("Override the detected platform to use in conditions.")	end
	target_shared_library_definition_name: STRING_32 do Result := locale.translation ("Shared Library Definition")	end
	target_total_order_on_reals: STRING_32 do Result := locale.translation ("Total Order on REALs") end
	target_total_order_on_reals_description: STRING_32 do Result := locale.translation ("When enabled NaN values will be lower than any other real values, and comparing NaN with another NaN will yield True and not False as usually done in IEEE arithmetic.") end
	target_shared_library_definition_description: STRING_32 do Result := locale.translation ("Specify the file the compiler uses to generate the exported functions.")	end
	target_library_root_name: STRING_32 do Result := locale.translation ("Library Root")	end
	target_library_root_description: STRING_32 do Result := locale.translation ("Absolute path to use as base for relative paths.")	end
	target_use_cluster_name_as_namespace_name: STRING_32 do Result := locale.translation ("Use Cluster Name as Namespace")	end
	target_use_cluster_name_as_namespace_description: STRING_32 do Result := locale.translation ("Should cluster names be used as namespaces?")	end
	target_use_all_cluster_name_as_namespace_name: STRING_32 do Result := locale.translation ("Use Recursive Cluster Name as Namespace")	end
	target_use_all_cluster_name_as_namespace_description: STRING_32 do Result := locale.translation ("Should names of folders in recursive clusters be used as namespaces?")	end
	target_force_32bits_name: STRING_32 do Result := locale.translation ("Force 32bits")	end
	target_force_32bits_description: STRING_32 do Result := locale.translation ("Force compilation for 32bits?")	end

	target_edit_manually: STRING_32 do Result := locale.translation ("Manually Edit Configuration")	end

	external_location_name: STRING_32 do Result := locale.translation ("Location")	end
	external_location_description: STRING_32 do Result := locale.translation ("Location of the external.")	end
	external_value_name: STRING_32 do Result := locale.translation ("Value")	end
	external_value_description: STRING_32 do Result := locale.translation ("Value of the external.")	end
	external_description_name: STRING_32 do Result := locale.translation ("Description")	end
	external_description_description: STRING_32 do Result := locale.translation ("Description of the external.")	end
	external_condition_name: STRING_32 do Result := locale.translation ("Condition")	end
	external_condition_description: STRING_32 do Result := locale.translation ("Conditions for this external.")	end

	external_include: STRING_32 do Result := locale.translation ("Include")	end
	external_cflag: STRING_32 do Result := locale.translation ("C flag")	end
	external_object: STRING_32 do Result := locale.translation ("Object")	end
	external_library: STRING_32 do Result := locale.translation ("Library")	end
	external_resource: STRING_32 do Result := locale.translation ("Resource")	end
	external_linker_flag: STRING_32 do Result := locale.translation ("Linker flag") end
	external_make: STRING_32 do Result := locale.translation ("Makefile")	end

	external_include_tree: STRING_32 do Result := locale.translation ("Includes")	end
	external_cflag_tree: STRING_32 do Result := locale.translation ("C flags")	end
	external_object_tree: STRING_32 do Result := locale.translation ("Objects")	end
	external_library_tree: STRING_32 do Result := locale.translation ("Libraries")	end
	external_resource_tree: STRING_32 do Result := locale.translation ("Resources")	end
	external_linker_flag_tree: STRING_32 do Result := locale.translation ("Linker flags")	end
	external_make_tree: STRING_32 do Result := locale.translation ("Makefiles")	end

	external_add_include: STRING_32 do Result := locale.translation ("Add Include")	end
	external_add_cflag: STRING_32 do Result := locale.translation ("Add C flag")	end
	external_add_object: STRING_32 do Result := locale.translation ("Add Object")	end
	external_add_library: STRING_32 do Result := locale.translation ("Add Library")	end
	external_add_resource: STRING_32 do Result := locale.translation ("Add Resource")	end
	external_add_linker_flag: STRING_32 do Result := locale.translation ("Add linker flag")	end
	external_add_make: STRING_32 do Result := locale.translation ("Add Make")	end

	task_pre_tree: STRING_32 do Result := locale.translation ("Pre Compilation Tasks")	end
	task_post_tree: STRING_32 do Result := locale.translation ("Post Compilation Tasks")	end

	task_pre: STRING_32 do Result := locale.translation ("Pre Compilation")	end
	task_post: STRING_32 do Result := locale.translation ("Post Compilation")	end
	task_type_name: STRING_32 do Result := locale.translation ("Type")	end
	task_type_description: STRING_32 do Result := locale.translation ("Type of the task.")	end
	task_command_name: STRING_32 do Result := locale.translation ("Command")	end
	task_command_description: STRING_32 do Result := locale.translation ("Command to execute.")	end
	task_description_name: STRING_32 do Result := locale.translation ("Description")	end
	task_description_description: STRING_32 do Result := locale.translation ("Description of the task.")	end
	task_working_directory_name: STRING_32 do Result := locale.translation ("Working Directory")	end
	task_working_directory_description: STRING_32 do Result := locale.translation ("Directory where the command will be executed.")	end
	task_succeed_name: STRING_32 do Result := locale.translation ("Must succeed")	end
	task_succeed_description: STRING_32 do Result := locale.translation ("Does this task have to finish successful for the compilation to continue?")	end
	task_condition_name: STRING_32 do Result := locale.translation ("Condition")	end
	task_condition_description: STRING_32 do Result := locale.translation ("Conditions for this task to be executed.")	end
	task_add_pre: STRING_32 do Result := locale.translation ("Add Pre Compilation Task")	end
	task_add_post: STRING_32 do Result := locale.translation ("Add Post Compilation Task")	end

	group_cluster_tree: STRING_32 do Result := locale.translation ("Clusters")	end
	group_assembly_tree: STRING_32 do Result := locale.translation ("Assemblies")	end
	group_library_tree: STRING_32 do Result := locale.translation ("Libraries")	end
	group_precompile_tree: STRING_32 do Result := locale.translation ("Precompile")	end
	group_override_tree: STRING_32 do Result := locale.translation ("Overrides")	end

	group_cluster: STRING_32 do Result := locale.translation ("Cluster")	end
	group_assembly: STRING_32 do Result := locale.translation ("Assembly")	end
	group_library: STRING_32 do Result := locale.translation ("Library")	end
	group_precompile: STRING_32 do Result := locale.translation ("Precompile")	end
	group_override: STRING_32 do Result := locale.translation ("Override")	end

	group_type_name: STRING_32 do Result := locale.translation ("Type")	end
	group_type_description: STRING_32 do Result := locale.translation ("Type of the group.")	end
	group_name_name: STRING_32 do Result := locale.translation ("Name")	end
	group_name_description: STRING_32 do Result := locale.translation ("Name of the group.")	end
	group_description_name: STRING_32 do Result := locale.translation ("Description")	end
	group_description_description: STRING_32 do Result := locale.translation ("Description of the group.")	end
	group_condition_name: STRING_32 do Result := locale.translation ("Condition")	end
	group_condition_description: STRING_32 do Result := locale.translation ("Conditions for this group to be used.")	end
	group_readonly_name: STRING_32 do Result := locale.translation ("Read Only")	end
	group_readonly_description: STRING_32 do Result := locale.translation ("Is this group read only?")	end
	group_location_name: STRING_32 do Result := locale.translation ("Location")	end
	group_location_description: STRING_32 do Result := locale.translation ("Location of this group.")	end
	group_prefix_name: STRING_32 do Result := locale.translation ("Prefix")	end
	group_prefix_description: STRING_32 do Result := locale.translation ("Prefix which all classes in this group get.")	end
	group_renaming_name: STRING_32 do Result := locale.translation ("Renaming")	end
	group_renaming_description: STRING_32 do Result := locale.translation ("Renaming of classes in this group.")	end
	group_class_option_name: STRING_32 do Result := locale.translation ("Class Options")	end
	group_class_option_description: STRING_32 do Result := locale.translation ("Class specific options.")	end
	group_eifgens_location_name: STRING_32 do Result := locale.translation ("EIFGENs location")	end
	group_eifgens_location_description: STRING_32 do Result := locale.translation ("Directory where the EIFGENs folder is.")	end
	group_add_cluster: STRING_32 do Result := locale.translation ("Add Cluster")	end
	group_add_subcluster: STRING_32 do Result := locale.translation ("Add Sub cluster")	end
	group_add_override: STRING_32 do Result := locale.translation ("Add Override")	end
	group_add_assembly: STRING_32 do Result := locale.translation ("Add Assembly")	end
	group_add_library: STRING_32 do Result := locale.translation ("Add Library")	end
	group_add_precompile: STRING_32 do Result := locale.translation ("Add Precompile")	end

	library_edit_configuration: STRING_32 do Result := locale.translation ("Edit Library Configuration")	end
	library_use_application_options_name: STRING_32 do Result := locale.translation ("Use Application Options")	end
	library_use_application_options_description: STRING_32 do Result := locale.translation ("Should this library use options from the application instead of from the library?")	end

	cluster_recursive_name: STRING_32 do Result := locale.translation ("Recursive")	end
	cluster_recursive_description: STRING_32 do Result := locale.translation ("Are sub folders recursively included?")	end
	cluster_hidden_name: STRING_32 do Result := locale.translation ("Hidden")	end
	cluster_hidden_description: STRING_32 do Result := locale.translation ("Is this a hidden cluster that can not be used if the system is used as a library?")	end
	cluster_dependencies_name: STRING_32 do Result := locale.translation ("Dependencies")	end
	cluster_dependencies_description: STRING_32 do Result := locale.translation ("Groups this cluster depends on.")	end
	cluster_visible_name: STRING_32 do Result := locale.translation ("Visible Classes")	end
	cluster_visible_description: STRING_32 do Result := locale.translation ("Classes visible for external code.")	end
	cluster_mapping_name: STRING_32 do Result := locale.translation ("Type Mapping")	end
	cluster_mapping_description: STRING_32 do Result := locale.translation ("Special type mappings.")	end

	assembly_name_name: STRING_32 do Result := locale.translation ("Assembly Name")	end
	assembly_name_description: STRING_32 do Result := locale.translation ("Full name of the assembly as found in the GAC.")	end
	assembly_culture_name: STRING_32 do Result := locale.translation ("Assembly Culture")	end
	assembly_culture_description: STRING_32 do Result := locale.translation ("Culture of the assembly.")	end
	assembly_version_name: STRING_32 do Result := locale.translation ("Assembly Version")	end
	assembly_version_description: STRING_32 do Result := locale.translation ("Version of the assembly.")	end
	assembly_public_key_token_name: STRING_32 do Result := locale.translation ("Assembly Public Key Token")	end
	assembly_public_key_token_description: STRING_32 do Result := locale.translation ("Public key token that identifies the asssembly.")	end

	override_override_name: STRING_32 do Result := locale.translation ("Overriding")	end
	override_override_description: STRING_32 do Result := locale.translation ("Groups this override is overriding.")	end
	class_option_class_name: STRING_32 do Result := locale.translation ("Name")	end
	class_option_file_name: STRING_32 do Result := locale.translation ("Location")	end
	properties_class_name: STRING_32 do Result := locale.translation ("Class")	end
	properties_target_name: STRING_32 do Result := locale.translation ("Target")	end

feature -- Tab names

	tab_properties_name: READABLE_STRING_32 do Result := locale.translation_in_context ("Properties", "configuration") end
	tab_language_name: READABLE_STRING_32 do Result := locale.translation_in_context ("Language", "configuration") end

feature -- Capability names and descriptions

	capability_header_capable_of_name: READABLE_STRING_32 do Result := locale.translation_in_context ("Support", "configuration.capability") end
	capability_header_if_root_name: READABLE_STRING_32 do Result := locale.translation_in_context ("Use", "configuration.capability") end
	capability_toggle_default_name: READABLE_STRING_32 do REsult := locale.translation_in_context ("Default", "configuration.capability") end
	capability_toggle_inherited_name: READABLE_STRING_32 do REsult := locale.translation_in_context ("Inherited", "configuration.capability") end

feature -- Option names and descriptions

	option_require_name: STRING_32 do Result := locale.translation ("Require")	end
	option_require_description: STRING_32 do Result := locale.translation ("Evaluate precondition assertions?")	end
	option_ensure_name: STRING_32 do Result := locale.translation ("Ensure")	end
	option_ensure_description: STRING_32 do Result := locale.translation ("Evaluate postcondition assertions?")	end
	option_check_name: STRING_32 do Result := locale.translation_in_context ("Check", "configuration.parser")	end
	option_check_description: STRING_32 do Result := locale.translation ("Evaluate check assertions?")	end
	option_invariant_name: STRING_32 do Result := locale.translation ("Invariant")	end
	option_invariant_description: STRING_32 do Result := locale.translation ("Evaluate invariant assertions?")	end
	option_loop_name: STRING_32 do Result := locale.translation ("Loop")	end
	option_loop_description: STRING_32 do Result := locale.translation ("Evaluate loop assertions?")	end
	option_sup_require_name: STRING_32 do Result := locale.translation ("Supplier Precondition")	end
	option_sup_require_description: STRING_32 do Result := locale.translation ("Evaluate precondition assertions of suppliers?")	end

	option_profile_name: STRING_32 do Result := locale.translation ("Profile")	end
	option_profile_description: STRING_32 do Result := locale.translation ("Generate profiling information?")	end
	option_trace_name: STRING_32 do Result := locale.translation ("Trace")	end
	option_trace_description: STRING_32 do Result := locale.translation ("Display name of all called features during execution?")	end
	option_full_class_checking_name: STRING_32 do Result := locale.translation ("Full Class Checking")	end
	option_full_class_checking_description: STRING_32 do Result := locale.translation ("Are features of parent classes rechecked in current class?")	end

	option_msil_application_optimize_name: STRING_32 do Result := locale.translation ("Apply .NET Application Optimizations")	end
	option_msil_application_optimize_description: STRING_32 do Result := locale.translation ("Specifies if any applicable .NET application-oriented optimizations should be applied to a finalized compilation.")	end

	option_namespace_name: STRING_32 do Result := locale.translation (".NET Namespace")	end
	option_namespace_description: STRING_32 do Result := locale.translation ("Namespace for .NET")	end

	option_debug_name: STRING_32 do Result := locale.translation ("Enabled")	end
	option_debug_description: STRING_32 do Result := locale.translation ("Are debug clauses globally enabled?")	end
	option_unnamed_debug_name: STRING_32 do Result := locale.translation ("Unnamed Debugs")	end

	option_warnings_name: STRING_32 do Result := locale.translation ("Enabled")	end
	option_warnings_description: STRING_32 do Result := locale.translation ("Are warnings enabled?")	end

	option_catcall_detection_name: STRING_32 do Result := locale.translation ("Catcall detection") end
	option_catcall_detection_description: STRING_32 do Result := locale.translation ({STRING_32} "[
			Catcall detection level the source code provides:
			 • No - Catcall detection is disabled, frozen and variant annotations are not taken into account for conformance;
			 • Conformance - Catcall detection is disabled but frozen and variant annotations are respected in type conformance checks;
			 • Complete - Catcall detection is enabled and frozen and variant annotations are respected in type conformance checks.
			]") end
	option_catcall_detection_value: ARRAYED_LIST [STRING_32]
			-- Name of a catcall detection option value indexed by the corresponding option index.
		once
			create Result.make_from_array (<<
				locale.translation_in_context ("None", "configuration.catcall_detection"),
				locale.translation_in_context ("Conformance", "configuration.catcall_detection"),
				locale.translation_in_context ("Complete", "configuration.catcall_detection")
			>>)
		ensure
			valid_index:
				Result.valid_index ({CONF_OPTION}.catcall_detection_index_none) and
				Result.valid_index ({CONF_OPTION}.catcall_detection_index_conformance) and
				Result.valid_index ({CONF_OPTION}.catcall_detection_index_all)
		end

	option_concurrency_name: STRING_32 do Result := locale.translation_in_context ("Concurrency", "configuration") end
	option_concurrency_description: STRING_32 do Result := locale.translation_in_context ({STRING_32} "[
				Concurrency mode:
				 • Thread - unstructured multithreading based on EiffelThread library or built-in (in .NET);
				 • None - no concurrency, mono-threaded;
				 • SCOOP - controlled by SCOOP rules.
			]", "configuration") end
	option_concurrency_value: ARRAYED_LIST [STRING_32]
			-- Name of a catcall detection option value indexed by the corresponding option index.
		once
			create Result.make_from_array (<<
				locale.translation_in_context ("Thread", "configuration.concurrency"),
				locale.translation_in_context ("None", "configuration.concurrency"),
				locale.translation_in_context ("SCOOP", "configuration.concurrency")
			>>)
		ensure
			valid_index:
				Result.valid_index ({CONF_TARGET_OPTION}.concurrency_index_thread) and
				Result.valid_index ({CONF_TARGET_OPTION}.concurrency_index_none) and
				Result.valid_index ({CONF_TARGET_OPTION}.concurrency_index_scoop)
		end

	option_void_safety_name: STRING_32 do Result := locale.translation ("Void safety") end
	option_void_safety_description: STRING_32 once
			Result := locale.translation ("Void safety level the source code provides:%N") +
				{STRING_32} " • " + option_void_safety_value [{CONF_OPTION}.void_safety_index_none] + " - " + option_void_safety_value_description [{CONF_OPTION}.void_safety_index_none] + ";%N" +
				{STRING_32} " • " + option_void_safety_value [{CONF_OPTION}.void_safety_index_conformance] + " - " + option_void_safety_value_description [{CONF_OPTION}.void_safety_index_conformance] + ";%N" +
				{STRING_32} " • " + option_void_safety_value [{CONF_OPTION}.void_safety_index_initialization] + " - " + option_void_safety_value_description [{CONF_OPTION}.void_safety_index_initialization] + ";%N" +
				{STRING_32} " • " + option_void_safety_value [{CONF_OPTION}.void_safety_index_transitional] + " - " + option_void_safety_value_description [{CONF_OPTION}.void_safety_index_transitional] + ";%N" +
				{STRING_32} " • " + option_void_safety_value [{CONF_OPTION}.void_safety_index_all] + " - " + option_void_safety_value_description [{CONF_OPTION}.void_safety_index_all] + "."
		end
	option_void_safety_value: ARRAYED_LIST [STRING_32]
			-- Name of a void safety option value indexed by the corresponding option index.
		once
			create Result.make_from_array (<<
				locale.translation_in_context ("None", "configuration.void_safety"),
				locale.translation_in_context ("Conformance", "configuration.void_safety"),
				locale.translation_in_context ("Initialization", "configuration.void_safety"),
				locale.translation_in_context ("Transitional", "configuration.void_safety"),
				locale.translation_in_context ("Complete", "configuration.void_safety")
			>>)
		ensure
			valid_index:
				Result.valid_index ({CONF_OPTION}.void_safety_index_none) and
				Result.valid_index ({CONF_OPTION}.void_safety_index_conformance) and
				Result.valid_index ({CONF_OPTION}.void_safety_index_initialization) and
				Result.valid_index ({CONF_OPTION}.void_safety_index_transitional) and
				Result.valid_index ({CONF_OPTION}.void_safety_index_all)
		end
	option_void_safety_value_description: ARRAYED_LIST [STRING_32]
			-- Name of a void safety option value indexed by the corresponding option index.
		once
			create Result.make_from_array (<<
				locale.translation ("Void safety is not guaranteed"),
				locale.translation ("Attachment status is respected in type conformance checks"),
				locale.translation ("Entities of attached type are properly initialized"),
				locale.translation ("Void safety rules are satisfied except for initialization checks for unqualified agents and allowing CAPs for preconditions and check instructions"),
				locale.translation ("All void safety rules are satisfied")
			>>)
		ensure
			valid_index:
				Result.valid_index ({CONF_OPTION}.void_safety_index_none) and
				Result.valid_index ({CONF_OPTION}.void_safety_index_conformance) and
				Result.valid_index ({CONF_OPTION}.void_safety_index_initialization) and
				Result.valid_index ({CONF_OPTION}.void_safety_index_transitional) and
				Result.valid_index ({CONF_OPTION}.void_safety_index_all)
		end


	option_syntax_name: STRING_32 do Result := locale.translation ("Syntax") end
	option_syntax_description: STRING_32 do Result := locale.translation ({STRING_32} "[
			Variant of syntax used in source code:
			 • Obsolete syntax - Favor obsolete syntax over standard with more recent keywords treated as identifiers;
			 • Transitional syntax - Favor standard syntax, but allow obsolete syntax when determinable by context;
			 • Standard syntax - Enforce current standard syntax;
			 • Provisional syntax - Allow not-yet-approved constructs.
		]") end
	option_syntax_obsolete_name: STRING_32 do Result := locale.translation ("Obsolete syntax") end
	option_syntax_transitional_name: STRING_32 do Result := locale.translation ("Transitional syntax") end
	option_syntax_standard_name: STRING_32 do Result := locale.translation ("Standard syntax") end
	option_syntax_provisional_name: STRING_32 do Result := locale.translation ("Provisional syntax") end

	option_array_name: STRING_32 do Result := locale.translation_in_context ("Manifest array type", "configuration.option") end
	option_array_description: STRING_32 do Result := locale.translation_in_context ({STRING_32} "[
			Should computed manifest array type be compared against target type of reattachment?
			 • Mismatch error: Yes, report an error if the types are different;
			 • Mismatch warning: Yes, report a warning if the types are different;
			 • Standard: No.
		]", "configuration.option") end
	option_array_mismatch_error_name: STRING_32 do Result := locale.translation_in_context ("Mismatch error", "configuration.option") end
	option_array_mismatch_warning_name: STRING_32 do Result := locale.translation_in_context ("Mismatch warning", "configuration.option") end
	option_array_standard_name: STRING_32 do Result := locale.translation_in_context ("Standard", "configuration.option") end

	warning_names: STRING_TABLE [STRING_32]
			-- Warning names.
		once
			create Result.make (13)
			Result.force (locale.translation ("Unused Locals"), w_unused_local)
			Result.force (locale.translation ("Unused attribute body"), w_vwab)
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
			Result.force (locale.translation ("Missing manifest array type"), w_manifest_array_type)
		end

	warning_descriptions: STRING_TABLE [STRING_32]
			-- Warning descriptions.
		once
			create Result.make (13)
			Result.force (locale.translation ("Warn about locals that are not used?"), w_unused_local)
			Result.force (locale.translation ("Warn about attribute bodies that are never executed?"), w_vwab)
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
			Result.force (locale.translation ("Warn about missing manifest array type?"), w_manifest_array_type)
		end

feature -- Misc

	general_add: STRING_32 do Result := locale.translation ("Add")	end
	general_close: STRING_32 do Result := locale.translation ("Close")	end
	general_remove: STRING_32 do Result := locale.translation ("Remove")	end
	variables_name: STRING_32 do Result := locale.translation ("Name")	end
	variables_value: STRING_32 do Result := locale.translation ("Value")	end
	mapping_old_name: STRING_32 do Result := locale.translation ("Old Name")	end
	mapping_new_name: STRING_32 do Result := locale.translation ("New Name")	end
	remove_target (a_target: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove $1?"), [a_target])
		end
	remove_remote_target (a_target, a_location: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove (remote) parent $1 ($2)?"), [a_target, a_location])
		end

	target_remove_group (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove $1 and any children of it?"), [a_group])
		end
	target_remove_library (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove the reference to $1?"), [a_group])
		end
	target_remove_external (a_external: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove $1?"), [a_external])
		end
	target_remove_task (a_task: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Are you sure you want to remove $1?"), [a_task])
		end

feature -- Condition dialog

	dial_cond_platforms: STRING_32 do Result := locale.translation ("Platforms")	end
	dial_cond_platforms_exclude: STRING_32 do Result := locale.translation ("Exclude platform(s)")	end
	dial_cond_other: STRING_32 do Result := locale.translation ("Other")	end
	dial_cond_build: STRING_32 do Result := locale.translation ("Build")	end
	dial_cond_dotnet: STRING_32 do Result := locale.translation (".NET")	end
	dial_cond_concurrency: STRING_32 do Result := locale.translation ("Concurrency")	end
	dial_cond_concurrency_exclude: STRING_32 do Result := locale.translation ("Exclude value(s)")	end
	dial_cond_concurrency_value (value: READABLE_STRING_GENERAL): STRING_32 do Result := locale.translation (value)	end
	dial_cond_void_safety: STRING_32 do Result := locale.translation ("Void safety")	end
	dial_cond_void_safety_exclude: STRING_32 do Result := locale.translation ("Exclude value(s)")	end
	dial_cond_void_safety_value (value: READABLE_STRING_GENERAL): STRING_32 do Result := locale.translation (value)	end

	dial_cond_dynamic_runtime: STRING_32 do Result := locale.translation ("Dynamic runtime")	end
	dial_cond_version: STRING_32 do Result := locale.translation ("Version")	end
	dial_cond_version_compiler: STRING_32 do Result := locale.translation ("<= compiler version <= ")	end
	dial_cond_version_clr: STRING_32 do Result := locale.translation ("<= MSIL CLR version <= ")	end
	dial_cond_custom: STRING_32 do Result := locale.translation ("Custom (Intersection)")	end
	dial_cond_new_custom: STRING_32 do Result := locale.translation ("new")	end
	dial_cond_new_custom_value: STRING_32 do Result := locale.translation ("new_value")	end
	dial_cond_custom_variable: STRING_32 do Result := locale.translation ("Variable")	end
	dial_cond_custom_value: STRING_32 do Result := locale.translation ("Value")	end
	dial_cond_add_and_term: STRING_32 do Result := locale.translation ("Add and-term")	end
	dial_cond_remove_and_term: STRING_32 do Result := locale.translation ("Remove and-term")	end
	dial_cond_and_term_1: STRING_32 do Result := locale.translation ("And-term 1")	end
	dial_cond_and_term_x (a_number: INTEGER): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("or And-term $1"), [a_number.out])
		end

feature -- File rule dialog

	dialog_file_rule_excludes: STRING_32 do Result := locale.translation ("Excludes:")	end
	dialog_file_rule_includes: STRING_32 do Result := locale.translation ("Includes:")	end
	dialog_file_rule_description: STRING_32 do Result := locale.translation ("Description:")	end
	dialog_file_rule_condition: STRING_32 do Result := locale.translation ("Condition:")	end
	dialog_file_rule_edit_condition: STRING_32 do Result := locale.translation ("Edit condition")	end
	dialog_file_rule_add_rule: STRING_32 do Result := locale.translation ("Add rule")	end
	dialog_file_rule_remove_rule: STRING_32 do Result := locale.translation ("Remove rule")	end
	dialog_file_rule_file_rule_x (a_number: INTEGER): READABLE_STRING_GENERAL
		do
			Result := locale.formatted_string (locale.translation ("File rule $1"), [a_number.out])
		end

feature -- Visible dialog

	dialog_visible_name: STRING_32 do Result := locale.translation ("Name: ")	end
	dialog_visible_renamed_name: STRING_32 do Result := locale.translation ("Renamed name: ")	end
	dialog_visible_add_class: STRING_32 do Result := locale.translation ("Add class")	end
	dialog_visible_add_feature: STRING_32 do Result := locale.translation ("Add feature")	end
	dialog_visible_remove: STRING_32 do Result := locale.translation ("Remove")	end

feature -- Renaming dialog

	dialog_renaming_old_name: STRING_32 do Result := locale.translation ("Old name")	end
	dialog_renaming_new_name: STRING_32 do Result := locale.translation ("New name")	end
	dialog_renaming_create_old: STRING_32 do Result := locale.translation ("OLD_NAME")	end
	dialog_renaming_create_new: STRING_32 do Result := locale.translation ("NEW_NAME")	end

feature -- Create task dialog

	dialog_task_add: STRING_32 do Result := locale.translation ("Add new task")	end

feature -- Create external dialog

	dialog_external_add: STRING_32 do Result := locale.translation ("Add new external")	end

feature -- Create remote target dialog

	dialog_create_remote_target_title: STRING_32 do Result := locale.translation ("Add Remote Target")	end
	dialog_create_remote_target_name: STRING_32 do Result := locale.translation ("Target Name") end
	dialog_create_remote_target_location: STRING_32 do Result := locale.translation ("Location") end

feature -- Create library dialog

	dialog_create_library_title: STRING_32 do Result := locale.translation ("Add Library")	end
	dialog_create_library_defaults: STRING_32 do Result := locale.translation ("Default libraries")	end
	dialog_create_library_name: STRING_32 do Result := locale.translation ("Name")	end
	dialog_create_library_void_safety: STRING_32 do Result := locale.translation ("Void safety")	end
	dialog_create_library_information: STRING_32 do Result := locale.translation ("Information")	end
	dialog_create_library_status: STRING_32 do Result := locale.translation ("Status")	end
	dialog_create_library_location: STRING_32 do Result := locale.translation ("Location")	end
	dialog_create_library_custom_location: STRING_32 do Result := locale.translation ("Custom")	end

	dialog_search_library_iron_package_manage_button_label: STRING_32 do Result := locale.translation ("Packages") end
	dialog_search_library_iron_package_manage_button_tooltip: STRING_32 do Result := locale.translation ("Manage IRON packages with the associated IRON tool") end

	dialog_search_library_in: STRING_32 do Result := locale.translation ("Search in")	end
	dialog_search_library_in_tooltip: STRING_32 do Result := locale.translation ("Search library using criteria on metadata (name, description, tags, ...)")	end
	dialog_search_library_by_class: STRING_32 do Result := locale.translation ("Search class")	end
	dialog_search_library_by_class_tooltip: STRING_32 do Result := locale.translation ("Search library by class name (wildchar supported).")	end

	dialog_search_classes: STRING_32 do Result := locale.translation ("Classes")	end
	dialog_search_found_n_classes (nb: INTEGER): STRING_32 do
			Result := locale.formatted_string (locale.plural_translation ("found one class", "found $1 classes", nb), [nb])
		end

	dialog_create_libraries: STRING_32 do Result := locale.translation ("Libraries")	end
	dialog_create_iron_packages: STRING_32 do Result := locale.translation ("IRON packages")	end
	dialog_create_back_to_previous_tab: STRING_32 do Result := locale.translation ("Back to libraries")	end
	dialog_create_refresh: STRING_32 do Result := locale.translation ("Refresh")	end
	dialog_create_refresh_tooltip: STRING_32 do Result := locale.translation ("Refresh list of libraries.")	end
	dialog_display_configuration_tooltip: STRING_32 do Result := locale.translation ("Display locations of configuration files used for libraries lookup.")	end

	dialog_create_searching_please_wait_message: STRING_32 do Result := locale.translation ("Building list of available libraries...")	end

	dialog_display_configuration_title: STRING_32 do Result := locale.translation ("Locations of configuration files") end

	dialog_display_configuration_text (a_lib_cfg: READABLE_STRING_GENERAL; a_user_lib_cfg: detachable READABLE_STRING_GENERAL; a_pre_cfg: READABLE_STRING_GENERAL; a_user_pre_cfg: detachable READABLE_STRING_GENERAL; is_user_files_supported: BOOLEAN): STRING_32
		do
			if is_user_files_supported and a_user_lib_cfg /= Void and a_user_pre_cfg /= Void then
				Result := locale.formatted_string (locale.translation ("[
Search paths for libraries are specified in the configuration file:
   $1
and could be overridden by user configuration file:
   $2

Search paths for precompiled libraries are specified in the configuration file:
   $3
and could be overridden by user configuration file:
   $4
						]"),
						[a_lib_cfg, a_user_lib_cfg, a_pre_cfg, a_user_pre_cfg]
					)
			else
				Result := locale.formatted_string (locale.translation ("[
Search paths for library ECFs are specified in the configuration file:
	$1

Search paths for precompile ECFs are specified in the configuration file:
	$2

						]"),
						[a_lib_cfg, a_pre_cfg]
					)
			end
		end

feature -- Iron packages box		

	iron_box_package_status_label: STRING_32 do Result := locale.translation ("Package Status") end

	iron_box_package_waiting_for_data_message: STRING_32 do Result := locale.translation ("Waiting for data ...") end

	iron_box_packages_label: STRING_32 do Result := locale.translation ("Packages") end

	iron_box_repositories_label: STRING_32 do Result := locale.translation ("Repositories") end

	iron_box_package_label: STRING_32 do Result := locale.translation ("Package") end

	iron_box_installation_label: STRING_32 do Result := locale.translation ("Installation") end

	iron_box_location_label: STRING_32 do Result := locale.translation ("Location") end

	iron_box_information_label: STRING_32 do Result := locale.translation ("Information") end

	iron_box_install_label: STRING_32 do Result := locale.translation ("Install") end

	iron_box_remove_label: STRING_32 do Result := locale.translation ("Remove") end

	iron_box_update_label: STRING_32 do Result := locale.translation ("Update") end

	iron_box_tags_label: STRING_32 do Result := locale.translation ("Tags") end

	iron_box_package_installed_label: STRING_32 do Result := locale.translation ("Is installed") end
	iron_box_package_not_yet_installed_label: STRING_32 do Result := locale.translation ("Not yet installed") end

	iron_box_missing_package_error_message: STRING_32 do Result := locale.translation ("Error: missing package.") end

	iron_box_package_installed_message (a_folder: PATH; a_projects: LIST [PATH]): STRING_32
		local
			s: STRING_32
		do
			create s.make_empty
			across
				a_projects as ic
			loop
				s.append_character (' ')
				s.append_character ('-')
				s.append_character (' ')
				s.append (a_folder.extended_path (ic).name)
				s.append_character ('%N')
			end
			Result := locale.formatted_string (locale.translation ("[
					Installed in folder "$1" .
					$2 associated ecf files:
					$3
				]"), [a_folder, a_projects.count, s])
		end

	iron_box_install_package_help (a_package_id: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("[
					To install:
					- use the graphical tool
					- or command: "iron install $1"
				]"), [a_package_id])
		end

	iron_box_install_conflicting_package_help (a_package_id: READABLE_STRING_GENERAL; a_package_location: READABLE_STRING_GENERAL; a_conflict_id: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("[
					WARNING: package "$2" is conflicting with package "$3".
					
					Both have the same identifier "$1", but package "$3" has priority over "$2".
					
					If only one is installed, iron reference "iron:$1:....ecf" in .ecf files will use the installed package.
					If both are installed, .ecf file should reference the package using the absolute location="$1" .
				]"), [a_package_id, a_package_location, a_conflict_id])
		end

	iron_box_conflicting_with_package_message (a_location: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("conflicting with $1"), [a_location])
		end

	iron_box_double_click_to_install_package_message (a_location: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("double-click to install $1"), [a_location])
		end

	iron_box_how_to_install_selected_package_message: STRING_32
		do
			Result := locale.translation ("To install: select and click button [Install].")
		end

	iron_box_package_installation_title (a_package_id: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Installation of package: $1"), [a_package_id])
		end

	iron_box_package_uninstallation_title (a_package_id: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Removal of package: $1"), [a_package_id])
		end

	iron_box_updating_title: STRING_32
		do
			Result := locale.translation ("Updating IRON")
		end

feature -- Create precompile dialog

	dialog_create_precompile_title: STRING_32 do Result := locale.translation ("Add Precompile")	end
	dialog_create_precompile_defaults: STRING_32 do Result := locale.translation ("Default precompiles")	end
	dialog_create_precompile_name: STRING_32 do Result := locale.translation ("Name")	end
	dialog_create_precompile_location: STRING_32 do Result := locale.translation ("Location")	end

feature -- Create assembly dialog

	dialog_create_assembly_found: STRING_32 do Result := locale.translation ("Assemblies")	end
	dialog_create_assembly_title: STRING_32 do Result := locale.translation ("Add Assembly")	end
	dialog_create_assembly_name: STRING_32 do Result := locale.translation ("Name")	end
	dialog_create_assembly_location: STRING_32 do Result := locale.translation ("Location")	end
	dialog_create_assembly_a_name: STRING_32 do Result := locale.translation ("Assembly Name")	end
	dialog_create_assembly_a_version: STRING_32 do Result := locale.translation ("Assembly Version")	end
	dialog_create_assembly_a_culture: STRING_32 do Result := locale.translation ("Assembly Culture")	end
	dialog_create_assembly_a_key: STRING_32 do Result := locale.translation ("Assembly Key")	end

feature -- Create cluster dialog

	dialog_create_cluster_title: STRING_32 do Result := locale.translation ("Add Cluster")	end
	dialog_create_cluster_name: STRING_32 do Result := locale.translation ("Name")	end
	dialog_create_cluster_location: STRING_32 do Result := locale.translation ("Location")	end

feature -- Create override dialog

	dialog_create_override_title: STRING_32 do Result := locale.translation ("Add Override Cluster")	end

feature -- Class option dialog

	dialog_class_option_class_name: STRING_32 do Result := locale.translation ("Class name")	end

	remove_group_text: STRING_32 do Result := locale.translation ("Remove group")	end

feature -- Validation warnings

	version_valid_format: STRING_32 do Result := locale.translation ("Version is not valid. It has to be in the form XXX.XXX.XXX.XXX") end
	version_min_max: STRING_32 do Result := locale.translation ("Minimum version cannot be greater than maximum version.") end
	library_target_override: STRING_32 do Result := locale.translation ("Library target cannot be used because it contains overrides which is forbidden.") end
	target_add_duplicate: STRING_32 do Result := locale.translation ("Cannot add target because there is already a target with the same name.") end
	target_remove_library_target: STRING_32 do Result := locale.translation ("Target cannot be removed because it is the library target.") end
	target_remove_last: STRING_32 do Result := locale.translation ("Target cannot be removed because it is the last target.") end
	target_remove_impossible: STRING_32 do Result := locale.translation ("Target cannot be removed.") end
	target_remove_extends (other_target: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Target cannot be removed because $1 extends it."), [other_target])
		end

	target_name_invalid: STRING_32 do Result := locale.translation ("Cannot rename target because the name is invalid.") end
	target_name_duplicate: STRING_32 do Result := locale.translation ("Cannot rename target because there is already a target with the new name.") end
	target_name_empty: STRING_32 do Result := locale.translation ("Cannot rename target because the name is empty.") end
	group_name_invalid: STRING_32 do Result := locale.translation ("Cannot rename group because the name is not valid.") end
	group_name_duplicate: STRING_32 do Result := locale.translation ("Cannot rename group because there is already a target with the new name.") end
	group_name_empty: STRING_32 do Result := locale.translation ("Cannot rename group because the name is empty.") end
	root_no_class: STRING_32 do Result := locale.translation ("Cannot specify root cluster or root procedure without a root class. Use all classes, specify a root class or specify nothing.") end
	root_none: STRING_32 do Result := locale.translation ("Root class has to be specified if the target is not extended by another target.") end
	root_invalid_cluster: STRING_32 do Result := locale.translation ("Root cluster name is invalid.") end
	root_invalid_class: STRING_32 do Result := locale.translation ("Root class name is invalid.") end
	root_invalid_feature: STRING_32 do Result := locale.translation ("Root procedure name is invalid.") end
	cluster_dependency_group_not_exist: STRING_32 do Result := locale.translation ("Cannot add dependency. There is no group with this name.") end
	override_group_not_exist: STRING_32 do Result := locale.translation ("Cannot add override. There is no group with this name.") end
	invalid_target_name: STRING_32 do Result := locale.translation ("The name of the target is invalid.") end
	invalid_assembly_name: STRING_32 do Result := locale.translation ("The name of the assembly is invalid.") end
	invalid_cluster_name: STRING_32 do Result := locale.translation ("The name of the cluster is invalid.") end
	invalid_library_name: STRING_32 do Result := locale.translation ("The name of the library is invalid.") end
	invalid_override_name: STRING_32 do Result := locale.translation ("The name of the override is invalid.") end
	invalid_precompile_name: STRING_32 do Result := locale.translation ("The name of the precompile is invalid.") end

	group_already_exists (a_group: READABLE_STRING_GENERAL): STRING_32
		require
			a_group_not_void: a_group /= Void
		do
			Result := locale.formatted_string (locale.translation ("There is already a group with name %"$1%"."), [a_group])
		end
	file_is_not_a_library: STRING_32 do Result := locale.translation ("The selected configuration file is not a library.%NPlease make sure the library is a valid Eiffel Configuration File and is has a library target.") end
	add_non_void_safe_library: STRING_32 do Result := locale.translation ("The selected library is not Void-Safe-compatible with the current target. Do you still want to utilize it?%N%NNote: Using non-Void-Safe-compatible libraries in a void-safe system can cause library incompatibilities.") end

	assembly_no_location: STRING_32 do Result := locale.translation ("No location specified.") end

feature -- Parse errors

	e_internal_parse_error: STRING_32 do Result := locale.translation ("Cannot parse configuration file. Unknown internal error.") end

	e_parse_invalid_tag (a_tag: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid tag/tag position '$1'"), [a_tag])
		end
	e_parse_invalid_value (an_attribute: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid or empty value for '$1'"), [an_attribute])
		end
	e_parse_invalid_attribute (an_attribute: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid attribute '$1'"), [an_attribute])
		end
	e_parse_unsupported_attribute (an_attribute: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Attribute '$1' is no longer supported for this element."), [an_attribute])
		end
	e_parse_missing_attribute (an_attribute: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Missing attribute '$1'"), [an_attribute])
		end
	e_parse_invalid_content (a_content: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid content: $1"), [a_content])
		end

	e_parse_incorrect_system_no_name: STRING_32 do Result := locale.translation ("Incorrect system tag, no name specified.") end
	e_parse_incorrect_system_name (a_system: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid system name $1."), [a_system])
		end

	e_parse_incorrect_system_invalid_uuid (a_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Incorrect system tag $1 invalid UUID specified."), [a_name])
		end

	e_parse_multiple_target_with_name (a_target: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Multiple targets with name $1."), [a_target])
		end

	e_parse_incorrect_target_parent (a_parent, a_target: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Missing parent target: $1 in target $2"), [a_parent, a_target])
		end
	e_parse_incorrect_remote_target_parent (a_parent: detachable READABLE_STRING_GENERAL; a_target: READABLE_STRING_GENERAL; a_location: READABLE_STRING_GENERAL): STRING_32
		do
			if a_parent = Void then
				Result := locale.formatted_string (locale.translation ("Missing remote parent target: no library target from $1 in target $2"), [a_location, a_target])
			else
				Result := locale.formatted_string (locale.translation ("Missing remote parent target: $1 from $2 in target $3"), [a_parent, a_location, a_target])
			end
		end
	e_parse_incorrect_target_no_name: STRING_32 do Result := locale.translation ("Target without a name specified.") end
	e_parse_incorrect_target_invalid_name (a_target: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid target name $1."), [a_target])
		end

	e_parse_incorrect_root_all: STRING_32 do Result := locale.translation ("Invalid value for all_classes attribute in root tag.") end
	e_parse_incorrect_root: STRING_32 do Result := locale.translation ("Invalid root tag.") end
	e_parse_incorrect_root_cluster: STRING_32 do Result := locale.translation ("Invalid root cluster.") end
	e_parse_incorrect_root_class: STRING_32 do Result := locale.translation ("Invalid root class.") end
	e_parse_incorrect_root_feature: STRING_32 do Result := locale.translation ("Invalid root procedure.") end

	e_parse_incorrect_setting_no_name: STRING_32 do Result := locale.translation ("Invalid setting tag, no name specified.") end
	e_parse_incorrect_setting (a_setting: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid setting tag $1."), [a_setting])
		end
	e_parse_incorrect_setting_value	(a_setting: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid value for setting $1."), [a_setting])
		end

	e_parse_incorrect_file_rule: STRING_32 do Result := locale.translation ("Invalid file_rule tag.") end

	e_parse_incorrect_external: STRING_32 do Result := locale.translation ("Invalid external tag.") end

	e_parse_incorrect_action_invalid (an_action: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid action tag $1."), [an_action])
		end
	e_parse_incorrect_action_succeed (an_action: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Non boolean value for succeed attribute of action $1."), [an_action])
		end
	e_parse_incorrect_action_no_command: STRING_32
		do
			Result := locale.translation ("Invalid action tag.")
		end

	e_parse_incorrect_variable_no_name: STRING_32 do Result := locale.translation ("Invalid variable tag.") end
	e_parse_incorrect_variable (a_variable: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid variable tag $1."), [a_variable])
		end

	e_parse_incorrect_library_no_name: STRING_32 do Result := locale.translation ("Invalid library tag.") end
	e_parse_incorrect_library_name (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid library name $1."), [a_group])
		end
	e_parse_incorrect_library (a_library: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid library tag $1."), [a_library])
		end
	e_parse_incorrect_library_conflict (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid library tag there is already a group with the name $1."), [a_group])
		end

	e_parse_incorrect_precompile_no_name: STRING_32 do Result := locale.translation ("Invalid precompile tag.") end
	e_parse_incorrect_precompile_name (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid precompile name $1."), [a_group])
		end
	e_parse_incorrect_precompile (a_precompile: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid precompile tag $1."), [a_precompile])
		end
	e_parse_incorrect_precompile_conflict (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid precompile tag there is already a group with the name $1."), [a_group])
		end
	e_parse_incorrect_precompile_multiple (a_precompile, an_other_precompile: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid precompile tag $1, there is already another precompile specified $2."), [a_precompile, an_other_precompile])
		end

	e_parse_incorrect_assembly_no_name: STRING_32 do Result := locale.translation ("Invalid assembly tag no name specified.") end
	e_parse_incorrect_assembly_name (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid assembly name $1."), [a_group])
		end
	e_parse_incorrect_assembly (an_assembly: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid assembly tag $1 no location specified."), [an_assembly])
		end
	e_parse_incorrect_assembly_conflict (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid assembly tag there is already a group with the name $1."), [a_group])
		end

	e_parse_incorrect_cluster_no_name: STRING_32 do Result := locale.translation ("Invalid cluster tag no name specified.") end
	e_parse_incorrect_cluster_name (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid cluster name $1."), [a_group])
		end
	e_parse_incorrect_cluster (a_cluster: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid cluster tag $1 no location specified."), [a_cluster])
		end
	e_parse_incorrect_cluster_conflict (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid cluster tag there is already a group with the name $1."), [a_group])
		end

	e_parse_incorrect_override_no_name: STRING_32 do Result := locale.translation ("Invalid override tag no name specified.") end
	e_parse_incorrect_override_name (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid override name $1."), [a_group])
		end
	e_parse_incorrect_override (an_override: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid override tag $1 no location specified."), [an_override])
		end
	e_parse_incorrect_override_conflict (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid override tag there is already a group with the name $1."), [a_group])
		end

	e_parse_incorrect_debug_no_name: STRING_32 do Result := locale.translation ("Invalid debug tag.") end
	e_parse_incorrect_debug (a_debug: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid debug tag $1."), [a_debug])
		end

	e_parse_incorrect_warning_no_name: STRING_32 do Result := locale.translation ("Invalid warning tag.") end
	e_parse_incorrect_warning (a_warning: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid warning tag $1."), [a_warning])
		end

	e_parse_incorrect_renaming_no_name: STRING_32 do Result := locale.translation ("Invalid renaming tag.") end
	e_parse_incorrect_renaming_no_new (an_old: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid renaming tag, no new name specified for $1."), [an_old])
		end
	e_parse_incorrect_renaming_no_old (a_new: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid renaming tag, no old name specified for $1."), [a_new])
		end

	e_parse_incorrect_class_opt: STRING_32 do Result := locale.translation ("Invalid class_option tag.") end

	e_parse_incorrect_option_override (option_name: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
		do
			Result := locale.formatted_string (locale.translation ("[
				Library option "$1" cannot be overridden outside the library.
			]"), [option_name])
		end

	e_parse_incorrect_visible (a_parent: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid visible tag on $1."), [a_parent])
		end
	e_parse_incorrect_visible_feature (a_feature: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Incorrect feature name $1 in visible clause ."), [a_feature])
		end
	e_parse_incorrect_visible_class (a_class: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Incorrect class name $1 in visible clause ."), [a_class])
		end

	e_parse_incorrect_uses (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid uses tag in group $1."), [a_group])
		end

	e_parse_incorrect_overrides (a_group: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid overrides tag in group $1."), [a_group])
		end

	e_parse_incorrect_condition: STRING_32 do Result := locale.translation ("Invalid condition tag.") end

	e_parse_incorrect_platform_mult: STRING_32 do Result := locale.translation ("Cannot have multiple platform specifications in one condition.") end
	e_parse_incorrect_platform_conflict: STRING_32 do Result := locale.translation ("Value and exclude attribute in platform condition cannot appear at the same time.") end
	e_parse_incorrect_platform_none: STRING_32 do Result := locale.translation ("No value or excluded-value specified in platform condition.") end
	e_parse_incorrect_platform (a_platform: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid platform $1."), [a_platform])
		end

	e_parse_incorrect_build_mult: STRING_32 do Result := locale.translation ("Cannot have multiple build specifications in one condition.") end
	e_parse_incorrect_build_conflict: STRING_32 do Result := locale.translation ("Value and exclude attribute in build condition cannot appear at the same time.") end
	e_parse_incorrect_build_none: STRING_32 do Result := locale.translation ("No value or excluded-value specified in build condition.") end
	e_parse_incorrect_build (a_build: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid build $1."), [a_build])
		end

	e_parse_incorrect_multithreaded : STRING_32 do Result := locale.translation ("No valid value specified in multithreaded condition.") end
	e_parse_incorrect_concurrency (a_concurrency: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid concurrency condition $1."), [a_concurrency])
		end
	e_parse_incorrect_void_safety (a_void_safety: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid void_safety condition $1."), [a_void_safety])
		end
	e_parse_incorrect_dotnet: STRING_32 do Result := locale.translation ("No valid value specified in .NET condition.") end
	e_parse_incorrect_dynamic_runtime: STRING_32 do Result := locale.translation ("No valid value specified in dynamic runtime condition.") end

	e_parse_incorrect_version_min (a_version: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid minimum version number in version condition: "), [a_version])
		end
	e_parse_incorrect_version_max (a_version: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid maximum version number in version condition: "), [a_version])
		end
	e_parse_incorrect_version_no_type: STRING_32 do Result := locale.translation ("No version type specified in version condition.") end
	e_parse_incorrect_version_no_version (a_version: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("No minimum or maximum version in version condition $1 specified."), [a_version])
		end
	e_parse_incorrect_version_type (a_type: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Invalid version type $1 in version condition."), [a_type])
		end
	e_parse_incorrect_version_min_max (a_type: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Minimum version cannot be greater than maximum version in version condition $1."), [a_type])
		end

	e_parse_incorrect_custom_no_name: STRING_32 do Result := locale.translation ("No name attribute in custom condition.") end
	e_parse_incorrect_custom_none (a_custom: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("No value or excluded-value specified in custom condition $1."), [a_custom])
		end
	e_parse_incorrect_custom_conflict (a_custom: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Value and exclude attribute in custom condition $1 cannot appear at the same time."), [a_custom])
		end

	e_parse_incorrect_mapping: STRING_32 do Result := locale.translation ("Invalid mapping tag.") end

	e_parse_incorrect_description: STRING_32 do Result := locale.translation ("Invalid description tag.") end

	e_parse_more_than_one_note (a_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Multiple note elements under $1."), [a_name])
		end

	e_parse_external_outside_target_element: STRING_32 do Result := locale.translation ("External element found outside a target element.") end

	e_parse_invalid_regexp (regexp: READABLE_STRING_GENERAL; file, description: detachable READABLE_STRING_GENERAL; position: INTEGER): STRING_32
		do
			if attached file and attached description then
				if position = 0 then
					Result := locale.formatted_string (locale.translation ("Invalid regular expression %"$1%" in %"$2%": $3."), [regexp, file, description])
				else
					Result := locale.formatted_string (locale.translation ("Invalid regular expression %"$1%" (error position: $4) in %"$2%": $3."), [regexp, file, description, position])
				end
			elseif attached file then
				Result := locale.formatted_string (locale.translation ("Invalid regular expression %"$1%" in %"$2%"."), [regexp, file])
			elseif attached description then
				if position = 0 then
					Result := locale.formatted_string (locale.translation ("Invalid regular expression %"$1%": $2."), [regexp, description])
				else
					Result := locale.formatted_string (locale.translation ("Invalid regular expression %"$1%" (error position: $3): $2."), [regexp, description, position])
				end
			else
				Result := locale.formatted_string (locale.translation ("Invalid regular expression: %"$1%"."), [regexp])
			end
		end

feature -- String parse errors

	e_parse_string_missing_name (option: READABLE_STRING_GENERAL): READABLE_STRING_32
			-- An error for a missing setting name.
		do
			Result := locale.formatted_string (locale.translation ("Missing name in the setting %"$1%""), [option])
		end

	e_parse_string_missing_value (option: READABLE_STRING_GENERAL): READABLE_STRING_32
			-- An error for a missing setting value.
		do
			Result := locale.formatted_string (locale.translation ("Missing value in the setting %"$1%""), [option])
		end

	e_parse_string_unknown_name (option_name: READABLE_STRING_GENERAL; known_names: ITERABLE [READABLE_STRING_GENERAL]): READABLE_STRING_32
			-- An error for an unknown setting name.
		local
			d: STRING_32
			s: STRING_32
		do
			create s.make_empty
			d := s
			across
				known_names as ic
			loop
				s.append (d)
				d := once {STRING_32} ", "
				s.append_string_general (ic)
			end
			Result := locale.formatted_string (locale.translation ("Unknown setting %"$1%" (Available settings: $2)"), [option_name, s])
		end

	e_parse_string_invalid_value (option_name, option_value: READABLE_STRING_GENERAL;
		expected_values: ITERABLE [READABLE_STRING_GENERAL]): READABLE_STRING_32
			-- An error for an invalid option value `option_value' of an option `option_name'.
		local
			d: STRING_32
			e: STRING_32
		do
			create e.make_empty
			d := e
			across
				expected_values as c
			loop
				e.append (d)
				d := once {STRING_32} ", "
				e.append_string_general (c)
			end
			Result := locale.formatted_string (locale.translation ("Invalid value for setting %"$1%": %"$2%" (Expected values: $3)"), [option_name, option_value, e])
		end

feature -- Capability errors

	e_incompatible_class_capability (capability, class_value, class_name, cluster_value, cluster_name, target, system, file: READABLE_STRING_GENERAL): READABLE_STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context
				("[
					Class option "$1" has value "$2" insufficient for its cluster value "$4".
						Class: $3
						Cluster: $5
						Target: $6
						System: $7
						File: $8
				]", "configuration"),
				capability, -- 1
				class_value, -- 2
				class_name, -- 3
				cluster_value, -- 4
				cluster_name, -- 5
				target, -- 6
				system, --7
				file) -- 8
		end

	e_incompatible_group_capability (capability, group_value, group_name, target_value, target_name, target_system, target_file: READABLE_STRING_GENERAL): READABLE_STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context
				("[
					Group option "$1" has value "$2" insufficient for value "$4" of the target containing this group.
						Group: $3
						Target: $5
						System: $6
						File: $7
				]", "configuration"),
				capability, -- 1
				group_value, -- 2
				group_name, -- 3
				target_value, -- 4
				target_name, -- 5
				target_system, -- 6
				target_file) -- 7
		end

	e_incompatible_target_capability (capability, parent_value, parent_name, parent_system, parent_file, target_value, target_name, target_system, target_file: READABLE_STRING_GENERAL): READABLE_STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context
				("[
					Capability "$1" of supplier target has value "$2" insufficient for client value "$6".
					Client/child target
						Name: $7
						System: $8
						File: $9
					Supplier/parent target					
						Name: $3
						System: $4
						File: $5
				]", "configuration"),
				capability, -- 1
				parent_value, -- 2
				parent_name, -- 3
				parent_system, -- 4
				parent_file, -- 5
				target_value, -- 6
				target_name, -- 7
				target_system, -- 8
				target_file) -- 9
		end

	e_incompatible_root_option (capability, root_value, capability_value, target_name, system, file: READABLE_STRING_GENERAL): READABLE_STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context
				("[
					Capability "$1" of current target has value "$3" insufficient for setting "$2".
						Target: $4
						System: $5
						File: $6
				]", "configuration"),
				capability, -- 1
				root_value, -- 2
				capability_value, -- 3
				target_name, -- 4
				system, -- 5
				file) -- 6
		end

	e_incompatible_root_capability (capability, parent_value, parent_name, parent_system, parent_file, target_value, target_name, target_system, target_file: READABLE_STRING_GENERAL): READABLE_STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context
				("[
					Capability "$1" of dependent target has value "$2" insufficient for current target setting "$6".
					Current target
						Name: $7
						System: $8
						File: $9
					Dependent target
						Name: $3
						System: $4
						File: $5
				]", "configuration"),
				capability, -- 1
				parent_value, -- 2
				parent_name, -- 3
				parent_system, -- 4
				parent_file, -- 5
				target_value, -- 6
				target_name, -- 7
				target_system, -- 8
				target_file) -- 9
		end

feature -- Boolean values

	boolean_true: STRING_32 do Result := locale.translation ("True") end

	boolean_false: STRING_32 do Result := locale.translation ("False") end

	boolean_values: STRING_TABLE [BOOLEAN]
			-- Boolean values mapping
		once
			create Result.make (2)
			Result.force (True, boolean_true)
			Result.force (False, boolean_false)
		end

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

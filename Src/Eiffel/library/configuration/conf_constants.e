indexing
	description: "Configuration constants."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONSTANTS

feature -- Platforms

	Pf_windows: INTEGER is 0x0001
	Pf_unix: INTEGER is 0x0002
	Pf_mac: INTEGER is 0x0008
	Pf_vxworks: INTEGER is 0x000F

		-- Names
	pf_windows_name: STRING is "Windows"
	pf_unix_name: STRING is "Unix"
	pf_macintosh_name: STRING is "Macintosh"
	pf_vxworks_name: STRING is "vxWorks"

feature -- Builds

	Build_workbench: INTEGER is 0x0100
	Build_finalize: INTEGER is 0x0200

		-- Names
	build_workbench_name: STRING is "Workbench"
	build_finalize_name: STRING is "Finalize"

feature -- Warnings

	w_unused_local: STRING is "unused_local"
	w_obsolete_class: STRING is "obsolete_class"
	w_obsolete_feature: STRING is "obsolete_feature"
	w_once_in_generic: STRING is "once_in_generic"
	w_syntax: STRING is "syntax"
	w_old_verbatim_strings: STRING is "old_verbatim_strings"
	w_same_uuid: STRING is "same_uuid"

feature -- Settings

	s_address_expression: STRING is "address_expression"
	s_array_optimization: STRING is "array_optimization"
	s_check_generic_creation_constraint: STRING is "check_generic_creation_constraint"
	s_check_vape: STRING is "check_vape"
	s_console_application: STRING is "console_application"
	s_cls_compliant: STRING is "cls_compliant"
	s_dead_code_removal: STRING is "dead_code_removal"
	s_dotnet_naming_convention: STRING is "dotnet_naming_convention"
	s_dynamic_runtime: STRING is "dynamic_runtime"
	s_exception_trace: STRING is "exception_trace"
	s_executable_name: STRING is "executable_name"
	s_full_type_checking: STRING is "full_type_checking"
	s_il_verifiable: STRING is "il_verifiable"
	s_inlining: STRING is "inlining"
	s_inlining_size: STRING is "inlining_size"
	s_java_generation: STRING is "java_generation"
	s_line_generation: STRING is "line_generation"
	s_metadata_cache_path: STRING is "metadata_cache_path"
	s_msil_assembly_compatibility: STRING is "msil_assembly_compatibility"
	s_msil_classes_per_module: STRING is "msil_classes_per_module"
	s_msil_clr_version: STRING is "msil_clr_version"
	s_msil_culture: STRING is "msil_culture"
	s_msil_generation: STRING is "msil_generation"
	s_msil_generation_type: STRING is "msil_generation_type"
	s_msil_key_file_name: STRING is "msil_key_file_name"
	s_msil_use_optimized_precompile: STRING is "msil_use_optimized_precompile"
	s_multithreaded: STRING is "multithreaded"
	s_old_verbatim_strings: STRING is "old_verbatim_strings"
	s_platform: STRING is "platform"
	s_external_runtime: STRING is "external_runtime"
	s_shared_library_definition: STRING is "shared_library_definition"
	s_use_cluster_name_as_namespace: STRING is "use_cluster_name_as_namespace"
	s_use_all_cluster_name_as_namespace: STRING is "use_all_cluster_name_as_namespace"

end

note
	description: "Configuration constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONSTANTS

feature -- Boolean values

	configuration_value_true: STRING_32 = "true"
			-- String representation of a configuration value "true".

	configuration_value_false: STRING_32 = "false"
			-- String representation of a configuration value "false".

	configuration_boolean_values: ARRAYED_LIST [READABLE_STRING_32]
			-- All possible configuration boolean values.
		once
			create Result.make (2)
			Result.extend (configuration_value_false)
			Result.extend (configuration_value_true)
		end

	configuration_boolean_value (v: BOOLEAN): READABLE_STRING_32
			-- A string representation of the value `v`.
		do
			Result := if v then configuration_value_true else configuration_value_false end
		end

feature -- Platforms

	Pf_windows: INTEGER = 0x0001
	Pf_unix: INTEGER = 0x0002
	Pf_mac: INTEGER = 0x0008
	Pf_vxworks: INTEGER = 0x000F

		-- Names
	pf_windows_name: STRING = "Windows"
	pf_unix_name: STRING = "Unix"
	pf_macintosh_name: STRING = "Macintosh"
	pf_vxworks_name: STRING = "vxWorks"

feature -- Builds

	Build_workbench: INTEGER = 0x0100
	Build_finalize: INTEGER = 0x0200

		-- Names
	build_workbench_name: STRING = "Workbench"
	build_finalize_name: STRING = "Finalize"

feature -- Concurrency

	concurrency_none: INTEGER = 0x0800
	concurrency_multithreaded: INTEGER = 0x0F00
	concurrency_scoop: INTEGER = 0x1000

		-- Names
	concurrency_none_name: STRING = "none"
	concurrency_multithreaded_name: STRING = "thread"
	concurrency_scoop_name: STRING = "scoop"

feature -- Void safety

	void_safety_none: INTEGER = 0x1100
	void_safety_conformance: INTEGER = 0x1200
	void_safety_initialization: INTEGER = 0x1300
	void_safety_transitional: INTEGER = 0x1400
	void_safety_all: INTEGER = 0x1500

		-- Names
	void_safety_none_name: STRING = "none"
	void_safety_conformance_name: STRING = "conformance"
	void_safety_initialization_name: STRING = "initialization"
	void_safety_transitional_name: STRING = "transitional"
	void_safety_all_name: STRING = "all"

feature -- Dead code removal

	sv_dead_code_none: STRING_32 = "none"
	sv_dead_code_feature: STRING_32 = "feature"
	sv_dead_code_all: STRING_32 = "all"

feature -- Version types

	v_compiler: STRING = "compiler"
	v_msil_clr: STRING = "msil_clr"

feature -- Warning: attributes

	wa_name: STRING = "name"
			-- Name of attribute "name".

	wa_enabled: STRING = "enabled"
			-- Name of attribute "enabled".

	wa_value: STRING = "value"
			-- Name of attribute "value".

feature -- Warning: names

	w_unused_local: STRING = "unused_local"
	w_vwab: STRING = "vwab"
	w_obsolete_class: STRING = "obsolete_class"
	w_obsolete_feature: STRING = "obsolete_feature"
	w_manifest_array_type: STRING = "manifest_array_type"
	w_once_in_generic: STRING = "once_in_generic"
	w_syntax: STRING = "syntax"
	w_old_verbatim_strings: STRING = "old_verbatim_strings"
	w_same_uuid: STRING = "same_uuid"
	w_export_class_missing: STRING = "export_class_missing"
	w_vweq: STRING = "vweq"
	w_vjrv: STRING = "vjrv"
	w_renaming_unknown_class: STRING = "renaming_unknown_class"
	w_option_unknown_class: STRING = "option_unknown_class"
	w_classname_filename_mismatch: STRING = "classname_filename_mismatch"

feature -- Settings

	s_address_expression: STRING = "address_expression"
	s_array_optimization: STRING = "array_optimization"
	s_automatic_backup: STRING = "automatic_backup"
	s_absent_explicit_assertion: STRING = "absent_explicit_assertion"
	s_check_for_void_target: STRING = "check_for_void_target"
	s_check_for_catcall_at_runtime: STRING = "check_for_catcall_at_runtime"
	s_check_generic_creation_constraint: STRING = "check_generic_creation_constraint"
	s_check_vape: STRING = "check_vape"
	s_cls_compliant: STRING = "cls_compliant"
	s_concurrency: STRING = "concurrency"
	s_void_safety: STRING = "void_safety"
	s_console_application: STRING = "console_application"
	s_dead_code_removal: STRING = "dead_code_removal"
	s_dotnet_naming_convention: STRING = "dotnet_naming_convention"
	s_dynamic_runtime: STRING = "dynamic_runtime"
	s_enforce_unique_class_names: STRING = "enforce_unique_class_names"
	s_exception_trace: STRING = "exception_trace"
	s_executable_name: STRING = "executable_name"
	s_external_runtime: STRING = "external_runtime"
	s_force_32bits: STRING = "force_32bits"
	s_il_verifiable: STRING = "il_verifiable"
	s_inlining: STRING = "inlining"
	s_inlining_size: STRING = "inlining_size"
	s_java_generation: STRING = "java_generation"
	s_library_root: STRING = "library_root"
	s_line_generation: STRING = "line_generation"
	s_manifest_array_type: STRING = "manifest_array_type"
	s_metadata_cache_path: STRING = "metadata_cache_path"
	s_msil_assembly_compatibility: STRING = "msil_assembly_compatibility"
	s_msil_classes_per_module: STRING = "msil_classes_per_module"
	s_msil_clr_version: STRING = "msil_clr_version"
	s_msil_culture: STRING = "msil_culture"
	s_msil_generation: STRING = "msil_generation"
	s_msil_generation_type: STRING = "msil_generation_type"
	s_msil_key_file_name: STRING = "msil_key_file_name"
	s_msil_use_optimized_precompile: STRING = "msil_use_optimized_precompile"
	s_multithreaded: STRING = "multithreaded"
	s_old_verbatim_strings: STRING = "old_verbatim_strings"
	s_old_feature_replication: STRING = "old_feature_replication"
	s_platform: STRING = "platform"
	s_shared_library_definition: STRING = "shared_library_definition"
	s_total_order_on_reals: STRING = "total_order_on_reals"
	s_use_cluster_name_as_namespace: STRING = "use_cluster_name_as_namespace"
	s_use_all_cluster_name_as_namespace: STRING = "use_all_cluster_name_as_namespace"

feature -- Setting values: manifest array type

	sv_array_default: STRING_32 = "default"
	sv_array_standard: STRING_32 = "standard"
	sv_array_mismatch_warning: STRING_32 = "mismatch_warning"
	sv_array_mismatch_error: STRING_32 = "mismatch_error"

feature -- Option names

	o_assertions: STRING_32 = "assertions"
	o_assertions_precondition: STRING_32 = "precondition"
	o_assertions_postcondition: STRING_32 = "postcondition"
	o_assertions_check: STRING_32 = "check"
	o_assertions_invariant: STRING_32 = "invariant"
	o_assertions_loop: STRING_32 = "loop"
	o_assertions_supplier_precondition: STRING_32 = "supplier_precondition"

	o_catcall_detection: STRING_32 = "cat_call_detection"
	o_debug_container: STRING_32 = "debug"
	o_description: STRING_32 = "description"

	o_is_attached_by_default: STRING_32 = "is_attached_by_default"
	o_is_debug: STRING_32 = "debug"
	o_is_full_class_checking: STRING_32 = "full_class_checking"
	o_is_msil_application_optimize: STRING_32 = "msil_application_optimize"
	o_is_obsolete_iteration: STRING_32 = "is_obsolete_iteration"
	o_is_obsolete_routine_type: STRING_32 = "is_obsolete_routine_type"
	o_is_optimize: STRING_32 = "optimize"
	o_is_profile: STRING_32 = "profile"
	o_is_trace: STRING_32 = "trace"
	o_warning: STRING_32 = "warning"

	o_manifest_array_type: STRING_32 = "manifest_array_type"
	o_namespace: STRING_32 = "namespace"
	o_syntax: STRING_32 = "syntax"
	o_void_safety: STRING_32 = "void_safety"
	o_warning_container: STRING_32 = "warning"

feature -- Capability names

	tag_capability: STRING_32 = "capability"
			-- A container element name for capabilities.

	tag_capability_catcall_detection: STRING_32 = "catcall_detection"
	tag_capability_code: STRING_32 = "code"
	tag_capability_concurrency: STRING_32 = "concurrency"
	tag_capability_platform: STRING_32 = "platform"
	tag_capability_void_safety: STRING_32 = "void_safety"

feature -- Capability attribute names

	ca_support: STRING_32 = "support"
	ca_use: STRING_32 = "use"

feature -- Target attribute names

	ta_abstract: STRING_32 = "abstract"
	ta_extends: STRING_32 = "extends"
	ta_extends_location: STRING_32 = "extends_location"
	ta_name: STRING_32 = "name"

feature -- Custom condition names

	tag_custom: STRING_32 = "custom"

feature -- Custom condition attribute names

	att_name: STRING_32 = "name"
	att_value: STRING_32 = "value"
	att_excluded_value: STRING_32 = "excluded_value"
	att_match: STRING_32 = "match"

feature -- Custom condition attribute values

	val_match_case_sensitive: STRING_32 = "case-sensitive"
	val_match_case_insensitive: STRING_32 = "case-insensitive"
	val_match_regexp: STRING_32 = "regexp"
	val_match_wildcard: STRING_32 = "wildcard"

feature -- Debug

	unnamed_debug: STRING = "__unnamed_debug__"

feature -- Backup

	backup_config_file: STRING = "original.ecf"
	backup_adapted_config_file: STRING = "config.ecf";

feature -- XML parsing/printing

	Lt_string: STRING_32
		once
			create Result.make (1)
			Result.append_character ({XML_MARKUP_CONSTANTS}.lt_char)
		end

	Gt_string: STRING_32
		once
			create Result.make (1)
			Result.append_character ({XML_MARKUP_CONSTANTS}.gt_char)
		end

	Amp_string: STRING_32
		once
			create Result.make (1)
			Result.append_character ({XML_MARKUP_CONSTANTS}.amp_char)
		end

	Quot_string: STRING_32
		once
			create Result.make (1)
			Result.append_character ({XML_MARKUP_CONSTANTS}.quot_char)
		end

feature -- Extension

	eiffel_file_extension: STRING = "e"
			-- File extension for an Eiffel source file without the dot

;note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

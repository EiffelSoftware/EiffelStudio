note
	description: "Configuration constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONSTANTS

inherit
	XM_MARKUP_CONSTANTS

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

feature -- Version types

	v_compiler: STRING = "compiler"
	v_msil_clr: STRING = "msil_clr"

feature -- Warnings

	w_unused_local: STRING = "unused_local"
	w_obsolete_class: STRING = "obsolete_class"
	w_obsolete_feature: STRING = "obsolete_feature"
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
	s_check_for_void_target: STRING = "check_for_void_target"
	s_check_for_catcall_at_runtime: STRING = "check_for_catcall_at_runtime"
	s_check_generic_creation_constraint: STRING = "check_generic_creation_constraint"
	s_check_vape: STRING = "check_vape"
	s_console_application: STRING = "console_application"
	s_force_32bits: STRING = "force_32bits"
	s_cls_compliant: STRING = "cls_compliant"
	s_dead_code_removal: STRING = "dead_code_removal"
	s_dotnet_naming_convention: STRING = "dotnet_naming_convention"
	s_dynamic_runtime: STRING = "dynamic_runtime"
	s_enforce_unique_class_names: STRING = "enforce_unique_class_names"
	s_exception_trace: STRING = "exception_trace"
	s_executable_name: STRING = "executable_name"
	s_il_verifiable: STRING = "il_verifiable"
	s_inlining: STRING = "inlining"
	s_inlining_size: STRING = "inlining_size"
	s_java_generation: STRING = "java_generation"
	s_library_root: STRING = "library_root"
	s_line_generation: STRING = "line_generation"
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
	s_external_runtime: STRING = "external_runtime"
	s_shared_library_definition: STRING = "shared_library_definition"
	s_use_cluster_name_as_namespace: STRING = "use_cluster_name_as_namespace"
	s_use_all_cluster_name_as_namespace: STRING = "use_all_cluster_name_as_namespace"

feature -- Debug

	unnamed_debug: STRING = "__unnamed_debug__"

feature -- Backup

	backup_config_file: STRING = "original.ecf"
	backup_adapted_config_file: STRING = "config.ecf";

feature -- XML parsing/printing

	Lt_string: STRING
		once
			create Result.make (1)
			Result.append_character (lt_char)
		end

	Gt_string: STRING
		once
			create Result.make (1)
			Result.append_character (gt_char)
		end

	Amp_string: STRING
		once
			create Result.make (1)
			Result.append_character (amp_char)
		end

	Quot_string: STRING
		once
			create Result.make (1)
			Result.append_character (quot_char)
		end

feature -- Extension

	eiffel_file_extension: STRING = "e"
			-- File extension for an Eiffel source file without the dot

invariant

note
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

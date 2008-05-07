indexing
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

feature -- Version types

	v_compiler: STRING is "compiler"
	v_msil_clr: STRING is "msil_clr"

feature -- Warnings

	w_unused_local: STRING is "unused_local"
	w_obsolete_class: STRING is "obsolete_class"
	w_obsolete_feature: STRING is "obsolete_feature"
	w_once_in_generic: STRING is "once_in_generic"
	w_syntax: STRING is "syntax"
	w_old_verbatim_strings: STRING is "old_verbatim_strings"
	w_same_uuid: STRING is "same_uuid"
	w_export_class_missing: STRING is "export_class_missing"
	w_vweq: STRING is "vweq"
	w_vjrv: STRING is "vjrv"
	w_renaming_unknown_class: STRING is "renaming_unknown_class"
	w_option_unknown_class: STRING is "option_unknown_class"
	w_classname_filename_mismatch: STRING is "classname_filename_mismatch"

feature -- Settings

	s_address_expression: STRING is "address_expression"
	s_array_optimization: STRING is "array_optimization"
	s_automatic_backup: STRING is "automatic_backup"
	s_check_for_void_target: STRING is "check_for_void_target"
	s_check_for_catcall_at_runtime: STRING is "check_for_catcall_at_runtime"
	s_check_generic_creation_constraint: STRING is "check_generic_creation_constraint"
	s_check_vape: STRING is "check_vape"
	s_console_application: STRING is "console_application"
	s_force_32bits: STRING is "force_32bits"
	s_cls_compliant: STRING is "cls_compliant"
	s_dead_code_removal: STRING is "dead_code_removal"
	s_dotnet_naming_convention: STRING is "dotnet_naming_convention"
	s_dynamic_runtime: STRING is "dynamic_runtime"
	s_enforce_unique_class_names: STRING is "enforce_unique_class_names"
	s_exception_trace: STRING is "exception_trace"
	s_executable_name: STRING is "executable_name"
	s_il_verifiable: STRING is "il_verifiable"
	s_inlining: STRING is "inlining"
	s_inlining_size: STRING is "inlining_size"
	s_java_generation: STRING is "java_generation"
	s_library_root: STRING is "library_root"
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
	s_old_feature_replication: STRING is "old_feature_replication"
	s_platform: STRING is "platform"
	s_external_runtime: STRING is "external_runtime"
	s_shared_library_definition: STRING is "shared_library_definition"
	s_use_cluster_name_as_namespace: STRING is "use_cluster_name_as_namespace"
	s_use_all_cluster_name_as_namespace: STRING is "use_all_cluster_name_as_namespace"

feature -- Debug

	unnamed_debug: STRING is "__unnamed_debug__"

feature -- Backup

	backup_config_file: STRING is "original.ecf"
	backup_adapted_config_file: STRING is "config.ecf";

feature -- XML parsing/printing

	Lt_string: STRING is
		once
			create Result.make (1)
			Result.append_character (lt_char)
		end

	Gt_string: STRING is
		once
			create Result.make (1)
			Result.append_character (gt_char)
		end

	Amp_string: STRING is
		once
			create Result.make (1)
			Result.append_character (amp_char)
		end

	Quot_string: STRING is
		once
			create Result.make (1)
			Result.append_character (quot_char)
		end

feature -- Extension

	eiffel_file_extension: STRING is "e"
			-- File extension for an Eiffel source file without the dot

invariant

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

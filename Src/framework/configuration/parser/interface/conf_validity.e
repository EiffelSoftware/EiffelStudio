indexing
	description: "Specifies constants and validity check against the constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_VALIDITY

inherit
	CONF_CONSTANTS

feature -- Basic validity queries

	valid_platform (a_platform: INTEGER): BOOLEAN is
			-- Is `a_platform' a valid platform?
		do
			Result := platform_names.has (a_platform)
		end

	valid_build (a_build: INTEGER): BOOLEAN is
			-- Is `a_build' a valid build?
		do
			Result := build_names.has (a_build)
		end

	valid_warning (a_warning: STRING): BOOLEAN is
			-- Is `a_warning' a valid warning?
		require
			a_warning_not_void: a_warning /= Void
			a_warning_lower: a_warning.is_equal (a_warning.as_lower)
		do
			if not a_warning.is_empty then
				Result := valid_warnings.has (a_warning)
			end
		end

	valid_regexp (a_regexp: STRING): BOOLEAN is
			-- is `a_regexp' a valid regular expression?
		local
			l_regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			if a_regexp /= Void then
				create l_regexp.make
				l_regexp.compile (a_regexp)
				Result := l_regexp.is_compiled
			end
		end

	valid_setting (a_setting: STRING): BOOLEAN is
			-- Is `a_setting' a valid setting?
		do
			Result := a_setting /= Void and then valid_settings.has (a_setting)
		end

	valid_version_type (a_version_type: STRING): BOOLEAN is
			-- Is `a_version_type' valid?
		do
			Result := a_version_type /= Void and then valid_version_types.has (a_version_type)
		end

	valid_eiffel_extension (a_file: STRING): BOOLEAN is
			-- Does `a_file' have a correct eiffel file extension?
		local
			l_ext: CHARACTER
			l_file_count: INTEGER
		do
			l_file_count := a_file.count
			if l_file_count > 2 and then a_file.item (l_file_count - 1 ) = '.' then
				l_ext := a_file.item (l_file_count)
				Result := l_ext = 'e' or else l_ext = 'E'
			end
		end

	valid_config_extension (a_file: STRING): BOOLEAN is
			-- Does `a_file' have a correct eiffel config file extension?
		local
			l_ext: STRING
			sep, cnt: INTEGER
		do
			cnt := a_file.count
			sep := a_file.last_index_of ('.', cnt)
			if sep /= 0 then
				l_ext := a_file.substring (sep+1, cnt)
				Result := l_ext.is_case_insensitive_equal ("ecf")
			end
		end

feature {NONE} -- Basic operation

	get_platform_name (a_platform: INTEGER): STRING is
			-- Get the name of `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
		do
			Result := platform_names.item (a_platform)
		ensure
			result_not_void: Result /= Void
		end

	get_build_name (a_build: INTEGER): STRING is
			-- Get the name of `a_build'.
		require
			valid_build: valid_build (a_build)
		do
			Result := build_names.item (a_build)
		ensure
			result_not_void: Result /= Void
		end

	get_platform (a_name: STRING): INTEGER is
			-- Get the platform with `a_name', otherwise return 0.
		do
			if a_name /= Void then
				from
					platform_names.start
				until
					Result /= 0 or platform_names.after
				loop
					if platform_names.item_for_iteration.is_case_insensitive_equal (a_name) then
						Result := platform_names.key_for_iteration
					end
					platform_names.forth
				end
			end
		ensure
			Result_valid: Result = 0 or else valid_platform (Result)
		end

	get_build (a_name: STRING): INTEGER is
			-- Get the build with `a_name', otherwise return 0.
		do
			if a_name /= Void then
				from
					build_names.start
				until
					Result /= 0 or build_names.after
				loop
					if build_names.item_for_iteration.is_case_insensitive_equal (a_name) then
						Result := build_names.key_for_iteration
					end
					build_names.forth
				end
			end
		ensure
			Result_valid: Result = 0 or else valid_build (Result)
		end

feature {NONE} -- Onces

	platform_names: HASH_TABLE [STRING, INTEGER] is
			-- The platform names mapped to their integer.
		once
			create Result.make (5)
			Result.force (pf_windows_name, Pf_windows)
			Result.force (pf_unix_name, Pf_unix)
			Result.force (pf_macintosh_name, Pf_mac)
			Result.force (pf_vxworks_name, Pf_vxworks)
		ensure
			Result_not_void: Result /= Void
		end

	build_names: HASH_TABLE [STRING, INTEGER] is
			-- The build names mapped to their integer.
		once
			create Result.make (2)
			Result.force (build_workbench_name, build_workbench)
			Result.force (build_finalize_name, build_finalize)
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	valid_warnings: SEARCH_TABLE [STRING] is
			-- The codes of valid warnings.
		once
			create Result.make (10)
			Result.force (w_unused_local)
			Result.force (w_obsolete_class)
			Result.force (w_obsolete_feature)
			Result.force (w_once_in_generic)
			Result.force (w_syntax)
			Result.force (w_old_verbatim_strings)
			Result.force (w_same_uuid)
			Result.force (w_export_class_missing)
			Result.force (w_vweq)
			Result.force (w_vjrv)
			Result.force (w_renaming_unknown_class)
			Result.force (w_option_unknown_class)
			Result.force (w_classname_filename_mismatch)
		ensure
			Result_not_void: Result /= Void
		end

	valid_version_types: SEARCH_TABLE [STRING] is
			-- The codes of valid version types.
		once
			create Result.make (2)
			Result.force (v_compiler)
			Result.force (v_msil_clr)
		ensure
			Result_not_void: Result /= Void
		end

	valid_settings: SEARCH_TABLE [STRING] is
			-- The codes of valid settings.
		once
			create Result.make (40)
			Result.force (s_address_expression)
			Result.force (s_array_optimization)
			Result.force (s_automatic_backup)
			Result.force (s_check_for_void_target)
			Result.force (s_check_generic_creation_constraint)
			Result.force (s_check_vape)
			Result.force (s_console_application)
			Result.force (s_force_32bits)
			Result.force (s_cls_compliant)
			Result.force (s_dead_code_removal)
			Result.force (s_dotnet_naming_convention)
			Result.force (s_dynamic_runtime)
			Result.force (s_enforce_unique_class_names)
			Result.force (s_exception_trace)
			Result.force (s_executable_name)
			Result.force (s_il_verifiable)
			Result.force (s_inlining)
			Result.force (s_inlining_size)
			Result.force (s_java_generation)
			Result.force (s_library_root)
			Result.force (s_line_generation)
			Result.force (s_metadata_cache_path)
			Result.force (s_msil_assembly_compatibility)
			Result.force (s_msil_classes_per_module)
			Result.force (s_msil_clr_version)
			Result.force (s_msil_culture)
			Result.force (s_msil_generation)
			Result.force (s_msil_generation_type)
			Result.force (s_msil_key_file_name)
			Result.force (s_msil_use_optimized_precompile)
			Result.force (s_multithreaded)
			Result.force (s_old_verbatim_strings)
			Result.force (s_platform)
			Result.force (s_external_runtime)
			Result.force (s_shared_library_definition)
			Result.force (s_use_cluster_name_as_namespace)
			Result.force (s_use_all_cluster_name_as_namespace)
		ensure
			Result_not_void: Result /= Void
		end

	boolean_settings: SEARCH_TABLE [STRING] is
			-- Settings that have a boolean value.
		once
			create Result.make (25)
			Result.force (s_dead_code_removal)
			Result.force (s_array_optimization)
			Result.force (s_inlining)
			Result.force (s_check_for_void_target)
			Result.force (s_check_generic_creation_constraint)
			Result.force (s_check_vape)
			Result.force (s_enforce_unique_class_names)
			Result.force (s_exception_trace)
			Result.force (s_address_expression)
			Result.force (s_java_generation)
			Result.force (s_msil_generation)
			Result.force (s_msil_use_optimized_precompile)
			Result.force (s_line_generation)
			Result.force (s_cls_compliant)
			Result.force (s_dotnet_naming_convention)
			Result.force (s_dynamic_runtime)
			Result.force (s_old_verbatim_strings)
			Result.force (s_console_application)
			Result.force (s_force_32bits)
			Result.force (s_multithreaded)
			Result.force (s_il_verifiable)
			Result.force (s_use_cluster_name_as_namespace)
			Result.force (s_use_all_cluster_name_as_namespace)
		ensure
			Result_not_void: Result /= Void
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

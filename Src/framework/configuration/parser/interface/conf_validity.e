﻿note
	description: "Specifies constants and validity check against the constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_VALIDITY

inherit
	CONF_CONSTANTS
		export
			{NONE} all
		end

	CONF_FILE_CONSTANTS

feature -- Basic validity queries

	valid_platform (a_platform: INTEGER): BOOLEAN
			-- Is `a_platform' a valid platform?
		do
			Result := platform_names.has (a_platform)
		end

	valid_build (a_build: INTEGER): BOOLEAN
			-- Is `a_build' a valid build?
		do
			Result := build_names.has (a_build)
		end

	valid_concurrency (a_concurrency: INTEGER): BOOLEAN
			-- Is `a_concurrency' a valid concurrency value?
		do
			Result := concurrency_names.has (a_concurrency)
		end

	is_warning_known (a_warning: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_warning' known?
		require
			a_warning_not_void: a_warning /= Void
			a_warning_lower: a_warning.same_string (a_warning.as_lower)
		do
			Result := known_warnings.has (a_warning)
		end

	valid_warning (a_warning: READABLE_STRING_GENERAL; a_namespace: detachable like latest_namespace): BOOLEAN
			-- Is `a_warning' a valid warning in `a_namespace'?
		require
			a_warning_not_void: a_warning /= Void
			a_warning_lower: a_warning.same_string (a_warning.as_lower)
		local
			w: like valid_warnings_default
		do
			if is_after_or_equal (a_namespace, namespace_1_10_0) then
				w := valid_warnings_1_10_0
			else
				w := valid_warnings_default
			end
			Result := w.has (a_warning)
		end

	valid_regexp (a_regexp: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_regexp' a valid regular expression?
		local
			l_regexp: REGULAR_EXPRESSION
			u: UTF_CONVERTER
		do
			if a_regexp /= Void then
				create l_regexp
					-- FIXME: We currently perform the match on the UTF-8 version of the string.
				l_regexp.compile (u.utf_32_string_to_utf_8_string_8 (a_regexp))
				Result := l_regexp.is_compiled
			end
		end

	regexp_error (a_regexp: READABLE_STRING_GENERAL):
			detachable TUPLE [message: READABLE_STRING_GENERAL; position: INTEGER]
			-- Is `a_regexp' a valid regular expression?
		local
			r: REGULAR_EXPRESSION
			u: UTF_CONVERTER
		do
			if a_regexp /= Void then
				create r
					-- FIXME: We currently perform the match on the UTF-8 version of the string.
				r.compile (u.utf_32_string_to_utf_8_string_8 (a_regexp))
				if not r.is_compiled then
					Result := [r.error_message, r.error_position]
				end
			end
		ensure
			valid_regexp: not attached Result implies valid_regexp (a_regexp)
		end

	valid_setting (a_setting: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_setting' a valid setting?
		do
			Result := a_setting /= Void and then (a_setting.is_valid_as_string_8 and then valid_settings.has (a_setting.to_string_8))
		end

	valid_version_type (a_version_type: STRING_32): BOOLEAN
			-- Is `a_version_type' valid?
		do
			Result := a_version_type /= Void and then valid_version_types.has (a_version_type)
		end

	valid_eiffel_extension (a_file: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_file' have a correct eiffel file extension?
		local
			l_ext: CHARACTER_32
			l_file_count: INTEGER
		do
			l_file_count := a_file.count
			if l_file_count > 2 and then a_file.item (l_file_count - 1 ) = '.' then
				l_ext := a_file.item (l_file_count)
				Result := l_ext = 'e' or else l_ext = 'E'
			end
		end

	valid_config_extension (a_file: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_file' have a correct eiffel config file extension?
		local
			cnt: INTEGER
		do
			cnt := a_file.count
				-- It should have at leat 5 characters, one for the file name and four
				-- for the extension part including the dot (".ecf").
			if cnt >= 5 then
				Result := a_file.item (cnt - 3) = {CHARACTER_32} '.' and
					a_file.item (cnt - 2).as_lower = {CHARACTER_32} 'e' and
					a_file.item (cnt - 1).as_lower = {CHARACTER_32} 'c' and
					a_file.item (cnt).as_lower = {CHARACTER_32} 'f'
			end
		end

feature {NONE} -- Basic operation

	get_platform_name (a_platform: INTEGER): STRING
			-- Get the name of `a_platform'.
		require
			valid_platform: valid_platform (a_platform)
		do
			check
				valid_platform: attached platform_names.item (a_platform) as l_item
			then
				Result := l_item
			end
		ensure
			result_not_void: Result /= Void
		end

	get_build_name (a_build: INTEGER): STRING
			-- Get the name of `a_build'.
		require
			valid_build: valid_build (a_build)
		do
			check
				valid_build: attached build_names.item (a_build) as l_item
			then
				Result := l_item
			end
		ensure
			result_not_void: Result /= Void
		end

	get_concurrency_name (index: INTEGER): STRING
			-- Get the concurrency name of `index'.
		require
			valid_index: valid_concurrency (index)
		do
			check
				valid_index: attached concurrency_names.item (index) as l_item
			then
				Result := l_item
			end
		ensure
			result_not_void: Result /= Void
		end

	get_platform (a_name: detachable READABLE_STRING_GENERAL): INTEGER
			-- Get the platform with `a_name', otherwise return 0.
		do
			if a_name /= Void then
				from
					platform_names.start
				until
					Result /= 0 or platform_names.after
				loop
					if a_name.is_case_insensitive_equal (platform_names.item_for_iteration) then
						Result := platform_names.key_for_iteration
					end
					platform_names.forth
				end
			end
		ensure
			Result_valid: Result = 0 or else valid_platform (Result)
		end

	get_build (a_name: detachable READABLE_STRING_GENERAL): INTEGER
			-- Get the build with `a_name', otherwise return 0.
		do
			if a_name /= Void then
				from
					build_names.start
				until
					Result /= 0 or build_names.after
				loop
					if a_name.is_case_insensitive_equal (build_names.item_for_iteration) then
						Result := build_names.key_for_iteration
					end
					build_names.forth
				end
			end
		ensure
			Result_valid: Result = 0 or else valid_build (Result)
		end

	get_concurrency (a_name: detachable READABLE_STRING_GENERAL): INTEGER
			-- Get the concurrency value with `a_name', otherwise return 0.
		do
			if a_name /= Void then
				from
					concurrency_names.start
				until
					Result /= 0 or concurrency_names.after
				loop
					if a_name.is_case_insensitive_equal (concurrency_names.item_for_iteration) then
						Result := concurrency_names.key_for_iteration
					end
					concurrency_names.forth
				end
			end
		ensure
			Result_valid: Result = 0 or else valid_concurrency (Result)
		end

	current_platform: INTEGER
			-- Get the underlying platform identifier.
		do
			if {PLATFORM}.is_windows then
				Result := pf_windows
			elseif {PLATFORM}.is_mac then
				Result := pf_mac
			elseif {PLATFORM}.is_vxworks then
				Result := pf_vxworks
			else
				Result := pf_unix
			end
		end

feature {NONE} -- Onces

	platform_names: HASH_TABLE [STRING, INTEGER]
			-- The platform names mapped to their integer.
		once
			create Result.make (4)
			Result.force (pf_windows_name, Pf_windows)
			Result.force (pf_unix_name, Pf_unix)
			Result.force (pf_macintosh_name, Pf_mac)
			Result.force (pf_vxworks_name, Pf_vxworks)
		ensure
			Result_not_void: Result /= Void
		end

	build_names: HASH_TABLE [STRING, INTEGER]
			-- The build names mapped to their integer.
		once
			create Result.make (2)
			Result.force (build_workbench_name, build_workbench)
			Result.force (build_finalize_name, build_finalize)
		ensure
			Result_not_void: Result /= Void
		end

	concurrency_names: HASH_TABLE [STRING, INTEGER]
			-- The concurrency values mapped to their integer.
		once
			create Result.make (3)
			Result.force (concurrency_none_name, concurrency_none)
			Result.force (concurrency_multithreaded_name, concurrency_multithreaded)
			Result.force (concurrency_scoop_name, concurrency_scoop)
		ensure
			Result_not_void: Result /= Void
		end

	msil_generation_type_values: ARRAYED_LIST [READABLE_STRING_32]
			-- Valid values for setting named `s_msil_generation_type'.
		do
			create Result.make_from_array (<<{STRING_32} "dll", {STRING_32} "exe">>)
		end

	msil_generation_type_value (string: READABLE_STRING_32; start_index, end_index: INTEGER): detachable READABLE_STRING_32
			-- A value of a valid msil_generation_type setting (if any) starting at `start_index' and ending at `end_index' of a string `string'.
		require
			valid_start_index: string.valid_index (start_index)
			valid_end_index: string.valid_index (end_index)
			valid_start_index_end_index: start_index <= end_index
		local
			n: INTEGER
		do
			n := end_index + 1 - start_index
			across
				msil_generation_type_values as c
			until
				attached Result
			loop
				if
					c.item.count = n and then
					c.item.same_caseless_characters (string, start_index, end_index, 1)
				then
					Result := c.item
				end
			end
		ensure
			valid_value: attached Result implies across msil_generation_type_values as c some c.item.same_caseless_characters (Result, 1, Result.count, 1)  end
		end

	msil_classes_per_module_value (string: READABLE_STRING_32; start_index, end_index: INTEGER): detachable READABLE_STRING_32
			-- A value of a msil_classes_per_module setting (if valid) starting at `start_index' and ending at `end_index' of a string `string'.
		require
			valid_start_index: string.valid_index (start_index)
			valid_end_index: string.valid_index (end_index)
			valid_start_index_end_index: start_index <= end_index
		do
			Result := string.substring (start_index, end_index)
			if not Result.is_natural_16 or else Result.to_natural_16 = 0 then
				Result := Void
			end
		end

	inlining_size_value (string: READABLE_STRING_32; start_index, end_index: INTEGER): detachable READABLE_STRING_32
			-- A value of a inlining_size setting (if valid) starting at `start_index' and ending at `end_index' of a string `string'.
		require
			valid_start_index: string.valid_index (start_index)
			valid_end_index: string.valid_index (end_index)
			valid_start_index_end_index: start_index <= end_index
		do
			Result := string.substring (start_index, end_index)
			if not Result.is_natural_8 or else Result.to_natural_8 > 100 then
				Result := Void
			end
		end

feature {NONE} -- Implementation

	known_warnings: STRING_TABLE [BOOLEAN]
			-- The codes of known warnings.
		once
			Result := valid_warnings_1_10_0
		end

	valid_warnings_default: STRING_TABLE [BOOLEAN]
			-- The codes of valid warnings in a namespace below `namespace_1_10_0'.
		once
			create Result.make (13)
			Result.force (True, w_unused_local)
			Result.force (True, w_obsolete_class)
			Result.force (True, w_obsolete_feature)
			Result.force (True, w_once_in_generic)
			Result.force (True, w_syntax)
			Result.force (True, w_old_verbatim_strings)
			Result.force (True, w_same_uuid)
			Result.force (True, w_export_class_missing)
			Result.force (True, w_vweq)
			Result.force (True, w_vjrv)
			Result.force (True, w_renaming_unknown_class)
			Result.force (True, w_option_unknown_class)
			Result.force (True, w_classname_filename_mismatch)
		ensure
			Result_not_void: Result /= Void
		end

	valid_warnings_1_10_0: STRING_TABLE [BOOLEAN]
			-- The codes of valid warnings in `namespace_1_10_0' and above.
		once
			Result := valid_warnings_default.twin
			Result.force (True, w_vwab)
		ensure
			Result_not_void: Result /= Void
		end

	valid_version_types: STRING_TABLE [BOOLEAN]
			-- The codes of valid version types.
		once
			create Result.make (2)
			Result.force (True, v_compiler)
			Result.force (True, v_msil_clr)
		ensure
			Result_not_void: Result /= Void
		end

	valid_settings: SEARCH_TABLE [STRING]
			-- The codes of valid settings.
		once
			create Result.make (40)
			Result.force (s_address_expression)
			Result.force (s_array_optimization)
			Result.force (s_automatic_backup)
			Result.force (s_check_for_void_target)
			Result.force (s_check_for_catcall_at_runtime)
			Result.force (s_check_generic_creation_constraint)
			Result.force (s_check_vape)
			Result.force (s_cls_compliant)
			Result.force (s_concurrency)
			Result.force (s_console_application)
			Result.force (s_dead_code_removal)
			Result.force (s_dotnet_naming_convention)
			Result.force (s_dynamic_runtime)
			Result.force (s_enforce_unique_class_names)
			Result.force (s_exception_trace)
			Result.force (s_executable_name)
			Result.force (s_force_32bits)
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
			Result.force (s_total_order_on_reals)
			Result.force (s_use_cluster_name_as_namespace)
			Result.force (s_use_all_cluster_name_as_namespace)
			Result.force (s_old_feature_replication)
		ensure
			Result_not_void: Result /= Void
		end

	boolean_settings: STRING_TABLE [BOOLEAN]
			-- Settings that have a boolean value.
		once
			create Result.make (27)
			Result.force (True, s_address_expression)
			Result.force (True, s_array_optimization)
			Result.force (True, s_automatic_backup)
			Result.force (True, s_check_for_catcall_at_runtime)
			Result.force (True, s_check_for_void_target)
			Result.force (True, s_check_generic_creation_constraint)
			Result.force (True, s_check_vape)
			Result.force (True, s_cls_compliant)
			Result.force (True, s_console_application)
			Result.force (True, s_dead_code_removal)
			Result.force (True, s_dotnet_naming_convention)
			Result.force (True, s_dynamic_runtime)
			Result.force (True, s_enforce_unique_class_names)
			Result.force (True, s_exception_trace)
			Result.force (True, s_force_32bits)
			Result.force (True, s_il_verifiable)
			Result.force (True, s_inlining)
			Result.force (True, s_java_generation)
			Result.force (True, s_line_generation)
			Result.force (True, s_msil_generation)
			Result.force (True, s_msil_use_optimized_precompile)
			Result.force (True, s_multithreaded)
			Result.force (True, s_old_feature_replication)
			Result.force (True, s_old_verbatim_strings)
			Result.force (True, s_total_order_on_reals)
			Result.force (True, s_use_all_cluster_name_as_namespace)
			Result.force (True, s_use_cluster_name_as_namespace)
		ensure
			Result_not_void: Result /= Void
		end

	true_boolean_settings: SEARCH_TABLE [STRING]
			-- Settings that have a boolean value True by default if not specified in configuration.
		once
			create Result.make (23)
			Result.force (s_check_generic_creation_constraint)
			Result.force (s_check_vape)
			Result.force (s_check_for_void_target)
			Result.force (s_check_for_catcall_at_runtime)
			Result.force (s_cls_compliant)
			Result.force (s_dead_code_removal)
			Result.force (s_inlining)
			Result.force (s_il_verifiable)
			Result.force (s_use_cluster_name_as_namespace)
			Result.force (s_use_all_cluster_name_as_namespace)
		ensure
			Result_not_void: Result /= Void
		end

	setting_name (string: READABLE_STRING_32; start_index, end_index: INTEGER): detachable READABLE_STRING_32
			-- A name of a valid setting (if any) starting at `start_index' and ending at `end_index' of a string `string'.
		require
			valid_start_index: string.valid_index (start_index)
			valid_end_index: string.valid_index (end_index)
			valid_start_index_end_index: start_index <= end_index
		do
			Result := key_name (string, start_index, end_index, valid_settings)
		ensure
			valid_setting: attached Result implies valid_settings.has (Result)
		end

	key_name (string: READABLE_STRING_32; start_index, end_index: INTEGER; keys: ITERABLE [READABLE_STRING_GENERAL]): detachable READABLE_STRING_32
			-- A key from `keys' (if any) starting at `start_index' and ending at `end_index' of a string `string'.
		require
			valid_start_index: string.valid_index (start_index)
			valid_end_index: string.valid_index (end_index)
			valid_start_index_end_index: start_index <= end_index
		local
			n: INTEGER
		do
			n := end_index + 1 - start_index
			across
				keys as c
			until
				attached Result
			loop
				if
					c.item.count = n and then
					c.item.same_characters (string, start_index, end_index, 1)
				then
					Result := c.item.as_string_32
				end
			end
		ensure
			valid_key: attached Result implies across keys as c some c.item.same_string (Result)  end
		end

	boolean_setting_name (string: READABLE_STRING_32; start_index, end_index: INTEGER): detachable READABLE_STRING_32
			-- A name of a valid boolean setting (if any) starting at `start_index' and ending at `end_index' of a string `string'.
		require
			valid_start_index: string.valid_index (start_index)
			valid_end_index: string.valid_index (end_index)
			valid_start_index_end_index: start_index <= end_index
		local
			n: INTEGER
		do
			n := end_index + 1 - start_index
			across
				boolean_settings as c
			until
				attached Result
			loop
				if
					c.key.count = n and then
					c.key.same_characters (string, start_index, end_index, 1)
				then
					Result := c.key.as_string_32
				end
			end
		ensure
			valid_boolean_setting: attached Result implies boolean_settings [Result]
		end

	concurrency_setting_name (string: READABLE_STRING_32; start_index, end_index: INTEGER): detachable READABLE_STRING_32
			-- A name of a valid concurrency setting (if any) starting at `start_index' and ending at `end_index' of a string `string'.
		require
			valid_start_index: string.valid_index (start_index)
			valid_end_index: string.valid_index (end_index)
			valid_start_index_end_index: start_index <= end_index
		do
			if
				s_concurrency.count = end_index + 1 - start_index and then
				s_concurrency.same_characters_general (string, start_index, end_index, 1)
			then
				Result := s_concurrency
			end
		ensure
			valid_concurrency_setting: attached Result implies Result.same_string_general (s_concurrency)
		end

feature {NONE} -- Option names

	boolean_options: SEARCH_TABLE [READABLE_STRING_32]
			-- Names of options that have a boolean value.
		once
			create Result.make (15)
			Result.force (o_assertions_precondition)
			Result.force (o_assertions_postcondition)
			Result.force (o_assertions_check)
			Result.force (o_assertions_invariant)
			Result.force (o_assertions_loop)
			Result.force (o_assertions_supplier_precondition)
			Result.force (o_is_attached_by_default)
			Result.force (o_is_debug)
			Result.force (o_is_full_class_checking)
			Result.force (o_is_msil_application_optimize)
			Result.force (o_is_obsolete_routine_type)
			Result.force (o_is_optimize)
			Result.force (o_is_profile)
			Result.force (o_is_trace)
			Result.force (o_is_warning)
		end

	valid_options: SEARCH_TABLE [READABLE_STRING_32]
			-- Names of all known options except for those that are placed in a container (debug and warning).
		once
			Result := boolean_options.twin
			Result.force (o_catcall_detection)
			Result.force (o_description)
			Result.force (o_namespace)
			Result.force (o_syntax)
			Result.force (o_void_safety)
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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

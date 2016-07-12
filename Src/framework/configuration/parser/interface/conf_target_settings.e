note
	description: "Configuration target settings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_TARGET_SETTINGS

inherit
	CONF_VALIDITY

create
	make

feature {NONE} -- Initialization

	make
			-- Create empty settings that may be filled later.
		do
			create internal_settings.make (1)
			create immediate_setting_concurrency.make (setting_concurrency_name, setting_concurrency_index_scoop)
		end

feature -- Access queries

	options: CONF_OPTION
			-- Options (Debuglevel, assertions, ...)
		do
			if attached internal_options as l_internal_options then
				Result := l_internal_options
			else
				create Result
			end
		end

	settings: HASH_TABLE [STRING_32, STRING_32]
			-- Settings.
		do
			Result := internal_settings
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access queries for settings

	setting_boolean (a_name: STRING): BOOLEAN
			-- Get value of boolean setting with `a_name'.
		require
			a_name_valid: valid_setting (a_name)
		local
			l_settings: like settings
		do
			l_settings := settings
			if attached l_settings.item (a_name) as l_found_item then
				check l_found_item.is_boolean end
				if not a_name.is_equal (s_array_optimization) then
					Result := l_found_item.to_boolean
				end
			else
				Result := true_boolean_settings.has (a_name)
			end
		end

	setting_address_expression: BOOLEAN
			-- Value of the address_expression setting.
		do
			Result := setting_boolean (s_address_expression)
		end

	setting_array_optimization: BOOLEAN
			-- Value of the array_optimization setting.
		do
			Result := setting_boolean (s_array_optimization)
		end

	setting_check_for_void_target: BOOLEAN
			-- Value for the `check_for_void_target' setting.
		do
			Result := setting_boolean (s_check_for_void_target)
		end

	setting_check_for_catcall_at_runtime: BOOLEAN
			-- Value for the `check_for_catcall_at_runtime' setting.
		do
			Result := setting_boolean (s_check_for_catcall_at_runtime)
		end

	setting_check_generic_creation_constraint: BOOLEAN
			-- Value of the check_generic_creation_constraint setting.
		do
			Result := setting_boolean (s_check_generic_creation_constraint)
		end

	setting_check_vape: BOOLEAN
			-- Value for the check_vape setting.
		do
			Result := setting_boolean (s_check_vape)
		end

	setting_console_application: BOOLEAN
			-- Value for the console_application setting.
		do
			Result := setting_boolean (s_console_application)
		end

	setting_cls_compliant: BOOLEAN
			-- Value for the cls_compliant setting.
		do
			Result := setting_boolean (s_cls_compliant)
		end

	setting_dead_code_removal: BOOLEAN
			-- Value for the dead_code_removal setting.
		do
			Result := setting_boolean (s_dead_code_removal)
		end

	setting_dotnet_naming_convention: BOOLEAN
			-- Value for the dotnet_naming_convention setting.
		do
			Result := setting_boolean (s_dotnet_naming_convention)
		end

	setting_dynamic_runtime: BOOLEAN
			-- Value for the dynamic_runtime setting.
		do
			Result := setting_boolean (s_dynamic_runtime)
		end

	setting_executable_name: STRING_32
			-- Value for the executable_name setting.
		do
			if attached settings.item (s_executable_name) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_enforce_unique_class_names: BOOLEAN
			-- Valeu for the enforce_unique_class_names setting.
		do
			Result := setting_boolean (s_enforce_unique_class_names)
		end

	setting_exception_trace: BOOLEAN
			-- Value for the exception_trace setting.
		do
			Result := setting_boolean (s_exception_trace)
		end

	setting_force_32bits: BOOLEAN
			-- Value for the force_32bits setting.
		do
			Result := setting_boolean (s_force_32bits)
		end

	setting_il_verifiable: BOOLEAN
			-- Value for the console_application setting.
		do
			Result := setting_boolean (s_il_verifiable)
		end

	setting_inlining: BOOLEAN
			-- Value for the inlining setting.
		do
			Result := setting_boolean (s_inlining)
		end

	setting_inlining_size: NATURAL_8
			-- Value for the inlining_size setting.
		do
			if attached settings.item (s_inlining_size) as l_found_item then
				check l_found_item.is_natural_8 and then l_found_item.to_natural_8 <= 100 end
				Result := l_found_item.to_natural_8
			else
				Result := 4
			end
		end

	setting_java_generation: BOOLEAN
			-- Value for the java_generation setting.
		do
			Result := setting_boolean (s_java_generation)
		end

	setting_line_generation: BOOLEAN
			-- Value for the line_generation setting.
		do
			Result := setting_boolean (s_line_generation)
		end

	setting_metadata_cache_path: STRING_32
			-- Value for the metadata_cache_path setting.
		do
			if attached settings.item (s_metadata_cache_path) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_assembly_compatibility: STRING_32
			-- Value for the msil_assembly_compatibility setting.
		do
			if attached settings.item (s_msil_assembly_compatibility) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_classes_per_module: NATURAL_16
			-- Value for the msil_classes_per_module setting.
		do
			if attached settings.item (s_msil_classes_per_module) as l_found_item then
				check l_found_item.is_natural_16 and then l_found_item.to_natural_16 > 0 end
				Result := l_found_item.to_natural_16
			else
				Result := 0
			end
		end

	setting_msil_clr_version: STRING_32
			-- Value for the msil_clr_version setting.
		do
			if attached settings.item (s_msil_clr_version) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_culture: STRING_32
			-- Value for the msil_culture setting.
		do
			if attached settings.item (s_msil_culture) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_generation: BOOLEAN
			-- Value for the msil_generation setting.
		do
			Result := setting_boolean (s_msil_generation)
		end

	setting_msil_generation_type: STRING_32
			-- Value for the msil_generation_type setting.
		do
			if attached settings.item (s_msil_generation_type) as l_found_item then
				check l_found_item.is_case_insensitive_equal_general ("exe") or l_found_item.is_case_insensitive_equal_general ("dll") end
				Result := l_found_item
			else
				Result := "exe"
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_key_file_name: STRING_32
			-- Value for the msil_key_file_name setting.
		do
			if attached settings.item (s_msil_key_file_name) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_msil_use_optimized_precompile: BOOLEAN
			-- Value for the msil_use_optimized_precompile setting.
		do
			Result := setting_boolean (s_msil_use_optimized_precompile)
		end

	setting_platform: STRING_32
			-- Value for the platform setting.
		do
			if attached settings.item (s_platform) as l_found_item then
				check get_platform (l_found_item) /= 0 end
				Result := l_found_item.as_lower
			else
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_external_runtime: STRING_32
			-- Value for the external_runtime setting.
		do
			if attached settings.item (s_external_runtime) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_shared_library_definition: STRING_32
			-- Value for the shared_library_definition setting.
		do
			if attached settings.item (s_shared_library_definition) as l_item then
				Result := l_item
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	setting_total_order_on_reals: BOOLEAN
			-- Value for the total_order_on_reals setting.
		do
			Result := setting_boolean (s_total_order_on_reals)
		end

	setting_use_cluster_name_as_namespace: BOOLEAN
			-- Value for the use_cluster_name_as_namespace setting.
		do
			Result := setting_boolean (s_use_cluster_name_as_namespace)
		end

	setting_use_all_cluster_name_as_namespace: BOOLEAN
			-- Value for the use_all_cluster_name_as_namespace setting.
		do
			Result := setting_boolean (s_use_all_cluster_name_as_namespace)
		end

	setting_automatic_backup: BOOLEAN
			-- Value for the automatic_backup setting.
		do
			Result := setting_boolean (s_automatic_backup)
		end

feature -- Access: concurrency setting

	setting_concurrency: CONF_VALUE_CHOICE
			-- Value of the "concurrency" setting from the immediate data.
		do
			Result := immediate_setting_concurrency
		ensure
			result_attached: attached Result
		end

	concurrency_mode: like {CONF_STATE}.concurrency
			-- Concurrency mode corresponding to `setting_concurrency'.
		do
			inspect setting_concurrency.index
			when setting_concurrency_index_none   then Result := concurrency_none
			when setting_concurrency_index_thread then Result := concurrency_multithreaded
			when setting_concurrency_index_scoop  then Result := concurrency_scoop
			end
		ensure
			definition:
				setting_concurrency.index = setting_concurrency_index_none   and then Result = concurrency_none or else
				setting_concurrency.index = setting_concurrency_index_thread and then Result = concurrency_multithreaded or else
				setting_concurrency.index = setting_concurrency_index_scoop  and then Result = concurrency_scoop
		end

	setting_concurrency_index_none: NATURAL_8 = 1
			-- Option index for no concurrency

	setting_concurrency_index_thread: NATURAL_8 = 2
			-- Option index for thread-based concurrency

	setting_concurrency_index_scoop: NATURAL_8 = 3
			-- Option index for SCOOP concurrency

	immediate_setting_concurrency: like setting_concurrency
			-- Value of the "concurrency" setting specified for this target.

	set_immediate_setting_concurrency (v: like setting_concurrency)
			-- Set value of the "concurrency" setting specified for this target.
			-- Inherited setting (if any) overrides this one.
		require
			v_attached: attached v
		do
			immediate_setting_concurrency := v
		ensure
			immediate_setting_concurrency_set: immediate_setting_concurrency = v
		end

feature {NONE} -- Access: concurrency setting

	setting_concurrency_name: ARRAY [READABLE_STRING_32]
			-- Available values for `setting_concurrency'.
		once
			Result := <<concurrency_none_name.as_string_32, concurrency_multithreaded_name.as_string_32, concurrency_scoop_name.as_string_32>>
		ensure
			result_attached: Result /= Void
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_options (an_option: like options)
			-- Set `an_option'.
		require
			an_option_not_void: an_option /= Void
		do
			internal_options := an_option
		ensure
			option_set: internal_options = an_option
		end

	set_settings (a_settings: like settings)
			-- Set `a_settings'.
		require
			a_settings_not_void: a_settings /= Void
		do
			internal_settings := a_settings
		ensure
			settings_set: internal_settings = a_settings
		end

	add_setting (a_name, a_value: STRING_32)
			-- Add a new setting.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_value_not_void: a_value /= Void
		do
			internal_settings.force (a_value, a_name)
		ensure
			added: internal_settings.item (a_name) = a_value
		end

	update_setting (a_name, a_value: STRING_32)
			-- Update/add/remove a setting.
		require
			a_name_valid: a_name /= Void and then valid_setting (a_name)
		do
			if a_value = Void or else a_value.is_empty then
				internal_settings.remove (a_name)
			else
				add_setting (a_name, a_value)
			end
		ensure
			updated_removed: a_value = Void or else a_value.is_empty implies not internal_settings.has (a_name)
			updated_added_set: a_value /= Void and then not a_value.is_empty implies internal_settings.item (a_name) = a_value
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation, attributes that are stored to the configuration file

	internal_options: detachable like options
			-- Options (Debuglevel, assertions, ...) of this target itself.

	changeable_internal_options: like options
			-- A possibility to change settings without knowing if we have some options already set.
		do
			Result := internal_options
			if not attached Result then
				create Result
				internal_options := Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	internal_settings: like settings
			-- Settings of this target itself.

invariant
	internal_settings_attached: attached internal_settings
	internal_setting_concurrency_attached: attached immediate_setting_concurrency

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

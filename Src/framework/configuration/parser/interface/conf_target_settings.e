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
		end

feature -- Access

	options: CONF_TARGET_OPTION
			-- Options (Debuglevel, assertions, ...)
		do
			if attached internal_options as l_internal_options then
				Result := l_internal_options
			else
				create Result
			end
		end

	settings: STRING_TABLE [READABLE_STRING_32]
			-- Settings.
		do
			Result := internal_settings
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access: settings

	setting_boolean (a_name: STRING): BOOLEAN
			-- Get value of boolean setting with `a_name'.
		require
			a_name_valid: is_boolean_setting_known (a_name)
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

	setting_absent_explicit_assertion: BOOLEAN
			-- Value of the setting "absent_explicit_assertion".
		do
			Result := setting_boolean (s_absent_explicit_assertion)
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

	setting_automatic_backup: BOOLEAN
			-- Value for the automatic_backup setting.
		do
			Result := setting_boolean (s_automatic_backup)
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
				Result := {STRING_32} "exe"
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
				Result := {STRING_32} ""
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

feature -- Modification

	force (other: CONF_TARGET_SETTINGS)
			-- Update current settings so that anything defined in `other' takes precedence.
		local
			new_options: like options
		do
			internal_settings.merge (other.settings)
			new_options := other.options.twin
			new_options.merge (options)
			internal_options := new_options
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

	merge_options (an_option: like options)
			-- If `internal_options` is already set, merge `an_option` with it,
			-- otherwise set the options to `an_option`.
		require
			an_option_not_void: an_option /= Void
		do
			if attached internal_options as l_opts then
				l_opts.merge (an_option)
			else
				internal_options := an_option
			end
		ensure
			option_set: internal_options /= Void
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

	add_setting (a_name, a_value: READABLE_STRING_32)
			-- Add a new setting.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_value_not_void: a_value /= Void
		do
			internal_settings.force (a_value, a_name)
		ensure
			added: internal_settings.item (a_name) = a_value
		end

	add_capability (a_name, a_value: READABLE_STRING_32)
			-- Add a new setting.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_value_not_void: a_value /= Void
		local
			l_opts: like internal_options
		do
			l_opts := internal_options
			if a_name.is_case_insensitive_equal_general (s_concurrency) then
				if l_opts = Void then
					create l_opts
					internal_options := l_opts
				end
				l_opts.concurrency.put (a_value)
			elseif a_name.is_case_insensitive_equal_general (s_void_safety) then
				if l_opts = Void then
					create l_opts
					internal_options := l_opts
				end
				l_opts.void_safety.put (a_value)
			end
		end

	update_setting (a_name: READABLE_STRING_32; a_value: detachable READABLE_STRING_32)
			-- Update/add/remove a setting.
		require
			a_name_valid: a_name /= Void and then is_setting_known (a_name)
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

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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

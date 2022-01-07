note
	description: "A parser that processes strings to retrieve configutation data."
	date: "$Date$"
	revision: "$Revision$"

class CONF_TARGET_SETTINGS_PARSER

inherit
	CONF_KEY_VALUE_PARSER [CONF_TARGET_SETTINGS]
		rename
			keys as available_configuration_option_names,
			parse as parse_target_settings
		end
	CONF_ACCESS
	CONF_VALIDITY

create
	make

feature {NONE} -- Creation

	make (available_clr_runtimes: like clr_runtimes)
			-- Initialize a new parser object with an agent `clr_runtimes' that can compute available CLR runtimes.
		do
			clr_runtimes := available_clr_runtimes
		end

feature -- Access

	clr_runtimes: FUNCTION [ITERABLE [READABLE_STRING_32]]
			-- A function that can compute available CLR run-times.

feature -- Basic operations

	parse_value (input: READABLE_STRING_32; delimiter_index: INTEGER; option: READABLE_STRING_32; settings: CONF_TARGET_SETTINGS)
			-- <Precursor>
		local
			value: READABLE_STRING_32
			valid_values: ITERABLE [READABLE_STRING_GENERAL]
			is_value_checked: BOOLEAN
			is_value_case_sensitive: BOOLEAN
			l_is_capability: BOOLEAN
		do
			l_is_capability := False
			is_value_case_sensitive := True
			if option.same_string_general (s_concurrency) then
				l_is_capability := True
				valid_values := concurrency_names
				is_value_case_sensitive := False
			elseif option.same_string_general (s_void_safety) then
				l_is_capability := True
				valid_values := void_safety_names
				is_value_case_sensitive := False
			elseif boolean_settings.has_key (option) then
				valid_values := configuration_boolean_values
				is_value_case_sensitive := False
			elseif option.same_string_general (s_dead_code_removal) then
				valid_values := dead_code_names
				is_value_case_sensitive := False
			elseif option.same_string_general (s_inlining_size) then
				value := inlining_size_value (input, delimiter_index + 1, input.count)
				valid_values := <<{STRING_32} "0 - 100">>
				is_value_checked := True
			elseif option.same_string_general (s_manifest_array_type) then
				valid_values := array_override_names
				is_value_case_sensitive := False
			elseif option.same_string_general (s_msil_classes_per_module) then
				value := msil_classes_per_module_value (input, delimiter_index + 1, input.count)
				valid_values := <<{STRING_32} "1 - 65535">>
				is_value_checked := True
			elseif option.same_string_general (s_msil_clr_version) then
				valid_values := clr_runtimes.item
			elseif option.same_string_general (s_msil_generation_type) then
				valid_values := msil_generation_type_values
				value := msil_generation_type_value (input, delimiter_index + 1, input.count)
				is_value_checked := True
			elseif option.same_string_general (s_platform) then
				valid_values := platform_names
				is_value_case_sensitive := False
			end
			if is_value_checked then
					-- There is nothing to be done.
					check attached valid_values end
			elseif attached valid_values then
					-- Check if specified value is a valid constant.
				value := value_from_list (valid_values, input, delimiter_index, is_value_case_sensitive)
			else
					-- The setting value is an arbitrary string.
				value := input.substring (delimiter_index + 1, input.count)
					check attached value end
			end
				check attached value or attached valid_values end
			if not attached value then
					-- The option value is invalid.
					check attached valid_values end
					-- The compiler is not smart enough to verify that `valid_values` is attached.
				error := conf_interface_names.e_parse_string_invalid_value
					(option, input.substring (delimiter_index + 1, input.count), if attached valid_values then valid_values else <<>> end)
			elseif l_is_capability then
				settings.add_capability (option, value)
			elseif option.same_string_general (s_dead_code_removal) then
				settings.changeable_internal_options.dead_code.put (value)
			elseif option.same_string_general (s_manifest_array_type) then
				settings.changeable_internal_options.array_override.put (value)
			else
				settings.add_setting (option, value)
			end
		end

feature {NONE} -- Search

	available_configuration_option_names: ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Available option names.
		do
			create Result.make (20)
			Result.compare_objects
			across
				boolean_options as ic
			loop
				Result.force (ic)
			end
			across
				known_settings as s
			loop
				if not Result.has (s) then
					Result.force (s)
				end
			end
			across
				known_capabilities as s
			loop
				if not Result.has (s) then
					Result.force (s)
				end
			end
			;(create {QUICK_SORTER [like available_configuration_option_names.item]}.make
				(create {STRING_COMPARATOR}.make)).sort (Result)
		end

;note
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

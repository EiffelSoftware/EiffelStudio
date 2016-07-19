note
	description: "A parser that processes strings to retrieve configutation data."
	date: "$Date$"
	revision: "$Revision$"

class CONF_STRING_PARSER

inherit
	CONF_ACCESS
	CONF_INTERFACE_CONSTANTS
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

	parse_target_settings (input: READABLE_STRING_32; settings: CONF_TARGET_SETTINGS)
			-- Update `settings' from `input' and set `error' accordingly.
		local
			delimiter_index: INTEGER
			option: READABLE_STRING_32
			value: READABLE_STRING_32
			valid_values: ITERABLE [READABLE_STRING_GENERAL]
			is_value_checked: BOOLEAN
		do
				-- Reset previous error message (if any).
			error := Void
				-- Retrieve an option name and its value.
			delimiter_index := input.index_of (delimiter, 1)
			if delimiter_index = 0 or else delimiter_index = input.count then
					-- The option value is missing, but check option name first to report if it is correct or not.
				if delimiter_index = 0 then
					delimiter_index := input.count + 1
				end
				option := setting_name (input, 1, delimiter_index - 1)
				if attached option then
						-- The option name is correct, but the value is missing.
					error := conf_interface_names.e_parse_string_missing_value (option)
				else
						-- The option name is not found.
					error := conf_interface_names.e_parse_string_unknown_name (input.head (delimiter_index - 1))
				end
			elseif delimiter_index = 1 then
				error := conf_interface_names.e_parse_string_missing_name (input)
			else
				option := setting_name (input, 1, delimiter_index - 1)
				if attached option then
					if boolean_settings.has_key (option) then
						valid_values := configuration_boolean_values
					elseif option.same_string_general (s_concurrency) then
						valid_values := concurrency_names
					elseif option.same_string_general (s_platform) then
						valid_values := platform_names
					elseif option.same_string_general (s_msil_generation_type) then
						valid_values := msil_generation_type_values
						value := msil_generation_type_value (input, delimiter_index + 1, input.count)
						is_value_checked := True
					elseif option.same_string_general (s_msil_clr_version) then
						valid_values := clr_runtimes.item
					elseif option.same_string_general (s_msil_classes_per_module) then
						value := msil_classes_per_module_value (input, delimiter_index + 1, input.count)
						valid_values := <<{STRING_32} "1 - 65535">>
						is_value_checked := True
					elseif option.same_string_general (s_inlining_size) then
						value := inlining_size_value (input, delimiter_index + 1, input.count)
						valid_values := <<{STRING_32} "0 - 100">>
						is_value_checked := True
					end
					if is_value_checked then
							-- There is nothing to be done.
					elseif attached valid_values then
							-- Check if value is a valid constant.
						value := value_from_list (valid_values, input, delimiter_index)
					else
							-- The setting value is an arbitrary string.
						value := input.substring (delimiter_index + 1, input.count)
					end
					if attached value then
							-- This is a valid setting, add it.
						settings.add_setting (option, value)
					else
							-- The option value is invalid.
						error := conf_interface_names.e_parse_string_invalid_value
							(input.head (delimiter_index - 1), input.substring (delimiter_index + 1, input.count), valid_values)
					end
				else
						-- The option name is not found.
					error := conf_interface_names.e_parse_string_unknown_name (input.head (delimiter_index - 1))
				end
			end
		end

feature -- Status report

	error: detachable READABLE_STRING_32
			-- An error message if last parsing has completed with an error.
			-- `Void' otherwise.

feature {NONE} -- Access

	delimiter: CHARACTER_32 = ':'
			-- A delimiter between an option name and an option value.

feature {NONE} -- Search

	value_from_list (list: ITERABLE [READABLE_STRING_GENERAL]; input: READABLE_STRING_32; delimiter_index: INTEGER): detachable READABLE_STRING_32
			-- A value specified in string `input' after value delimited index `delimited_index' that matches one of values specified in `list' (if any).
		require
			valid_delimter_index: input.valid_index (delimiter_index) and input.valid_index (delimiter_index + 1)
		local
			n: INTEGER
		do
				-- Value substring length.
			n := input.count - delimiter_index
			across
				list as c
			loop
				if
					c.item.count = n and then
					c.item.same_characters (input, delimiter_index + 1, input.count, 1)
				then
					Result := c.item.as_string_32
				end
			end
		end

;note
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

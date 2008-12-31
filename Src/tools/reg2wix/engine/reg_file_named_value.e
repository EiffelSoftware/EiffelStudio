note
	description: "[
		Represents a Windows registry key name/value pair.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	REG_FILE_NAMED_VALUE

inherit
	REG_FILE_VALUE
		redefine
			has_value,
			is_default,
			is_valid_value,
			process_ini_content
		end

create
	make

feature -- Access

	name: STRING
			-- Value index name

	value_type_code: NATURAL
			-- Value type code

feature {NONE} -- Access

	supported_type_codes: HASH_TABLE [NATURAL, STRING]
			-- Supportted type codes
		once
			create Result.make (2)
			Result.put (tc_string, tcs_string) -- Dummy entry
			Result.put (tc_dword, tcs_dword)
		ensure
			result_attached: Result /= Void
			result_compares_objects: Result.object_comparison
		end

feature -- Status report

	is_default: BOOLEAN
			-- Indicate if named value is a default value
		do
			Result := False
		end

	has_value: BOOLEAN
			-- Determines if a value is set
		do
			if value_type_code = tc_string then
				Result := value /= Void and then not value.is_empty
			else
				Result := True
			end
		end

	is_supported: BOOLEAN
			-- Indicates if type is supported
		do
			Result := value_type_code /= tc_unsupported
		end

feature -- Query

	is_valid_value (a_value: like value): BOOLEAN
			-- Determines if `a_value' is a valid value.
		do
			Result := a_value /= Void and then not a_value.is_empty
		end

feature {NONE} -- Query

	type_code_for_string (a_tcs: STRING): NATURAL
			-- Retrieves a type code for string `a_tcs'
		require
			a_tcs_attached: a_tcs /= Void
			not_a_tcs_is_empty: not a_tcs.is_empty
		do
			if supported_type_codes.has (a_tcs) then
				Result := supported_type_codes[a_tcs]
			else
					-- Not all type codes are supported yet, see `supported_type_codes'
				Result := tc_unsupported
			end
		end

feature {NONE} -- Basic operations

	split_value (a_value: STRING): TUPLE [value: STRING; type_code: NATURAL]
			-- Splits value `a_value' into a corresponding value and type code.
		require
			a_value_attached: a_value /= Void
			not_a_value_is_empty: not a_value.is_empty
		local
			l_pos: INTEGER
			l_value: STRING
			l_tcs: STRING
			l_tc: NATURAL
		do
			l_tc := tc_string

			if a_value.item (1) /= '"' then
					-- Not a string
				l_pos := a_value.index_of (':', 1)
			end

			if l_pos > 1 then
				l_tcs := a_value.substring (1, l_pos - 1)
				l_tc := type_code_for_string (l_tcs)
				if l_tc = tc_unsupported then
					l_value := a_value
				else
					if l_pos < a_value.count then
						l_value := a_value.substring (l_pos + 1, a_value.count)
					end
				end

			else
				l_value := a_value
			end

			if l_value /= Void and l_tc = tc_string then
					-- Remove string quotes
				l_value := prune_quotes (l_value)
			end

			Result := [l_value, l_tc]
		ensure
			not_result_value_is_empty: Result.value /= Void implies not Result.value.is_empty
		end

feature {NONE} -- Process

	process_ini_content (a_property: INI_PROPERTY)
			-- Processes the content of an INI property `a_property'
		local
			l_data: like split_value
		do
			l_data := split_value (a_property.value)

			name := prune_quotes (a_property.name)
			value := unescape_value (l_data.value)
			value_type_code := l_data.type_code
		end

feature -- Constants

	tc_unsupported: NATURAL = 0
	tc_string: NATURAL = 1
	tc_binary: NATURAL = 2
	tc_dword: NATURAL = 3
	tc_multi_string: NATURAL = 4
	tc_expandable_string: NATURAL = 5
			-- Type codes

	tcs_string: STRING = "string"
	tcs_binary: STRING = "hex"
	tcs_dword: STRING = "dword"
	tcs_multi_string: STRING = "hex(7)"
	tcs_expandable_string: STRING = "hex(2)"
			-- Type code strings

invariant
	name_not_empty: name /= Void
	not_name_is_empty: not name.is_empty
	value_attached: value /= Void

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

note
	description: "A parser to read key-value pairs."
	date: "$Date$"
	revision: "$Revision$"

deferred class CONF_KEY_VALUE_PARSER [G]

inherit
	CONF_INTERFACE_CONSTANTS
	CONF_UTILITY

feature {NONE} -- Access

	keys: ITERABLE [READABLE_STRING_GENERAL]
			-- The known names of pairs.
		deferred
		end

	delimiter: CHARACTER_32 = ':'
			-- A delimiter between a key and a value.

feature -- Basic operations

	parse (input: READABLE_STRING_32; storage: G)
			-- Update `storage` from `input` and set `error` accordingly.
		local
			delimiter_index: INTEGER
		do
				-- Reset previous error message (if any).
			error := Void
				-- Retrieve a key and an associated value.
			delimiter_index := input.index_of (delimiter, 1)
			if delimiter_index = 0 then
				delimiter_index := input.count + 1
			end
			if delimiter_index = 1 then
					-- The key is missing.
				error := conf_interface_names.e_parse_string_missing_name (input)
			elseif not attached key_name (input, 1, delimiter_index - 1, keys) as key then
					-- The key is not found.
				error := conf_interface_names.e_parse_string_unknown_name (input.head (delimiter_index - 1), keys)
			elseif delimiter_index >= input.count then
					-- The value is missing.
				error := conf_interface_names.e_parse_string_missing_value (key)
			else
				parse_value (input, delimiter_index, key, storage)
			end
		end

feature {NONE} -- Basic operations

	parse_value (input: READABLE_STRING_32; delimiter_index: INTEGER; key: READABLE_STRING_32; storage: G)
			-- Update `storage` from `input` with value starting at `delimiter_index` for key `key` and set `error' accordingly.
		require
			not attached error
			not input.is_empty
			delimiter_index > 1
			delimiter_index < input.count
			not key.is_empty
		deferred
		end

feature -- Status report

	error: detachable READABLE_STRING_32
			-- An error message if last parsing has completed with an error.
			-- `Void' otherwise.

feature {NONE} -- Search

	value_from_list (list: ITERABLE [READABLE_STRING_GENERAL]; input: READABLE_STRING_32; delimiter_index: INTEGER; is_value_case_sensitive: BOOLEAN): detachable READABLE_STRING_32
			-- A value specified in string `input` after value delimited index `delimited_index` that matches one of the values specified in `list` (if any).
			-- If `is_value_case_sensitive` is False, compare the value caseless, otherwise compare strictly.
		require
			valid_delimiter_index: input.valid_index (delimiter_index) and input.valid_index (delimiter_index + 1)
		local
			l_key_count, l_input_count: INTEGER
		do
				-- Value substring length.
			l_input_count := input.count
			l_key_count := l_input_count - delimiter_index
			across
				list as c
			until
				attached Result
			loop
				if
					c.count = l_key_count and then
					if is_value_case_sensitive then
						c.same_characters (input, delimiter_index + 1, l_input_count, 1)
					else
						c.same_caseless_characters (input, delimiter_index + 1, l_input_count, 1)
					end
				then
					Result := c.as_string_32
				end
			end
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

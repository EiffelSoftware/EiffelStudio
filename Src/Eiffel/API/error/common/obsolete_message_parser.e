note
	description: "Obsolete message parser."

class OBSOLETE_MESSAGE_PARSER

feature -- Date evaluation

	date (m: READABLE_STRING_8): TUPLE [message: READABLE_STRING_8; date: DATE; is_specified: BOOLEAN]
			-- Date specified in the message `m` if any.
			-- If a date is extracted to `Result.date`, the message without date information is returned in `Result.message`, and `Result.is_specified` is set to `True`.
			-- If no date is extracted, the original message is returned in `Result.message`, `Result.date` is set to the default date, and `Result.is_specified` is set to `False`.
		local
			i, j: like {STRING}.count
			c: CHARACTER
			date_string: READABLE_STRING_8
		do
				-- Look for a trailing ']'.
			from
				i := m.count
			until
				i <= 0 or else m [i] = ']'
			loop
				c := m [i]
				if c.is_space or else c.is_punctuation or else not c.is_printable then
						-- Advance to the next character.
					i := i - 1
				else
						-- Stop iteration.
					i := 0
				end
			end
			from
				j := i
			until
				j <= 1 or else attached date_string
			loop
				j := j - 1
				if m [j] = '[' then
					date_string := m.substring (j + 1, i - 1)
				end
			end
			if attached date_string and then {DATE_VALIDITY_CHECKER}.date_valid (date_string, date_code) then
					-- Remove date string from the message.
				from
					j := j - 1
				until
					j <= 1 or else not m [j].is_space
				loop
					j := j - 1
				end
				Result := [m.substring (1, j), create {DATE}.make_from_string (date_string, date_code), True]
			else
					-- Use default values.
				Result := [m, default_date, False]
			end
		ensure
			class
		end

feature -- Output

	default_date_string: READABLE_STRING_8
			-- A string representing default date of an obsolete message when the date stamp is not specified.
		do
			Result := default_date.formatted_out (date_code)
		ensure
			class
		end

feature {NONE} -- Date evaluation

	default_date: DATE
			-- Date to be used when none is specified explicitly.
		once
				-- A safe default corresponds to the release of the compiler with checks for obsolete messages.
			create Result.make (2017, 7, 1)
		ensure
			class
		end

	date_code: STRING = "yyyy-mm-dd"
			-- Expected string code.

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

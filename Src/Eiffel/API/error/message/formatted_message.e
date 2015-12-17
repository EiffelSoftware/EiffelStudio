note
	description: "Optionally parameterized messages that are subject to translation."

class
	FORMATTED_MESSAGE

feature -- Format: elements

	element (data: PROCEDURE [TEXT_FORMATTER]): like formattable
			-- Agent to add a given `data' to output using a formatter.
		do
			Result := agent (s: FORMAT_SPECIFICATION; v: PROCEDURE [TEXT_FORMATTER]; t: TEXT_FORMATTER)
				do
					v (t)
				end (?, data, ?)
		end

feature -- Format: lists

	list (data: like listable): like formattable
			-- Agent to add a given list `data' to output using a formatter.
		do
			Result := message_formatter.list (add_list, data)
		end

feature {NONE} -- Format: lists

	frozen listable: ITERABLE [PROCEDURE [TEXT_FORMATTER]]
			-- An anchor for a type that can be used to create a formatted list using `list'.
		do
		ensure
			is_used: False
		end

	add_list: PROCEDURE [detachable FORMAT_SPECIFICATION, TEXT_FORMATTER, like listable]
			-- Agent to add an arbitrary list of items to output using a formatter.
		do
			Result := agent (f: detachable FORMAT_SPECIFICATION; t: TEXT_FORMATTER; i: like listable)
				local
					delimiter: detachable READABLE_STRING_GENERAL
				do
					across
						i as c
					loop
						if attached delimiter then
								-- This is not a first iteration, add `delimiter' before item.
							t.add (delimiter)
						elseif attached f then
								-- First iteration, set delimiter for subsequent iterations from the format specification.
							delimiter := f.item
						else
								-- First iteration, set delimiter for subsequent iterations to the default  one.
							delimiter := {STRING_32} ", "
						end
						c.item (t)
					end
				end
		end

feature -- Format: message parsing

	format (formatter: TEXT_FORMATTER; message: READABLE_STRING_GENERAL; arguments: ITERABLE [like formattable])
			-- Format `message' replacing placeholders with elements from `arguments' using `formatter'.
			-- See `{COMPOSITE_FORMATTER}.format'.
		do
			message_formatter.format (formatter, message, arguments)
		end

feature {NONE} -- Format: message parsing

	formattable: PROCEDURE [FORMAT_SPECIFICATION, TEXT_FORMATTER]
			-- An anchor for a type of message parameters accepted by `format'.
		do
		ensure
			is_used: False
		end

	message_formatter: COMPOSITE_FORMATTER [TEXT_FORMATTER]
			-- Formatter of the fix message(s).
		once
				-- TODO: Add features to handle substrings to TEXT_FORMATTER.
			create Result.make (
				agent (t: TEXT_FORMATTER; s: READABLE_STRING_GENERAL; start_index, end_index: INTEGER_32)
						-- Add a substring of `s' with valid index positions between `start_index' and `end_index' to `t'.
					local
						i, j: INTEGER
					do
						from
							i := start_index
						until
							i > end_index
						loop
								-- Look for a new line.
							from
								j := i
							until
								j > end_index or else s [j] = {CHARACTER_32} '%N'
							loop
								j := j + 1
							end
								-- Add all text before a new line or the end.
							t.add (s.substring (i, j - 1))
							if j <= end_index then
									-- There is a new line.
								t.add_new_line
							end
							i := j + 1
						end
					end)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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

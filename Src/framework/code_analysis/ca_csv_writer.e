note
	description: "Writes to a CSV file."
	author: "Stefan Zurfluh", "Eiffel Software", "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CSV_WRITER

create
	make

feature {NONE} -- Initialization

	make (a_file_name: PATH)
			-- Initializate writer to write to the file of name `a_file_name'.
		do
			create output_file.make_with_path (a_file_name)
			output_file.open_write
		ensure
			is_open: output_file.is_open_write
		end

feature -- Modification

	put_strings (vs: ITERABLE [READABLE_STRING_32])
			-- Write string fields `vs` to the current line.
			-- (Note: the new line is not added.)
		do
			across
				vs as v
			loop
				put_string (v)
			end
		end

	put_string (v: READABLE_STRING_32)
			-- Write a string field `v` to the current line.
		require
			is_open: is_file_open
		local
			u: UTF_CONVERTER
			writable_output: STRING_32
			i, n: like {READABLE_STRING_32}.count
			is_unicode: BOOLEAN
			c: CHARACTER_32
		do
			put_separator
			from
				n := v.count
			until
				i >= n
			loop
				i := i + 1
				c := v [i]
				inspect c
				when '%N', '"', separator then
					create writable_output.make_from_string (v)
					if is_unicode then
							-- All properties are detected.
							-- Exit from the loop.
						i := n
					end
				else
					if c >= '%/128/' then
						is_unicode := True
						if attached writable_output then
								-- All properties are detected.
								-- Exit from the loop.
							i := n
						end
					end
				end
			end
			if attached writable_output then
					-- Enclose field in quotes.
				output_file.put_character ('"')
					-- Replace new lines with spaces.
				writable_output.replace_substring_all ({STRING_32} "%N", {STRING_32} " ")
					-- Replace quotes with double quotes.
				writable_output.replace_substring_all ({STRING_32} "%"", {STRING_32} "%"%"")
				output_file.put_string (u.string_32_to_utf_8_string_8 (writable_output))
				output_file.put_character ('"')
			else
				output_file.put_string (u.string_32_to_utf_8_string_8 (v))
			end
		end

	put_integer_32 (i: INTEGER_32)
			-- Write an integer field `v` to the current line.
		do
			put_separator
			output_file.put_integer_32 (i)
		end

	put_empty
			-- Write an empty field.
		do
			put_separator
		end

	put_new_line
			-- Finish current line and advance to the new one.
		require
			is_open: is_file_open
		do
			output_file.put_new_line
			is_separator_required := False
		end

	add_line (a_line: READABLE_STRING_32)
			-- Writes `a_line' to the CSV file. A new line will be
			-- added automatically afterwards.
		require
			is_open: is_file_open
			no_new_lines: not a_line.has ('%N')
		local
			u: UTF_CONVERTER
		do
			output_file.put_string (u.string_32_to_utf_8_string_8 (a_line))
			output_file.put_new_line
		end

	close_file
			-- Closes the log file and forbids any further writing to it.
		require
			is_open: is_file_open
		do
			output_file.close
		ensure
			is_closed: output_file.is_closed
		end

feature -- Status report

	is_file_open: BOOLEAN
			-- Is file open?
		do
			Result := output_file.is_open_write
		end

feature {NONE} -- Status report

	is_separator_required: BOOLEAN
			-- Is separator required?

feature {NONE} -- Modification

	put_separator
			-- Put separator before a field if required.
		do
			if is_separator_required then
				output_file.put_character (separator.to_character_8)
			end
			is_separator_required := True
		end

feature {NONE} -- Storage

	separator: CHARACTER_32 = ','
			-- Field separator.

	output_file: PLAIN_TEXT_FILE
			-- The file that is written to.

invariant
	separator_is_ascii: separator <= '%/127/'

;note
	copyright:	"Copyright (c) 2014-2023, Eiffel Software"
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

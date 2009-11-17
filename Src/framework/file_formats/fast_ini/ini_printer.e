note
	description: "[
		Simpler writer for generating INI files on a medium ({IO_MEDIUM}) object.
		
		Note: Be sure to call `flush' at the end of writing to write any buffer content.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_PRINTER

create
	make

feature {NONE} -- Initialization

	make (a_medium: like medium)
			-- Initializes the write with a medium to write the generated contents to.
			--
			-- `a_medium': Medium to write generated contents to.
		require
			a_medium_attached: attached a_medium
			a_medium_is_open_write: attached {CONSOLE} a_medium or else a_medium.is_open_write
		do
			medium := a_medium
		ensure
			medium_set: medium = a_medium
		end

feature -- Access

	medium: IO_MEDIUM
			-- Medium to write generated contents to.

feature {NONE} -- Access

	buffer: STRING
			-- Buffered content
		attribute
			create Result.make (100)
		end

feature -- Status report

	is_writable: BOOLEAN
			-- Indicates if the medium can be written to.
		do
			Result := attached {CONSOLE} medium or else medium.is_open_write
		ensure
			is_console_or_writable: Result implies (attached {CONSOLE} medium or else medium.is_open_write)
		end

	is_valid_section_name (a_name: READABLE_STRING_8): BOOLEAN
			-- Determines if a given section name is valid for an INI file.
			--
			-- `a_name': Section name to validate.
			-- `Result': True of the section name is valid; False otherwise.
		require
			a_name_attached: attached a_name
		local
			c: CHARACTER
			i, i_count: INTEGER
		do
			Result := a_name.count <= {INI_CONSTANTS}.max_name_length
			if Result then
				from
					i := 1
					i_count := a_name.count
				until
					i > i_count or else not Result
				loop
					c := a_name[i]
					Result := c.is_printable and c /= {INI_CONSTANTS}.section_start and c /= {INI_CONSTANTS}.section_end
					i := i + 1
				end
			end

		end

	is_valid_property_name (a_name: READABLE_STRING_8): BOOLEAN
			-- Determines if a given property name is valid for an INI file.
			--
			-- `a_name': Property name to validate.
			-- `Result': True of the property name is valid; False otherwise.
		require
			a_name_attached: attached a_name
		local
			c: CHARACTER
			i, i_count: INTEGER
		do
			Result := a_name.count <= {INI_CONSTANTS}.max_name_length
			if Result then
				from
					i := 1
					i_count := a_name.count
				until
					i > i_count or else not Result
				loop
					c := a_name[i]
					Result := c.is_printable and c /= {INI_CONSTANTS}.property_value_qualifier
					i := i + 1
				end
			end
		end

feature {NONE} -- Status report

	is_spacing_required: BOOLEAN
			-- Indicates if any output has been produced already.
			--| Used for formatting.

feature -- Basic operations: Output

	put_new_line
			-- Puts an new line.
		require
			is_writable: is_writable
		do
			medium.new_line
			is_spacing_required := False
		end

	put_comment (a_comment: READABLE_STRING_8)
			-- Puts a new comment on the current line.
		require
			is_writable: is_writable
			a_comment_attached: attached a_comment
		local
			l_buffer: like buffer
			l_spacing: BOOLEAN
		do
			l_spacing := is_spacing_required

			l_buffer := buffer
			l_buffer.append_character ({INI_CONSTANTS}.comment_pound)
			if not a_comment.is_empty then
				l_buffer.append_character (' ')
				l_buffer.append_string_general (a_comment)
			end
			l_buffer.append_character ('%N')

			is_spacing_required := l_spacing
		ensure
			is_spacing_required_unchanged: is_spacing_required = old is_spacing_required
		end

	put_section (a_name: READABLE_STRING_8)
			-- Puts a new INI section (e.g. [`a_name']) on the current line.
			--
			-- `a_name': Name of the section to write out.
		require
			is_writable: is_writable
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			a_name_is_valid_section_name: is_valid_section_name (a_name)
		local
			l_medium: like medium
		do
			l_medium := medium
			if is_spacing_required then
				put_new_line
			end
			flush_buffer

			l_medium.put_character ({INI_CONSTANTS}.section_start)
			l_medium.put_string (a_name.as_string_8)
			l_medium.put_character ({INI_CONSTANTS}.section_end)
			put_new_line

			is_spacing_required := True
		ensure
			not_is_spacing_required: not is_spacing_required
		end

	put_property (a_name: READABLE_STRING_8; a_value: detachable READABLE_STRING_8)
			-- Puts a new INI property on the current line.
			-- Note: No section is required to put a property in an INI file.
			--
			-- `a_name': Name of the property to write out.
			-- `a_value': An optional value to associated with the property.
		require
			is_writable: is_writable
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			a_name_is_valid_property_name: is_valid_property_name (a_name)
		local
			l_medium: like medium
		do
			flush_buffer

			l_medium := medium
			l_medium.put_string (a_name.as_string_8)
			if attached a_value and then not a_value.is_empty then
				l_medium.put_character ({INI_CONSTANTS}.property_value_qualifier)
				l_medium.put_string (a_value.as_string_8)
			end
			put_new_line

			is_spacing_required := True
		ensure
			is_spacing_required: is_spacing_required
		end

	flush
			-- Writes out any buffered content.
		require
			is_writable: is_writable
		do
			flush_buffer
			if attached {FILE} medium as l_file then
				l_file.flush
			end
		ensure
			buffer_is_empty: buffer.is_empty
		end

feature {NONE} -- Basic operations: Output

	flush_buffer
			-- Writes out the buffered content only.
			-- Note: Does not flush any disk content, for that use `flush'.
		require
			is_writable: is_writable
		do
			medium.put_string (buffer)
			buffer.wipe_out
		ensure
			buffer_is_empty: buffer.is_empty
		end

invariant
	medium_attached: attached medium
	is_writable: is_writable

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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

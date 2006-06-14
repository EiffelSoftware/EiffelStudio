indexing
	description: "Class to write documents to a file or a text buffer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_DOCUMENT_WRITER

feature -- Basic Operations

	write_to_file (a_document: INI_DOCUMENT; a_file: PLAIN_TEXT_FILE) is
			-- Writes INI document `a_document' to `a_file'.
		require
			a_document_attached: a_document /= Void
			a_file_attached: a_file /= Void
			a_file_opened_for_writing: a_file.is_open_write
			a_file_writable: a_file.writable
		local
			retried: BOOLEAN
		do
			if not retried then
				write_properties (a_document.default_properties, a_file)
				write_properties (a_document.named_properties, a_file)
				write_literals (a_document.literals, a_file)
				write_sections (a_document.sections, a_file)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Basic Operations

	write_literals (a_literals: LIST [INI_LITERAL]; a_file: PLAIN_TEXT_FILE) is
			-- Writes INI literals `a' to `a_file'.
		require
			a_literals_attached: a_literals /= Void
			a_file_attached: a_file /= Void
			a_file_opened_for_writing: a_file.is_open_write
			a_file_writable: a_file.writable
		local
			l_lit: INI_LITERAL
			l_cursor: CURSOR
		do
			l_cursor := a_literals.cursor
			from
				a_literals.start
			until
				a_literals.after
			loop
				l_lit := a_literals.item
				a_file.put_string (l_lit.name)
				a_file.put_new_line
				a_literals.forth
			end
			a_literals.go_to (l_cursor)
		ensure
			a_literals_unmoved: a_literals.cursor.is_equal (old a_literals.cursor)
		end

	write_properties (a_properties: LIST [INI_PROPERTY]; a_file: PLAIN_TEXT_FILE) is
			-- Writes INI properties `a_properties' to `a_file'.
		require
			a_properties_attached: a_properties /= Void
			a_file_attached: a_file /= Void
			a_file_opened_for_writing: a_file.is_open_write
			a_file_writable: a_file.writable
		local
			l_prop: INI_PROPERTY
			l_cursor: CURSOR
		do
			l_cursor := a_properties.cursor
			from
				a_properties.start
			until
				a_properties.after
			loop
				l_prop := a_properties.item
				if l_prop.name /= Void then
					a_file.put_string (l_prop.name)
				end
				a_file.put_character ({INI_SCANNER_SYMBOLS}.assigner_indicator)
				if l_prop.value /= Void then
					a_file.put_string (l_prop.value)
				end
				a_file.put_new_line
				a_properties.forth
			end
			a_properties.go_to (l_cursor)
		ensure
			a_properties_unmoved: a_properties.cursor.is_equal (old a_properties.cursor)
		end

	write_sections (a_sections: LIST [INI_SECTION]; a_file: PLAIN_TEXT_FILE) is
			-- Writes INI properties `a_properties' to `a_file'.
		require
			a_sections_attached: a_sections /= Void
			a_file_attached: a_file /= Void
			a_file_opened_for_writing: a_file.is_open_write
			a_file_writable: a_file.writable
		local
			l_section: INI_SECTION
			l_props: LIST [INI_PROPERTY]
			l_cursor: CURSOR
		do
			l_cursor := a_sections.cursor
			from
				a_sections.start
			until
				a_sections.after
			loop
				l_section := a_sections.item
				a_file.put_character ({INI_SCANNER_SYMBOLS}.section_start_indicator)
				a_file.put_string (l_section.label)
				a_file.put_character ({INI_SCANNER_SYMBOLS}.assigner_indicator)
				a_file.put_new_line
				write_properties (l_section.default_properties, a_file)
				write_properties (l_section.named_properties, a_file)
				write_literals (l_section.literals, a_file)
				a_sections.forth
			end
			a_sections.go_to (l_cursor)
		ensure
			a_sections_unmoved: a_sections.cursor.is_equal (old a_sections.cursor)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {INI_DOCUMENT_WRITER}

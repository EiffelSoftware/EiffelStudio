indexing
	description: "Generates po entries from an compilable Eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PO_GENERATOR

create
	make

feature -- Initialize

	make (a_file: like file; a_text: like text) is
			-- Initialize.
		require
			a_file_not_void: a_file /= Void
			a_text_not_void: a_text /= Void
		do
			file := a_file
			text := a_text
		ensure
			file_set: file = a_file
			text_set: text = a_text
		end

feature -- Status report

	has_error: BOOLEAN

feature {NONE} -- Access

	file: PO_FILE

	text: STRING_GENERAL

feature -- Generation

	generate is
			-- Generate entries and write them into `file'.
		local
			l_iterator: I18N_AST_ITERATOR
			l_string: STRING
			l_string_low: STRING
		do
			l_string := text.as_string_8
			l_string_low := l_string.as_lower
			if l_string_low.has_substring (name_of_translate) or else l_string_low.has_substring (name_of_translate_plural) then
				eiffel_parser.reset
				eiffel_parser.parse_from_string (l_string)
				if eiffel_parser.error_count > 0 then
					has_error := true
				else
					create l_iterator
					l_iterator.set_parsed_class (eiffel_parser.root_node)
					l_iterator.set_match_list (eiffel_parser.match_list)
					l_iterator.set_po_file (file)
					l_iterator.set_translate_feature (name_of_translate)
					l_iterator.set_translate_plural_feature (name_of_translate_plural)
					l_iterator.process_class_as (eiffel_parser.root_node)
				end
			end
		end

feature {NONE} -- Implementation

	eiffel_parser: EIFFEL_PARSER is
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
			Result.set_il_parser
		end

feature {NONE} -- Constants

	name_of_translate: STRING is "translate"

	name_of_translate_plural: STRING is "translate_plural"

invariant
	text_not_void: text /= Void
	file_not_void: file /= Void

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end

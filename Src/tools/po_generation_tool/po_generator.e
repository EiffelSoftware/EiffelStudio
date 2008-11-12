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
			--
			-- `a_file': File where parsed messages are added
			-- `a_text': Eiffel source text which is parsed for messages
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
			-- Did an error occur while parsing `text'?

feature -- Element change

	set_source_file_name (a_str: STRING) is
			-- Set `source_file_name' to `a_str'.
		require
			a_str_not_void: a_str /= Void
		do
			source_file_name := a_str
		ensure
			source_file_name_set: source_file_name = a_str
		end

feature -- Access

	file: PO_FILE
			-- File where messages are added

	text: STRING_GENERAL
			-- Eiffel source text which is parsed for messages

	source_file_name: STRING
			-- File name of Eiffel source file
			-- This is used to generate references from the messages to their source file.

feature -- Generation

	generate is
			-- Generate entries and write them into `file'.
		require
			source_file_name_set: source_file_name /= Void
		local
			l_iterator: I18N_AST_ITERATOR
			l_string: STRING
			l_string_low: STRING
		do
			l_string := text.as_string_8
			l_string_low := l_string.as_lower
			if l_string_low.has_substring (name_of_translate) or else l_string_low.has_substring (name_of_translate_plural) or else l_string_low.has_substring (name_of_feature_clause.as_lower) then
				eiffel_parser.reset
				eiffel_parser.parse_from_string (l_string)
				if eiffel_parser.error_count > 0 then
					has_error := true
				else
					create l_iterator
					l_iterator.set_parsed_class (eiffel_parser.root_node)
					l_iterator.set_match_list (eiffel_parser.match_list)
					l_iterator.set_po_file (file)
					l_iterator.set_source_file_name (source_file_name)
					l_iterator.set_source_text (l_string)
					l_iterator.set_translate_feature (name_of_translate)
					l_iterator.set_feature_clause_name (name_of_feature_clause)
					l_iterator.set_translate_plural_feature (name_of_translate_plural)
					l_iterator.process_class_as (eiffel_parser.root_node)
				end
			end
		end

feature {NONE} -- Implementation

	eiffel_parser: EIFFEL_PARSER is
			-- Eiffel parser used to parse input text
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
			Result.set_il_parser
		end

feature {NONE} -- Constants

	name_of_translate: STRING is "translation"
			-- Name of translate feature
			-- Arguments from this feature are taken as translateable messages.

	name_of_translate_plural: STRING is "plural_translation"
			-- Name of translate feature for plurals
			-- Arguments from this feature are taken as translateable plural messages.

	name_of_feature_clause: STRING = "Internationalization"

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

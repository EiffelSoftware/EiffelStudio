note
	description: "Generates po entries from an compilable Eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PO_GENERATOR

create
	make

feature {NONE} -- Creation

	make (a_file: like file; a_text: like text; a_source_file_name: like source_file_name)
			-- Initialize.
			--
			-- `a_file': File where parsed messages are added
			-- `a_text': Eiffel source text which is parsed for messages
		require
			a_file_not_void: a_file /= Void
			a_text_not_void: a_text /= Void
			a_source_file_name_attached: a_source_file_name /= Void
		do
			file := a_file
			text := a_text
			source_file_name := a_source_file_name
		ensure
			file_set: file = a_file
			text_set: text = a_text
			source_file_name_set: source_file_name = a_source_file_name
		end

feature -- Status report

	has_error: BOOLEAN
			-- Did an error occur while parsing `text'?

feature -- Access

	file: PO_FILE
			-- File where messages are added

	text: STRING_8
			-- Eiffel source text which is parsed for messages.

	source_file_name: STRING_32
			-- File name of Eiffel source file
			-- This is used to generate references from the messages to their source file.

feature -- Generation

	generate
			-- Generate entries and write them into `file'.
		require
			source_file_name_set: source_file_name /= Void
		local
			l_iterator: I18N_AST_ITERATOR
			l_string: STRING_8
			l_string_low: STRING_8
		do
			l_string := text
			l_string_low := l_string.as_lower
			if l_string_low.has_substring (name_of_translation) or else l_string_low.has_substring (name_of_plural_translation) or else l_string_low.has_substring (name_of_feature_clause.as_lower) then
				eiffel_parser.reset
				eiffel_parser.set_syntax_version (eiffel_parser.ecma_syntax)
				eiffel_parser.parse_class_from_string (l_string, Void, Void)
				if eiffel_parser.error_count > 0 then
					eiffel_parser.reset
					eiffel_parser.set_syntax_version (eiffel_parser.provisional_syntax)
					eiffel_parser.parse_class_from_string (l_string, Void, Void)
					if eiffel_parser.error_count > 0 then
						eiffel_parser.reset
						eiffel_parser.set_syntax_version (eiffel_parser.transitional_syntax)
						eiffel_parser.parse_class_from_string (l_string, Void, Void)
						if eiffel_parser.error_count > 0 then
							eiffel_parser.reset
							eiffel_parser.set_syntax_version (eiffel_parser.obsolete_syntax)
							eiffel_parser.parse_class_from_string (l_string, Void, Void)
							if eiffel_parser.error_count > 0 then
								has_error := True
							end
						end
					end
				end
				if
					not has_error and then
					attached eiffel_parser.root_node as root_node and then
					attached eiffel_parser.match_list as match_list
				then
					create l_iterator.make
						(file,
						name_of_translation,
						name_of_plural_translation,
						name_of_translation_in_context,
						name_of_plural_translation_in_context,
						name_of_feature_clause,
						source_file_name,
						l_string
						)
					l_iterator.set_parsed_class (root_node)
					l_iterator.set_match_list (match_list)
					l_iterator.process_class_as (root_node)
				end
			end
		end

feature {NONE} -- Implementation

	eiffel_parser: EIFFEL_PARSER
			-- Eiffel parser used to parse input text
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
			Result.set_il_parser
		end

feature {NONE} -- Constants

	name_of_translation: STRING_32 = "translation"
			-- Name of translate feature
			-- Arguments from this feature are taken as translateable messages.

	name_of_plural_translation: STRING_32 = "plural_translation"
			-- Name of translate feature for plurals
			-- Arguments from this feature are taken as translateable plural messages.

	name_of_translation_in_context: STRING_32 = "translation_in_context"
			-- Name of translation in context feature
			-- Arguments from this feature are taken as translateable messages.

	name_of_plural_translation_in_context: STRING_32 = "plural_translation_in_context"
			-- Name of plural translation in context feature
			-- Arguments from this feature are taken as translateable messages.

	name_of_feature_clause: STRING_32 = "Internationalization"
			-- Name of the feature clause under which we are going to extract info.

invariant
	text_not_void: text /= Void
	file_not_void: file /= Void

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

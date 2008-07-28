indexing
	description: "Search in a string, only the first match is captured."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_INCREMENTAL_STRATEGY

inherit
	MSR_SEARCH_TEXT_STRATEGY
		redefine
			launch
		end

create
	make,
	make_with_start,
	make_empty

feature -- Initialization

	make_with_start (a_keyword: like keyword;
					a_range: like surrounding_text_range;
					a_class_name: like class_name;
					a_path: like text_in_file_path;
					a_source_text: STRING_32;
					a_start: like start_position) is
			-- Initialization
		require
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
			class_name_attached: a_class_name /= Void
			path_attached: a_path /= Void
			source_text_attached: a_source_text /= Void
			a_start_valid: a_start >= 1 and a_start <= a_source_text.count
		do
			make (a_keyword, a_range, a_class_name, a_path, a_source_text)
			start_position_internal := a_start
		end

feature -- Access

	start_position : INTEGER is
			-- Start position of `text_to_be_searched'
		do
			if is_text_to_be_searched_set then
				if start_position_internal <= text_to_be_searched.count and
					start_position_internal >= 1
				then
					Result := start_position_internal
				else
					Result := 1
				end
			else
				Result := 1
			end
		ensure then
			start_position_in_the_scope: Result >= 1 and
										(is_keyword_set implies Result <= text_to_be_searched.count)
		end

feature --Element change

	set_start_position (position: INTEGER) is
			-- Set `start_position_internal' with position.
		require else
			position_is_in_the_scope: position <= text_to_be_searched.count and position >= 1
		do
			start_position_internal := position
		ensure
			position_is_in_the_scope: start_position_internal = position
		end

feature -- Basic operations

	launch is
			-- Launch searching.
		local
				-- Uncomment and use the following line to enable Unicode search when Gobo is ready.
			-- l_compile_string, l_to_be_searched: UC_UTF8_STRING
			l_compile_string, l_to_be_searched: STRING
			l_keyword: STRING
		do
			create item_matched_internal.make (0)
			build_class_name
			pcre_regex.reset
			pcre_regex.set_caseless (not case_sensitive_internal)
				-- Uncomment and use the following line to enable Unicode search when Gobo is ready.
			-- l_keyword := utf32_to_utf8 (keyword)
			l_keyword := keyword.as_string_8
			if not is_regular_expression_used then
				l_keyword := string_formatter.mute_escape_characters (l_keyword)
			end
			if is_whole_word_matched then
				l_keyword := string_formatter.build_match_whole_word (l_keyword)
			end
				-- Uncomment and use the following line to enable Unicode search when Gobo is ready.
			-- create l_to_be_searched.make_from_utf8 (utf32_to_utf8 (text_to_be_searched))
			-- create l_compile_string.make_from_utf8 (l_keyword)
			l_compile_string := l_keyword
			l_to_be_searched := text_to_be_searched
			pcre_regex.compile (l_compile_string)
			if pcre_regex.is_compiled then
				pcre_regex.match_substring (l_to_be_searched, start_position, l_to_be_searched.count)
			end
			if pcre_regex.has_matched then
				item_matched_internal.wipe_out
				add_new_item
			elseif pcre_regex.is_compiled then
				pcre_regex.match_substring (l_to_be_searched, 1, l_to_be_searched.count)
				if pcre_regex.has_matched then
					item_matched_internal.wipe_out
					add_new_item
				end
			end
			launched := True
			item_matched_internal.start
		end

feature {NONE} -- Implementation

	start_position_internal: INTEGER
			-- Search start position in `text_to_be_searched'

invariant

	invariant_clause: True -- Your invariant here

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

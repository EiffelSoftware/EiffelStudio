indexing
	description: "Objects that represent matches in the given text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_TEXT_ITEM

inherit
	MSR_ITEM
		rename
			make as make_item
		end

	MSR_FORMATTER

create
	make

feature -- Initialization

	make (a_name: like class_name;
			a_path: like path;
			a_text: MSR_STRING_ADAPTER;
			a_start: like start_index;
			a_end: like end_index) is
			-- Initialization
		require
			name_attached: a_name /= Void
			not_name_is_empty: not a_name.is_empty
			path_attached: a_path /= Void
			text_attached: a_text /= Void
			a_start_positive: a_start >= 0
			a_end_positive: a_end >= 0
		do
			make_item (a_name, a_path, a_text)
			start_index := a_start
			end_index := a_end
			create captured_submatches_internal.make (0)
		ensure
			class_name_set: class_name = a_name
			path_set: path = a_path
			source_text_set: source_text_internal = a_text
			start_index_set: start_index = a_start
			end_index_set: end_index = a_end
		end

feature -- Access

	text : STRING
			-- Exact text found

	start_index : INTEGER
			-- Start position of the found text

	end_index : INTEGER
			-- End position of the found text

	start_index_in_unix_text : INTEGER is
			-- Start position of the found text, "%R"s are ignored
		do
			Result := start_index - percent_r_count
		end

	end_index_in_unix_text : INTEGER is
			-- End position of the found text, "%R"s are ignored
		do
			Result := end_index - percent_r_count + text.occurrences ('%R')
		end

	start_index_in_context_text : INTEGER is
			-- Start position of `text' in `context_text'
		do
			Result := start_index_in_context_text_internal
		ensure
			start_index_in_context_text: Result = start_index_in_context_text_internal
		end

	context_text : STRING
			-- Text to be presented with surroundings

	line_number : INTEGER is
			-- Line number of current match in `source_text'
		do
			Result := line_number_internal
		end

	percent_r_count : INTEGER is
			--  Number of '%R' before text in `source_text'
		do
			Result := percent_r_count_internal
		end

	captured_submatches: ARRAYED_LIST [STRING] is
			-- Submatches
		do
			Result := captured_submatches_internal
		ensure
			captured_submatches_not_void: Result = captured_submatches_internal
		end

	pcre_regex: MSR_RX_PCRE_REGULAR_EXPRESSION

feature {MSR_SEARCH_STRATEGY, MSR_REPLACE_STRATEGY} -- Element Change

	set_start_index (a_start: like start_index) is
			-- Set `start_index' with `a_start'.
		require
			a_start_positive: a_start >= 0
		do
			start_index := a_start
		ensure
			start_index_set: start_index = a_start
		end

	set_end_index (a_end: like start_index) is
			-- Set `end_index' with `a_end'.
		require
			a_end_positive: a_end >= 0
		do
			end_index := a_end
		ensure
			end_index_set: end_index = a_end
		end

	set_text (a_text : STRING) is
			-- Set what exactly is found.
		require
			a_text_attached: a_text /= Void
		do
			text := a_text
		ensure
			text_set: text = a_text
		end

feature -- Element Change

	set_context_text (context: STRING) is
			-- Set `context_text' with context.
		do
			context_text := replace_RNT_to_space (context)
		ensure then
			context_text_contains_no_new_lines: not context_text.has ('%N')
			context_text_contains_no_tabs: not context_text.has ('%T')
		end

	set_line_number (i: INTEGER) is
			-- Set `line_number' with i.
		do
			line_number_internal := i
		end

	set_percent_r_count (i: INTEGER) is
			-- Set `percent_r_count' with i.
		do
			percent_r_count_internal := i
		end

	set_submatches (strings: ARRAYED_LIST [STRING]) is
			-- Set `submatches' with strings.
		require
			strings_not_void: strings /= Void
		do
			captured_submatches_internal := strings
		ensure
			start_index_internal_not_void: captured_submatches_internal = strings
		end

	set_pcre_regex (a_pcre_regex: MSR_RX_PCRE_REGULAR_EXPRESSION) is
			-- Set `pcre_regex' with a_pcre_regex.
		require
			a_pcre_regex_not_void: a_pcre_regex /= Void
		do
			pcre_regex := a_pcre_regex
		end

feature {NONE} -- Implementation

	captured_submatches_internal: ARRAYED_LIST [STRING]
			-- Submatches that are captured from between parenthesises

	line_number_internal: INTEGER
			-- Line number `text' at in `source_text'

	percent_r_count_internal: INTEGER
			-- Count of "%R" in front of `text' in `source_text'.

invariant
	captured_submatches_internal_not_void: captured_submatches_internal /= Void

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

indexing
	description: "Search in a string"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_TEXT_STRATEGY

inherit
	MSR_SEARCH_STRATEGY
		redefine
			reset_all, launch, is_search_prepared
		end

create
	make, make_empty

feature {NONE} -- Initialization

	make (a_keyword: STRING; a_range: INTEGER; a_class_name: STRING; a_path: FILE_NAME; a_source_text: STRING) is
			-- Initialization
		require
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
			class_name_attached: a_class_name /= Void
			path_attached: a_path /= Void
			source_text_attached: a_source_text /= Void
		do
			make_search_strategy (a_keyword, a_range)
			class_name_internal := a_class_name
			text_in_file_path_internal := a_path
			text_to_be_searched_internal.set_real_string (a_source_text)
		ensure
			class_name_attached: a_class_name = class_name_internal
			path_attached: a_path = text_in_file_path
			source_text_attached: a_source_text = text_to_be_searched_internal.real_string
		end

	make_empty is
			-- Empty object
		do
			create pcre_regex.make
			reset_all
		end

feature -- Access

	text_to_be_searched: STRING is
			-- Text to be searched in
		require
			is_text_to_be_searched_set : is_text_to_be_searched_set
		do
			Result := text_to_be_searched_internal.real_string
		ensure
			text_to_be_searched_not_void: Result = text_to_be_searched_internal.real_string
		end

	text_to_be_searched_adapter: MSR_STRING_ADAPTER is
			-- `text_to_be_searched_internal', an adapter contains `text_to_be_searched'
		do
			Result := text_to_be_searched_internal
		ensure
			text_to_be_searched_adapter_not_void: Result /= Void
		end

	text_in_file_path: FILE_NAME is
			-- Path of the file in which the searching text is
		require
			text_in_file_path_not_void: is_text_in_file_path_set
		do
			Result := text_in_file_path_internal
		ensure
			text_in_file_path_not_void: Result = text_in_file_path_internal
		end

	class_name: STRING is
			-- Class name of the searching text
		require
			is_launched : is_launched
		do
			if class_name_internal.is_empty then
				build_class_name
			end
			Result := class_name_internal
		ensure
			class_name_not_void: Result = class_name_internal
		end


feature -- Status report

	is_text_to_be_searched_set : BOOLEAN is
			-- Is `text_to_be_searched' set?
		do
			Result := (not text_to_be_searched_internal.real_string.is_empty)
		ensure
			text_to_be_searched_not_void: Result = (not text_to_be_searched_internal.real_string.is_empty)
		end

	is_text_in_file_path_set: BOOLEAN is
			-- Is `text_in_file_path' set?
		do
			Result := (text_in_file_path_internal /= Void)
		ensure
			is_text_in_file_path_set : Result = (text_in_file_path_internal /= Void)
		end

	is_class_name_set: BOOLEAN is
			-- Is `class_name' set?
		do
			Result := (class_name_internal /= Void)
		end

	is_search_prepared: BOOLEAN is
			-- Is search prepared?
		do
			Result :=
			Precursor and
			is_text_in_file_path_set and
			is_text_to_be_searched_set
		end

feature -- Status setting

	set_text_to_be_searched (text: STRING) is
			-- Set `text_to_be_searched_internal' with text.
		require
			text_not_void: text /= Void
		do
			text_to_be_searched_internal.set_real_string (text)
		ensure
			text_to_be_searched_internal_not_void: text_to_be_searched_internal.real_string = text
		end

	set_text_in_file_path (p_file_path: FILE_NAME) is
			-- Set `text_in_file_path_internal' with p_file_path.
		require
			p_file_path_not_void: p_file_path /= Void
		do
			text_in_file_path_internal := p_file_path
		ensure
			text_in_file_path_internal_not_void: text_in_file_path_internal = p_file_path
		end

	set_class_name (name: STRING) is
			-- Set `class_name_internal' with name.
		require
			name_not_void: name /= Void
		do
			class_name_internal := name
		ensure
			class_name_internal_not_void: class_name_internal /= Void
		end

	set_data (a_data: ANY) is
			-- Set `data' with a_data.
		require
			a_data_not_void: a_data /= Void
		do
			data := a_data
		ensure
			data_not_void: data /= Void
		end

	set_date (a_date: INTEGER) is
			-- Set `date' with a_date.
		do
			date := a_date
		end

feature -- Basic operations		

	reset_all is
			-- Reset all
		do
			Precursor
			create text_to_be_searched_internal.make ("")
			class_name_internal := Void
			text_in_file_path_internal := Void
		ensure then
			not_is_text_in_file_path_set: not is_text_to_be_searched_set
			not_is_text_to_be_searched_set: not is_text_to_be_searched_set
			class_name_internal_void: class_name_internal = Void
		end

	launch is
			-- Launch searching.
		local
			l_compile_string: STRING
		do
			create item_matched_internal.make (0)
			if not is_class_name_set then
				build_class_name
			end
			pcre_regex.set_caseless (not case_sensitive)
			if is_regular_expression_used then
				l_compile_string := keyword
			else
				l_compile_string := string_formatter.mute_escape_characters (keyword)
			end
			if is_whole_word_matched then
				l_compile_string := string_formatter.build_match_whole_word (l_compile_string)
			end
			pcre_regex.compile (l_compile_string)
			if pcre_regex.is_compiled then
				pcre_regex.match (text_to_be_searched)
			end
			if pcre_regex.has_matched then
				from
					pcre_regex.first_match
				until
					not pcre_regex.has_matched
				loop
					add_new_item
					pcre_regex.next_match
				end
			end
			launched := true
			item_matched_internal.start
		ensure then
			class_name_internal /= Void
		end

feature {NONE} -- Implementation

	text_to_be_searched_internal : MSR_STRING_ADAPTER
			-- Text to search in.

	text_in_file_path_internal: FILE_NAME
			-- Path of the file in which the text is.

	class_name_internal: STRING
			-- Class name of the text being searched, or "Not a class" as a static string.

	data: ANY
			-- Data that will be set to all items yielding.

	date: INTEGER
			-- Date of the current source

	add_new_item is
			-- Add new item from the pcre_regex's captures.
		local
			last_item, new_item : MSR_TEXT_ITEM
			present_start,present_end: INTEGER
			i: INTEGER
			line_number: INTEGER
			start_count_line_position: INTEGER
		do
			create new_item.make (class_name_internal,
								 text_in_file_path,
								 text_to_be_searched_internal,
								 pcre_regex.captured_start_position (0),
								 pcre_regex.captured_end_position (0))
			new_item.set_text (pcre_regex.captured_substring (0))
			new_item.set_pcre_regex (pcre_regex)
			if data /= Void then
				new_item.set_data (data)
			end
			new_item.set_date (date)
			if not item_matched.is_empty then
				last_item ?= item_matched.last
			end
			if last_item /= Void and then new_item.source_text = last_item.source_text then
				start_count_line_position := last_item.start_index
				line_number := last_item.line_number +
							string_formatter.occurrences_in_bound('%N',
																new_item.source_text,
																start_count_line_position,
																new_item.start_index)
				new_item.set_percent_r_count (last_item.percent_r_count +
											 string_formatter.occurrences_in_bound ('%R',
											 									new_item.source_text,
											 									start_count_line_position,
											 									new_item.start_index))
			else
				start_count_line_position := 1
				line_number := string_formatter.occurrences_in_bound('%N',
																	new_item.source_text,
																	start_count_line_position,
																	new_item.start_index) + 1
				new_item.set_percent_r_count (string_formatter.occurrences_in_bound ('%R',
																					new_item.source_text,
																					start_count_line_position,
																					new_item.start_index))
			end
			new_item.set_line_number (line_number)
			if pcre_regex.captured_start_position (0) - surrounding_text_range_internal > 0 then
				present_start := pcre_regex.captured_start_position (0) - surrounding_text_range_internal
				new_item.set_start_index_in_context_text (surrounding_text_range_internal + 1)
			else
				present_start := 1
				new_item.set_start_index_in_context_text (pcre_regex.captured_start_position (0))
			end
			if pcre_regex.captured_end_position (0) + surrounding_text_range_internal < text_to_be_searched.count then
				present_end := pcre_regex.captured_end_position (0) + surrounding_text_range_internal
			else
				present_end := text_to_be_searched.count
			end
			new_item.set_context_text (text_to_be_searched.substring (present_start,present_end))
			from
				i := 1
			until
				i >= pcre_regex.match_count
			loop
				new_item.captured_submatches.extend (pcre_regex.captured_substring (i))
				i := i + 1
			end
			item_matched_internal.extend (new_item)
		end

	build_class_name is
			-- Build the class name of the text if exists --not well solved
		local
			l_class_name:STRING
			l_list_string: LIST [STRING]
		do
			l_class_name := text_in_file_path.out
			l_list_string := l_class_name.split (operating_environment.directory_separator)
			l_class_name := l_list_string [l_list_string.count]
			if l_class_name.has ('.') then
				l_class_name := l_class_name.substring (1,
														l_class_name.last_index_of ('.', l_class_name.count) - 1)
			end
			l_class_name.to_upper
			if l_class_name.count = 0 then
				l_class_name := "Not a class"
			end
			class_name_internal := l_class_name
		end

invariant

	is_launched implies (class_name_internal /= Void)

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

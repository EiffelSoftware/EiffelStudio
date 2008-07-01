indexing
	description: "Recursively search in a directory. All matches return."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_DIRECTORY_STRATEGY

inherit
	MSR_SEARCH_STRATEGY
		redefine
			reset_all,
			launch
		end

create
	make

feature {NONE} -- Initialization

	make (a_keyword: STRING; a_range: INTEGER; a_path: FILE_NAME) is
			-- Initialization
		require
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
			a_path_attached: a_path /= Void
		do
			make_search_strategy (a_keyword, a_range)
			set_path (a_path)
		end

feature -- Access

	path: FILE_NAME is
			-- Directory that is searching
		require else
			path_not_void: is_path_set
		do
			Result:= path_internal
		ensure then
			path : Result = path_internal
		end

feature -- Status report

	is_path_set: BOOLEAN is
			-- If path is set
		do
			Result := (path_internal /= Void)
		ensure then
			is_path_set: Result = (path_internal /= Void)
		end

	is_subdirectory_searched: BOOLEAN
			-- Are subdirectories searched?

feature -- Status setting

	set_path (p_path: FILE_NAME) is
			-- Set path to search.
		require else
			p_path_not_void: p_path /= Void
		do
			path_internal := p_path
		ensure then
			is_path_set: is_path_set
		end

	set_one_file_searched_action (action: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Set action for invokation one a file searched
		require
			action_not_void: action /= Void
		do
			one_file_searched_internal := action
		ensure
			one_file_searched_internal_not_void: one_file_searched_internal = action
		end

	set_subdirectory_searched (b: BOOLEAN) is
			-- Set `is_subdirectory_searched' with b.
		do
			is_subdirectory_searched := b
		end

feature -- Basic operations		

	reset_all is
			-- Reset all
		do
			Precursor
			directory_strategy := Void
			file_strategy:= Void
			path_internal := Void
			is_subdirectory_searched := True
		ensure then
			directory_strategy_void: directory_strategy = Void
			file_strategy_void: file_strategy = Void
			not_is_path_set: not is_path_set
		end

	launch is
			-- Launch the the search.
		require else
			is_path_set: is_path_set
		local
			i:INTEGER
			l_directory: DIRECTORY
			l_file:RAW_FILE
		do
			create item_matched_internal.make (0)
			create l_directory.make (path)
			if l_directory.exists then
				l_directory.open_read
					 -- Recursively retrieve the directory tree.
				from
					l_directory.start
					l_directory.readentry
					i := 1
				until
					i > l_directory.count
				loop
					if not(l_directory.lastentry.is_equal (".") or l_directory.lastentry.is_equal("..")) then
						create l_file.make (string_formatter.extend_file_path (path, l_directory.lastentry).out)
						if l_file.exists then
							if l_file.is_directory and then is_subdirectory_searched then
								create directory_strategy.make (keyword, surrounding_text_range_internal, string_formatter.extend_file_path (path, l_directory.lastentry))
								if case_sensitive then
									directory_strategy.set_case_sensitive
								else
									directory_strategy.set_case_insensitive
								end
								directory_strategy.set_whole_word_matched (is_whole_word_matched)
								directory_strategy.set_regular_expression_used (is_regular_expression_used)
								directory_strategy.launch
								if directory_strategy.is_launched then
									item_matched_internal.finish
									item_matched_internal.merge_right (directory_strategy.item_matched)
								end
							else
								create file_strategy.make (keyword, surrounding_text_range_internal, string_formatter.extend_file_path (path, l_directory.lastentry))
								if case_sensitive then
									file_strategy.set_case_sensitive
								else
									file_strategy.set_case_insensitive
								end
								file_strategy.set_whole_word_matched (is_whole_word_matched)
								file_strategy.set_regular_expression_used (is_regular_expression_used)
								file_strategy.launch
								if file_strategy.is_launched then
									item_matched_internal.finish
									item_matched_internal.merge_right (file_strategy.item_matched)
								end
							end
							if one_file_searched_internal /= Void then
								one_file_searched_internal.call ([string_formatter.extend_file_path (path, l_directory.lastentry).out])
							end
						end
					end
					l_directory.readentry
					i := i + 1
				end
			l_directory.close
			end
			launched := True
			item_matched_internal.start
		end

feature {NONE} -- Implementation

	path_internal : FILE_NAME
			-- Directory to be searched

	file_strategy: MSR_SEARCH_FILE_STRATEGY
			-- File strategy used for file searching

	directory_strategy: MSR_SEARCH_DIRECTORY_STRATEGY
			-- Directory strategy used for directory recursively searching

	one_file_searched_internal: PROCEDURE [ANY, TUPLE [STRING]]
			-- Invokes once one file searched

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

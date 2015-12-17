note
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

	make (a_keyword: STRING; a_range: INTEGER; a_path: like path)
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

	path: PATH
			-- Directory that is searching
		require else
			path_not_void: is_path_set
		do
			Result:= path_internal
		ensure then
			path: Result = path_internal
		end

feature -- Status report

	is_path_set: BOOLEAN
			-- If path is set
		do
			Result := (path_internal /= Void)
		ensure then
			is_path_set: Result = (path_internal /= Void)
		end

	is_subdirectory_searched: BOOLEAN
			-- Are subdirectories searched?

feature -- Status setting

	set_path (p_path: like path)
			-- Set path to search.
		require else
			p_path_not_void: p_path /= Void
		do
			path_internal := p_path
		ensure then
			is_path_set: is_path_set
		end

	set_one_file_searched_action (action: PROCEDURE [PATH])
			-- Set action for invokation one a file searched
		require
			action_not_void: action /= Void
		do
			one_file_searched_internal := action
		ensure
			one_file_searched_internal_not_void: one_file_searched_internal = action
		end

	set_subdirectory_searched (b: BOOLEAN)
			-- Set `is_subdirectory_searched' with b.
		do
			is_subdirectory_searched := b
		end

feature -- Basic operations		

	reset_all
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

	launch
			-- Launch the the search.
		require else
			is_path_set: is_path_set
		local
			i:INTEGER
			l_directory: DIRECTORY
			l_entries: ARRAYED_LIST [PATH]
			l_file: RAW_FILE
		do
			create item_matched_internal.make (0)
			create l_directory.make_with_path (path)
			if l_directory.exists then
					 -- Recursively retrieve the directory tree.
				from
					l_entries := l_directory.entries
				until
					l_entries.after
				loop
					if not (l_entries.item.is_current_symbol or l_entries.item.is_parent_symbol) then
						create l_file.make_with_path (path.extended_path (l_entries.item))
						if l_file.exists then
							if l_file.is_directory and then is_subdirectory_searched then
								create directory_strategy.make (keyword, surrounding_text_range_internal, path.extended_path (l_entries.item))
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
								create file_strategy.make (keyword, surrounding_text_range_internal, path.extended_path (l_entries.item))
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
								one_file_searched_internal.call ([path.extended_path (l_entries.item)])
							end
						end
					end
					l_entries.forth
					i := i + 1
				end
			end
			launched := True
			item_matched_internal.start
		end

feature {NONE} -- Implementation

	path_internal: detachable like path
			-- Directory to be searched

	file_strategy: MSR_SEARCH_FILE_STRATEGY
			-- File strategy used for file searching

	directory_strategy: MSR_SEARCH_DIRECTORY_STRATEGY
			-- Directory strategy used for directory recursively searching

	one_file_searched_internal: PROCEDURE [PATH]
			-- Invokes once one file searched

invariant
	invariant_clause: True -- Your invariant here

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

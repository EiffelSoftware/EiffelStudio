indexing
	description: "Objects that represent certain search strategy, and should be implemented later."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$" 
	
deferred class
	MSR_SEARCH_STRATEGY

feature {NONE} -- Initialization

	make_search_strategy(a_keyword: STRING; a_range: INTEGER) is
			-- Initialization
		require
			keyword_attached: a_keyword /= Void
			range_positive: a_range >= 0
		do
			create pcre_regex.make
			reset_all
			keyword_internal := a_keyword
			surrounding_text_range_internal := a_range
		ensure
			keyword_attached: keyword = a_keyword
			surrounding_positive: surrounding_text_range_internal >= 0
		end

feature -- Access

	item_matched : ARRAYED_LIST [MSR_ITEM] is
			-- Matched items
		do
			Result := item_matched_internal
		ensure
			item_matched_not_void_if_launched: is_launched implies Result /= Void
		end
	
	keyword: STRING is
			-- Search keyword.
		require
			is_keyword_set : is_keyword_set
		do
			Result := keyword_internal
		ensure
			keyword_not_void: Result = keyword_internal
		end
		
	surrounding_text_range : INTEGER is
			-- Number of characters on one side of found text in a item's context text.
		do
			Result:= surrounding_text_range_internal
		end		
		
feature -- Status report

	case_sensitive : BOOLEAN is
			-- Is case matched?
		do
			Result := case_sensitive_internal
		ensure
			case_sensitive: Result = case_sensitive_internal
		end
		
	is_regular_expression_used : BOOLEAN is
			-- Is regular expression used in searching?
		do
			Result := is_regular_expression_used_internal
		ensure	
			is_regular_expression_used: Result = is_regular_expression_used_internal
		end
	
	is_whole_word_matched: BOOLEAN is
			-- Is whole word matched?
		do
			Result := is_whole_word_matched_internal
		ensure
			is_whole_word_matched: Result = is_whole_word_matched_internal
		end		
	
	is_launched: BOOLEAN is
			-- Is searching launched?
		do
			Result := launched
		ensure
			is_launched : Result = launched
		end		
		
	is_keyword_set: BOOLEAN is
			-- Is search keyword set
		do
			Result := (keyword_internal /= Void)
		ensure
			is_keyword_set_right: Result = (keyword_internal /= Void)
		end
		
	is_search_prepared: BOOLEAN is
			-- Is search prepared?
		do
			Result := true
		end		
	
feature -- Status setting

	set_keyword (text: STRING) is
			-- Set `keyword_internal' with text for searching.
		require
			text_not_void: text /= Void
		do		
			keyword_internal := text
		ensure
			keyword_not_void: keyword_internal = text
		end
	
	set_surrounding_text_range (range : INTEGER) is
			-- Set `surrounding_text_range_internal' with range.
		require
			range_larger_equal_than_zero: range >= 0
		do
			surrounding_text_range_internal := range
		ensure
			range_larger_equal_than_zero: surrounding_text_range_internal = range
		end
		
	set_case_sensitive is
			-- Set search matching case.
		do
			case_sensitive_internal := true
		ensure
			case_sensitive : case_sensitive
		end
	
	set_case_insensitive is
			-- Set search not matching case.
		do
			case_sensitive_internal := false
		ensure
			not_case_sensitive : not case_sensitive
		end
	
	set_regular_expression_used (p_regular_expression_used: BOOLEAN) is
			-- Set `is_regular_expression_used_internel' with p_regular_expression_used.
		do
			is_regular_expression_used_internal := p_regular_expression_used
		ensure
			is_regular_expression_used_set: is_regular_expression_used = p_regular_expression_used
		end
		
	set_whole_word_matched (p_whole_word_matched: BOOLEAN) is
			-- Set `is_whole_word_matched_internal' with p_whole_word_matched.
		do
			is_whole_word_matched_internal := p_whole_word_matched	
		ensure
			is_whole_word_matched_set: is_whole_word_matched = p_whole_word_matched
		end		
	
feature -- Basic operations		
		
	reset_all is
			-- Reset
		do
			item_matched_internal := Void
			set_case_insensitive
			set_regular_expression_used (true)
			set_whole_word_matched (false)			
			launched := false
			pcre_regex.reset
			pcre_regex.set_multiline (true)
			pcre_regex.set_empty_allowed (false)
			keyword_internal := Void
			surrounding_text_range_internal := 20
		ensure
			surrounding_text_range_internal_default: surrounding_text_range_internal = 20
			case_insensitive: not case_sensitive
			item_matched_internal_void : item_matched_internal = Void
			not_is_keyword_set: not is_keyword_set
			not_is_launched: not is_launched
			regular_expression_used: is_regular_expression_used
			whole_word_matched: not is_whole_word_matched_internal
		end
	
	launch is
			-- Launch searching
		require
			is_search_prepared: is_search_prepared
		deferred
		ensure
			item_matched_internal_not_void : item_matched_internal /= Void
			is_launched: is_launched
			item_keep_first: (not item_matched_internal.is_empty) implies item_matched_internal.isfirst
		end
			
feature {NONE} -- Implementation

	keyword_internal : STRING
			--Keywords for searching

	surrounding_text_range_internal : INTEGER
			-- Most number of charactors by oneside of the searching text.

	item_matched_internal : ARRAYED_LIST[MSR_ITEM]	
			-- All matched items in the specific location.

	case_sensitive_internal : BOOLEAN	
			-- When set search is case sensitive
			
	launched : BOOLEAN
			-- If search has been launched.
			
	is_regular_expression_used_internal: BOOLEAN
			-- If regular expression is used in searching
			
	is_whole_word_matched_internal: BOOLEAN
			-- If search whole word
			
	string_formatter: MSR_FORMATTER is
			-- Mute every GOBO regular expression meta-characters in a string.
		once
			Result := create {MSR_FORMATTER}
		end
		
feature {NONE} -- Implementation
		
	pcre_regex : MSR_RX_PCRE_REGULAR_EXPRESSION
	
invariant
	
	surrounding_text_range_internal_larger_than_zero: surrounding_text_range_internal >= 0
	
	pcre_regex_not_void: pcre_regex /= Void
	
	item_matched_internal_not_void_after_launched: launched implies item_matched_internal /= Void

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

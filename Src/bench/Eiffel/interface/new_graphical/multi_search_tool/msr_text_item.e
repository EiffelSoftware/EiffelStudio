indexing
	description: "Objects that represent matches in the given text."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_TEXT_ITEM

inherit
	MSR_ITEM
		redefine
			start_index,
			context_text,
			end_index,
			start_index_in_unix_text,
			end_index_in_unix_text,
			make
		end
	
	MSR_FORMATTER

create
	make

feature -- Initialization

	make is
			-- Initialization
		do
			Precursor
			create captured_submatches_internal.make (0)
		end	

feature -- Access
	
	start_index : INTEGER is
			-- Start position of the found text		
		do
			Result := start_index_internal
		end
	
	end_index : INTEGER is
			-- End position of the found text
		do
			Result := end_index_internal
		end
	
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
		
	context_text: STRING is
			-- Text to be presented with surroundings
		do
			Result := context_text_internal
		end

	captured_submatches: ARRAYED_LIST [STRING] is
			-- Submatches
		do
			Result := captured_submatches_internal
		ensure
			captured_submatches_not_void: Result = captured_submatches_internal
		end
		
	pcre_regex: MSR_RX_PCRE_REGULAR_EXPRESSION
		
feature -- Element Change
	
	set_start_index (index: INTEGER) is
			-- Set `start_index' with index.
		do
			start_index_internal := index
		end
	
	set_end_index (index: INTEGER) is
			-- Set `end_index' with index.
		do
			end_index_internal := index
		end
	
	set_context_text (context: STRING) is
			-- Set `context_text' with context.
		do
			context_text_internal := replace_RNT_to_space (context)
		ensure then
			context_text_internal_contains_no_new_lines: not context_text_internal.has ('%N')
			context_text_internal_contains_no_tabs: not context_text_internal.has ('%T')
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

end

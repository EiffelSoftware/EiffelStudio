indexing
	description: "Search in a string, only the first match is captured."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_SEARCH_INCREMENTAL_STRATEGY

inherit
	MSR_SEARCH_TEXT_STRATEGY	
		redefine
			launch
		end

creation
	make		

feature -- Access

	start_position : INTEGER is
			-- Start position of `text_to_be_searched'
		do
			if is_text_to_be_searched_set then			
				if start_position_internal <= text_to_be_searched.count and start_position_internal >= 1 then
					Result := start_position_internal
				else
					Result := 1
				end
			else
				Result := 1
			end		
		ensure then
			start_position_in_the_scope: Result >= 1 and (is_keyword_set implies Result <= text_to_be_searched.count)
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
			l_compile_string: STRING
		do
			create item_matched_internal.make (0)
			build_class_name
			pcre_regex.reset
			pcre_regex.set_caseless (not case_sensitive_internal)
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
				pcre_regex.match_substring (text_to_be_searched, start_position, text_to_be_searched.count)			
			end
			if pcre_regex.has_matched then
				item_matched_internal.wipe_out
				add_new_item
			end
			launched := true
			item_matched_internal.start
		end

feature {NONE} -- Implementation

	start_position_internal: INTEGER
			-- Search start position in `text_to_be_searched'
			
invariant

	invariant_clause: True -- Your invariant here

end

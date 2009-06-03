note
	description: "Build editor displayable token from EiffelLex TOKENs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN_BUILDER

feature -- Access

	build_token (a_token: TOKEN): EDITOR_TOKEN
	        -- 
	  	require
	  	do
	  		inspect a_token.type
	  		when 0 then
	  			-- unmatched, but not text
	  		when unmatched_type then
	  			create {EDITOR_TOKEN_TEXT} Result.make (a_token.string_value)
	  		when char_type then
	  			create {EDITOR_TOKEN_CHARACTER} Result.make (a_token.string_value)
	  		when comment_type then
	  			create {EDITOR_TOKEN_COMMENT} Result.make (a_token.string_value)
	  		when integer_type then       
	  			create {EDITOR_TOKEN_NUMBER} Result.make (a_token.string_value)	  			
	  		when operator_type then
	  			create {EDITOR_TOKEN_OPERATOR} Result.make (a_token.string_value)
	  		when real_type then
	  			create {EDITOR_TOKEN_NUMBER} Result.make (a_token.string_value)
	  		when space_type then
	  			create {EDITOR_TOKEN_SPACE} Result.make (a_token.string_value.count)
	  		when string_type then
	  			create {EDITOR_TOKEN_STRING} Result.make (a_token.string_value)
			when tab_type then
				create {EDITOR_TOKEN_TABULATION} Result.make (a_token.string_value.count)
			when text_type then
				if a_token.keyword_code > 0 then
	  			    create {EDITOR_TOKEN_KEYWORD} Result.make (a_token.string_value)
	  			else
					create {EDITOR_TOKEN_TEXT} Result.make (a_token.string_value)
				end
			when newline_type then
				-- Do nothing because EDITOR_LINE automatically deals with newlines.  Must catch it here though to 
				-- avoid producing a text token instead.
	  		else
	  			if not a_token.string_value.has_substring ("%N") then	  			   
		  			create {EDITOR_TOKEN_TEXT} Result.make (a_token.string_value)		  		
	  			end
	  		end
	  	end
		
feature {NONE} -- Implementation

	unmatched_type: INTEGER = 1
	char_type: INTEGER = 2
	comment_type: INTEGER = 3
	integer_type: INTEGER = 4
	operator_type: INTEGER = 5
	real_type: INTEGER = 6
	space_type: INTEGER = 7
	string_type: INTEGER = 8
	tab_type: INTEGER = 9
	newline_type: INTEGER = 10
	text_type: INTEGER = 11;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TOKEN_BUILDER

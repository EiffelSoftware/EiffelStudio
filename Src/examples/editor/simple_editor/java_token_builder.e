note
	description: "Summary description for {JAVA_TOKEN_BUILDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_TOKEN_BUILDER

inherit
	TOKEN_BUILDER
		redefine
				build_token
		end

	EV_STOCK_COLORS

feature -- Access

	build_token (a_token: TOKEN): detachable EDITOR_TOKEN
	        -- Build editor token
		local
			l_value: STRING
	  	do
	  		l_value := a_token.string_value
	  		inspect a_token.type
	  		when 0 then
	  			-- unmatched, but not text
	  		when unmatched_type then
	  			create {EDITOR_TOKEN_TEXT} Result.make (l_value)
	  		when char_type then
	  			create {EDITOR_TOKEN_CHARACTER} Result.make (l_value)
	  		when comment_type then
	  			create {EDITOR_TOKEN_COMMENT} Result.make (l_value)
	  			Result.set_text_color (Dark_green)
	  		when integer_type then
	  			create {EDITOR_TOKEN_NUMBER} Result.make (l_value)
	  		when operator_type then
	  			create {EDITOR_TOKEN_OPERATOR} Result.make (l_value)
	  		when real_type then
	  			create {EDITOR_TOKEN_NUMBER} Result.make (l_value)
	  		when space_type then
	  			create {EDITOR_TOKEN_SPACE} Result.make (l_value.count)
	  		when string_type then
	  			create {EDITOR_TOKEN_STRING} Result.make (l_value)
	  			Result.set_text_color (blue)
			when tab_type then
				create {EDITOR_TOKEN_TABULATION} Result.make (l_value.count)
			when text_type then
				if a_token.keyword_code > 0 then
	  			    create {EDITOR_TOKEN_KEYWORD} Result.make (l_value)
	  			    Result.set_text_color (keyword_color)
	  			else
					create {EDITOR_TOKEN_TEXT} Result.make (l_value)
				end
			when newline_type then
				-- Do nothing because EDITOR_LINE automatically deals with newlines.  Must catch it here though to
				-- avoid producing a text token instead.
	  		else
	  			if not a_token.string_value.has_substring ("%N") then
		  			create {EDITOR_TOKEN_TEXT} Result.make (l_value)
	  			end
	  		end
	  	end

	  keyword_color: EV_COLOR
	  		once
	  			create Result.make_with_8_bit_rgb (180, 39, 125)
	  		end

end

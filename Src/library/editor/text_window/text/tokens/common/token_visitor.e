indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN_VISITOR

feature -- Access

	last_structured_text_item: TEXT_ITEM
	
feature -- Commands

	process_basic_token (image: STRING) is
		do
			last_structured_text_item := create {BASIC_TEXT}.make (image)
		end

	process_character_token (image: STRING) is
		do
			last_structured_text_item := create {CHARACTER_TEXT}.make (image)
		end
		
	process_keyword_token (image: STRING) is
		do
			last_structured_text_item := create {KEYWORD_TEXT}.make (image)
		end	
		
	process_eol_token (image: STRING) is
		do
			last_structured_text_item := create {NEW_LINE_ITEM}.make
		end
		
	process_number_token (image: STRING) is
		do
			last_structured_text_item := create {NUMBER_TEXT}.make (image)
		end

	process_string_token (image: STRING) is
		do
			last_structured_text_item := create {STRING_TEXT}.make (image)
		end

	process_tabulation_token (image: STRING) is
		do
			last_structured_text_item := create {INDENT_TEXT}.make (image.count)
		end

end -- class TOKEN_VISITOR


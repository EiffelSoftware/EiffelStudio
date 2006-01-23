indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TOKEN_VISITOR


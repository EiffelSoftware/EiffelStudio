indexing
	description: "Visitor of Eiffel specific tokens."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TOKEN_VISITOR

inherit
	TOKEN_VISITOR
	
feature -- Visitor

	process_reserved_word_token (image: STRING) is
		do
			last_structured_text_item := create {RESERVED_WORD_TEXT}.make (image)
		end
	
	process_local_token (image: STRING) is
		do
			last_structured_text_item := create {LOCAL_TEXT}.make (image)
		end

	process_generic_token (image: STRING) is
		do
			last_structured_text_item := create {GENERIC_TEXT}.make (image)
		end

end -- class EIFFEL_TOKEN_VISITOR

indexing
	description	: "Tokens for `Result' and `Current'."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_RESERVED

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color,
			background_color,	
			editor_preferences,
			process
		end

create
	make

feature -- Visitor

	process (a_token_visitor: EIFFEL_TOKEN_VISITOR) is
			--  Process
		do
			a_token_visitor.process_reserved_word_token (image)
		end

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := editor_preferences.reserved_text_color
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.reserved_background_color
		end

	editor_preferences: EB_EDITOR_DATA is
			-- 
		once
			Result ?= editor_preferences_cell.item
		end

end -- class EDITOR_TOKEN_RESERVED



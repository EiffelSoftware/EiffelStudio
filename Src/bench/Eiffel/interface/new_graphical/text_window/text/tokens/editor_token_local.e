indexing
	description	: "Tokens for local symbols."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_LOCAL

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
			a_token_visitor.process_local_token (image)
		end

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := editor_preferences.local_text_color
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.local_background_color
		end

	editor_preferences: EB_EDITOR_DATA is
			-- 
		once
			Result ?= editor_preferences_cell.item
		end

end -- class EDITOR_TOKEN_LOCAL

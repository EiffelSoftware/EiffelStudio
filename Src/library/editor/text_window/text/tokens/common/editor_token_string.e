indexing
	description	: "Token that describe an Eiffel string"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_STRING

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color, 
			background_color,
			process
		end

create
	make

feature -- Visitor

	process (a_token_visitor: TOKEN_VISITOR) is
			--  Process
		do
			a_token_visitor.process_string_token (image)
		end


feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := editor_preferences.string_text_color
		end

	background_color: EV_COLOR is
		do
			if is_highlighted then				
				Result := editor_preferences.highlight_color
			else
				Result := editor_preferences.string_background_color
			end
		end

end -- class EDITOR_TOKEN_STRING

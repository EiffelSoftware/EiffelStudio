indexing
	description	: "Token that describe an number (integer, real, ...) "
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_NUMBER

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color, background_color
		end

create
	make

feature {NONE} -- Implementation
	
	text_color: WEL_COLOR_REF is
		do
			Result := editor_preferences.number_text_color
		end

	background_color: WEL_COLOR_REF is
		do
			Result := editor_preferences.number_background_color
		end

end -- class EDITOR_TOKEN_NUMBER

indexing
	description	: "Token that describe an operator (+, :=, ?=, ...) "
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_OPERATOR

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color, background_color
		end

create
	make

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := editor_preferences.operator_text_color
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.operator_background_color
		end

end -- class EDITOR_SYMBOL

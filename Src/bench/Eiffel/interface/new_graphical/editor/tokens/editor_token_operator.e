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
			text_color
		end

create
	make

feature {NONE} -- Implementation
	
	text_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(196,0,0)
		end

end -- class EDITOR_SYMBOL

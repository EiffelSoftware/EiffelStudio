indexing
	description	: "Token that describe a character."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_CHARACTER

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color, background_color
		end

create
	make

feature {NONE} -- Implementation
	
	text_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(0,128,0)
		end

	background_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(196,0,196)
		end

end -- class EDITOR_TOKEN_CHARACTER

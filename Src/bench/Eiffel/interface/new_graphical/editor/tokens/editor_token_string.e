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
			text_color, background_color
		end

create
	make

feature {NONE} -- Implementation
	
	text_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(128,0,0)
		end

	background_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(0,196,196)
		end

end -- class EDITOR_STRING

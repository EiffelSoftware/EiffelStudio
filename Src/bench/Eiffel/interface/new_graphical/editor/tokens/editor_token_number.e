indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
		once
			create Result.make_rgb(0,0,128)
		end

	background_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(196,196,0)
		end

end -- class EDITOR_TOKEN_NUMBER

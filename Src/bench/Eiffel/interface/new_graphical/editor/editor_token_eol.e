indexing
	description	: "Token that describe the end of a line."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_EOL

inherit
	EDITOR_TOKEN

create
	make

feature -- Initialisation

	make is
			-- Create the token (image is an empty string)
		do
			image := ""
			length := 1
			width := 0
		end

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
		do
			-- Do nothing.
		end

feature {NONE} -- Properties used to display the token

	text_color: WEL_COLOR_REF is do end
		-- undefined for this token

	background_color: WEL_COLOR_REF is do end
		-- undefined for this token

	font: WEL_FONT is do end
		-- undefined for this token

end -- class EDITOR_COMMENT

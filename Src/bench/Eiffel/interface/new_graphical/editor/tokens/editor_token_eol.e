indexing
	description	: "Token that describe the end of a line."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_EOL

inherit
	EDITOR_TOKEN

	SHARED_EDITOR_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make is
			-- Create the token (image is an empty string)
		do
			image := ""
			length := 1
		end

feature -- Miscellaneous

	width: INTEGER is
		do
			Result := 0
		end

	display(d_y: INTEGER; a_dc: WEL_DC) is
		do
			if font /= Void then
				a_dc.select_font(font)
			end

				-- Display the text.
			a_dc.text_out (position, d_y, "¶")

			if font /= Void then
				a_dc.unselect_font
			end
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			Result := 0
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := 1
		end

feature {NONE} -- Properties used to display the token

	text_color: WEL_COLOR_REF is
		do
		end

	background_color: WEL_COLOR_REF is
		do
		end

	font: WEL_FONT is
		local
			log_font: WEL_LOG_FONT
		once
				-- create the font
			create log_font.make(editor_preferences.font_size, editor_preferences.font_name)
			create Result.make_indirect(log_font)
		end

end -- class EDITOR_COMMENT

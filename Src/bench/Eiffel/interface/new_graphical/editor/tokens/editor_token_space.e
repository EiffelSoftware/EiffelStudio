indexing
	description	: "Objects that represent one or several spaces"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_SPACE

inherit
	EDITOR_TOKEN

	SHARED_EDITOR_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make(number: INTEGER) is
			-- Create a token composed of `number' spaces.
		local
			i: INTEGER
		do
			length := number
			create image.make(number)
			from i := 1 until i > number loop
				image.append_character(' ')
				i := i + 1
			end
		end

feature -- Miscellaneous

	display(d_y: INTEGER; dc: WEL_DC) is
		do
			--[ Don't display anything. If an option is set to see the spaces, 
			--  put it here ]
		end

	width: INTEGER is
		do
			Result := length * space_width
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
				-- The result can be easily computed since all
				-- the spaces have the same size.
			Result := n * space_width
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := a_width // space_width + 1
		end

feature {NONE} -- Implementation

	text_color: WEL_COLOR_REF is
			-- Color of the displayed text
		do
		end

	background_color: WEL_COLOR_REF is
			-- Background color of the displayed text
		do
		end

	font: WEL_FONT is
			-- Font used to draw the text
		local
			log_font: WEL_LOG_FONT
		once
				-- create the font
			create log_font.make(editor_preferences.font_size, editor_preferences.font_name)
			create Result.make_indirect(log_font)
		end

	space_width: INTEGER is
		local
			dc: WEL_MEMORY_DC
		once
			create dc.make
			dc.select_font(font)
			Result := dc.string_width(" ")
			dc.unselect_font
		end

end -- class EDITOR_TOKEN_SPACE

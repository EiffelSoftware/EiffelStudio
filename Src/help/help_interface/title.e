indexing
	description: "Title element."
	author: "Parker Abercrombie"
	date: "$Date$"

class
	TITLE

inherit
	GENERIC_ELEMENT
		redefine
			start_tag,
			end_tag
		end

create
	make

feature -- Output

	start_tag (target_display: EV_RICH_TEXT) is
			-- Start title region.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
		do
			format := target_display.character_format
			create font.make
			font.set_height (24)
			format.set_font (font)
			target_display.set_character_format (format)
		end

	end_tag (target_display: EV_RICH_TEXT) is
			-- End title region.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
		do
			format := target_display.character_format
			create font.make
			font.set_height (32)
			format.set_font (font)
			target_display.set_character_format (format)

			target_display.append_text ("%N")
		end

end -- class TITLE

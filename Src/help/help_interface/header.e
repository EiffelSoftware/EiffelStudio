indexing
	description: "Topic Header"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	HEADER

inherit
	GENERIC_ELEMENT
		redefine
			start_tag,
			end_tag
		end;

create
	make

feature -- Basic operations

	start_tag (target_display: EV_RICH_TEXT) is
			-- Start header region.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
		do
			target_display.append_text ("%N%N")

			format := target_display.character_format
			create font.make
			font.set_height (18)
			format.set_font (font)
			target_display.set_character_format (format)
		end

	end_tag (target_display: EV_RICH_TEXT) is
			-- End header region.
		local
			format: EV_CHARACTER_FORMAT
			font: EV_FONT
		do
			format := target_display.character_format
			create font.make
			font.set_height (14)
			format.set_font (font)
			target_display.set_character_format (format)

			target_display.append_text ("%N%N")
		end

end -- class HEADER

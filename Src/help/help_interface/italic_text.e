indexing
	description: "Italic text"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	ITALIC_TEXT

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
			-- Start italic region.
		local
			format: EV_CHARACTER_FORMAT
		do
			format := target_display.character_format
			format.set_italic (True)
			target_display.set_character_format (format)
		ensure then
			is_italic: target_display.character_format.is_italic
		end

	end_tag (target_display: EV_RICH_TEXT) is
			-- End italic region.
		local
			format: EV_CHARACTER_FORMAT
		do
			format := target_display.character_format
			format.set_italic (False)
			target_display.set_character_format (format)
		ensure then
			is_not_italic: not target_display.character_format.is_italic
		end

end -- class ITALIC_TEXT

indexing
	description: "Eiffel keyword."
	author: "Parker Abercrombie"
	date: "$Date$"

class
	EIFFEL_KEYWORD

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
			-- Start keyword region.
		local
			format: EV_CHARACTER_FORMAT
			color: EV_COLOR
		do
			format := target_display.character_format
			create color.make_rgb (0, 0, 255)
			format.set_color (color)
			target_display.set_character_format (format)
		end

	end_tag (target_display: EV_RICH_TEXT) is
			-- End keyword region.
		local
			format: EV_CHARACTER_FORMAT
			color: EV_COLOR
		do
			format := target_display.character_format
			create color.make
			format.set_color (color)
			target_display.set_character_format (format)
		end

end -- class EIFFEL_KEYWORD

indexing
	description: "Eiffel comment."
	author: "Parker Abercrombie"
	date: "$Date$"

class
	EIFFEL_COMMENT

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
			-- Start comment region.
		local
			format: EV_CHARACTER_FORMAT
			color: EV_COLOR
		do
			format := target_display.character_format
			create color.make_rgb (255, 0, 0)
			format.set_color (color)
			target_display.set_character_format (format)
		end

	end_tag (target_display: EV_RICH_TEXT) is
			-- End comment region.
		local
			format: EV_CHARACTER_FORMAT
			color: EV_COLOR
		do
			format := target_display.character_format
			create color.make
			format.set_color (color)
			target_display.set_character_format (format)
		end

end -- class EIFFEL_COMMENT

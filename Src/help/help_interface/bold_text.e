indexing
	description: "Bold text"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	BOLD_TEXT

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
			-- Start bold region.
		local
			format: EV_CHARACTER_FORMAT
		do
			format := target_display.character_format
			format.set_bold (True)
			target_display.set_character_format (format)
		ensure then
			is_bold: target_display.character_format.is_bold
		end

	end_tag (target_display: EV_RICH_TEXT) is
			-- End bold region.
		local
			format: EV_CHARACTER_FORMAT
		do
			format := target_display.character_format
			format.set_bold (False)
			target_display.set_character_format (format)
		ensure then
			is_not_bold: not target_display.character_format.is_bold
		end

end -- class BOLD_TEXT

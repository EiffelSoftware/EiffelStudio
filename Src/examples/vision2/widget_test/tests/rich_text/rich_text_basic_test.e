indexing
	description: "Objects that test EV_RICH_TEXT."
	date: "$Date$"
	revision: "$Revision$"

class
	RICH_TEXT_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			counter: INTEGER
			font: EV_FONT
			character_format: EV_CHARACTER_FORMAT
		do
			create rich_text
			rich_text.set_minimum_size (300, 300)
			font := rich_text.font
			from
				counter := 1
			until
				counter > 5
			loop
				rich_text.append_text (sample_text)
				font.set_height (font.height + counter)
				create character_format.make_with_font (font)
				rich_text.format_region (rich_text.text_length - sample_text.count, rich_text.text_length, character_format)
				counter := counter + 1
			end
		
			widget := rich_text
		end
		
feature {NONE} -- Implementation

	rich_text: EV_RICH_TEXT
		-- Widget that test is to be performed on.
		
	sample_text: STRING is "Rich Text%N"
		-- Sample text for testing.

end -- class RICH_TEXT_BASIC_TEST

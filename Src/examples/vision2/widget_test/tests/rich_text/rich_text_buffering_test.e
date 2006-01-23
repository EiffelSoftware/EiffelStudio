indexing
	description: "Objects that test `buffered_append' of EV_RICH_TEXT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RICH_TEXT_BUFFERING_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			create vertical_box
			create rich_text
			vertical_box.extend (rich_text)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			create text_input.make_with_text ("Rich text")
			horizontal_box.extend (text_input)
			create buffer_button.make_with_text_and_action ("Buffer Text", agent perform_buffering)
			horizontal_box.extend (buffer_button)
			
			rich_text.set_minimum_size (300, 300)
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	perform_buffering is
			-- Buffer two versions of `text_input.text' into `rich_text, one black and
			-- the other red with bold enabled. Buffer each of these texts 1000 times.
		local
			counter: INTEGER
			font1, font2: EV_FONT
			character_format1, character_format2: EV_CHARACTER_FORMAT
			text: STRING
		do
			text := text_input.text
			font1 := rich_text.font
			font2 := font1.twin
				-- Enable this font as bold.
			font2.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			
				-- Create two formats used for buffering.
			create character_format1.make_with_font_and_color (font1, (create {EV_STOCK_COLORS}).black, rich_text.background_color)
			create character_format2.make_with_font_and_color (font2, (create {EV_STOCK_COLORS}).red, rich_text.background_color)
			
			from
				counter := 1
			until
				counter > 1000
			loop
				rich_text.buffered_append (text + counter.out, character_format1)	
				rich_text.buffered_append (text + counter.out, character_format2)
				counter := counter + 1
			end
				--Now flush the buffer.
			rich_text.flush_buffer
		end

	rich_text: EV_RICH_TEXT
		-- Widget that test is to be performed on.
		
	buffer_button: EV_BUTTON
		-- Button to control buffering
		
	text_input: EV_TEXT_FIELD;
		-- Text field to input text for buffing.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class RICH_TEXT_BUFFERING_TEST

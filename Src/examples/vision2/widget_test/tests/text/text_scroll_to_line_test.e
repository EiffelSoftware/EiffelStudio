indexing
	description: "Objects that test EV_TEXT."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_SCROLL_TO_LINE_TEST

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
			label: EV_LABEL
			line_select: EV_SPIN_BUTTON
			horizontal_box: EV_HORIZONTAL_BOX
			counter: INTEGER
		do
			create vertical_box
			vertical_box.set_minimum_size (300, 300)
			create text
			text.disable_edit
			text.set_background_color ((create {EV_STOCK_COLORS}).white)
			vertical_box.extend (text)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			create label.make_with_text ("Enter a line to scroll to : ")
			label.align_text_right
			horizontal_box.extend (label)
			create line_select
			
				-- We do not want 0 to be in our range, as the lines of
				-- `text' start at 1.
			line_select.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 100))
			horizontal_box.extend (line_select)
			horizontal_box.disable_item_expand (line_select)
			line_select.change_actions.extend (agent scroll_to_line)
			
				-- Build some lines into `text' corresponding to the range
				-- of `line_select'.
			from
				counter := 1
			until
				counter > line_select.value_range.upper
			loop
				text.set_text (text.text + "This is line " + counter.out + "%N")
				counter := counter + 1
			end
		
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	text: EV_TEXT
		-- Widget that test is to be performed on.
	
	scroll_to_line (a_line: INTEGER) is
			-- Scroll to line `a_line' in `text'.
		do
			text.scroll_to_line (a_line)
		end

end -- class TEXT_SCROLL_TO_LINE_TEST

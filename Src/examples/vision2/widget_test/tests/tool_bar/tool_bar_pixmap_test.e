indexing
	description: "Objects that demonstrate EV_TOOL_BAR"
	pixmaps_required: "1, 2"
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_PIXMAP_TEST
	
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
			tool_bar_button: EV_TOOL_BAR_BUTTON
			tool_bar_separator: EV_TOOL_BAR_SEPARATOR
		do
			create tool_bar
			from
				counter := 1
			until
				counter > 10
			loop
				create tool_bar_button.make_with_text ("Button " + counter.out)
				tool_bar_button.set_pixmap (numbered_pixmap (counter \\ 2 + 1))
				tool_bar.extend (tool_bar_button)
				if counter \\ 3 = 0 then
					create tool_bar_separator
					tool_bar.extend (tool_bar_separator)
				end
				counter := counter + 1
			end
			
			widget := tool_bar
		end
		
feature {NONE} -- Implementation

	tool_bar: EV_TOOL_BAR
		-- Widget that test is to be performed on.

end -- class TOOL_BAR_PIXMAP_TEST

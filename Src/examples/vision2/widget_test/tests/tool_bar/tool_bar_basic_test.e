indexing
	description: "Objects that demonstrate EV_TOOL_BAR"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_BASIC_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			counter: INTEGER
			tool_bar_button: EV_TOOL_BAR_BUTTON
		do
			create tool_bar
			from
				counter := 1
			until
				counter > 10
			loop
				create tool_bar_button.make_with_text ("Button " + counter.out)
				tool_bar.extend (tool_bar_button)
				counter := counter + 1
			end
			
			widget := tool_bar
		end
		
feature {NONE} -- Implementation

	tool_bar: EV_TOOL_BAR

end -- class TOOL_BAR_BASIC_TEST

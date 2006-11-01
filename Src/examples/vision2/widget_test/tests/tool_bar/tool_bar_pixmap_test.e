indexing
	description: "Objects that demonstrate EV_TOOL_BAR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	tool_bar: EV_TOOL_BAR;
		-- Widget that test is to be performed on.

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


end -- class TOOL_BAR_PIXMAP_TEST

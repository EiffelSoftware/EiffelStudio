indexing
	description: "Objects that provide components that need to be accessed%
		%by many different classes."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_ACCESSIBLE

feature -- Access

	display_window: GB_DISPLAY_WINDOW is
			-- Displays the current window that has been built.
		once
			Create Result
		end
		
	builder_window: GB_BUILDER_WINDOW is
			-- A representation of the current window that has been built,
			-- with all containers visible.
		once
			Create Result
		end
		
	type_selector: GB_TYPE_SELECTOR is
			-- Tool for selecting supported vision2 types.
		once
			Create Result
		end
		
	layout_constructor: GB_LAYOUT_CONSTRUCTOR is
			-- Tool for laying out widgets.
		once
			Create Result
		end

end -- class GB_ACCESSIBLE

indexing
	description: "Objects that provide components that need to be accessed%
		%by many different classes."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_TOOLS

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
			Result.set_size (400, 300)
		end
		
	type_selector: GB_TYPE_SELECTOR is
			-- Tool for selecting supported vision2 types.
		once
			Create Result
		end
		
	component_selector: GB_COMPONENT_SELECTOR is
			-- Tool for working with user defined components.
		once
			Create Result
		end
		
		
	layout_constructor: GB_LAYOUT_CONSTRUCTOR is
			-- Tool for laying out widgets.
		once
			Create Result
		end
		
	project_settings_window: GB_SYSTEM_WINDOW is
			-- Window which displays current project properties.
		once
			create Result
		end
		

end -- class GB_ACCESSIBLE

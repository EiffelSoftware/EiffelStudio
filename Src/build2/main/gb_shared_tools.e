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
		ensure
			exists: Result /= Void
		end
		
	builder_window: GB_BUILDER_WINDOW is
			-- A representation of the current window that has been built,
			-- with all containers visible.
		once
			Create Result
			Result.set_size (400, 300)
		ensure
			exists: Result /= Void
		end
		
	type_selector: GB_TYPE_SELECTOR is
			-- Tool for selecting supported vision2 types.
		once
			Create Result
		ensure
			exists: Result /= Void
		end
		
	component_selector: GB_COMPONENT_SELECTOR is
			-- Tool for working with user defined components.
		once
			Create Result
		ensure
			exists: Result /= Void
		end

	layout_constructor: GB_LAYOUT_CONSTRUCTOR is
			-- Tool for laying out widgets.
		once
			Create Result
		ensure
			exists: Result /= Void
		end
		
	project_settings_window: GB_SYSTEM_WINDOW is
			-- Window which displays current project properties.
		once
			create Result
		ensure
			exists: Result /= Void
		end
		
	main_window: GB_MAIN_WINDOW is
			-- `Result' is main window of `Current'.
		once
			create Result
		ensure
			exists: Result /= Void
		end
		
	component_viewer: GB_COMPONENT_VIEWER is
			-- `Result' is component viewer of system.
		once
			create Result
		end

end -- class GB_ACCESSIBLE

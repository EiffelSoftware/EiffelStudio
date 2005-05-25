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
		do
			Result := Display_window_cell.item
		end
		
	set_display_window (a_display_window: GB_DISPLAY_WINDOW) is
			-- Store `a_display_window' in `Display_window_cell'.
		do
			Display_window_cell.put (a_display_window)
		end		
	
	Display_window_cell: CELL [GB_DISPLAY_WINDOW] is
			-- A cell to hold `display_window' which allows the
			-- window to be replaced.
		once
			Create Result.put (Void)
		ensure
			exists: Result /= Void
		end
		
	builder_window: GB_BUILDER_WINDOW is
			-- A representation of the current window that has been built,
			-- with all containers visible.
		do
			Result := builder_window_cell.item
		end
		
	set_builder_window (a_builder_window: GB_BUILDER_WINDOW) is
			-- Store `a_builder_window' in `builder_window_cell'.
		do
			Builder_window_cell.put (a_builder_Window)
			a_builder_window.set_size (400, 300)
		end

	builder_window_cell: CELL [GB_BUILDER_WINDOW] is
			-- A cell to hold `builder_window' which allows
			-- the window to be replaced.
		once
			create Result.put (Void)
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
		
	widget_selector: GB_WIDGET_SELECTOR is
			-- Tool for selecting widgets.
		once
			create Result
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
		
	history_dialog: GB_HISTORY_DIALOG is
			-- `Result' is history dialog of system.
		once
			Result := (create {GB_SHARED_HISTORY}).history.history_dialog
		end
		
	constants_dialog: GB_CONSTANTS_DIALOG is
			-- `Result' is constants dialog used in EiffelBuild.
		once
			create Result
		end

	multiple_split_area: MULTIPLE_SPLIT_AREA is
			-- `Result' is multiple slit area to hold tools.
		once
			create Result
		end

	all_floating_tools: ARRAYED_LIST [EV_DIALOG] is
			-- `Result' is all tools that are independent of the main window.
			-- The `tools_always_on_top' command applies to these windows only.
		once
			create Result.make (4)
			Result.extend (builder_window)
			Result.extend (display_window)
			Result.extend (component_viewer)
			Result.extend (history_dialog)
			Result.extend (constants_dialog)
		end
		
	all_storable_tools: ARRAYED_LIST [GB_STORABLE_TOOL] is
			-- All tools that are storable.
		once
			create Result.make (4)	
			Result.extend (Component_selector)
			Result.extend (Layout_constructor)
			Result.extend (Type_selector)
			Result.extend (widget_selector)
		end

	tool_by_name (name: STRING): GB_STORABLE_TOOL is
			-- `Result' is tool corresponding to `name'.
		require
			name_valid: valid_tool_name (name)
		local
			tools: ARRAYED_LIST [GB_STORABLE_TOOL]	
		do
			tools := all_storable_tools
			from
				tools.start
			until
				tools.off or Result /= Void
			loop
				if name.is_equal (tools.item.storable_name) then
					Result := tools.item
				end
				tools.forth
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	tool_by_widget (a_widget: EV_WIDGET): GB_STORABLE_TOOL is
			-- `Result' is tool with widget `a_widget'.
		require
			a_widget_not_void: a_widget /= Void
		local
			tools: ARRAYED_LIST [GB_STORABLE_TOOL]
		do
			tools := all_storable_tools
			from
				tools.start
			until
				tools.off or Result /= Void
			loop
				if tools.item.as_widget = a_widget then
					Result := tools.item
				end
				tools.forth
			end
		end
		
	storable_name_by_tool (a_widget: GB_STORABLE_TOOL): STRING is
			-- Result is a string representation of tool `a_widget'.
			-- Used in the preferences representation.
		require
			a_widget_not_void: a_widget /= Void
		do
			Result := a_widget.storable_name
		ensure
			Result_not_void: Result /= Void
		end

	Component_selector_name: STRING is "Component selector"
		-- String representation for component selector.
	
	Type_selector_name: STRING is "Type selector"
		-- String representation for type selector.
	
	Widget_selector_name: STRING is "Widget selector"
		-- String representation for widget selector.
	
	valid_tool_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid tool name?
			-- Case sensitive.
		require
			name_not_void: a_name /= Void
		do
			if a_name.is_equal (tool_name_as_storable (Component_selector_name)) or 
				a_name.is_equal (tool_name_as_storable (Type_selector_name)) or
				a_name.is_equal (tool_name_as_storable (Widget_selector_name)) then
				Result := True	
			end
		end
		
	clipboard_dialog: EV_DIALOG is
			-- Dialog to display contents of `clipboard'.
		once
			create Result
		end
		
feature {NONE} -- Implementation

	tool_name_as_storable (a_name: STRING): STRING is
			-- `Result' is representation of `a_name' without
			-- spaces, and all lower case.
		require
			name_not_void: a_name /= Void
		do
			Result := a_name.twin
			Result.to_lower
			Result.prune_all (' ')
		end

end -- class GB_ACCESSIBLE

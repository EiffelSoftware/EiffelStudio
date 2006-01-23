indexing
	description: "Objects that provide components that need to be accessed%
		%by many different classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TOOLS

inherit
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end

create
	make_with_components

feature -- Access

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Initialize `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			create layout_constructor.make_with_components (components)
			create type_selector.make_with_components (components)
			create component_selector.make_with_components (components)
			create widget_selector.make_with_components (components)
			create component_viewer.make_with_components (components)
			create history_dialog.make_with_components (components)
			create constants_dialog.make_with_components (components)
			create project_settings_window.make_with_components (components)
			create tip_of_the_day_dialog.make_with_components (components)
			create clipboard_dialog
			clipboard_dialog.set_title ("Clipboard Contents")
			fake_cancel_button (clipboard_dialog, agent clipboard_dialog.hide)
			clipboard_dialog.set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).icon_clipboard @ 1)

			create display_window_cell.put (Void)
			create builder_window_cell.put (Void)
			set_builder_window (create {GB_BUILDER_WINDOW}.make_with_components (components))
			set_display_window (create {GB_DISPLAY_WINDOW}.make_with_components (components))

			create all_floating_tools.make (4)
			all_floating_tools.extend (builder_window)
			all_floating_tools.extend (display_window)
			all_floating_tools.extend (component_viewer)
			all_floating_tools.extend (history_dialog)
			all_floating_tools.extend (constants_dialog)

			create all_storable_tools.make (4)
			all_storable_tools.extend (Component_selector)
			all_storable_tools.extend (Layout_constructor)
			all_storable_tools.extend (Type_selector)
			all_storable_tools.extend (widget_selector)
		ensure
			components_set: components = a_components
		end


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

	set_main_window (a_main_window: EV_TITLED_WINDOW) is
			-- Assign `a_main_window' to `main_window'.
		require
			a_main_window_not_void: a_main_window /= Void
		do
			main_window := a_main_window
		end

	Display_window_cell: CELL [GB_DISPLAY_WINDOW]
			-- A cell to hold `display_window' which allows the
			-- window to be replaced.

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

	builder_window_cell: CELL [GB_BUILDER_WINDOW]
			-- A cell to hold `builder_window' which allows
			-- the window to be replaced.

	type_selector: GB_TYPE_SELECTOR
			-- Tool for selecting supported vision2 types.

	component_selector: GB_COMPONENT_SELECTOR
			-- Tool for working with user defined components.

	layout_constructor: GB_LAYOUT_CONSTRUCTOR
			-- Tool for laying out widgets.

	widget_selector: GB_WIDGET_SELECTOR
			-- Tool for selecting widgets.

	project_settings_window: GB_SYSTEM_WINDOW
			-- Window which displays current project properties.

	main_window: EV_TITLED_WINDOW
			-- `Result' is main window associated with `Current'.
			-- Dialogs are shown relative to this window.

	component_viewer: GB_COMPONENT_VIEWER
			-- `Result' is component viewer of system.

	history_dialog: GB_HISTORY_DIALOG
			-- `Result' is history dialog of system.

	constants_dialog: GB_CONSTANTS_DIALOG
			-- `Result' is constants dialog used in EiffelBuild.

	tip_of_the_day_dialog: GB_TIP_OF_THE_DAY_DIALOG
			-- A dialog to display tips to the user.

	all_floating_tools: ARRAYED_LIST [EV_DIALOG]
			-- `Result' is all tools that are independent of the main window.
			-- The `tools_always_on_top' command applies to these windows only.

	all_storable_tools: ARRAYED_LIST [GB_STORABLE_TOOL]
			-- All tools that are storable.

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

	clipboard_dialog: EV_DIALOG

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_ACCESSIBLE

indexing
	description: "Objects that represent the tool bar for a widget_selector."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WIDGET_SELECTOR_TOOL_BAR

inherit
	EV_TOOL_BAR
		redefine
			initialize, is_in_default_state
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			copy, default_create, is_equal
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			copy, default_create, is_equal
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			copy, default_create, is_equal
		end

create
	make_with_widget_selector

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_widget_selector (a_widget_selector: GB_WIDGET_SELECTOR; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' associated to `a_widget_selector' and assign `a_components' to `components'.
		require
			a_widget_selector_not_void: a_widget_selector /= Void
			a_components_not_void: a_components /= Void
		do
			components := a_components
			widget_selector := a_widget_selector
			default_create
		ensure
			widget_selector_set: widget_selector = a_widget_selector
			components_set: components = a_components
		end

	initialize is
			-- Initialize `Current'.
		do
			create include_directory_button
			include_directory_button.set_pixmap (pixmap_by_name ("directory_search_small"))
			include_directory_button.select_actions.extend (agent include_all_directories)
			include_directory_button.set_tooltip (include_directory_button_tooltip)

			root_window_button := components.commands.set_root_window_command.new_toolbar_item (True, False)

			create show_hide_empty_directories_button
			show_hide_empty_directories_button.set_pixmap (pixmap_by_name ("icon_show_hide_directory_color"))
			show_hide_empty_directories_button.select_actions.extend (agent show_hide_all_empty_directories)
			show_hide_empty_directories_button.set_tooltip (show_hide_empty_directories_tooltip)

			create new_directory_button
			new_directory_button.select_actions.extend (agent widget_selector.add_new_directory (Void))
			new_directory_button.set_pixmap (pixmap_by_name ("icon_new_cluster_small_color"))
			new_directory_button.set_tooltip (new_directory_button_tooltip)
			new_directory_button.set_pebble (create {GB_NEW_DIRECTORY_PEBBLE})

			create expand_all_button
			expand_all_button.select_actions.extend (agent expand_tree_recursive (widget_selector.widget))
			expand_all_button.select_actions.extend (agent (components.status_bar).set_timed_status_text (all_expanded_text))
			expand_all_button.set_pixmap (pixmap_by_name ("icon_expand_all_small_color"))
			expand_all_button.set_tooltip (expand_all_button_tooltip)
			expand_all_button.drop_actions.extend (agent expand_subtree_recursive)

			extend (new_directory_button)
			extend (expand_all_button)
			extend (root_window_button)
			extend (include_directory_button)
			extend (show_hide_empty_directories_button)
			is_initialized := True
		end

feature -- Access

	widget_selector: GB_WIDGET_SELECTOR
		-- Widget selector to which `Current' is associated.

	include_directory_button: EV_TOOL_BAR_BUTTON
			-- A button which is used to add all directories within the current
			-- directory structure to the current project.

	root_window_button: EV_TOOL_BAR_BUTTON
			-- A button used to select the root window of the project.

	show_hide_empty_directories_button: EV_TOOL_BAR_TOGGLE_BUTTON
			-- A button used to show/hide all empty directories within `Current'.

	new_directory_button: EV_TOOL_BAR_BUTTON
			-- `Result' is a tool bar button that
			-- calls `add_new_directory'.

	expand_all_button: EV_TOOL_BAR_BUTTON
			-- `Result' is a tool bar button that expands contents of `Current'

feature {GB_SET_ROOT_WINDOW_COMMAND, GB_WIDGET_SELECTOR} -- Status Setting

	update_select_root_window_command is
			-- Update status of root window button based on the currently selected window.
		do
			if not components.system_status.loading_project then
				if widget_selector.selected_directory = Void and (widget_selector.selected_window /= Void and then
					(widget_selector.selected_window.object.type.is_equal (ev_titled_window_string) or
					widget_selector.selected_window.object.type.is_equal (ev_dialog_string)) and components.object_handler.root_window_object /= widget_selector.selected_window.object) then
					root_window_button.enable_sensitive
				else
					root_window_button.disable_sensitive
				end
			end
		end

feature {NONE} -- Implementation

	include_all_directories is
			-- Include all dirs reachable from the project location, to the current project
		do
			widget_selector.internal_include_all_directories (create {DIRECTORY}.make (components.system_status.current_project_settings.project_location), create {ARRAYED_LIST [STRING]}.make (5))
			components.status_bar.set_timed_status_text (directories_included_text)
		end

	expand_subtree_recursive (widget_selector_common_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Expand `widget_selector_common_item' recursively
		require
			widget_selector_common_item_not_void: widget_selector_common_item /= Void
		do
			widget_selector_common_item.expand_recursive
			components.status_bar.set_timed_status_text ("All nodes of " + widget_selector_common_item.name + " expanded.")
		end

	show_hide_all_empty_directories is
			-- Show/hide all empty directories in project based on state of `show_hide_empty_directories_button'.
		do
			if show_hide_empty_directories_button.is_selected then
				widget_selector.recursive_do_all (agent internal_hide_directory)
				components.status_bar.set_timed_status_text (all_empty_directories_hidden_text)
			else
				widget_selector.recursive_do_all (agent internal_show_directory)
				components.status_bar.set_timed_status_text (all_empty_directories_shown_text)
			end
		end

	internal_hide_directory (selector_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Ensure that `selector_item' is hidden in `Current'.
		require
			selector_item_not_void: selector_item /= Void
		local
			directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			directory ?= selector_item
			if directory /= Void then
				if directory.is_grayed_out and directory.tree_item.parent /= Void then
					directory.tree_item.parent.prune_all (directory.tree_item)
				end
			end
		end

	internal_show_directory (selector_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Ensure that `selector_item' is visible in `Current'.
		require
			selector_item_not_void: selector_item /= Void
		local
			directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			directory ?= selector_item
			if directory /= Void and directory.tree_item.parent = Void then
				if directory.parent /= widget_selector then
					add_to_tree_node_alphabetically (directory.parent.tree_item, directory.tree_item)
				else
					check
						parent_is_widget_selector: directory.parent = widget_selector
					end
					add_to_tree_node_alphabetically (widget_selector.widget, directory.tree_item)
				end
			end
		end

	is_in_default_state: BOOLEAN is True
		-- Is `Current' in its default state?

invariant
	widget_selector_not_void: widget_selector /= Void
	bi_directional: widget_selector.tool_bar /= Void implies widget_selector.tool_bar = Current

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_WIDGET_SELECTOR_TOOL_BAR

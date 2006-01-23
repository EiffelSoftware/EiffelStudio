indexing
	description: "Objects that hold user defined components."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_SELECTOR

inherit
	EV_LIST
		undefine
			is_in_default_state
		redefine
			initialize
		end

	GB_DEFAULT_STATE

	GB_STORABLE_TOOL
		undefine
			default_create, is_equal, copy
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	GB_NAMING_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_LIST}
			set_minimum_height (tool_minimum_height)
			drop_actions.extend (agent add_new_component)
			drop_actions.set_veto_pebble_function (agent is_valid_object)
			key_press_actions.extend (agent check_for_component_delete)
		end

feature -- Access

	tool_bar: EV_TOOL_BAR is
			-- A tool bar containing all buttons associated with `Current'.
		do
			create Result
		end

	name: STRING is "Component Selector"
			-- Full name used to represent `Current'.

feature -- Basic operation

	add_new_component (object_stone: GB_OBJECT_STONE) is
			-- Add a new component representing `object_stone'.
		require
			object_stone_not_void: object_stone /= Void
		local
			component_item: GB_COMPONENT_SELECTOR_ITEM
			dialog: GB_NAMING_DIALOG
			standard_object_stone: GB_STANDARD_OBJECT_STONE
		do
			standard_object_stone ?= object_stone
			if standard_object_stone /= Void then
				create dialog.make_with_values (unique_name_from_array (all_component_names, "component"), "New component", "Please specify the component name:", Component_invalid_name_warning, agent valid_component_name)
				dialog.show_modal_to_window (parent_window (Current))
				if not dialog.cancelled then
					create component_item.make_from_object (standard_object_stone.object, dialog.name, components)
					extend (component_item)
				end
			end
		end

	valid_component_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid component name?
		local
			temp_string: STRING
		do
			if valid_class_name (a_name) then
				temp_string := a_name
				temp_string.to_lower
				if not all_component_names.has (temp_string) then
					Result := True
				end
			end
		end

	delete_component (component_name: STRING) is
			-- Remove component with name `component_name'.
		require
			vaid_component_name: component_name /= Void and not component_name.is_empty
		local
			found: BOOLEAN
			component: GB_COMPONENT
		do
			components.xml_handler.remove_component (component_name)
				-- We must now remove the child of `Current' representing
				-- the component named `component_name'.
			from
				start
			until
				off or found
			loop
				if item.text.is_equal (component_name) then
					found := True
					remove
				end
					-- We need this protection, as otherwise, if we
					-- remove the last item, `forth' will fail.
				if not found then
					forth
				end
			end
			component := components.tools.component_viewer.component
			if component /= Void and then component.name.is_equal (component_name) then
				components.tools.component_viewer.clear
			end
			check
				component_matched_correctly: found
			end
		end

	is_valid_object (object_stone: GB_OBJECT_STONE): BOOLEAN is
			-- Is `an_object' a valid object which may be dropped
			-- in Current?
		require
			object_stone_not_void: object_stone /= Void
		local
			standard_object_stone: GB_STANDARD_OBJECT_STONE
		do
			standard_object_stone ?= object_stone
			if standard_object_stone /= Void then

				-- Checks that we are not transporting from the type
				-- selector tool.
			if standard_object_stone.object.object /= Void then
				Result := True
			end

				--|FIXME Why can we not support windows and dialogs?
			if standard_object_stone.object_type.is_equal (Ev_titled_window_string) or
				standard_object_stone.object_type.is_equal (ev_dialog_string) then
				Result := False
			end
			else
				Result := False
			end
		end

feature {GB_XML_HANDLER} -- Basic operation

	add_components (list: ARRAYED_LIST [STRING]) is
			-- For every item in `list', add a matching
			-- component to `Current'.
		require
			list_not_void: list /= Void
		local
			component_item: GB_COMPONENT_SELECTOR_ITEM
		do
			from
				list.start
			until
				list.off
			loop
				create component_item.make_with_name (list.item, components)
				extend (component_item)
				list.forth
			end
		ensure
			count_increased_correctly: count = old count + list.count
		end

feature {NONE} -- Implementation

	check_for_component_delete (a_key: EV_KEY) is
			-- Respond to keypress of `a_key' and delete selected object.
		require
			a_key_not_void: a_key /= Void
		local
			warning_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if a_key.code = Key_delete and selected_item /= Void then
					-- Only perform deletion if delete key pressed, and an
					-- object was selected.
				if preferences.dialog_data.show_deleting_keyboard_warning then
					create warning_dialog.make_initialized (2, preferences.dialog_data.show_deleting_keyboard_warning_string, delete_warning1 + "component" + delete_warning2, delete_do_not_show_again, preferences.preferences)
					warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
					warning_dialog.set_ok_action (agent delete_component (selected_item.text))
					warning_dialog.show_modal_to_window (parent_window (Current))
				else
					delete_component (selected_item.text)
				end
			end
		end

	all_component_names: ARRAYED_LIST [STRING] is
			-- `Result' is all named components displayed in `Current'.
			-- All components must be in `Current', so this is all components
			-- in the system. All strings in `Result' are lowercase.
			-- `Result' is empty if no components currently exist.
		local
			temp_string: STRING
		do
			create Result.make (0)
			from
				start
			until
				off
			loop
				temp_string := item.text
				temp_string.to_lower
				Result.extend (temp_string)
				forth
			end
			Result.compare_objects
		ensure
			result_not_void: Result /= Void
			comparing_objects: Result.object_comparison
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


end -- class GB_COMPONENT_SELECTOR

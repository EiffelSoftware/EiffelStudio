indexing
	description: "Objects that hold user defined components."
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
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end
		
	GB_SHARED_XML_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
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

create
	default_create
	
feature {NONE} -- Initialization

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
		
	add_new_component (an_object: GB_OBJECT) is
			-- Add a new component representing `an_object'.
		require
			an_object_not_void: an_object /= Void
		local
			component_item: GB_COMPONENT_SELECTOR_ITEM
			dialog: GB_NAMING_DIALOG
		do
			create dialog.make_with_values (unique_name_from_array (all_component_names, "component"), "New component", "Please specify the component name:", Component_invalid_name_warning, agent valid_component_name)
			dialog.show_modal_to_window (parent_window (Current))
			if not dialog.cancelled then
				create component_item.make_from_object (an_object, dialog.name)	
				extend (component_item)
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
			xml_handler.remove_component (component_name)
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
			component := component_viewer.component
			if component /= Void and then component.name.is_equal (component_name) then
				Component_viewer.clear
			end
			check
				component_matched_correctly: found
			end
		end

	is_valid_object (an_object: GB_OBJECT): BOOLEAN is
			-- Is `an_object' a valid object which may be dropped
			-- in Current?
		do
				-- Checks that we are not transporting from the type
				-- selector tool.
			if an_object.object /= Void then
				Result := True
			end
				-- Components made from WINDOWS are not allowed, as
				-- only one window is currently allowed in the system.
			if an_object.type.is_equal (Ev_titled_window_string) then
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
				create component_item.make_with_name (list.item)
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
				if Preferences.boolean_resource_value (preferences.show_deleting_keyboard_warning, True) then
					create warning_dialog.make_initialized (2, preferences.show_deleting_keyboard_warning, delete_warning1 + "component" + delete_warning2, delete_do_not_show_again)
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
		
end -- class GB_COMPONENT_SELECTOR

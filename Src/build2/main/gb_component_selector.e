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
	
	GB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end
		
	GB_WIDGET_UTILITIES
		undefine
			default_create, is_equal, copy
		end
		
	GB_ACCESSIBLE_SYSTEM_STATUS
		undefine
			default_create, is_equal, copy
		end
		
	GB_ACCESSIBLE_XML_HANDLER
		undefine
			default_create, is_equal, copy
		end

create
	default_create
	
feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_LIST}
			drop_actions.extend (agent add_new_component)
			drop_actions.set_veto_pebble_function (agent is_valid_object)
		end

feature -- Basic operation
		
	add_new_component (an_object: GB_OBJECT) is
			-- Add a new component representing `an_object'.
		local
			component_item: GB_COMPONENT_SELECTOR_ITEM
			dialog: GB_COMPONENT_NAMER_DIALOG
			new_component_name: STRING
		do
			create dialog.make_with_names (all_component_names)
			dialog.show_modal_to_window (parent_window (Current))
			new_component_name := dialog.name
			
			if not new_component_name.is_empty then
				create component_item.make_from_object (an_object, new_component_name)	
				extend (component_item)
			end
		end
		
	delete_component (component_name: STRING) is
			-- Remove component with name `component_name'.
		require
			vaid_component_name: component_name /= Void and not component_name.is_empty
		local
			dialog: EV_CONFIRMATION_DIALOG
			found: BOOLEAN
			item_to_delete: EV_LIST_ITEM
		do
			create dialog.make_with_text (Delete_component_warning)
			dialog.show_modal_to_window (system_status.main_window)
			if dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
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
				check
					component_matched_correctly: found
				end
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
		ensure
			result_not_void: Result /= Void
		end
		
		
end -- class GB_COMPONENT_SELECTOR

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
		
	add_new_component (an_object: GB_OBJECT) is
			-- Add a new component representing `an_object'.
		local
			component_item: GB_COMPONENT_SELECTOR_ITEM
		do
			create component_item.make_from_object (an_object, "Component_" + (count + 1).out)
			extend (component_item)
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
		
end -- class GB_COMPONENT_SELECTOR

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

create
	default_create
	
feature {NONE} -- Imitialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_LIST}
			drop_actions.extend (agent add_new_component)
			drop_actions.set_veto_pebble_function (agent is_valid_object)
		end
		
	add_new_component (an_object: GB_OBJECT) is
			-- Add a new component representing `an_object'.
		do
			
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
			if an_object.type.is_equal ("EV_TITLED_WINDOW") then
				Result := False
			end
		end
		
		
		
end -- class GB_COMPONENT_SELECTOR

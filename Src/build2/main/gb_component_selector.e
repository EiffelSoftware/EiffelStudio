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
		end
		
end -- class GB_COMPONENT_SELECTOR

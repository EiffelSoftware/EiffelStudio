indexing
	description: "Leaf for Eiffel syntax node."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LEAF_AS
	
inherit
	AST_EIFFEL
		undefine
			type_check, byte_node, number_of_breakpoint_slots
		end

	LOCATION_AS
		rename
			make as make_with_location
		end

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := Current
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := Current
		end

end

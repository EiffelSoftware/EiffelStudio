indexing
	description: "Objects that represent a flat vertical split area."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_VERTICAL_SPLIT_AREA
	
inherit
	EV_VERTICAL_SPLIT_AREA
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Set flat mode.
		do
			Precursor {EV_VERTICAL_SPLIT_AREA}
			implementation.enable_flat_separator
		end

end -- class GB_SPLIT_AREA


indexing
	description: "Constants for `bench'."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRAPHICAL_DATA

feature {NONE} -- Resources

	Graphical_resources: EB_GRAPHICAL_PARAMETERS is
			-- Graphical resources
		once
			Create Result.make
		end

end -- class EB_GRAPHICAL_DATA

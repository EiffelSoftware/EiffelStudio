indexing
	description: "Argument direction support (in, out, inout)"
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_DIRECTIONS

feature -- Access

	in_argument, out_argument, inout_argument: INTEGER is unique
			-- Constants

feature -- Status Report

	is_valid_direction (a_direction: INTEGER): BOOLEAN is
			-- Is `a_direction' a valid direction constant?
		do
			Result := a_direction = in_argument or a_direction = out_argument or a_direction = inout_argument
		end

end -- class ECD_DIRECTIONS

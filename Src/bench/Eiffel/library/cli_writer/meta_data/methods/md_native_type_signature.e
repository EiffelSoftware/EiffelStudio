indexing
	description: "A special signature containing only one native type descriptor. Used for marshalling."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_NATIVE_TYPE_SIGNATURE

inherit
	MD_SIGNATURE

create
	make

feature -- Reset

	reset is
			-- Reset current for new signature definition
		do
			current_position := 0
		ensure
			current_position_set: current_position = 0
		end

feature -- Setting

	set_native_type (a_type: INTEGER_8) is
			-- Insert `a_type' into Current.
		do
			internal_put (a_type, current_position)
			current_position := current_position + 1
		end
		
end
indexing
	description: "A special signature containing only one type descriptor"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TYPE_SIGNATURE

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

end -- class MD_TYPE_SIGNATURE

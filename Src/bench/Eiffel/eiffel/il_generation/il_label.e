indexing
	description: "Representation of a IL label."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_LABEL

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER) is
			-- Initialize IL object with id `a_id'.
		do
			id := a_id
		end

feature -- Access

	id: INTEGER

end -- class IL_LABEL

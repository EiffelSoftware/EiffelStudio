indexing
	description: "Class used to store state circles."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class S_CIRCLE 

inherit
	SHARED_STORAGE_INFO

creation
	make

feature {NONE} -- Initialization

	make (s: STATE_CIRCLE) is
		do
			identifier := s.data.identifier
			x := s.center.x
			y := s.center.y
		end

feature -- Access

	state_circle: STATE_CIRCLE is
		do
			create Result.make
			Result.init
			Result.set_data (state_table.item (identifier))
			circle_table.put (Result, identifier)
		end

	center: EV_POINT is
		do
			create Result.set (x, y)
		end

feature {NONE} -- Implementation

	identifier: INTEGER

	x, y: INTEGER

end -- class S_CIRCLE


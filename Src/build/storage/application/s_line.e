indexing
	description: "Class used to store application lines."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class S_LINE

inherit
	SHARED_STORAGE_INFO

creation
	make

feature {NONE} -- Initialization

	make (s: STATE_LINE) is
		local
			state_circle: STATE_CIRCLE
		do
			state_circle ?= s.source
			if state_circle = Void then
				io.error.putstring ("Does not know how to store black boxes yet%N")
			end
			source := state_circle.data.identifier
			state_circle ?= s.destination
			if state_circle = Void then
				io.error.putstring ("Does not know how to store black boxes yet%N")
			end
			destination := state_circle.data.identifier
			bidirectional := s.bi_directional
			x1 := s.tail.x
			y1 := s.tail.y
			x2 := s.head.x
			y2 := s.head.y
		end

feature -- Access

	state_line: STATE_LINE is
		local
			tail, head: EV_POINT
		do
			create Result.make
			Result.set_elements (circle_table.item (source), 
								circle_table.item (destination))
			Result.set_bi_directional (bidirectional)
			create tail.set (x1, y1)
			create head.set (x2, y2)
			Result.set_from_points (tail, head)
		end

feature {NONE} -- Implementation

	source, destination: INTEGER

	bidirectional: BOOLEAN

	x1, y1, x2, y2: INTEGER

end -- class S_LINE


indexing

	description: 
		"Zone in a text, specified by its start and end positions, %
		%and which displays a representation of the associated %
		%element. Comparable, with respect to start and end positions.";
	date: "$Date$";
	revision: "$Revision$"

class TEXT_ZONE

inherit
	COMPARABLE

creation

	make

feature {NONE} -- Initialization

	make (e: like element; sp, ep: like start_position) is
		require
			e_exists: e /= Void
			meaningful_pos: sp < ep
		do
			element := e
			start_position := sp
			end_position := ep
		ensure
			element_set: element = e
			start_position_set: start_position = sp
			end_position_set: end_position = ep
		end

feature -- Access

	element: ANY
			-- Element displayed in Current zone, between `start_position'
			-- and `end_position'

	start_position, end_position: INTEGER
			-- Positions between which `element' is displayed in the 
			-- corresponding text.
			-- Specified in number of characters.

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := (start_position < other.start_position) or else
				(start_position = other.start_position and then
				end_position < other.start_position)
		end

invariant

	element_exist: element /= Void
	meaningful_positions: start_position < end_position

end -- class TEXT_ZONE

indexing

	description: 
		"Zone in a text, specified by its start and end positions, %
		%and which displays a representation of the associated %
		%data. Comparable, with respect to start and end positions.";
	date: "$Date$";
	revision: "$Revision$"

class DATA_TEXT_ZONE

inherit

	TEXT_ZONE
		rename
			element as data
		redefine
			data
		end
			
creation

	make

feature -- Access

	data: DATA
			-- Data displayed in Current zone, between `start_position'
			-- and `end_position'

end -- class DATA_TEXT_ZONE

indexing
	description: "Information required to read in a file of the EIFGEN/COMP directory."
	date: "$Date$"
	revision: "$Revision$"

class READ_INFO 

inherit
	SERVER_INFO

create
	make

feature -- Access

	object_count: INTEGER;
			-- Number of objects to retrieve

feature -- Update

	set_position (i: INTEGER) is
			-- Assign `i' to `offset'.
		do
			position := i;
		end;

	set_object_count (i: INTEGER) is
			-- Assign `i' to `object_count'.
		do
			object_count := i;
		end;

end

indexing
	description: "Information about the location of an object in a file%
				%of the EIFGEN/COMP directory."
	date: "$Date$"
	revision: "$Revision$"

class SERVER_INFO

create
	make

feature

	position: INTEGER;
			-- Position id file of id `id'.

	file_id: INTEGER;
			-- Id of the file where associated item is strored

	make (p: INTEGER; i: INTEGER) is
			-- Initialization
		require
			good_position: p >= 0;
			good_id: i /= 0
		do
			position := p;
			file_id := i
		end;

	trace is
		do
			io.error.put_string ("SERVER_INFO%Nposition: ");
			io.error.put_integer (position);
			io.error.put_string ("%Nid: ");
			io.error.put_integer (file_id);
			io.error.put_new_line;
		end;

end

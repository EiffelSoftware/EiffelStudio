indexing
	description: "Information about the location of an object in a file%
				%of the EIFGEN/COMP directory."
	date: "$Date$"
	revision: "$Revision$"

class SERVER_INFO

creation
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
			io.error.putstring ("SERVER_INFO%Nposition: ");
			io.error.putint (position);
			io.error.putstring ("%Nid: ");
			io.error.putint (file_id);
			io.error.new_line;
		end;

end


class SERVER_INFO

creation

	make

feature

	position: INTEGER;
			-- Position id file of id `id'.

	id: FILE_ID;
			-- Id of the file where associated item is strored

	make (p: INTEGER; i: FILE_ID) is
			-- Initialization
		require
			good_position: p >= 0;
			good_id: i /= Void
		do
			position := p;
			id := i
		end;

	trace is
		do
			io.error.putstring ("SERVER_INFO%Nposition: ");
			io.error.putint (position);
			io.error.putstring ("%Nid: ");
			id.trace;
			io.error.new_line;
		end;

end

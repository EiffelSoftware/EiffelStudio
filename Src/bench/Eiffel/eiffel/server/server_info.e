
class SERVER_INFO

creation

	make

feature

	position: INTEGER;
			-- Position id file of id `id'.

	id: INTEGER;
			-- Id of the file where associated item is strored

	make (p, i: INTEGER) is
			-- Initialization
		require
			good_position: p >= 0;
			good_id: i > 0
		do
			position := p;
			id := i
		end;

end

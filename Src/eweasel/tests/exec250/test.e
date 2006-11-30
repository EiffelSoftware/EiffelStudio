indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature

	make is
			--
		local
			t: TEST2
		do
			t.make
		end

	g is
		do
		end

end

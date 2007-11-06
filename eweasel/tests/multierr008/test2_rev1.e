indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST2
inherit
	TEST1
		redefine
			make
		end

create
	make

feature

	make is
		do
			print ("Hello TEST2%N")
		end

end

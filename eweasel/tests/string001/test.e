indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature
	make
		local
			s8: TEST_STRING_8
			s32: TEST_STRING_32
		do
			create s8.make
			create s32.make
		end

end

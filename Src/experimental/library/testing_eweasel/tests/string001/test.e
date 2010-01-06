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
			is8: TEST_IMMUTABLE_STRING_8
			s32: TEST_STRING_32
			is32: TEST_IMMUTABLE_STRING_32
		do
			create s8.make
			create s32.make
			create is8.make
			create is32.make
		end

end

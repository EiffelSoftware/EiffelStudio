class
	TEST

create
	make

feature

	make
		local
			t32: TEST_REAL_32
			t64: TEST_REAL_64
		do
			create t32.make
			create t64.make
		end

end

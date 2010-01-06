class TEST

creation
	make

feature

	make is
		local
			l_test: TEST1
		do
			create {TEST2} l_test.make
			l_test.action
			create {TEST3} l_test.make
			l_test.action
		end

end


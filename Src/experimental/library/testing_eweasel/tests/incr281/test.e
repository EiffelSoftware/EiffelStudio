class TEST
create
	make

feature
	make
		do
			create test1
		end

	test1: TEST1 [TEST2]
end


class
    TEST

create
	make

feature 

	make is
		local
			l_test1: TEST1 [DOUBLE]
			l_test2: TEST2 [DOUBLE]
		do
			create l_test1.make (5.0)
			create l_test2.make (5.0)
		end

end

class TEST

creation
	make

feature

	make is
		local
			l_test2: TEST1
		do
			create {TEST2} l_test2
			l_test2.go_i_th (create {TEST4})
		end

end


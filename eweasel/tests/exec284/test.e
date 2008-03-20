class TEST

create
	make

feature
	 make
		local
			l_t1: TEST1 [STRING]
			l_t2: TEST1 [TEST2 [STRING]]
		do
			create l_t1.make
			create l_t2.make
		end

end

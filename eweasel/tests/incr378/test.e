class TEST

create
	make
feature

--	test2: TEST2 [STRING]
--	test1_s: TEST1 [STRING, TYPED_PREFERENCE [STRING]]
--	test1_i: TEST1 [INTEGER, TYPED_PREFERENCE [INTEGER]]

	make
		do
			make2
		end

	make2
		local
			l_test2: TEST2 [STRING]
			l_test1_s: TEST1 [STRING, TYPED_PREFERENCE [STRING]]
			l_test1_i: TEST1 [INTEGER, TYPED_PREFERENCE [INTEGER]]
		do
			create l_test1_s
			l_test1_s.do_something
			create l_test1_i
			l_test1_i.do_something
			create l_test2
			l_test2.do_something
		end

end

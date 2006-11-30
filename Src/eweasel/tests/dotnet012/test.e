class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			l_test, l_test_bis: TEST1
			l_cloneable: ICLONEABLE
		do
			create l_test
			l_cloneable := l_test
			l_test_bis ?= l_cloneable
			if not l_test_bis.is_equal (l_test) then
				print ("Not OK%N")
			end
		end

end

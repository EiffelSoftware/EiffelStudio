class TEST2[G -> {B, ANY} create make_b end]
feature
	test
		local
			l_g: G
			l_test1: TEST1[G]
		do
			create l_g.make_b
			create l_test1
			l_test1.test
		end
end


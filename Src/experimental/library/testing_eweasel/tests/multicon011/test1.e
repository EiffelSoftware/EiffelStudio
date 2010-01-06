class TEST1[G -> A create make_a end]
feature
	test
		local
			l_g: G
		do
			create l_g.make_a
		end
end


class TEST 
create
	make
feature

	make is
		local
			x: X [NUMERIC]
			l_num: NUMERIC
		do
			create x
			l_num := x.f (1, 1.0)
		end

end

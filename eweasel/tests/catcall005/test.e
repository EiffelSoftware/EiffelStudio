class TEST 
create
	make
feature

	make
		local
			x: X [NUMERIC]
			x_var: X [variant NUMERIC]
			l_num: NUMERIC
		do
			create x
			l_num := x.f (1, 1.0)

			create x_var
			l_num := x_var.f (1, 1.0)
		end

end

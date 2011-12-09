class
	TEST

create
	make

feature

	make is
		local
			l_exp: EXP	
		do
			l_exp := new_exp
			io.put_integer (l_exp.i)
			io.put_new_line
		end

	new_exp: EXP
		do
			Result.allocate_memory
		end

end

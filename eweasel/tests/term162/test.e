class TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			t_i: TEST1 [INTEGER]
			t_p: TEST1 [POINTER]
		do
			create t_i
			create t_p
		end

end

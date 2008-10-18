class TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			t1: TEST1 [INTEGER]
			t2: TEST4
		do
			create t2
			create t1
			t1.extend (1)
		end

end

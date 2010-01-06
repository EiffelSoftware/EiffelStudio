class TEST
create
	make

feature

	make is
		local
			t1: TEST1 [INTEGER]
			t2: TEST1 [STRING]
		do
			create t1.make
			create t2.make
		end

end

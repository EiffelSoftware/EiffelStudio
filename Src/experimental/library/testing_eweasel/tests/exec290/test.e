class TEST
create
	make

feature

	make is
		local
			t1: TEST1 [ANY]
			t2: TEST1 [INTEGER]
			t3: TEST1 [INTEGER_64]
		do
			create t1.make ("STRING")
			create t2.make (0x80000000)
			create t3.make (0x8000000000000000)
			create t2.make (0x00000001)
			create t3.make (0x0000000000000001)
		end

end

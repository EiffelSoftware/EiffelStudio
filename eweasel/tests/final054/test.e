class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			t1_a: TEST1 [ANY]
			t1: TEST1 [INTEGER]
			t2_a: TEST2 [ANY]
			t2: TEST2 [INTEGER]
		do
			create t2
			t2.make (2, 4)
			t2.make2 (2, 4)

			t2_a := t2
			t2_a.make (2, 4)
			t2_a.make2 (2, 4)

			t1 := t2
			t1.make (2, 4)
			t1.make2 (2, 4)

			t1_a := t2
			t1_a.make (2, 4)
			t1_a.make2 (2, 4)
		end

end

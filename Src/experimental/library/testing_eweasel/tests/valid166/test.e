class TEST
creation
	make
feature

	make is
		local
			t: TEST1 [ANY]
			t2: TEST1 [INTEGER]
		do
			create t.make
			create t2.make
		end

end


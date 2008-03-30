class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			t1: TEST1 [ANY]
			t2: TEST2 [STRING]
		do
			create t2
			t1 := t2
			t1.make (4.5, Void)
		end

end

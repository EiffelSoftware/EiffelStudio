class TEST3

feature

	f
		local
			t2: TEST2
		do
			t1 := t2
		end

	g
		local
			t2: TEST2
		do
			t1 := t2
		end

	t1: TEST1 [STRING]

end

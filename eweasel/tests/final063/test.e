class TEST
create
	make

feature {NONE}

	make
		local
			t: TEST2
			t3: TEST3
		do
			create t
			t.f

			create t3
			t3.f
		end

	t1: TEST1
end

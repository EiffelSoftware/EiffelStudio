class TEST
create
	make

feature {NONE}

	make
		local
			t: TEST2
		do
			create t
			t.f
		end

	t1: TEST1
end

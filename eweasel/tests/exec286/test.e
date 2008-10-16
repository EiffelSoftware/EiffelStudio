class TEST
create
	make

feature {NONE}

	make
		local
			t1: TEST1 [STRING]
			t2: TEST2 [STRING]
		do
			create t1
			t1.f
			create t2
			t2.f
		end

end

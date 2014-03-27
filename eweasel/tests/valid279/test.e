class TEST
		
create
	make

feature {NONE}

	make
		local
			t1: TEST1
			t2: TEST2
		do
			create t1.make ("bar")
			create t2.make ("bar")
		end

end

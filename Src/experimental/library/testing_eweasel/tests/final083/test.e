class TEST
create
	make

feature
	make
		local
			t1: TEST1 [INTEGER, STRING, STRING]
		do
			create t1
			t1.g
		end

end

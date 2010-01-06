class TEST

create
	make

feature 

	make is
		local
			t: TEST1
		do
			create t.make
		end
end

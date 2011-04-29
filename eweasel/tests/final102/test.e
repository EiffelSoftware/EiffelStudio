class 
	TEST

create 
	make

feature 

	make
		local
			t1: TEST4 [STRING_8, STRING_8]
		do
			create t1.make ("s", "s2")
		end
	
end -- class TEST

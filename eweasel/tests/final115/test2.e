class TEST2

inherit
	TEST1 [NONE]
		redefine
			failure
		end

feature

	failure 
		do
			io.put_string ("In TEST2")
			io.put_new_line
		end

end

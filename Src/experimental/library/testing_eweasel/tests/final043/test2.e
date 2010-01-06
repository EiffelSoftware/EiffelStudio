class
	TEST2

inherit
	TEST1
		redefine
			g
		end

feature

	g is
		do
			print ("TEST2%N")
		end

end

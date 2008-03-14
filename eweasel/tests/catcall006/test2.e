class TEST2

inherit
	TEST1
		redefine
			 f
		end

feature

	f is
		do
			print ("Calling TEST2.f%N")
			attr.g
		end
	g is
		do
			print ("Calling TEST2.g%N")
		end

end

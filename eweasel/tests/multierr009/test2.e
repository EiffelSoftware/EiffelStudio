class
	TEST2

inherit
	TEST1
		redefine
			make
		end

create
	make

feature

	make is
		do
			print ("Hello%N")
		end

end

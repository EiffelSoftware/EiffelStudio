class TEST
inherit
	TEST1
		redefine
			f
		end

create
	make

feature

	f is
		do
			print ("Success 2%N")
		end

end

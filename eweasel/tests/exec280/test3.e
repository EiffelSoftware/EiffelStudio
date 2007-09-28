class
	TEST3

inherit
	TEST2 [INTEGER]
		redefine
			default_create
		end

feature

	default_create is
		do
			print ("TEST3.default_create%N")
			create string.make_empty
		end

end

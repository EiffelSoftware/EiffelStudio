class
	TEST2 [G]

inherit
	TEST1 [G]
		redefine
			make
		end

feature

	make (v: like int; g: like item) is
		do
			print (v)
		end

end

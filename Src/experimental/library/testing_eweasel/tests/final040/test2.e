class
	TEST2 [reference G -> TEST4]

inherit
	TEST1
		redefine
			b
		end

feature

	b: G is do end

end

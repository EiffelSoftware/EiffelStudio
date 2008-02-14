class TEST2
inherit
	TEST1 [A]
		redefine
			s
		end

feature
	s: B

end

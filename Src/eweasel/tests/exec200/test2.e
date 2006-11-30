class TEST2
inherit
	TEST1 [STRING]
		redefine
			s
		end

feature
	s: DIRECTORY_NAME

end

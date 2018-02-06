class TEST5

inherit
	PARENT
	TEST2
		redefine
			value
		end
	TEST3
		redefine
			value
		end
	TEST4
		redefine
			value
		end

feature

	value: INTEGER = 7

end


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
	value: INTEGER
		external "C inline"
		alias "7"
		end
end

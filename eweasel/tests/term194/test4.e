
class TEST4
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
feature
	value: INTEGER
		once ("OBJECT")
			Result := 13
		end

end

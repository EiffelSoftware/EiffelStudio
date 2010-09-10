
class TEST3
inherit
	PARENT
	TEST2
		redefine
			value
		end
feature
	value: INTEGER
		once ("OBJECT")
			Result := 29
		end

end

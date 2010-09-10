
class TEST3
inherit
	TEST4
		redefine
			value
		end
	TEST5
		redefine
			value
		end
feature
	value: INTEGER
		once ("OBJECT")
			Result := 29 + precursor {TEST4} + precursor {TEST5}
		end
	
end

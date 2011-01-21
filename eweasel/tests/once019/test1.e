
class TEST1
inherit
	TEST2
		redefine
			value
		end
feature
	value: STRING
		once ("OBJECT")
			Result := "Ermine"
		end
		
end

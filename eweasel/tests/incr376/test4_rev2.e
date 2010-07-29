
class TEST4 [G]
inherit
	TEST2
		redefine
			val
		end
feature
	val: STRING
		once ("OBJECT")
			Result := precursor
		end
	
end

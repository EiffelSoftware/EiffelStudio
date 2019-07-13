
class TEST4 [G]
inherit
	TEST2
		redefine
			val
		end
feature
	val: READABLE_STRING_8
		once ("OBJECT")
			Result := precursor
		end
	
end


class TEST2
inherit
	TEST3
		redefine
			a, b, c
		end
feature
	a: INTEGER
	   once ("OBJECT")
	   	Result := 4 + precursor
	   end

	b: INTEGER
	   once ("OBJECT")
	   	Result := 5 + precursor
	   end

	c: INTEGER
	   once ("OBJECT")
	   	Result := 6 + precursor
	   end

end


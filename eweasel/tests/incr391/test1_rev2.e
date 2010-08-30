
class TEST1
inherit
	TEST3
		redefine
			c
		end
feature
	c: INTEGER
	   once ("OBJECT")
	   	Result := 3
	   end

end


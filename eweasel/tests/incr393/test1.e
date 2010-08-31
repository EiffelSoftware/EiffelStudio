
class TEST1
inherit
	TEST2
		redefine
			c
		end
feature
	c: INTEGER
	   external "C inline"
	   alias "47"
	   end

end


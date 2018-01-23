class TEST1

inherit
	TEST2
		redefine
			c
		end

feature

	c: INTEGER
		do
			Result := 47
		end

end

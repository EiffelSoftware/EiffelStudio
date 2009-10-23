class
	TEST

create
	make

feature {NONE} -- Creation

	make (args: ARRAY [STRING])
		local
			a1, a2: COMPARABLE
			b: BOOLEAN
			c1: TEST1 [STRING, INTEGER]
		do
			a1 := ""
			a2 := ""
			b := a1 < a2
			create c1
		end

feature -- Basic operations

	plus alias "+" (other: TEST): TEST
		do
			Result := Current
		end

end

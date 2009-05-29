class A

create
	make

convert
	make ({TUPLE [STRING]})

feature {NONE} -- Creation

	make (a: TUPLE [i: STRING])
			-- Initialize `item' from `a'.
		do
			item := a.i
		end

feature -- Access
		
	item: STRING
			-- Data

end
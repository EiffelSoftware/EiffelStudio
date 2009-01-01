indexing
	description	: "System's root class"

class
	TEST

create
	make 

feature -- Initialization
	
	
	make is
		local
			a: A [REAL_32]
			c: A [CHARACTER_8]
			l_r: REAL_32
			l_c: CHARACTER_8
		do
			create a
			a.f.t1 := 1_0
			l_r := a.f.t1

			create c
			c.f.t1 := 'a'
			l_c := c.f.t1
		end
	
		

end -- class ROOT_CLASS


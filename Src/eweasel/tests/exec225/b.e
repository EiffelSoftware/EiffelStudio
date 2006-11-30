expanded class B[G]

inherit

	A[G]
		redefine
			default_create
		end

feature

	default_create is
		do
			a := "B" 
		end

	b: INTEGER

	set_b (new_b: INTEGER) is
		do
			b := new_b
		end 

end

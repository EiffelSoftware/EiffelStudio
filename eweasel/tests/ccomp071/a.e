expanded class
	A

feature -- Access

	a: INTEGER
	s: separate STRING

feature -- Settings

	set (i: like a; a_s: like s)
		do
			a := i
			s := a_s
		end

end

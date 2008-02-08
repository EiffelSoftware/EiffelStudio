expanded class
	A

feature -- Access

	a: INTEGER
	s: STRING

feature -- Settings

	set (i: like a; a_s: like s) is
		do
			a := i
			s := a_s
		end

end

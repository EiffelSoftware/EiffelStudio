expanded class
	C [G]

inherit
	ANY
		redefine
			default_create
		end

feature

	default_create is
		do
			i := 5
		end

	i: INTEGER

end


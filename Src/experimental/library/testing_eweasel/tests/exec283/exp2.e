expanded class
	EXP2

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature

	default_create is
		do
			i := 5
		end

	i: INTEGER

end

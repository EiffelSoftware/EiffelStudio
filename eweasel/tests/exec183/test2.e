expanded class
	TEST2

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
			name := "Emmanuel"
		end

	name: STRING

	set_name (s: like name) is
		do
			name := s
		end

	to_reference: ANY is
		do
		end

end -- class TEST2


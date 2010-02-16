expanded class
	EXP4

inherit
	ANY
		redefine
			default_create, is_equal
		end

create
	default_create

feature

	default_create
		do
			create s.make (10)
			s.append ("toto")
		end

	is_equal (o: like Current): BOOLEAN
		do
			Result := s.is_equal (o.s)
		end

	s: STRING

end

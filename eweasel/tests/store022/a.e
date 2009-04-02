expanded class A
inherit
	ANY
		redefine
			default_create,
			is_equal
		end

create
	default_create

feature {NONE} -- Creation

	default_create is
		do
			create s.make_from_string ("TEST")
			i := -1
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
		do
			Result := s ~ other.s and then i = other.i
		end

feature -- Access

	s: STRING
	i: INTEGER

end

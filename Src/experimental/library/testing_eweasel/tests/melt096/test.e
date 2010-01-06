class
	TEST

creation

	make

feature -- Initialization

	make is
		do
			test_appended
			test_infix_plus
		end

	test_appended is
			-- Output a welcome message.
			--| (Automatically generated.)
		local
			s, t, u: ES_STRING
			i: INTEGER
			d: DOUBLE
		do
			!! s.make_from_string ("hello ")
			!! t.make_from_string ("you bludger!")
			u := s.appended (t)
			u := u.appended (u)
			u := u.appended (i)
			u := u.appended (d)
		end;

	test_infix_plus is
			-- Output a welcome message.
			--| (Automatically generated.)
		local
			s, t, u: ES_STRING
			i: INTEGER
			d: DOUBLE
		do
			!! s.make_from_string ("hello ")
			!! t.make_from_string ("you bludger!")
			u := s + t
			u := u + u
			u := u + i
			u := u + d
		end;


end

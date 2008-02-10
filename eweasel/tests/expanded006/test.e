indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_a: A [ANY]
			l_b: A [EXPANDED_CLASS [B]]
			l_c: A [EXPANDED_CLASS [C]]
		do
			create l_a
			create l_b
			create l_c
			test_object (l_a)
			test_object (l_b)
			test_object (l_c)
		end

	test_object (a: A [ANY]) is
		require
			a /= Void
		do
			io.put_string ("Printing ")
			io.put_string (a.generating_type)
			io.put_new_line
			if a.a /= Void then
				io.put_string (a.a.generating_type)
				io.put_new_line
			end
			if a.b /= Void then
				io.put_string (a.b.generating_type)
				io.put_new_line
			end
			io.put_string (a.c1.generating_type)
			io.put_new_line
			io.put_string (a.c2.generating_type)
			io.put_new_line
			io.put_string (a.d1.generating_type)
			io.put_new_line
			io.put_string (a.d2.generating_type)
			io.put_new_line

			if a.f_a /= Void then
				io.put_string (a.f_a.generating_type)
				io.put_new_line
			end
			if a.f_b /= Void then
				io.put_string (a.f_b.generating_type)
				io.put_new_line
			end
			io.put_string (a.f_c1.generating_type)
			io.put_new_line
			io.put_string (a.f_c2.generating_type)
			io.put_new_line
			io.put_string (a.f_d1.generating_type)
			io.put_new_line
			io.put_string (a.f_d2.generating_type)
			io.put_new_line

			io.put_new_line
		end


end 

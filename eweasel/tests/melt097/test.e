class
	TEST

create
	make

feature -- Initialization

	make is
		local
			exp2: TEST2 [INTEGER]
			exp2_bis: TEST2 [TEST3]
			exp3: TEST3
			s: STRING_8
			i16: INTEGER_16
		do
			create exp2
			create exp2_bis
			create s.make_empty

			print_type_data (s, {STRING_8})
			print_type_data (i16, {INTEGER_16})
			print_type_data (exp2, {TEST2 [INTEGER]})
			print_type_data (exp2_bis, {TEST2 [TEST3]})
			print_type_data (exp3, {TEST3})

		end

	print_type_data (a: ANY; t: TYPE [ANY])
		require
			a_not_void: a /= Void
		local
			internal: INTERNAL
			l_default: detachable ANY
			i, nb: INTEGER
		do
			create internal

			io.put_string (a.generating_type.name)
			io.put_new_line

			io.put_boolean (t = a.generating_type)
			io.put_new_line

			io.put_boolean (internal.dynamic_type (a) = a.generating_type.type_id)
			io.put_new_line

			io.put_boolean (a.generating_type.has_default)
			io.put_new_line

			if a.generating_type.has_default then
				l_default := a.generating_type.default
				if l_default /= Void then
					io.put_string (l_default.out)
					io.put_new_line
				else
					io.put_string ("Void%N")
				end
			end

			from
				i := 1
				nb := a.generating_type.generic_parameter_count
				io.put_integer (nb)
				io.put_new_line
			until
				i > nb
			loop
				io.put_string (a.generating_type.generic_parameter_type (i))
				io.put_new_line
				i := i + 1
			end
		end

end

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

			print_type_data (s, {detachable STRING_8})
			print_type_data (s, {STRING_8})
			print_type_data (i16, {INTEGER_16})
			print_type_data (exp2, {TEST2 [INTEGER]})
			print_type_data (exp2_bis, {TEST2 [TEST3]})
			print_type_data (exp3, {TEST3})

			check_default_precondition ({TEST3})
			check_default_precondition ({INTEGER_16})
			check_default_precondition ({detachable STRING_8})
			check_default_precondition ({STRING_8})
		end

	print_type_data (a: ANY; t: TYPE [detachable ANY])
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
			io.put_string (t.name)
			io.put_new_line

			io.put_boolean (t = a.generating_type)
			io.put_new_line

			io.put_boolean (internal.dynamic_type (a) = a.generating_type.type_id)
			io.put_new_line

			io.put_boolean (a.generating_type.has_default)
			io.put_new_line

			io.put_boolean (t.has_default)
			io.put_new_line

			if t.has_default then
				l_default := t.default
				if l_default /= Void then
					io.put_string (l_default.out)
					io.put_new_line
				else
					io.put_string ("Void%N")
				end
			end

			from
				i := 1
				nb := t.generic_parameter_count
				io.put_integer (nb)
				io.put_new_line
			until
				i > nb
			loop
				io.put_string (t.generic_parameter_type (i))
				io.put_new_line
				i := i + 1
			end
			io.put_new_line
		end

	check_default_precondition (t: TYPE [detachable ANY])
		require
			t_not_void: t /= Void
		local
			l_default: detachable ANY
			retried: BOOLEAN
		do
			if not retried then
				if not t.has_default then
					l_default := t.default
				end
			else
				io.put_string ("Exception for " + t.name)
				io.put_new_line
			end
		rescue
			retried := True
			retry
		end

end

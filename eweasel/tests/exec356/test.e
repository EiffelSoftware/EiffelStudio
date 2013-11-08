class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			e1: E1
			e2: E2
			i1: I1
			i2: I2
			a: A [B, B, B, B]
			b: B
		do
			create e1
			create e2
			create i1
			create i2
			create fe1
			create fe2
			create fi1
			create fi2
				-- Perform calls on locals.
			io.put_string ("Local"); io.put_new_line
			io.put_string (e1 (2)); io.put_new_line
			io.put_string (e2 (4, 6)); io.put_new_line
			i1 (3)
			i2 (5, 7)
				-- Perform calls on locals with qualified calls on them.
			io.put_string ("Local with call"); io.put_new_line
			io.put_string (e1 (7).out); io.put_new_line
			io.put_string (e2 (8, 9).out); io.put_new_line
				-- Perform calls on arguments.
			io.put_string ("Argument"); io.put_new_line
			f (e1, e2, i1, i2)
				-- Perform calls on unqualified features.
			io.put_string ("Unqualified"); io.put_new_line
			io.put_string (fe1 (2)); io.put_new_line
			io.put_string (fe2 (4, 6)); io.put_new_line
			fi1 (3)
			fi2 (5, 7)
				-- Perform calls on unqualified features with qualified calls on them.
			io.put_string ("Unqualified with call"); io.put_new_line
			io.put_string (fe1 (1).out); io.put_new_line
			io.put_string (fe2 (2, 3).out); io.put_new_line
				-- Perform calls on qualified features.
			io.put_string ("Qualified"); io.put_new_line
			io.put_string (Current.fe1 (1)); io.put_new_line
			io.put_string (Current.fe2 (3, 5)); io.put_new_line
			Current.fi1 (2)
			Current.fi2 (4, 6)
				-- Perform calls on qualified features with qualified calls on them.
			io.put_string ("Qualified with call"); io.put_new_line
			io.put_string (Current.fe1 (3).out); io.put_new_line
			io.put_string (Current.fe2 (4, 5).out); io.put_new_line
				-- Perform calls on Precursor.
			io.put_string ("Precursor"); io.put_new_line
			create b
			b.this_e1.do_nothing
			b.this_e2.do_nothing
			b.this_i1.do_nothing
			b.this_i2.do_nothing
				-- Test renaming in formal generics.
			io.put_string ("Renaming"); io.put_new_line
			create a
			a.test_renaming (b, b, b, b)
		end

feature

	f (ae1: E1; ae2: E2; ai1: I1; ai2: I2)
			-- Performs calls on arguments.
		require
			ae1: is_ok (ae1 (0))
			ae2: is_ok (ae2 (0, 0))
			fe1: is_ok (fe1 (10))
			fe2: is_ok (fe2 (10, 10))
			oe1: attached ae1 as oe1 implies is_ok (oe1 (12))
			oe2: attached ae2 as oe2 implies is_ok (oe2 (12, 13))
		do
			io.put_string (ae1 (1)); io.put_new_line
			io.put_string (ae2 (2, 3)); io.put_new_line
			ai1 (4)
			ai2 (5, 6)
		end

feature

	fe1: E1
	fe2: E2
	fi1: I1
	fi2: I2

feature

	is_ok (s: STRING): BOOLEAN
		do
			io.put_string (s)
			io.put_new_line
			Result := True
		end

end

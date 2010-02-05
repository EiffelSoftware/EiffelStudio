class
	TEST

create
	make

feature
	make
		do
			io.put_double (nan.min (4.0))
			io.put_new_line
			io.put_double ((4.0).min (nan))
			io.put_new_line
			io.put_double (nan.max (4.0))
			io.put_new_line
			io.put_double ((4.0).max (nan))
			io.put_new_line
		end

	nan_as_natural_64: NATURAL_64 is 0x7FF8000000000000

	nan: DOUBLE is
		local
			l_ptr: MANAGED_POINTER
		once
			create l_ptr.make (8)
			l_ptr.put_natural_64 (nan_as_natural_64, 0)
			Result := l_ptr.read_real_64 (0)
		end

	same_double (d1, d2: DOUBLE): BOOLEAN is
		do
			Result := ($d1).memory_compare ($d2, 8)
		end

end

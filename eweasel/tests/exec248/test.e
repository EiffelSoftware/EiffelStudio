class
	TEST

create
	make

feature
	make
		do
			if "$DATA" = "$DATA" then
			end
			io.put_real ({REAL_32}.nan.min ({REAL_32} 4.0))
			io.put_new_line
			io.put_real (({REAL_32} 4.0).min ({REAL_32}.nan))
			io.put_new_line
			io.put_real ({REAL_32}.nan.max ({REAL_32} 4.0))
			io.put_new_line
			io.put_real (({REAL_32} 4.0).max ({REAL_32}.nan))
			io.put_new_line
			io.put_double ({REAL_64}.nan.min (4.0))
			io.put_new_line
			io.put_double ((4.0).min ({REAL_64}.nan))
			io.put_new_line
			io.put_double ({REAL_64}.nan.max (4.0))
			io.put_new_line
			io.put_double ((4.0).max ({REAL_64}.nan))
			io.put_new_line
		end

end

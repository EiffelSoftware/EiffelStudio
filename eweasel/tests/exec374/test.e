class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			report_32 ( 1,  1)
			report_32 (-1,  1)
			report_32 ( 1, -1)
			report_32 (-1, -1)
			report_32 ( 1, {REAL_32}.nan)
			report_32 ({REAL_32}.nan, 1)
			report_32 ({REAL_32}.nan, {REAL_32}.nan)
			report_32 ({REAL_32}.positive_infinity, {REAL_32}.positive_infinity)
			report_32 ({REAL_32}.negative_infinity, {REAL_32}.positive_infinity)
			report_32 ({REAL_32}.positive_infinity, {REAL_32}.negative_infinity)
			report_32 ({REAL_32}.negative_infinity, {REAL_32}.negative_infinity)
			report_32 ({REAL_32}.positive_infinity, {REAL_32}.nan)
			report_32 ({REAL_32}.nan, {REAL_32}.positive_infinity)
			report_32 ({REAL_32}.negative_infinity, {REAL_32}.nan)
			report_32 ({REAL_32}.nan, {REAL_32}.negative_infinity)
			io.put_new_line
			report_64 ( 1,  1)
			report_64 (-1,  1)
			report_64 ( 1, -1)
			report_64 (-1, -1)
			report_64 ( 1, {REAL_64}.nan)
			report_64 ({REAL_64}.nan, 1)
			report_64 ({REAL_64}.nan, {REAL_64}.nan)
			report_64 ({REAL_64}.positive_infinity, {REAL_64}.positive_infinity)
			report_64 ({REAL_64}.negative_infinity, {REAL_64}.positive_infinity)
			report_64 ({REAL_64}.positive_infinity, {REAL_64}.negative_infinity)
			report_64 ({REAL_64}.negative_infinity, {REAL_64}.negative_infinity)
			report_64 ({REAL_64}.positive_infinity, {REAL_64}.nan)
			report_64 ({REAL_64}.nan, {REAL_64}.positive_infinity)
			report_64 ({REAL_64}.negative_infinity, {REAL_64}.nan)
			report_64 ({REAL_64}.nan, {REAL_64}.negative_infinity)
		end

feature {NONE} -- Output

	report_32 (x, y: REAL_32)
			-- Print results of comparison `x` to `y`.
		do
			io.put_string ("REAL_32: ")
			io.put_real (x)
			io.put_character (' ')
			io.put_real (y)
			io.put_new_line
			io.put_string ("  =  std: " + (x  = y).to_integer.out + " ieee: " + x.ieee_is_equal         (y).to_integer.out +
				" is_equal: "          + x.is_equal (y).to_integer.out          +
				" is_deep_equal: "     + x.is_deep_equal (y).to_integer.out     +
				" standard_is_equal: " + x.standard_is_equal (y).to_integer.out + "%N")
			io.put_string (" <=  std: " + (x <= y).to_integer.out + " ieee: " + x.ieee_is_less_equal    (y).to_integer.out + "%N")
			io.put_string (" <   std: " + (x <  y).to_integer.out + " ieee: " + x.ieee_is_less          (y).to_integer.out + "%N")
			io.put_string (" >   std: " + (x >  y).to_integer.out + " ieee: " + x.ieee_is_greater       (y).to_integer.out + "%N")
			io.put_string (" >=  std: " + (x >= y).to_integer.out + " ieee: " + x.ieee_is_greater_equal (y).to_integer.out + "%N")
			io.put_string (" max std: " + x.max (y).out + " ieee: " + x.ieee_maximum_number (y).out + "%N")
			io.put_string (" min std: " + x.min (y).out + " ieee: " + x.ieee_minimum_number (y).out + "%N")
		end

	report_64 (x, y: REAL_64)
			-- Print results of comparison `x` to `y`.
		do
			io.put_string ("REAL_64: ")
			io.put_double (x)
			io.put_character (' ')
			io.put_double (y)
			io.put_new_line
			io.put_string ("  =  std: " + (x  = y).to_integer.out + " ieee: " + x.ieee_is_equal         (y).to_integer.out +
				" is_equal: "          + x.is_equal (y).to_integer.out          +
				" is_deep_equal: "     + x.is_deep_equal (y).to_integer.out     +
				" standard_is_equal: " + x.standard_is_equal (y).to_integer.out + "%N")
			io.put_string (" <=  std: " + (x <= y).to_integer.out + " ieee: " + x.ieee_is_less_equal    (y).to_integer.out + "%N")
			io.put_string (" <   std: " + (x <  y).to_integer.out + " ieee: " + x.ieee_is_less          (y).to_integer.out + "%N")
			io.put_string (" >   std: " + (x >  y).to_integer.out + " ieee: " + x.ieee_is_greater       (y).to_integer.out + "%N")
			io.put_string (" >=  std: " + (x >= y).to_integer.out + " ieee: " + x.ieee_is_greater_equal (y).to_integer.out + "%N")
			io.put_string (" max std: " + x.max (y).out + " ieee: " + x.ieee_maximum_number (y).out + "%N")
			io.put_string (" min std: " + x.min (y).out + " ieee: " + x.ieee_minimum_number (y).out + "%N")
		end

end

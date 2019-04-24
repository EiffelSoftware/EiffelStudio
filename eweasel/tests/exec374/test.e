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
			io.put_string ("  = std: " + (x  = y).to_integer.out + " ieee: " + x.ieee_is_equal         (y).to_integer.out + "%N")
			io.put_string (" <= std: " + (x <= y).to_integer.out + " ieee: " + x.ieee_is_less_equal    (y).to_integer.out + "%N")
			io.put_string (" <  std: " + (x <  y).to_integer.out + " ieee: " + x.ieee_is_less          (y).to_integer.out + "%N")
			io.put_string (" >  std: " + (x >  y).to_integer.out + " ieee: " + x.ieee_is_greater       (y).to_integer.out + "%N")
			io.put_string (" >= std: " + (x >= y).to_integer.out + " ieee: " + x.ieee_is_greater_equal (y).to_integer.out + "%N")
		end

end

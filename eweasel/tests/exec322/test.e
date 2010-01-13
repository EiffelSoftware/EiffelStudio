class TEST

create
	make

feature

	make
		do
			test_real_64_nan
			test_real_64_log_2
			test_real_64_log10
			test_real_64_log
			test_real_64_cosine
			test_real_64_arc_cosine
			test_real_64_sine
			test_real_64_arc_sine
			test_real_64_tangent
			test_real_64_arc_tangent
			test_real_64_sqrt
			test_real_64_exp
			test_real_64_floor
			test_real_64_ceiling
			test_real_64_dabs
			test_real_64_pow
		end

	test_real_64_nan
		local
			x: INTEGER
			d: REAL_64
		do
				-- The indeterminate forms
			d := x / x
			check_is_real_64_nan (d)

			d := {REAL_64}.positive_infinity / {REAL_64}.positive_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.positive_infinity / {REAL_64}.negative_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.negative_infinity / {REAL_64}.positive_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.negative_infinity / {REAL_64}.negative_infinity
			check_is_real_64_nan (d)

			d := {REAL_64} 0.0 * {REAL_64}.positive_infinity
			check_is_real_64_nan (d)

			d := {REAL_64} 0.0 * {REAL_64}.negative_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.positive_infinity + {REAL_64}.negative_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.negative_infinity + {REAL_64}.positive_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.positive_infinity - {REAL_64}.positive_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.negative_infinity - {REAL_64}.negative_infinity
			check_is_real_64_nan (d)
		end

	test_real_64_log_2
		local
			d: REAL_64
		do
			d := real_64_math.log_2 ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.log_2 (-1)
			check_is_real_64_nan (d)

			d := real_64_math.log_2 (-4)
			check_is_real_64_nan (d)

			d := real_64_math.log_2 ({REAL_64} 1.0)
			check_one (d = {REAL_64} 0.0)

			d := real_64_math.log_2 ({REAL_64}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_64_math.log_2 ({REAL_64}.negative_infinity)
			check_is_real_64_nan (d)
		end

	test_real_64_log10
		local
			d: REAL_64
		do
			d := real_64_math.log10 ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.log10 (-1)
			check_is_real_64_nan (d)

			d := real_64_math.log10 (-4)
			check_is_real_64_nan (d)

			d := real_64_math.log10 ({REAL_64} 1.0)
			check_one (d = {REAL_64} 0.0)

			d := real_64_math.log10 ({REAL_64}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_64_math.log10 ({REAL_64}.negative_infinity)
			check_is_real_64_nan (d)
		end

	test_real_64_log
		local
			d: REAL_64
		do
			d := real_64_math.log ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.log (-1)
			check_is_real_64_nan (d)

			d := real_64_math.log (-4)
			check_is_real_64_nan (d)

			d := real_64_math.log ({REAL_64} 1.0)
			check_one (d = {REAL_64} 0.0)

			d := real_64_math.log ({REAL_64}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_64_math.log ({REAL_64}.negative_infinity)
			check_is_real_64_nan (d)
		end

	test_real_64_cosine
		local
			d: REAL_64
		do
			d := real_64_math.cosine ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.cosine ({REAL_64}.positive_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.cosine ({REAL_64}.negative_infinity)
			check_is_real_64_nan (d)
		end

	test_real_64_arc_cosine
		local
			d: REAL_64
		do
			d := real_64_math.arc_cosine ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64}.positive_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64}.negative_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64} -1.1)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64} -5.0)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64} 1.1)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64} 5.0)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64} 1.0)
			check_one (d = {REAL_64} 0.0)
		end

	test_real_64_sine
		local
			d: REAL_64
		do
			d := real_64_math.sine ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.sine ({REAL_64}.positive_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.sine ({REAL_64}.negative_infinity)
			check_is_real_64_nan (d)
		end

	test_real_64_arc_sine
		local
			d: REAL_64
		do
			d := real_64_math.arc_sine ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.arc_sine ({REAL_64}.positive_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.arc_sine ({REAL_64}.negative_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.arc_sine ({REAL_64} -1.1)
			check_is_real_64_nan (d)

			d := real_64_math.arc_sine ({REAL_64} -5.0)
			check_is_real_64_nan (d)

			d := real_64_math.arc_sine ({REAL_64} 1.1)
			check_is_real_64_nan (d)

			d := real_64_math.arc_sine ({REAL_64} 5.0)
			check_is_real_64_nan (d)

			d := real_64_math.arc_sine ({REAL_64} 0.0)
			check_one (d = {REAL_64} 0.0)

			d := real_64_math.arc_sine ({REAL_64} -0.0)
			check_one (d = {REAL_64} -0.0)
		end

	test_real_64_tangent
		local
			d: REAL_64
		do
			d := real_64_math.tangent ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.tangent ({REAL_64}.positive_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.tangent ({REAL_64}.negative_infinity)
			check_is_real_64_nan (d)
		end

	test_real_64_arc_tangent
		local
			d: REAL_64
		do
			d := real_64_math.arc_tangent ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.arc_tangent ({REAL_64}.positive_infinity)
			check_one (d = {MATH_CONST}.pi_2)

			d := real_64_math.arc_tangent ({REAL_64}.negative_infinity)
			check_one (d = -{MATH_CONST}.pi_2)

			d := real_64_math.arc_sine ({REAL_64} 0.0)
			check_one (d = {REAL_64} 0.0)

			d := real_64_math.arc_sine ({REAL_64} -0.0)
			check_one (d = {REAL_64} -0.0)
		end

	test_real_64_sqrt
		local
			d: REAL_64
		do
			d := real_64_math.sqrt ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.sqrt ({REAL_64} -5.0)
			check_is_real_64_nan (d)

			d := real_64_math.sqrt ({REAL_64} -1.0)
			check_is_real_64_nan (d)

			d := real_64_math.sqrt ({REAL_64} 0.0)
			check_one (d = {REAL_64} 0.0)

			d := real_64_math.sqrt ({REAL_64} -0.0)
			check_one (d = {REAL_64} -0.0)

			d := real_64_math.sqrt ({REAL_64}.positive_infinity)
			check_one (d.is_positive_infinity)
		end

	test_real_64_exp
		local
			d: REAL_64
		do
			d := real_64_math.exp ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.exp ({REAL_64}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_64_math.exp ({REAL_64}.negative_infinity)
			check_one (d = {REAL_64} 0.0)
		end

	test_real_64_floor
		local
			d: REAL_64
		do
			d := real_64_math.floor ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.floor ({REAL_64}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_64_math.floor ({REAL_64}.negative_infinity)
			check_one (d.is_negative_infinity)
	
			d := real_64_math.floor ({REAL_64} 0.0)
			check_one (d = {REAL_64} 0.0)
	
			d := real_64_math.floor ({REAL_64} -0.0)
			check_one (d = {REAL_64} -0.0)

			d := {REAL_64}.nan
			d := d.floor_real_64
			check_is_real_64_nan (d)

			d := {REAL_64}.positive_infinity
			d := d.floor_real_64
			check_one (d.is_positive_infinity)

			d := {REAL_64}.negative_infinity
			d := d.floor_real_64
			check_one (d.is_negative_infinity)
	
			d := {REAL_64} 0.0
			d := d.floor_real_64
			check_one (d = {REAL_64} 0.0)
	
			d := {REAL_64} -0.0
			d := d.floor_real_64
			check_one (d = {REAL_64} -0.0)
		end

	test_real_64_ceiling
		local
			d: REAL_64
		do
			d := real_64_math.ceiling ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.ceiling ({REAL_64}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_64_math.ceiling ({REAL_64}.negative_infinity)
			check_one (d.is_negative_infinity)
	
			d := real_64_math.ceiling ({REAL_64} 0.0)
			check_one (d = {REAL_64} 0.0)
	
			d := real_64_math.ceiling ({REAL_64} -0.0)
			check_one (d = {REAL_64} -0.0)

			d := {REAL_64}.nan
			d := d.ceiling_real_64
			check_is_real_64_nan (d)

			d := {REAL_64}.positive_infinity
			d := d.ceiling_real_64
			check_one (d.is_positive_infinity)

			d := {REAL_64}.negative_infinity
			d := d.ceiling_real_64
			check_one (d.is_negative_infinity)
	
			d := {REAL_64} 0.0
			d := d.ceiling_real_64
			check_one (d = {REAL_64} 0.0)
	
			d := {REAL_64} -0.0
			d := d.ceiling_real_64
			check_one (d = {REAL_64} -0.0)
		end

	test_real_64_dabs
		local
			d: REAL_64
		do
			d := real_64_math.dabs ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.dabs ({REAL_64}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_64_math.dabs ({REAL_64}.negative_infinity)
			check_one (d.is_positive_infinity)
	
			d := real_64_math.dabs ({REAL_64} 0.0)
			check_one (d = {REAL_64} 0.0)
	
			d := real_64_math.dabs ({REAL_64} -0.0)
			check_one (d = {REAL_64} 0.0)
		end

	test_real_64_pow
		local
			d: REAL_64
		do
			d := {REAL_64} 1.0 ^ {REAL_64}.positive_infinity
			check_real_64_equal (d, {REAL_64} 1.0)
		end

	check_real_64_equal (a, b: REAL_64)
		do
			if a /= b then
				io.put_string ("Not equal%N")
			end
		end

	check_is_real_64_nan (d: REAL_64)
		do
			check_one (d.is_nan)
			check_one (not d.is_negative_infinity)
			check_one (not d.is_positive_infinity)
		end

	check_one (v: BOOLEAN)
		do
			if not v then
				io.put_string ("Not OK%N")
			end
		end

	real_64_math: DOUBLE_MATH
		once
			create Result
		end

end

class TEST_REAL_32

create
	make

feature

	make
		do
			test_real_32_nan
			test_real_32_log_2
			test_real_32_log10
			test_real_32_log
			test_real_32_cosine
			test_real_32_arc_cosine
			test_real_32_sine
			test_real_32_arc_sine
			test_real_32_tangent
			test_real_32_arc_tangent
			test_real_32_sqrt
			test_real_32_exp
			test_real_32_floor
			test_real_32_ceiling
			test_real_32_rabs
			test_real_32_pow
		end

	test_real_32_nan
		local
			x: INTEGER
			d: REAL_32
		do
				-- The indeterminate forms
			d := (x / x).truncated_to_real
			check_is_real_32_nan (d)

			d := {REAL_32}.positive_infinity / {REAL_32}.positive_infinity
			check_is_real_32_nan (d)

			d := {REAL_32}.positive_infinity / {REAL_32}.negative_infinity
			check_is_real_32_nan (d)

			d := {REAL_32}.negative_infinity / {REAL_32}.positive_infinity
			check_is_real_32_nan (d)

			d := {REAL_32}.negative_infinity / {REAL_32}.negative_infinity
			check_is_real_32_nan (d)

			d := {REAL_32} 0.0 * {REAL_32}.positive_infinity
			check_is_real_32_nan (d)

			d := {REAL_32} 0.0 * {REAL_32}.negative_infinity
			check_is_real_32_nan (d)

			d := {REAL_32}.positive_infinity + {REAL_32}.negative_infinity
			check_is_real_32_nan (d)

			d := {REAL_32}.negative_infinity + {REAL_32}.positive_infinity
			check_is_real_32_nan (d)

			d := {REAL_32}.positive_infinity - {REAL_32}.positive_infinity
			check_is_real_32_nan (d)

			d := {REAL_32}.negative_infinity - {REAL_32}.negative_infinity
			check_is_real_32_nan (d)
		end

	test_real_32_log_2
		local
			d: REAL_32
		do
			d := real_32_math.log_2 ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.log_2 (-1)
			check_is_real_32_nan (d)

			d := real_32_math.log_2 (-4)
			check_is_real_32_nan (d)

			d := real_32_math.log_2 ({REAL_32} 1.0)
			check_one (d = {REAL_32} 0.0)

			d := real_32_math.log_2 ({REAL_32}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_32_math.log_2 ({REAL_32}.negative_infinity)
			check_is_real_32_nan (d)
		end

	test_real_32_log10
		local
			d: REAL_32
		do
			d := real_32_math.log10 ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.log10 (-1)
			check_is_real_32_nan (d)

			d := real_32_math.log10 (-4)
			check_is_real_32_nan (d)

			d := real_32_math.log10 ({REAL_32} 1.0)
			check_one (d = {REAL_32} 0.0)

			d := real_32_math.log10 ({REAL_32}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_32_math.log10 ({REAL_32}.negative_infinity)
			check_is_real_32_nan (d)
		end

	test_real_32_log
		local
			d: REAL_32
		do
			d := real_32_math.log ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.log (-1)
			check_is_real_32_nan (d)

			d := real_32_math.log (-4)
			check_is_real_32_nan (d)

			d := real_32_math.log ({REAL_32} 1.0)
			check_one (d = {REAL_32} 0.0)

			d := real_32_math.log ({REAL_32}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_32_math.log ({REAL_32}.negative_infinity)
			check_is_real_32_nan (d)
		end

	test_real_32_cosine
		local
			d: REAL_32
		do
			d := real_32_math.cosine ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.cosine ({REAL_32}.positive_infinity)
			check_is_real_32_nan (d)

			d := real_32_math.cosine ({REAL_32}.negative_infinity)
			check_is_real_32_nan (d)
		end

	test_real_32_arc_cosine
		local
			d: REAL_32
		do
			d := real_32_math.arc_cosine ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.arc_cosine ({REAL_32}.positive_infinity)
			check_is_real_32_nan (d)

			d := real_32_math.arc_cosine ({REAL_32}.negative_infinity)
			check_is_real_32_nan (d)

			d := real_32_math.arc_cosine ({REAL_32} -1.1)
			check_is_real_32_nan (d)

			d := real_32_math.arc_cosine ({REAL_32} -5.0)
			check_is_real_32_nan (d)

			d := real_32_math.arc_cosine ({REAL_32} 1.1)
			check_is_real_32_nan (d)

			d := real_32_math.arc_cosine ({REAL_32} 5.0)
			check_is_real_32_nan (d)

			d := real_32_math.arc_cosine ({REAL_32} 1.0)
			check_one (d = {REAL_32} 0.0)
		end

	test_real_32_sine
		local
			d: REAL_32
		do
			d := real_32_math.sine ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.sine ({REAL_32}.positive_infinity)
			check_is_real_32_nan (d)

			d := real_32_math.sine ({REAL_32}.negative_infinity)
			check_is_real_32_nan (d)
		end

	test_real_32_arc_sine
		local
			d: REAL_32
		do
			d := real_32_math.arc_sine ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.arc_sine ({REAL_32}.positive_infinity)
			check_is_real_32_nan (d)

			d := real_32_math.arc_sine ({REAL_32}.negative_infinity)
			check_is_real_32_nan (d)

			d := real_32_math.arc_sine ({REAL_32} -1.1)
			check_is_real_32_nan (d)

			d := real_32_math.arc_sine ({REAL_32} -5.0)
			check_is_real_32_nan (d)

			d := real_32_math.arc_sine ({REAL_32} 1.1)
			check_is_real_32_nan (d)

			d := real_32_math.arc_sine ({REAL_32} 5.0)
			check_is_real_32_nan (d)

			d := real_32_math.arc_sine ({REAL_32} 0.0)
			check_one (d = {REAL_32} 0.0)

			d := real_32_math.arc_sine ({REAL_32} -0.0)
			check_one (d = {REAL_32} -0.0)
		end

	test_real_32_tangent
		local
			d: REAL_32
		do
			d := real_32_math.tangent ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.tangent ({REAL_32}.positive_infinity)
			check_is_real_32_nan (d)

			d := real_32_math.tangent ({REAL_32}.negative_infinity)
			check_is_real_32_nan (d)
		end

	test_real_32_arc_tangent
		local
			d: REAL_32
		do
			d := real_32_math.arc_tangent ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.arc_tangent ({REAL_32}.positive_infinity)
			check_one (d = {MATH_CONST}.pi_2.truncated_to_real)

			d := real_32_math.arc_tangent ({REAL_32}.negative_infinity)
			check_one (d = -{MATH_CONST}.pi_2.truncated_to_real)

			d := real_32_math.arc_sine ({REAL_32} 0.0)
			check_one (d = {REAL_32} 0.0)

			d := real_32_math.arc_sine ({REAL_32} -0.0)
			check_one (d = {REAL_32} -0.0)
		end

	test_real_32_sqrt
		local
			d: REAL_32
		do
			d := real_32_math.sqrt ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.sqrt ({REAL_32} -5.0)
			check_is_real_32_nan (d)

			d := real_32_math.sqrt ({REAL_32} -1.0)
			check_is_real_32_nan (d)

			d := real_32_math.sqrt ({REAL_32} 0.0)
			check_one (d = {REAL_32} 0.0)

			d := real_32_math.sqrt ({REAL_32} -0.0)
			check_one (d = {REAL_32} -0.0)

			d := real_32_math.sqrt ({REAL_32}.positive_infinity)
			check_one (d.is_positive_infinity)
		end

	test_real_32_exp
		local
			d: REAL_32
		do
			d := real_32_math.exp ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.exp ({REAL_32}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_32_math.exp ({REAL_32}.negative_infinity)
			check_one (d = {REAL_32} 0.0)
		end

	test_real_32_floor
		local
			d: REAL_32
		do
			d := real_32_math.floor ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.floor ({REAL_32}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_32_math.floor ({REAL_32}.negative_infinity)
			check_one (d.is_negative_infinity)
	
			d := real_32_math.floor ({REAL_32} 0.0)
			check_one (d = {REAL_32} 0.0)
	
			d := real_32_math.floor ({REAL_32} -0.0)
			check_one (d = {REAL_32} -0.0)

			d := {REAL_32}.nan
			d := d.floor_real_32
			check_is_real_32_nan (d)

			d := {REAL_32}.positive_infinity
			d := d.floor_real_32
			check_one (d.is_positive_infinity)

			d := {REAL_32}.negative_infinity
			d := d.floor_real_32
			check_one (d.is_negative_infinity)
	
			d := {REAL_32} 0.0
			d := d.floor_real_32
			check_one (d = {REAL_32} 0.0)
	
			d := {REAL_32} -0.0
			d := d.floor_real_32
			check_one (d = {REAL_32} -0.0)
		end

	test_real_32_ceiling
		local
			d: REAL_32
		do
			d := real_32_math.ceiling ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.ceiling ({REAL_32}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_32_math.ceiling ({REAL_32}.negative_infinity)
			check_one (d.is_negative_infinity)
	
			d := real_32_math.ceiling ({REAL_32} 0.0)
			check_one (d = {REAL_32} 0.0)
	
			d := real_32_math.ceiling ({REAL_32} -0.0)
			check_one (d = {REAL_32} -0.0)

			d := {REAL_32}.nan
			d := d.ceiling_real_32
			check_is_real_32_nan (d)

			d := {REAL_32}.positive_infinity
			d := d.ceiling_real_32
			check_one (d.is_positive_infinity)

			d := {REAL_32}.negative_infinity
			d := d.ceiling_real_32
			check_one (d.is_negative_infinity)
	
			d := {REAL_32} 0.0
			d := d.ceiling_real_32
			check_one (d = {REAL_32} 0.0)
	
			d := {REAL_32} -0.0
			d := d.ceiling_real_32
			check_one (d = {REAL_32} -0.0)
		end

	test_real_32_rabs
		local
			d: REAL_32
		do
			d := real_32_math.rabs ({REAL_32}.nan)
			check_is_real_32_nan (d)

			d := real_32_math.rabs ({REAL_32}.positive_infinity)
			check_one (d.is_positive_infinity)

			d := real_32_math.rabs ({REAL_32}.negative_infinity)
			check_one (d.is_positive_infinity)
	
			d := real_32_math.rabs ({REAL_32} 0.0)
			check_one (d = {REAL_32} 0.0)
	
			d := real_32_math.rabs ({REAL_32} -0.0)
			check_one (d = {REAL_32} 0.0)
		end

	test_real_32_pow
		local
			d: REAL_64
		do
			d := {REAL_32} 1.0 ^ {REAL_32}.positive_infinity
			check_one (d = {REAL_64} 1.0)
		end

	check_real_32_equal (a, b: REAL_32)
		do
			if a /= b then
				io.put_string ("Not equal%N")
			end
		end

	check_is_real_32_nan (d: REAL_32)
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

	real_32_math: SINGLE_MATH
		once
			create Result
		end

end

class TEST

create
	make

feature

	make
		do
--			test_real_32
			test_real_64_nan
		end

	test_real_64_nan
		local
			x: INTEGER
			d: REAL_64
		do
				-- Verify that operation involving a NaN results in a NaN

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

			d := {REAL_64} 1.0 ^ {REAL_64}.positive_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.positive_infinity + {REAL_64}.negative_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.negative_infinity + {REAL_64}.positive_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.positive_infinity - {REAL_64}.positive_infinity
			check_is_real_64_nan (d)

			d := {REAL_64}.negative_infinity - {REAL_64}.negative_infinity
			check_is_real_64_nan (d)

				-- Operations with complex results
			d := real_64_math.sqrt (-1)
			check_is_real_64_nan (d)

			d := real_64_math.log_2 (-1)
			check_is_real_64_nan (d)

			d := real_64_math.log (-1)
			check_is_real_64_nan (d)

			d := real_64_math.log10 (-1)
			check_is_real_64_nan (d)

				-- Various trigonometric operations
			d := real_64_math.arc_sine ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.arc_sine ({REAL_64} 2.0)
			check_is_real_64_nan (d)

			d := real_64_math.arc_sine ({REAL_64} -2.0)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64}.positive_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64}.negative_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64} 2.0)
			check_is_real_64_nan (d)

			d := real_64_math.arc_cosine ({REAL_64} -2.0)
			check_is_real_64_nan (d)

			d := real_64_math.tangent ({REAL_32}.nan)
			check_is_real_64_nan (d)

			d := real_64_math.tangent ({REAL_32}.positive_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.tangent ({REAL_32}.negative_infinity)
			check_is_real_64_nan (d)

			d := real_64_math.tangent ({MATH_CONST}.pi / 2)
			check_is_real_64_nan (d)
		end

	check_is_real_64_nan (d: REAL_64)
		do
			check_one ("is_nan for REAL_64", d.is_nan)
			check_one ("is_nan for REAL_64", not d.is_negative_infinity)
			check_one ("is_nan for REAL_64", not d.is_positive_infinity)
		end

	check_one (tag: STRING; v: BOOLEAN)
		require
			tag_not_void: tag /= Void
		do
			if not v then
				io.put_string ("Not OK for " + tag)
				io.put_new_line
			end
		end

	real_32_math: SINGLE_MATH
		once
			create Result
		end

	real_64_math: DOUBLE_MATH
		once
			create Result
		end

end

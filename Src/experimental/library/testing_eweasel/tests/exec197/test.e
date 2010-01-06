class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			test
		end

feature {NONE} -- Tests

	test is
			-- Test exception codes.
		local
			l_n8: NATURAL_8
			l_n16: NATURAL_16
			l_n32: NATURAL_32
			l_n64: NATURAL_64
			l_i8: INTEGER_8
			l_i16: INTEGER_16
			l_i32: INTEGER
			l_i64: INTEGER_64

			r: REAL
			d: DOUBLE
		do
				-- Targets are NATURAL_XX.
			l_n64 := l_n8
			l_n64 := l_n16
			l_n64 := l_n32
			l_n64 := l_n64

			l_n32 := l_n8
			l_n32 := l_n16
			l_n32 := l_n32

			l_n16 := l_n8
			l_n16 := l_n16

			l_n8 := l_n8

				-- Targets are INTEGER_XX.
			l_i64 := l_i8
			l_i64 := l_i16
			l_i64 := l_i32
			l_i64 := l_i64
			l_i64 := l_n8
			l_i64 := l_n16
			l_i64 := l_n32

			l_i32 := l_i8
			l_i32 := l_i16
			l_i32 := l_i32
			l_i32 := l_n8
			l_i32 := l_n16

			l_i16 := l_i8
			l_i16 := l_i16
			l_i16 := l_n8

			l_i8 := l_i8

				-- Target is REAL
			r := l_i8
			r := l_i16
			r := l_i32
			r := l_i64
			r := l_n8
			r := l_n16
			r := l_n32
			r := l_n64
			r := d.truncated_to_real

				-- Target is DOUBLE
			d := l_i8
			d := l_i16
			d := l_i32
			d := l_i64
			d := l_n8
			d := l_n16
			d := l_n32
			d := l_n64
			d := r
		end

end

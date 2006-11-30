class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		do
			init_values

			test_eq
			test_ne
			test_le
			test_lt
			test_ge
			test_gt
			test_mod
			test_div
			test_shift_left
			test_shift_right
		end

feature -- Access

	i8: INTEGER_8
	i16: INTEGER_16
	i32: INTEGER
	i64: INTEGER_64

	n8: NATURAL_8
	n16: NATURAL_16
	n32: NATURAL_32
	n64: NATURAL_64

feature {NONE} -- Initialization

	init_values is
		do
			i8 := 0xa0
			i16 := 0xa000
			i32 := 0xa0000000
			i64 := 0xa000000000000000

			n8 := 0xa0
			n16 := 0xa000
			n32 := 0xa0000000
			n64 := 0xa000000000000000
		end

feature {NONE} -- Implementation

	test_eq is
		do
			check_boolean (i8 = i8)
			check_boolean (i16 = i16)
			check_boolean (i32 = i32)
			check_boolean (i64 = i64)
			check_boolean (n8 = n8)
			check_boolean (n16 = n16)
			check_boolean (n32 = n32)
			check_boolean (n64 = n64)
		end

	test_ne is
		do
			check_boolean (i8 /= {INTEGER_8} 0x80)
			check_boolean (i16 /= {INTEGER_16} 0x8000)
			check_boolean (i32 /= {INTEGER} 0x80000000)
			check_boolean (i64 /= {INTEGER_64} 0x8000000000000000)
			check_boolean (n8 /= {NATURAL_8} 0x80)
			check_boolean (n16 /= {NATURAL_16} 0x8000)
			check_boolean (n32 /= {NATURAL_32} 0x80000000)
			check_boolean (n64 /= {NATURAL_64} 0x8000000000000000)
		end

	test_le is
		do
			check_boolean (i8 <= {INTEGER_8} 0xff)
			check_boolean (i16 <= {INTEGER_16} 0xffff)
			check_boolean (i32 <= {INTEGER} 0xffffffff)
			check_boolean (i64 <= {INTEGER_64} 0xffffffffffffffff)

			check_boolean (i8 <= {INTEGER_8} 0xb0)
			check_boolean (i16 <= {INTEGER_16} 0xb000)
			check_boolean (i32 <= {INTEGER} 0xb0000000)
			check_boolean (i64 <= {INTEGER_64} 0xb000000000000000)

			check_boolean (i8 <= {INTEGER_8} 0xa0)
			check_boolean (i16 <= {INTEGER_16} 0xa000)
			check_boolean (i32 <= {INTEGER} 0xa0000000)
			check_boolean (i64 <= {INTEGER_64} 0xa000000000000000)

			check_boolean (n8 <= {NATURAL_8} 0xff)
			check_boolean (n16 <= {NATURAL_16} 0xffff)
			check_boolean (n32 <= {NATURAL_32} 0xffffffff)
			check_boolean (n64 <= {NATURAL_64} 0xffffffffffffffff)

			check_boolean (n8 <= {NATURAL_8} 0xb0)
			check_boolean (n16 <= {NATURAL_16} 0xb000)
			check_boolean (n32 <= {NATURAL_32} 0xb0000000)
			check_boolean (n64 <= {NATURAL_64} 0xb000000000000000)

			check_boolean (n8 <= {NATURAL_8} 0xa0)
			check_boolean (n16 <= {NATURAL_16} 0xa000)
			check_boolean (n32 <= {NATURAL_32} 0xa0000000)
			check_boolean (n64 <= {NATURAL_64} 0xa000000000000000)

			check_boolean ({NATURAL_8} 0x05 <= n8)
			check_boolean ({NATURAL_16} 0x05 <= n16)
			check_boolean ({NATURAL_32} 0x05 <= n32)
			check_boolean ({NATURAL_64} 0x05 <= n64)
		end

	test_lt is
		do
			check_boolean (i8 < {INTEGER_8} 0xff)
			check_boolean (i16 < {INTEGER_16} 0xffff)
			check_boolean (i32 < {INTEGER} 0xffffffff)
			check_boolean (i64 < {INTEGER_64} 0xffffffffffffffff)

			check_boolean (i8 < {INTEGER_8} 0xb0)
			check_boolean (i16 < {INTEGER_16} 0xb000)
			check_boolean (i32 < {INTEGER} 0xb0000000)
			check_boolean (i64 < {INTEGER_64} 0xb000000000000000)

			check_boolean (not (i8 < {INTEGER_8} 0xa0))
			check_boolean (not (i16 < {INTEGER_16} 0xa000))
			check_boolean (not (i32 < {INTEGER} 0xa0000000))
			check_boolean (not (i64 < {INTEGER_64} 0xa000000000000000))

			check_boolean (n8 < {NATURAL_8} 0xff)
			check_boolean (n16 < {NATURAL_16} 0xffff)
			check_boolean (n32 < {NATURAL_32} 0xffffffff)
			check_boolean (n64 < {NATURAL_64} 0xffffffffffffffff)

			check_boolean (n8 < {NATURAL_8} 0xb0)
			check_boolean (n16 < {NATURAL_16} 0xb000)
			check_boolean (n32 < {NATURAL_32} 0xb0000000)
			check_boolean (n64 < {NATURAL_64} 0xb000000000000000)

			check_boolean (not (n8 < {NATURAL_8} 0xa0))
			check_boolean (not (n16 < {NATURAL_16} 0xa000))
			check_boolean (not (n32 < {NATURAL_32} 0xa0000000))
			check_boolean (not (n64 < {NATURAL_64} 0xa000000000000000))

			check_boolean ({NATURAL_8} 0x05 < n8)
			check_boolean ({NATURAL_16} 0x05 < n16)
			check_boolean ({NATURAL_32} 0x05 < n32)
			check_boolean ({NATURAL_64} 0x05 < n64)
		end

	test_ge is
		do
			check_boolean ({INTEGER_8} 0xff >= i8)
			check_boolean ({INTEGER_16} 0xffff >= i16)
			check_boolean ({INTEGER} 0xffffffff >= i32)
			check_boolean ({INTEGER_64} 0xffffffffffffffff >= i64)

			check_boolean ({INTEGER_8} 0xb0 >= i8)
			check_boolean ({INTEGER_16} 0xb000 >= i16)
			check_boolean ({INTEGER} 0xb0000000 >= i32)
			check_boolean ({INTEGER_64} 0xb000000000000000 >= i64)

			check_boolean ({INTEGER_8} 0xa0 >= i8)
			check_boolean ({INTEGER_16} 0xa000 >= i16)
			check_boolean ({INTEGER} 0xa0000000 >= i32)
			check_boolean ({INTEGER_64} 0xa000000000000000 >= i64)

			check_boolean ({NATURAL_8} 0xff >= n8)
			check_boolean ({NATURAL_16} 0xffff >= n16)
			check_boolean ({NATURAL_32} 0xffffffff >= n32)
			check_boolean ({NATURAL_64} 0xffffffffffffffff >= n64)

			check_boolean ({NATURAL_8} 0xb0 >= n8)
			check_boolean ({NATURAL_16} 0xb000 >= n16)
			check_boolean ({NATURAL_32} 0xb0000000 >= n32)
			check_boolean ({NATURAL_64} 0xb000000000000000 >= n64)

			check_boolean ({NATURAL_8} 0xa0 >= n8)
			check_boolean ({NATURAL_16} 0xa000 >= n16)
			check_boolean ({NATURAL_32} 0xa0000000 >= n32)
			check_boolean ({NATURAL_64} 0xa000000000000000 >= n64)

			check_boolean (n8 >= {NATURAL_8} 0x05)
			check_boolean (n16 >= {NATURAL_16} 0x05)
			check_boolean (n32 >= {NATURAL_32} 0x05)
			check_boolean (n64 >= {NATURAL_64} 0x05)
		end

	test_gt is
		do
			check_boolean ({INTEGER_8} 0xff > i8)
			check_boolean ({INTEGER_16} 0xffff > i16)
			check_boolean ({INTEGER} 0xffffffff > i32)
			check_boolean ({INTEGER_64} 0xffffffffffffffff > i64)

			check_boolean ({INTEGER_8} 0xb0 > i8)
			check_boolean ({INTEGER_16} 0xb000 > i16)
			check_boolean ({INTEGER} 0xb0000000 > i32)
			check_boolean ({INTEGER_64} 0xb000000000000000 > i64)

			check_boolean (not ({INTEGER_8} 0xa0 > i8))
			check_boolean (not ({INTEGER_16} 0xa000 > i16))
			check_boolean (not ({INTEGER} 0xa0000000 > i32))
			check_boolean (not ({INTEGER_64} 0xa000000000000000 > i64))

			check_boolean ({NATURAL_8} 0xff > n8)
			check_boolean ({NATURAL_16} 0xffff > n16)
			check_boolean ({NATURAL_32} 0xffffffff > n32)
			check_boolean ({NATURAL_64} 0xffffffffffffffff > n64)

			check_boolean ({NATURAL_8} 0xb0 > n8)
			check_boolean ({NATURAL_16} 0xb000 > n16)
			check_boolean ({NATURAL_32} 0xb0000000 > n32)
			check_boolean ({NATURAL_64} 0xb000000000000000 > n64)
			
			check_boolean (not ({NATURAL_8} 0xa0 > n8))
			check_boolean (not ({NATURAL_16} 0xa000 > n16))
			check_boolean (not ({NATURAL_32} 0xa0000000 > n32))
			check_boolean (not ({NATURAL_64} 0xa000000000000000 > n64))

			check_boolean (n8 > {NATURAL_8} 0x05)
			check_boolean (n16 > {NATURAL_16} 0x05)
			check_boolean (n32 > {NATURAL_32} 0x05)
			check_boolean (n64 > {NATURAL_64} 0x05)
		end

	test_mod is
		do
			check_boolean ((10 \\ 6) = 4)
			check_boolean ((10 \\ -6) = 4)
			check_boolean ((-10 \\ 6) = -4)
			check_boolean ((-10 \\ -6) = -4)

				-- 0xf6 = -10; 0xfA = -6 when it is signed
			check_boolean (({NATURAL_8} 10 \\ {NATURAL_8} 6) = 4)
			check_boolean (({NATURAL_8} 10 \\ {NATURAL_8} 0xfA) = 0xA)
			check_boolean (({NATURAL_8} 0xf6 \\ {NATURAL_8} 6) = 0)
			check_boolean (({NATURAL_8} 0xf6 \\ {NATURAL_8} 0xfA) = 0xf6)
		end

	test_div is
		do
			check_boolean ((10 // 6) = 1)
			check_boolean ((10 // -6) = -1)
			check_boolean ((-10 // 6) = -1)
			check_boolean ((-10 // -6) = 1)

				-- 0xf6 = -10; 0xfA = -6 when it is signed
			check_boolean (({NATURAL_8} 10 // {NATURAL_8} 6) = 1)
			check_boolean (({NATURAL_8} 10 // {NATURAL_8} 0xfA) = 0)
			check_boolean (({NATURAL_8} 0xf6 // {NATURAL_8} 6) = 41)
			check_boolean (({NATURAL_8} 0xf6 // {NATURAL_8} 0xfA) = 0)
		end

	test_shift_left is
		do
			check_boolean ( (i8 |<< 3) = 0 )
			check_boolean ( (i16 |<< 3) = 0 )
			check_boolean ( (i32 |<< 3) = 0 )
			check_boolean ( (i64 |<< 3) = 0 )

			check_boolean ( (n8 |<< 3) = 0 )
			check_boolean ( (n16 |<< 3) = 0 )
			check_boolean ( (n32 |<< 3) = 0 )
			check_boolean ( (n64 |<< 3) = 0 )
		end

	test_shift_right is
		do
			check_boolean ( (i8 |>> 1) = {INTEGER_8} 0xD0 )
			check_boolean ( (i16 |>> 1) = {INTEGER_16} 0xD000 )
			check_boolean ( (i32 |>> 1) = {INTEGER} 0xD0000000)
			check_boolean ( (i64 |>> 1) = {INTEGER_64} 0xD000000000000000 )

			check_boolean ( (n8 |>> 1) = {NATURAL_8} 0x50 )
			check_boolean ( (n16 |>> 1) = {NATURAL_16} 0x5000 )
			check_boolean ( (n32 |>> 1) = {NATURAL_32} 0x50000000 )
			check_boolean ( (n64 |>> 1) = {NATURAL_64} 0x5000000000000000 )
		end

	check_boolean (b: BOOLEAN) is
		do
			if not b then
				io.put_string ("Not OK.%N")
			end
		end

end

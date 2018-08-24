class L_INTEGER

feature

	int1: INTEGER
	int2: INTEGER

	basic_operators (arg1, arg2: INTEGER)
		do
			check False end
		end

	conversion
		local
			l_int8: INTEGER_8
			l_int16: INTEGER_16
			l_int32: INTEGER_32
			l_int64: INTEGER_64
			l_nat8: NATURAL_8
			l_nat16: NATURAL_16
			l_nat32: NATURAL_32
			l_nat64: NATURAL_64
		do
				-- INTEGER_8 to others
			l_int8 := -7
			check l_int8 = -7 end
			l_int16 := l_int8
			check l_int16 = -7 end
			l_int32 := l_int8
			check l_int32 = -7 end
			l_int64 := l_int8
			check l_int64 = -7 end

			l_int8 := 7
			l_nat8 := l_int8.as_natural_8
			check l_nat8 = 7 end
			l_nat16 := l_int8.as_natural_16
			check l_nat16 = 7 end
			l_nat32 := l_int8.as_natural_32
			check l_nat32 = 7 end
			l_nat64 := l_int8.as_natural_64
			check l_nat64 = 7 end

			l_nat8 := l_int8.as_natural_8
			check 0 <= l_nat8 and l_nat8 <= 255 end
			l_nat16 := l_int8.as_natural_8
			check 0 <= l_nat16 and l_nat16 <= 65535 end
			l_nat32 := l_int8.as_natural_8
			check 0 <= l_nat32 and l_nat32 <= 4294967295 end
			l_nat64 := l_int8.as_natural_8
			check 0 <= l_nat64 and l_nat64 <= 18446744073709551615 end

				-- Others to INTEGER_8
			l_int16 := 123
			l_int8 := l_int16.as_integer_8
			check l_int8 = 123 end
			l_int32 := 123
			l_int8 := l_int32.as_integer_8
			check l_int8 = 123 end
			l_int64 := 123
			l_int8 := l_int64.as_integer_8
			check l_int8 = 123 end

			l_int16 := 2000
			l_int8 := l_int16.as_integer_8
			check -128 <= l_int8 and l_int8 <= 127 end
			l_int32 := 200000000
			l_int8 := l_int32.as_integer_8
			check -128 <= l_int8 and l_int8 <= 127 end
			l_int64 := 200000000000
			l_int8 := l_int64.as_integer_8
			check -128 <= l_int8 and l_int8 <= 127 end

			l_nat8 := 123
			l_int8 := l_nat8.as_integer_8
			check l_int8 = 123 end
			l_nat16 := 123
			l_int8 := l_nat16.as_integer_8
			check l_int8 = 123 end
			l_int32 := 123
			l_int8 := l_int32.as_integer_8
			check l_int8 = 123 end
			l_int64 := 123
			l_int8 := l_int64.as_integer_8
			check l_int8 = 123 end

			l_nat8 := 200
			l_int8 := l_nat8.as_integer_8
			check -128 <= l_int8 and l_int8 <= 127 end
			l_nat16 := 20000
			l_int8 := l_nat16.as_integer_8
			check -128 <= l_int8 and l_int8 <= 127 end
			l_nat32 := 200000000
			l_int8 := l_nat32.as_integer_8
			check -128 <= l_int8 and l_int8 <= 127 end
			l_nat64 := 200000000000
			l_int8 := l_nat64.as_integer_8
			check -128 <= l_int8 and l_int8 <= 127 end


				-- NATURAL_8 to others
			l_nat8 := 73
			l_nat16 := l_nat8
			l_nat32 := l_nat8
			l_nat64 := l_nat8

			check l_nat8 = 73 end
			check l_nat16 = 73 end
			check l_nat32 = 73 end
			check l_nat64 = 73 end
		end

	mixed_operations
		local
			l_nat16: NATURAL_16
			l_nat64: NATURAL_64
			l_int32: INTEGER_32
		do
			check False end
		end

end

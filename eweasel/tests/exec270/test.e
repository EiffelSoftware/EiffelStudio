indexing
	description: "[
		Test for basic types to show that their implementation by the compiler is correct and
		that also when assigned to a reference entity the dynamic binding works properly as well.
		]"

class TEST

create
	make

feature

	make is
		do
			test_integer_8
			test_integer_16
			test_integer_32
			test_integer_64
			test_natural_8
			test_natural_16
			test_natural_32
			test_natural_64
		end

feature -- Access

	i8_ref: INTEGER_8_REF
	i16_ref: INTEGER_16_REF
	i32_ref: INTEGER_32_REF
	i64_ref: INTEGER_64_REF
	n8_ref: NATURAL_8_REF
	n16_ref: NATURAL_16_REF
	n32_ref: NATURAL_32_REF
	n64_ref: NATURAL_64_REF
	p_ref: POINTER_REF
	c8_ref: CHARACTER_8_REF
	c32_ref: CHARACTER_32_REF
	r32_ref: REAL_32_REF
	r64_ref: REAL_64_REF
	b_ref: BOOLEAN_REF

	i8: INTEGER_8
	i16: INTEGER_16
	i32: INTEGER_32
	i64: INTEGER_64
	n8: NATURAL_8
	n16: NATURAL_16
	n32: NATURAL_32
	n64: NATURAL_64
	p: POINTER
	c8: CHARACTER_8
	c32: CHARACTER_32
	r32: REAL_32
	r64: REAL_64
	b: BOOLEAN
	a: ANY

feature {NONE} -- Testing

	test_integer_8
		local
			l_i8: INTEGER_8
			l_i8_ref: INTEGER_8_REF
			l_i16: INTEGER_16
			l_i32: INTEGER_32
			l_i64: INTEGER_64
			l_n8: NATURAL_8
			l_n16: NATURAL_16
			l_n32: NATURAL_32
			l_n64: NATURAL_64
			l_r32: REAL_32
			l_r64: REAL_64
			l_c8: CHARACTER_8
			l_c32: CHARACTER_32
		do
			i8 := -10
			a := i8
			check_equals ("generating_type", a.generating_type.out, "INTEGER_8")

			i8_ref := i8
			check_boolean ("comparison ref/non-ref", i8_ref.item = i8)

			i8_ref := i8
			l_n8 := i8.as_natural_8
			check_boolean ("as_natural_8 - 1", l_n8 = 0xF6)
			check_boolean ("as_natural_8 - 2", l_n8 = i8_ref.as_natural_8)
			l_n16 := i8.as_natural_16
			check_boolean ("as_natural_16 - 1", l_n16 = 0xFFF6)
			check_boolean ("as_natural_16 - 2", l_n16 = i8_ref.as_natural_16)
			l_n32 := i8.as_natural_32
			check_boolean ("as_natural_32 - 1", l_n32 = 0xFFFFFFF6)
			check_boolean ("as_natural_32 - 2", l_n32 = i8_ref.as_natural_32)
			l_n64 := i8.as_natural_64
			check_boolean ("as_natural_64 - 1", l_n64 = 0xFFFFFFFFFFFFFFF6)
			check_boolean ("as_natural_64 - 2", l_n64 = i8_ref.as_natural_64)

			i8_ref := i8
			l_i8 := i8.as_integer_8
			check_boolean ("as_integer_8 - 1", l_i8 = -10)
			check_boolean ("as_integer_8 - 2", l_i8 = i8_ref.as_integer_8)
			l_i16 := i8.as_integer_16
			check_boolean ("as_integer_16 - 1", l_i16 = -10)
			check_boolean ("as_integer_16 - 2", l_i16 = i8_ref.as_integer_16)
			l_i32 := i8.as_integer_32
			check_boolean ("as_integer_32 - 1", l_i32 = -10)
			check_boolean ("as_integer_32 - 2", l_i32 = i8_ref.as_integer_32)
			l_i64 := i8.as_integer_64
			check_boolean ("as_integer_64 - 1", l_i64 = -10)
			check_boolean ("as_integer_64 - 2", l_i64 = i8_ref.as_integer_64)

			i8_ref := i8
			l_i8 := i8.to_integer_8
			check_boolean ("to_integer_8 - 1", l_i8 = -10)
			check_boolean ("to_integer_8 - 2", l_i8 = i8_ref.to_integer_8)
			l_i16 := i8.to_integer_16
			check_boolean ("to_integer_16 - 1", l_i16 = -10)
			check_boolean ("to_integer_16 - 2", l_i16 = i8_ref.to_integer_16)
			l_i32 := i8.to_integer_32
			check_boolean ("to_integer_32 - 1", l_i32 = -10)
			check_boolean ("to_integer_32 - 2", l_i32 = i8_ref.to_integer_32)
			l_i64 := i8.to_integer_64
			check_boolean ("to_integer_64 - 1", l_i64 = -10)
			check_boolean ("to_integer_64 - 2", l_i64 = i8_ref.to_integer_64)

			i8_ref := i8
			l_r32 := i8.to_real
			check_boolean ("to_real - 1", l_r32 = -10)
			check_boolean ("to_real - 2", l_r32 = i8_ref.to_real)

			i8_ref := i8
			l_r64 := i8.to_double
			check_boolean ("to_double - 1", l_r64 = -10)
			check_boolean ("to_double - 2", l_r64 = i8_ref.to_double)

			i8 := 10
			i8_ref := i8
			l_c8 := i8.to_character_8
			check_boolean ("to_character_8 - 1", l_c8 = '%/10/')
			check_boolean ("to_character_8 - 2", l_c8 = i8_ref.to_character_8)

			i8_ref := i8
			l_c32 := i8.to_character_32
			check_boolean ("to_character_32 - 1", l_c32 = '%/10/')
			check_boolean ("to_character_32 - 2", l_c32 = i8_ref.to_character_32)

			i8 := -19
			i8_ref := i8
			check_boolean ("< - 1", i8 < {INTEGER_8} -5)
			check_boolean ("< - 2", i8_ref < {INTEGER_8} -5)
			check_boolean ("+ - 1", i8 + 5 = {INTEGER_8} -14)
			check_boolean ("+ - 2", i8_ref + {INTEGER_8} 5 = {INTEGER_8} -14)
			check_boolean ("- - 1", i8 - 5 = {INTEGER_8} -24)
			check_boolean ("- - 2", i8_ref - {INTEGER_8} 5 = {INTEGER_8} -24)
			check_boolean ("* - 1", i8 * 5 = {INTEGER_8} -95)
			check_boolean ("* - 2", i8_ref * {INTEGER_8} 5 = {INTEGER_8} -95)

			i8 := -20
			i8_ref := i8
			check_boolean ("/ - 1", i8 / 2 = {REAL_64} -10.0)
			check_boolean ("/ - 2", i8_ref / {INTEGER_8} 2 = {REAL_64} -10.0)
			check_boolean ("prefix + - 1", +i8 = {INTEGER_8} -20)
			check_boolean ("prefix + - 2", +i8_ref = {INTEGER_8} -20)
			check_boolean ("prefix - - 1", -i8 = {INTEGER_8} 20)
			check_boolean ("prefix - - 2", -i8_ref = {INTEGER_8} 20)
			check_boolean ("// - 1", i8 // 2 = {INTEGER_8} -10)
			check_boolean ("// - 2", i8_ref // {INTEGER_8} 2 = {INTEGER_8} -10)
			check_boolean ("\\ - 1", i8 \\ 2 = {INTEGER_8} 0)
			check_boolean ("\\ - 2", i8_ref \\ {INTEGER_8} 2 = {INTEGER_8} 0)
			check_boolean ("^ - 1", i8 ^ 2 = {REAL_64} 400.0)
			check_boolean ("^ - 2", i8_ref ^ 2 = {REAL_64} 400.0)

			i8 := 0x0F
			l_i8 := 0xF0
			i8_ref := i8
			l_i8_ref := l_i8
			check_boolean ("& - 1", i8 & l_i8 = {INTEGER_8} 0x00)
			check_boolean ("& - 2", i8_ref & l_i8_ref = {INTEGER_8} 0x00)
			check_boolean ("| - 1", i8 | l_i8 = {INTEGER_8} 0xFF)
			check_boolean ("| - 2", i8_ref | l_i8_ref = {INTEGER_8} 0xFF)
			check_boolean ("xor - 1", i8.bit_xor (l_i8) = {INTEGER_8} 0xFF)
			check_boolean ("xor - 2", i8_ref.bit_xor (l_i8_ref) = {INTEGER_8} 0xFF)
			check_boolean ("bit_not - 1", i8.bit_not = {INTEGER_8} 0xF0)
			check_boolean ("bit_not - 2", i8_ref.bit_not = {INTEGER_8} 0xF0)
			check_boolean ("|<< - 1", i8 |<< 3 = {INTEGER_8} 0x78)
			check_boolean ("|<< - 2", i8_ref |<< 3 = {INTEGER_8} 0x78)
			check_boolean ("|>> - 1", i8 |>> 3 = {INTEGER_8} 0x01)
			check_boolean ("|>> - 2", i8_ref |>> 3 = {INTEGER_8} 0x01)
		end

	test_integer_16
		local
			l_i8: INTEGER_8
			l_i16: INTEGER_16
			l_i16_ref: INTEGER_16_REF
			l_i32: INTEGER_32
			l_i64: INTEGER_64
			l_n8: NATURAL_8
			l_n16: NATURAL_16
			l_n32: NATURAL_32
			l_n64: NATURAL_64
			l_r32: REAL_32
			l_r64: REAL_64
			l_c8: CHARACTER_8
			l_c32: CHARACTER_32
		do
			i16 := -10
			a := i16
			check_equals ("generating_type", a.generating_type.out, "INTEGER_16")

			i16_ref := i16
			check_boolean ("comparison ref/non-ref", i16_ref.item = i16)

			i16_ref := i16
			l_n8 := i16.as_natural_8
			check_boolean ("as_natural_8 - 1", l_n8 = 0xF6)
			check_boolean ("as_natural_8 - 2", l_n8 = i16_ref.as_natural_8)
			l_n16 := i16.as_natural_16
			check_boolean ("as_natural_16 - 1", l_n16 = 0xFFF6)
			check_boolean ("as_natural_16 - 2", l_n16 = i16_ref.as_natural_16)
			l_n32 := i16.as_natural_32
			check_boolean ("as_natural_32 - 1", l_n32 = 0xFFFFFFF6)
			check_boolean ("as_natural_32 - 2", l_n32 = i16_ref.as_natural_32)
			l_n64 := i16.as_natural_64
			check_boolean ("as_natural_64 - 1", l_n64 = 0xFFFFFFFFFFFFFFF6)
			check_boolean ("as_natural_64 - 2", l_n64 = i16_ref.as_natural_64)

			i16_ref := i16
			l_i8 := i16.as_integer_8
			check_boolean ("as_integer_8 - 1", l_i8 = -10)
			check_boolean ("as_integer_8 - 2", l_i8 = i16_ref.as_integer_8)
			l_i16 := i16.as_integer_16
			check_boolean ("as_integer_16 - 1", l_i16 = -10)
			check_boolean ("as_integer_16 - 2", l_i16 = i16_ref.as_integer_16)
			l_i32 := i16.as_integer_32
			check_boolean ("as_integer_32 - 1", l_i32 = -10)
			check_boolean ("as_integer_32 - 2", l_i32 = i16_ref.as_integer_32)
			l_i64 := i16.as_integer_64
			check_boolean ("as_integer_64 - 1", l_i64 = -10)
			check_boolean ("as_integer_64 - 2", l_i64 = i16_ref.as_integer_64)

			i16_ref := i16
			l_i8 := i16.to_integer_8
			check_boolean ("to_integer_8 - 1", l_i8 = -10)
			check_boolean ("to_integer_8 - 2", l_i8 = i16_ref.to_integer_8)
			l_i16 := i16.to_integer_16
			check_boolean ("to_integer_16 - 1", l_i16 = -10)
			check_boolean ("to_integer_16 - 2", l_i16 = i16_ref.to_integer_16)
			l_i32 := i16.to_integer_32
			check_boolean ("to_integer_32 - 1", l_i32 = -10)
			check_boolean ("to_integer_32 - 2", l_i32 = i16_ref.to_integer_32)
			l_i64 := i16.to_integer_64
			check_boolean ("to_integer_64 - 1", l_i64 = -10)
			check_boolean ("to_integer_64 - 2", l_i64 = i16_ref.to_integer_64)

			i16_ref := i16
			l_r32 := i16.to_real
			check_boolean ("to_real - 1", l_r32 = -10)
			check_boolean ("to_real - 2", l_r32 = i16_ref.to_real)

			i16_ref := i16
			l_r64 := i16.to_double
			check_boolean ("to_double - 1", l_r64 = -10)
			check_boolean ("to_double - 2", l_r64 = i16_ref.to_double)

			i16 := 10
			i16_ref := i16
			l_c8 := i16.to_character_8
			check_boolean ("to_character_8 - 1", l_c8 = '%/10/')
			check_boolean ("to_character_8 - 2", l_c8 = i16_ref.to_character_8)

			i16_ref := i16
			l_c32 := i16.to_character_32
			check_boolean ("to_character_32 - 1", l_c32 = '%/10/')
			check_boolean ("to_character_32 - 2", l_c32 = i16_ref.to_character_32)

			i16 := -19
			i16_ref := i16
			check_boolean ("< - 1", i16 < {INTEGER_16} -5)
			check_boolean ("< - 2", i16_ref < {INTEGER_16} -5)
			check_boolean ("+ - 1", i16 + 5 = {INTEGER_16} -14)
			check_boolean ("+ - 2", i16_ref + {INTEGER_16} 5 = {INTEGER_16} -14)
			check_boolean ("- - 1", i16 - 5 = {INTEGER_16} -24)
			check_boolean ("- - 2", i16_ref - {INTEGER_16} 5 = {INTEGER_16} -24)
			check_boolean ("* - 1", i16 * 5 = {INTEGER_16} -95)
			check_boolean ("* - 2", i16_ref * {INTEGER_16} 5 = {INTEGER_16} -95)

			i16 := -20
			i16_ref := i16
			check_boolean ("/ - 1", i16 / 2 = {REAL_64} -10.0)
			check_boolean ("/ - 2", i16_ref / {INTEGER_16} 2 = {REAL_64} -10.0)
			check_boolean ("prefix + - 1", +i16 = {INTEGER_16} -20)
			check_boolean ("prefix + - 2", +i16_ref = {INTEGER_16} -20)
			check_boolean ("prefix - - 1", -i16 = {INTEGER_16} 20)
			check_boolean ("prefix - - 2", -i16_ref = {INTEGER_16} 20)
			check_boolean ("// - 1", i16 // 2 = {INTEGER_16} -10)
			check_boolean ("// - 2", i16_ref // {INTEGER_16} 2 = {INTEGER_16} -10)
			check_boolean ("\\ - 1", i16 \\ 2 = {INTEGER_16} 0)
			check_boolean ("\\ - 2", i16_ref \\ {INTEGER_16} 2 = {INTEGER_16} 0)
			check_boolean ("^ - 1", i16 ^ 2 = {REAL_64} 400.0)
			check_boolean ("^ - 2", i16_ref ^ 2 = {REAL_64} 400.0)

			i16 := 0x0F
			l_i16 := 0xF0
			i16_ref := i16
			l_i16_ref := l_i16
			check_boolean ("& - 1", i16 & l_i16 = {INTEGER_16} 0x00)
			check_boolean ("& - 2", i16_ref & l_i16_ref = {INTEGER_16} 0x00)
			check_boolean ("| - 1", i16 | l_i16 = {INTEGER_16} 0xFF)
			check_boolean ("| - 2", i16_ref | l_i16_ref = {INTEGER_16} 0xFF)
			check_boolean ("xor - 1", i16.bit_xor (l_i16) = {INTEGER_16} 0xFF)
			check_boolean ("xor - 2", i16_ref.bit_xor (l_i16_ref) = {INTEGER_16} 0xFF)
			check_boolean ("bit_not - 1", i16.bit_not = {INTEGER_16} 0xFFF0)
			check_boolean ("bit_not - 2", i16_ref.bit_not = {INTEGER_16} 0xFFF0)
			check_boolean ("|<< - 1", i16 |<< 3 = {INTEGER_16} 0x78)
			check_boolean ("|<< - 2", i16_ref |<< 3 = {INTEGER_16} 0x78)
			check_boolean ("|>> - 1", i16 |>> 3 = {INTEGER_16} 0x01)
			check_boolean ("|>> - 2", i16_ref |>> 3 = {INTEGER_16} 0x01)
		end

	test_integer_32
		local
			l_i8: INTEGER_8
			l_i16: INTEGER_16
			l_i32: INTEGER_32
			l_i32_ref: INTEGER_32_REF
			l_i64: INTEGER_64
			l_n8: NATURAL_8
			l_n16: NATURAL_16
			l_n32: NATURAL_32
			l_n64: NATURAL_64
			l_r32: REAL_32
			l_r64: REAL_64
			l_c8: CHARACTER_8
			l_c32: CHARACTER_32
		do
			i32 := -10
			a := i32
			check_equals ("generating_type", a.generating_type.out, "INTEGER_32")

			i32_ref := i32
			check_boolean ("comparison ref/non-ref", i32_ref.item = i32)

			i32_ref := i32
			l_n8 := i32.as_natural_8
			check_boolean ("as_natural_8 - 1", l_n8 = 0xF6)
			check_boolean ("as_natural_8 - 2", l_n8 = i32_ref.as_natural_8)
			l_n16 := i32.as_natural_16
			check_boolean ("as_natural_16 - 1", l_n16 = 0xFFF6)
			check_boolean ("as_natural_16 - 2", l_n16 = i32_ref.as_natural_16)
			l_n32 := i32.as_natural_32
			check_boolean ("as_natural_32 - 1", l_n32 = 0xFFFFFFF6)
			check_boolean ("as_natural_32 - 2", l_n32 = i32_ref.as_natural_32)
			l_n64 := i32.as_natural_64
			check_boolean ("as_natural_64 - 1", l_n64 = 0xFFFFFFFFFFFFFFF6)
			check_boolean ("as_natural_64 - 2", l_n64 = i32_ref.as_natural_64)

			i32_ref := i32
			l_i8 := i32.as_integer_8
			check_boolean ("as_integer_8 - 1", l_i8 = -10)
			check_boolean ("as_integer_8 - 2", l_i8 = i32_ref.as_integer_8)
			l_i16 := i32.as_integer_16
			check_boolean ("as_integer_16 - 1", l_i16 = -10)
			check_boolean ("as_integer_16 - 2", l_i16 = i32_ref.as_integer_16)
			l_i32 := i32.as_integer_32
			check_boolean ("as_integer_32 - 1", l_i32 = -10)
			check_boolean ("as_integer_32 - 2", l_i32 = i32_ref.as_integer_32)
			l_i64 := i32.as_integer_64
			check_boolean ("as_integer_64 - 1", l_i64 = -10)
			check_boolean ("as_integer_64 - 2", l_i64 = i32_ref.as_integer_64)

			i32_ref := i32
			l_i8 := i32.to_integer_8
			check_boolean ("to_integer_8 - 1", l_i8 = -10)
			check_boolean ("to_integer_8 - 2", l_i8 = i32_ref.to_integer_8)
			l_i16 := i32.to_integer_16
			check_boolean ("to_integer_16 - 1", l_i16 = -10)
			check_boolean ("to_integer_16 - 2", l_i16 = i32_ref.to_integer_16)
			l_i32 := i32.to_integer_32
			check_boolean ("to_integer_32 - 1", l_i32 = -10)
			check_boolean ("to_integer_32 - 2", l_i32 = i32_ref.to_integer_32)
			l_i64 := i32.to_integer_64
			check_boolean ("to_integer_64 - 1", l_i64 = -10)
			check_boolean ("to_integer_64 - 2", l_i64 = i32_ref.to_integer_64)

			i32_ref := i32
			l_r32 := i32.to_real
			check_boolean ("to_real - 1", l_r32 = -10)
			check_boolean ("to_real - 2", l_r32 = i32_ref.to_real)

			i32_ref := i32
			l_r64 := i32.to_double
			check_boolean ("to_double - 1", l_r64 = -10)
			check_boolean ("to_double - 2", l_r64 = i32_ref.to_double)

			i32 := 10
			i32_ref := i32
			l_c8 := i32.to_character_8
			check_boolean ("to_character_8 - 1", l_c8 = '%/10/')
			check_boolean ("to_character_8 - 2", l_c8 = i32_ref.to_character_8)

			i32_ref := i32
			l_c32 := i32.to_character_32
			check_boolean ("to_character_32 - 1", l_c32 = '%/10/')
			check_boolean ("to_character_32 - 2", l_c32 = i32_ref.to_character_32)

			i32 := -19
			i32_ref := i32
			check_boolean ("< - 1", i32 < {INTEGER_32} -5)
			check_boolean ("< - 2", i32_ref < {INTEGER_32} -5)
			check_boolean ("+ - 1", i32 + 5 = {INTEGER_32} -14)
			check_boolean ("+ - 2", i32_ref + {INTEGER_32} 5 = {INTEGER_32} -14)
			check_boolean ("- - 1", i32 - 5 = {INTEGER_32} -24)
			check_boolean ("- - 2", i32_ref - {INTEGER_32} 5 = {INTEGER_32} -24)
			check_boolean ("* - 1", i32 * 5 = {INTEGER_32} -95)
			check_boolean ("* - 2", i32_ref * {INTEGER_32} 5 = {INTEGER_32} -95)

			i32 := -20
			i32_ref := i32
			check_boolean ("/ - 1", i32 / 2 = {REAL_64} -10.0)
			check_boolean ("/ - 2", i32_ref / {INTEGER_32} 2 = {REAL_64} -10.0)
			check_boolean ("prefix + - 1", +i32 = {INTEGER_32} -20)
			check_boolean ("prefix + - 2", +i32_ref = {INTEGER_32} -20)
			check_boolean ("prefix - - 1", -i32 = {INTEGER_32} 20)
			check_boolean ("prefix - - 2", -i32_ref = {INTEGER_32} 20)
			check_boolean ("// - 1", i32 // 2 = {INTEGER_32} -10)
			check_boolean ("// - 2", i32_ref // {INTEGER_32} 2 = {INTEGER_32} -10)
			check_boolean ("\\ - 1", i32 \\ 2 = {INTEGER_32} 0)
			check_boolean ("\\ - 2", i32_ref \\ {INTEGER_32} 2 = {INTEGER_32} 0)
			check_boolean ("^ - 1", i32 ^ 2 = {REAL_64} 400.0)
			check_boolean ("^ - 2", i32_ref ^ 2 = {REAL_64} 400.0)

			i32 := 0x0F
			l_i32 := 0xF0
			i32_ref := i32
			l_i32_ref := l_i32
			check_boolean ("& - 1", i32 & l_i32 = {INTEGER_32} 0x00)
			check_boolean ("& - 2", i32_ref & l_i32_ref = {INTEGER_32} 0x00)
			check_boolean ("| - 1", i32 | l_i32 = {INTEGER_32} 0xFF)
			check_boolean ("| - 2", i32_ref | l_i32_ref = {INTEGER_32} 0xFF)
			check_boolean ("xor - 1", i32.bit_xor (l_i32) = {INTEGER_32} 0xFF)
			check_boolean ("xor - 2", i32_ref.bit_xor (l_i32_ref) = {INTEGER_32} 0xFF)
			check_boolean ("bit_not - 1", i32.bit_not = {INTEGER_32} 0xFFFFFFF0)
			check_boolean ("bit_not - 2", i32_ref.bit_not = {INTEGER_32} 0xFFFFFFF0)
			check_boolean ("|<< - 1", i32 |<< 3 = {INTEGER_32} 0x78)
			check_boolean ("|<< - 2", i32_ref |<< 3 = {INTEGER_32} 0x78)
			check_boolean ("|>> - 1", i32 |>> 3 = {INTEGER_32} 0x01)
			check_boolean ("|>> - 2", i32_ref |>> 3 = {INTEGER_32} 0x01)
		end

	test_integer_64
		local
			l_i8: INTEGER_8
			l_i16: INTEGER_16
			l_i32: INTEGER_32
			l_i64: INTEGER_64
			l_i64_ref: INTEGER_64_REF
			l_n8: NATURAL_8
			l_n16: NATURAL_16
			l_n32: NATURAL_32
			l_n64: NATURAL_64
			l_r32: REAL_32
			l_r64: REAL_64
			l_c8: CHARACTER_8
			l_c32: CHARACTER_32
		do
			i64 := -10
			a := i64
			check_equals ("generating_type", a.generating_type.out, "INTEGER_64")

			i64_ref := i64
			check_boolean ("comparison ref/non-ref", i64_ref.item = i64)

			i64_ref := i64
			l_n8 := i64.as_natural_8
			check_boolean ("as_natural_8 - 1", l_n8 = 0xF6)
			check_boolean ("as_natural_8 - 2", l_n8 = i64_ref.as_natural_8)
			l_n16 := i64.as_natural_16
			check_boolean ("as_natural_16 - 1", l_n16 = 0xFFF6)
			check_boolean ("as_natural_16 - 2", l_n16 = i64_ref.as_natural_16)
			l_n32 := i64.as_natural_32
			check_boolean ("as_natural_32 - 1", l_n32 = 0xFFFFFFF6)
			check_boolean ("as_natural_32 - 2", l_n32 = i64_ref.as_natural_32)
			l_n64 := i64.as_natural_64
			check_boolean ("as_natural_64 - 1", l_n64 = 0xFFFFFFFFFFFFFFF6)
			check_boolean ("as_natural_64 - 2", l_n64 = i64_ref.as_natural_64)

			i64_ref := i64
			l_i8 := i64.as_integer_8
			check_boolean ("as_integer_8 - 1", l_i8 = -10)
			check_boolean ("as_integer_8 - 2", l_i8 = i64_ref.as_integer_8)
			l_i16 := i64.as_integer_16
			check_boolean ("as_integer_16 - 1", l_i16 = -10)
			check_boolean ("as_integer_16 - 2", l_i16 = i64_ref.as_integer_16)
			l_i32 := i64.as_integer_32
			check_boolean ("as_integer_32 - 1", l_i32 = -10)
			check_boolean ("as_integer_32 - 2", l_i32 = i64_ref.as_integer_32)
			l_i64 := i64.as_integer_64
			check_boolean ("as_integer_64 - 1", l_i64 = -10)
			check_boolean ("as_integer_64 - 2", l_i64 = i64_ref.as_integer_64)

			i64_ref := i64
			l_i8 := i64.to_integer_8
			check_boolean ("to_integer_8 - 1", l_i8 = -10)
			check_boolean ("to_integer_8 - 2", l_i8 = i64_ref.to_integer_8)
			l_i16 := i64.to_integer_16
			check_boolean ("to_integer_16 - 1", l_i16 = -10)
			check_boolean ("to_integer_16 - 2", l_i16 = i64_ref.to_integer_16)
			l_i32 := i64.to_integer_32
			check_boolean ("to_integer_32 - 1", l_i32 = -10)
			check_boolean ("to_integer_32 - 2", l_i32 = i64_ref.to_integer_32)
			l_i64 := i64.to_integer_64
			check_boolean ("to_integer_64 - 1", l_i64 = -10)
			check_boolean ("to_integer_64 - 2", l_i64 = i64_ref.to_integer_64)

			i64_ref := i64
			l_r32 := i64.to_real
			check_boolean ("to_real - 1", l_r32 = -10)
			check_boolean ("to_real - 2", l_r32 = i64_ref.to_real)

			i64_ref := i64
			l_r64 := i64.to_double
			check_boolean ("to_double - 1", l_r64 = -10)
			check_boolean ("to_double - 2", l_r64 = i64_ref.to_double)

			i64 := 10
			i64_ref := i64
			l_c8 := i64.to_character_8
			check_boolean ("to_character_8 - 1", l_c8 = '%/10/')
			check_boolean ("to_character_8 - 2", l_c8 = i64_ref.to_character_8)

			i64_ref := i64
			l_c32 := i64.to_character_32
			check_boolean ("to_character_32 - 1", l_c32 = '%/10/')
			check_boolean ("to_character_32 - 2", l_c32 = i64_ref.to_character_32)

			i64 := -19
			i64_ref := i64
			check_boolean ("< - 1", i64 < {INTEGER_64} -5)
			check_boolean ("< - 2", i64_ref < {INTEGER_64} -5)
			check_boolean ("+ - 1", i64 + 5 = {INTEGER_64} -14)
			check_boolean ("+ - 2", i64_ref + {INTEGER_64} 5 = {INTEGER_64} -14)
			check_boolean ("- - 1", i64 - 5 = {INTEGER_64} -24)
			check_boolean ("- - 2", i64_ref - {INTEGER_64} 5 = {INTEGER_64} -24)
			check_boolean ("* - 1", i64 * 5 = {INTEGER_64} -95)
			check_boolean ("* - 2", i64_ref * {INTEGER_64} 5 = {INTEGER_64} -95)

			i64:= -20
			i64_ref := i64
			check_boolean ("/ - 1", i64 / 2 = {REAL_64} -10.0)
			check_boolean ("/ - 2", i64_ref / {INTEGER_64} 2 = {REAL_64} -10.0)
			check_boolean ("prefix + - 1", +i64 = {INTEGER_64} -20)
			check_boolean ("prefix + - 2", +i64_ref = {INTEGER_64} -20)
			check_boolean ("prefix - - 1", -i64 = {INTEGER_64} 20)
			check_boolean ("prefix - - 2", -i64_ref = {INTEGER_64} 20)
			check_boolean ("// - 1", i64 // 2 = {INTEGER_64} -10)
			check_boolean ("// - 2", i64_ref // {INTEGER_64} 2 = {INTEGER_64} -10)
			check_boolean ("\\ - 1", i64 \\ 2 = {INTEGER_64} 0)
			check_boolean ("\\ - 2", i64_ref \\ {INTEGER_64} 2 = {INTEGER_64} 0)
			check_boolean ("^ - 1", i64 ^ 2 = {REAL_64} 400.0)
			check_boolean ("^ - 2", i64_ref ^ 2 = {REAL_64} 400.0)

			i64 := 0x0F
			l_i64 := 0xF0
			i64_ref := i64
			l_i64_ref := l_i64
			check_boolean ("& - 1", i64 & l_i64 = {INTEGER_64} 0x00)
			check_boolean ("& - 2", i64_ref & l_i64_ref = {INTEGER_64} 0x00)
			check_boolean ("| - 1", i64 | l_i64 = {INTEGER_64} 0xFF)
			check_boolean ("| - 2", i64_ref | l_i64_ref = {INTEGER_64} 0xFF)
			check_boolean ("xor - 1", i64.bit_xor (l_i64) = {INTEGER_64} 0xFF)
			check_boolean ("xor - 2", i64_ref.bit_xor (l_i64_ref) = {INTEGER_64} 0xFF)
			check_boolean ("bit_not - 1", i64.bit_not = {INTEGER_64} 0xFFFFFFFFFFFFFFF0)
			check_boolean ("bit_not - 2", i64_ref.bit_not = {INTEGER_64} 0xFFFFFFFFFFFFFFF0)
			check_boolean ("|<< - 1", i64 |<< 3 = {INTEGER_64} 0x78)
			check_boolean ("|<< - 2", i64_ref |<< 3 = {INTEGER_64} 0x78)
			check_boolean ("|>> - 1", i64 |>> 3 = {INTEGER_64} 0x01)
			check_boolean ("|>> - 2", i64_ref |>> 3 = {INTEGER_64} 0x01)
		end

	test_natural_8
		local
			l_i8: INTEGER_8
			l_i16: INTEGER_16
			l_i32: INTEGER_32
			l_i64: INTEGER_64
			l_n8: NATURAL_8
			l_n8_ref: NATURAL_8_REF
			l_n16: NATURAL_16
			l_n32: NATURAL_32
			l_n64: NATURAL_64
			l_r32: REAL_32
			l_r64: REAL_64
			l_c8: CHARACTER_8
			l_c32: CHARACTER_32
		do
			n8 := 10
			a := n8
			check_equals ("generating_type", a.generating_type.out, "NATURAL_8")

			n8_ref := n8
			check_boolean ("comparison ref/non-ref", n8_ref.item = n8)

			n8_ref := n8
			l_n8 := n8.as_natural_8
			check_boolean ("as_natural_8 - 1", l_n8 = 10)
			check_boolean ("as_natural_8 - 2", l_n8 = n8_ref.as_natural_8)
			l_n16 := n8.as_natural_16
			check_boolean ("as_natural_16 - 1", l_n16 = 10)
			check_boolean ("as_natural_16 - 2", l_n16 = n8_ref.as_natural_16)
			l_n32 := n8.as_natural_32
			check_boolean ("as_natural_32 - 1", l_n32 = 10)
			check_boolean ("as_natural_32 - 2", l_n32 = n8_ref.as_natural_32)
			l_n64 := n8.as_natural_64
			check_boolean ("as_natural_64 - 1", l_n64 = 10)
			check_boolean ("as_natural_64 - 2", l_n64 = n8_ref.as_natural_64)

			n8_ref := n8
			l_i8 := n8.as_integer_8
			check_boolean ("as_integer_8 - 1", l_i8 = 10)
			check_boolean ("as_integer_8 - 2", l_i8 = n8_ref.as_integer_8)
			l_i16 := n8.as_integer_16
			check_boolean ("as_integer_16 - 1", l_i16 = 10)
			check_boolean ("as_integer_16 - 2", l_i16 = n8_ref.as_integer_16)
			l_i32 := n8.as_integer_32
			check_boolean ("as_integer_32 - 1", l_i32 = 10)
			check_boolean ("as_integer_32 - 2", l_i32 = n8_ref.as_integer_32)
			l_i64 := n8.as_integer_64
			check_boolean ("as_integer_64 - 1", l_i64 = 10)
			check_boolean ("as_integer_64 - 2", l_i64 = n8_ref.as_integer_64)

			n8_ref := n8
			l_i8 := n8.to_integer_8
			check_boolean ("to_integer_8 - 1", l_i8 = 10)
			check_boolean ("to_integer_8 - 2", l_i8 = n8_ref.to_integer_8)
			l_i16 := n8.to_integer_16
			check_boolean ("to_integer_16 - 1", l_i16 = 10)
			check_boolean ("to_integer_16 - 2", l_i16 = n8_ref.to_integer_16)
			l_i32 := n8.to_integer_32
			check_boolean ("to_integer_32 - 1", l_i32 = 10)
			check_boolean ("to_integer_32 - 2", l_i32 = n8_ref.to_integer_32)
			l_i64 := n8.to_integer_64
			check_boolean ("to_integer_64 - 1", l_i64 = 10)
			check_boolean ("to_integer_64 - 2", l_i64 = n8_ref.to_integer_64)

			n8_ref := n8
			l_r32 := n8.to_real_32
			check_boolean ("to_real_32 - 1", l_r32 = 10)
			check_boolean ("to_real_32 - 2", l_r32 = n8_ref.to_real_32)

			n8_ref := n8
			l_r64 := n8.to_real_64
			check_boolean ("to_real_64 - 1", l_r64 = 10)
			check_boolean ("to_real_64 - 2", l_r64 = n8_ref.to_real_64)

			n8 := 10
			n8_ref := n8
			l_c8 := n8.to_character_8
			check_boolean ("to_character_8 - 1", l_c8 = '%/10/')
			check_boolean ("to_character_8 - 2", l_c8 = n8_ref.to_character_8)

			n8_ref := n8
			l_c32 := n8.to_character_32
			check_boolean ("to_character_32 - 1", l_c32 = '%/10/')
			check_boolean ("to_character_32 - 2", l_c32 = n8_ref.to_character_32)

			n8 := 19
			n8_ref := n8
			check_boolean ("< - 1", n8 < {NATURAL_8} 25)
			check_boolean ("< - 2", n8_ref < {NATURAL_8} 25)
			check_boolean ("+ - 1", n8 + 5 = {NATURAL_8} 24)
			check_boolean ("+ - 2", n8_ref + {NATURAL_8} 5 = {NATURAL_8} 24)
			check_boolean ("- - 1", n8 - 5 = {NATURAL_8} 14)
			check_boolean ("- - 2", n8_ref - {NATURAL_8} 5 = {NATURAL_8} 14)
			check_boolean ("* - 1", n8 * 5 = {NATURAL_8} 95)
			check_boolean ("* - 2", n8_ref * {NATURAL_8} 5 = {NATURAL_8} 95)

			n8 := 20
			n8_ref := n8
			check_boolean ("/ - 1", n8 / 2 = {REAL_64} 10.0)
			check_boolean ("/ - 2", n8_ref / {NATURAL_8} 2 = {REAL_64} 10.0)
			check_boolean ("prefix + - 1", +n8 = {NATURAL_8} 20)
			check_boolean ("prefix + - 2", +n8_ref = {NATURAL_8} 20)
			check_boolean ("// - 1", n8 // 2 = {NATURAL_8} 10)
			check_boolean ("// - 2", n8_ref // {NATURAL_8} 2 = {NATURAL_8} 10)
			check_boolean ("\\ - 1", n8 \\ 2 = {NATURAL_8} 0)
			check_boolean ("\\ - 2", n8_ref \\ {NATURAL_8} 2 = {NATURAL_8} 0)
			check_boolean ("^ - 1", n8 ^ 2 = {REAL_64} 400.0)
			check_boolean ("^ - 2", n8_ref ^ 2 = {REAL_64} 400.0)

			n8 := 0x0F
			l_n8 := 0xF0
			n8_ref := n8
			l_n8_ref := l_n8
			check_boolean ("& - 1", n8 & l_n8 = {NATURAL_8} 0x00)
			check_boolean ("& - 2", n8_ref & l_n8_ref = {NATURAL_8} 0x00)
			check_boolean ("| - 1", n8 | l_n8 = {NATURAL_8} 0xFF)
			check_boolean ("| - 2", n8_ref | l_n8_ref = {NATURAL_8} 0xFF)
			check_boolean ("xor - 1", n8.bit_xor (l_n8) = {NATURAL_8} 0xFF)
			check_boolean ("xor - 2", n8_ref.bit_xor (l_n8_ref) = {NATURAL_8} 0xFF)
			check_boolean ("bit_not - 1", n8.bit_not = {NATURAL_8} 0xF0)
			check_boolean ("bit_not - 2", n8_ref.bit_not = {NATURAL_8} 0xF0)
			check_boolean ("|<< - 1", n8 |<< 3 = {NATURAL_8} 0x78)
			check_boolean ("|<< - 2", n8_ref |<< 3 = {NATURAL_8} 0x78)
			check_boolean ("|>> - 1", n8 |>> 3 = {NATURAL_8} 0x01)
			check_boolean ("|>> - 2", n8_ref |>> 3 = {NATURAL_8} 0x01)
		end

	test_natural_16
		local
			l_i8: INTEGER_8
			l_i16: INTEGER_16
			l_i32: INTEGER_32
			l_i64: INTEGER_64
			l_n8: NATURAL_8
			l_n16: NATURAL_16
			l_n16_ref: NATURAL_16_REF
			l_n32: NATURAL_32
			l_n64: NATURAL_64
			l_r32: REAL_32
			l_r64: REAL_64
			l_c8: CHARACTER_8
			l_c32: CHARACTER_32
		do
			n16 := 10
			a := n16
			check_equals ("generating_type", a.generating_type.out, "NATURAL_16")

			n16_ref := n16
			check_boolean ("comparison ref/non-ref", n16_ref.item = n16)

			n16_ref := n16
			l_n8 := n16.as_natural_8
			check_boolean ("as_natural_8 - 1", l_n8 = 10)
			check_boolean ("as_natural_8 - 2", l_n8 = n16_ref.as_natural_8)
			l_n16 := n16.as_natural_16
			check_boolean ("as_natural_16 - 1", l_n16 = 10)
			check_boolean ("as_natural_16 - 2", l_n16 = n16_ref.as_natural_16)
			l_n32 := n16.as_natural_32
			check_boolean ("as_natural_32 - 1", l_n32 = 10)
			check_boolean ("as_natural_32 - 2", l_n32 = n16_ref.as_natural_32)
			l_n64 := n16.as_natural_64
			check_boolean ("as_natural_64 - 1", l_n64 = 10)
			check_boolean ("as_natural_64 - 2", l_n64 = n16_ref.as_natural_64)

			n16_ref := n16
			l_i8 := n16.as_integer_8
			check_boolean ("as_integer_8 - 1", l_i8 = 10)
			check_boolean ("as_integer_8 - 2", l_i8 = n16_ref.as_integer_8)
			l_i16 := n16.as_integer_16
			check_boolean ("as_integer_16 - 1", l_i16 = 10)
			check_boolean ("as_integer_16 - 2", l_i16 = n16_ref.as_integer_16)
			l_i32 := n16.as_integer_32
			check_boolean ("as_integer_32 - 1", l_i32 = 10)
			check_boolean ("as_integer_32 - 2", l_i32 = n16_ref.as_integer_32)
			l_i64 := n16.as_integer_64
			check_boolean ("as_integer_64 - 1", l_i64 = 10)
			check_boolean ("as_integer_64 - 2", l_i64 = n16_ref.as_integer_64)

			n16_ref := n16
			l_i8 := n16.to_integer_8
			check_boolean ("to_integer_8 - 1", l_i8 = 10)
			check_boolean ("to_integer_8 - 2", l_i8 = n16_ref.to_integer_8)
			l_i16 := n16.to_integer_16
			check_boolean ("to_integer_16 - 1", l_i16 = 10)
			check_boolean ("to_integer_16 - 2", l_i16 = n16_ref.to_integer_16)
			l_i32 := n16.to_integer_32
			check_boolean ("to_integer_32 - 1", l_i32 = 10)
			check_boolean ("to_integer_32 - 2", l_i32 = n16_ref.to_integer_32)
			l_i64 := n16.to_integer_64
			check_boolean ("to_integer_64 - 1", l_i64 = 10)
			check_boolean ("to_integer_64 - 2", l_i64 = n16_ref.to_integer_64)

			n16_ref := n16
			l_r32 := n16.to_real_32
			check_boolean ("to_real_32 - 1", l_r32 = 10)
			check_boolean ("to_real_32 - 2", l_r32 = n16_ref.to_real_32)

			n16_ref := n16
			l_r64 := n16.to_real_64
			check_boolean ("to_real_64 - 1", l_r64 = 10)
			check_boolean ("to_real_64 - 2", l_r64 = n16_ref.to_real_64)

			n16 := 10
			n16_ref := n16
			l_c8 := n16.to_character_8
			check_boolean ("to_character_8 - 1", l_c8 = '%/10/')
			check_boolean ("to_character_8 - 2", l_c8 = n16_ref.to_character_8)

			n16_ref := n16
			l_c32 := n16.to_character_32
			check_boolean ("to_character_32 - 1", l_c32 = '%/10/')
			check_boolean ("to_character_32 - 2", l_c32 = n16_ref.to_character_32)

			n16 := 19
			n16_ref := n16
			check_boolean ("< - 1", n16 < {NATURAL_16} 25)
			check_boolean ("< - 2", n16_ref < {NATURAL_16} 25)
			check_boolean ("+ - 1", n16 + 5 = {NATURAL_16} 24)
			check_boolean ("+ - 2", n16_ref + {NATURAL_16} 5 = {NATURAL_16} 24)
			check_boolean ("- - 1", n16 - 5 = {NATURAL_16} 14)
			check_boolean ("- - 2", n16_ref - {NATURAL_16} 5 = {NATURAL_16} 14)
			check_boolean ("* - 1", n16 * 5 = {NATURAL_16} 95)
			check_boolean ("* - 2", n16_ref * {NATURAL_16} 5 = {NATURAL_16} 95)

			n16 := 20
			n16_ref := n16
			check_boolean ("/ - 1", n16 / 2 = {REAL_64} 10.0)
			check_boolean ("/ - 2", n16_ref / {NATURAL_16} 2 = {REAL_64} 10.0)
			check_boolean ("prefix + - 1", +n16 = {NATURAL_16} 20)
			check_boolean ("prefix + - 2", +n16_ref = {NATURAL_16} 20)
			check_boolean ("// - 1", n16 // 2 = {NATURAL_16} 10)
			check_boolean ("// - 2", n16_ref // {NATURAL_16} 2 = {NATURAL_16} 10)
			check_boolean ("\\ - 1", n16 \\ 2 = {NATURAL_16} 0)
			check_boolean ("\\ - 2", n16_ref \\ {NATURAL_16} 2 = {NATURAL_16} 0)
			check_boolean ("^ - 1", n16 ^ 2 = {REAL_64} 400.0)
			check_boolean ("^ - 2", n16_ref ^ 2 = {REAL_64} 400.0)

			n16 := 0x0F
			l_n16 := 0xF0
			n16_ref := n16
			l_n16_ref := l_n16
			check_boolean ("& - 1", n16 & l_n16 = {NATURAL_16} 0x00)
			check_boolean ("& - 2", n16_ref & l_n16_ref = {NATURAL_16} 0x00)
			check_boolean ("| - 1", n16 | l_n16 = {NATURAL_16} 0xFF)
			check_boolean ("| - 2", n16_ref | l_n16_ref = {NATURAL_16} 0xFF)
			check_boolean ("xor - 1", n16.bit_xor (l_n16) = {NATURAL_16} 0xFF)
			check_boolean ("xor - 2", n16_ref.bit_xor (l_n16_ref) = {NATURAL_16} 0xFF)
			check_boolean ("bit_not - 1", n16.bit_not = {NATURAL_16} 0xFFF0)
			check_boolean ("bit_not - 2", n16_ref.bit_not = {NATURAL_16} 0xFFF0)
			check_boolean ("|<< - 1", n16 |<< 3 = {NATURAL_16} 0x78)
			check_boolean ("|<< - 2", n16_ref |<< 3 = {NATURAL_16} 0x78)
			check_boolean ("|>> - 1", n16 |>> 3 = {NATURAL_16} 0x01)
			check_boolean ("|>> - 2", n16_ref |>> 3 = {NATURAL_16} 0x01)
		end

	test_natural_32
		local
			l_i8: INTEGER_8
			l_i16: INTEGER_16
			l_i32: INTEGER_32
			l_i64: INTEGER_64
			l_n8: NATURAL_8
			l_n16: NATURAL_16
			l_n32: NATURAL_32
			l_n32_ref: NATURAL_32_REF
			l_n64: NATURAL_64
			l_r32: REAL_32
			l_r64: REAL_64
			l_c8: CHARACTER_8
			l_c32: CHARACTER_32
		do
			n32 := 10
			a := n32
			check_equals ("generating_type", a.generating_type.out, "NATURAL_32")

			n32_ref := n32
			check_boolean ("comparison ref/non-ref", n32_ref.item = n32)

			n32_ref := n32
			l_n8 := n32.as_natural_8
			check_boolean ("as_natural_8 - 1", l_n8 = 10)
			check_boolean ("as_natural_8 - 2", l_n8 = n32_ref.as_natural_8)
			l_n16 := n32.as_natural_16
			check_boolean ("as_natural_16 - 1", l_n16 = 10)
			check_boolean ("as_natural_16 - 2", l_n16 = n32_ref.as_natural_16)
			l_n32 := n32.as_natural_32
			check_boolean ("as_natural_32 - 1", l_n32 = 10)
			check_boolean ("as_natural_32 - 2", l_n32 = n32_ref.as_natural_32)
			l_n64 := n32.as_natural_64
			check_boolean ("as_natural_64 - 1", l_n64 = 10)
			check_boolean ("as_natural_64 - 2", l_n64 = n32_ref.as_natural_64)

			n32_ref := n32
			l_i8 := n32.as_integer_8
			check_boolean ("as_integer_8 - 1", l_i8 = 10)
			check_boolean ("as_integer_8 - 2", l_i8 = n32_ref.as_integer_8)
			l_i16 := n32.as_integer_16
			check_boolean ("as_integer_16 - 1", l_i16 = 10)
			check_boolean ("as_integer_16 - 2", l_i16 = n32_ref.as_integer_16)
			l_i32 := n32.as_integer_32
			check_boolean ("as_integer_32 - 1", l_i32 = 10)
			check_boolean ("as_integer_32 - 2", l_i32 = n32_ref.as_integer_32)
			l_i64 := n32.as_integer_64
			check_boolean ("as_integer_64 - 1", l_i64 = 10)
			check_boolean ("as_integer_64 - 2", l_i64 = n32_ref.as_integer_64)

			n32_ref := n32
			l_i8 := n32.to_integer_8
			check_boolean ("to_integer_8 - 1", l_i8 = 10)
			check_boolean ("to_integer_8 - 2", l_i8 = n32_ref.to_integer_8)
			l_i16 := n32.to_integer_16
			check_boolean ("to_integer_16 - 1", l_i16 = 10)
			check_boolean ("to_integer_16 - 2", l_i16 = n32_ref.to_integer_16)
			l_i32 := n32.to_integer_32
			check_boolean ("to_integer_32 - 1", l_i32 = 10)
			check_boolean ("to_integer_32 - 2", l_i32 = n32_ref.to_integer_32)
			l_i64 := n32.to_integer_64
			check_boolean ("to_integer_64 - 1", l_i64 = 10)
			check_boolean ("to_integer_64 - 2", l_i64 = n32_ref.to_integer_64)

			n32_ref := n32
			l_r32 := n32.to_real_32
			check_boolean ("to_real_32 - 1", l_r32 = 10)
			check_boolean ("to_real_32 - 2", l_r32 = n32_ref.to_real_32)

			n32_ref := n32
			l_r64 := n32.to_real_64
			check_boolean ("to_real_64 - 1", l_r64 = 10)
			check_boolean ("to_real_64 - 2", l_r64 = n32_ref.to_real_64)

			n32 := 10
			n32_ref := n32
			l_c8 := n32.to_character_8
			check_boolean ("to_character_8 - 1", l_c8 = '%/10/')
			check_boolean ("to_character_8 - 2", l_c8 = n32_ref.to_character_8)

			n32_ref := n32
			l_c32 := n32.to_character_32
			check_boolean ("to_character_32 - 1", l_c32 = '%/10/')
			check_boolean ("to_character_32 - 2", l_c32 = n32_ref.to_character_32)

			n32 := 19
			n32_ref := n32
			check_boolean ("< - 1", n32 < {NATURAL_32} 25)
			check_boolean ("< - 2", n32_ref < {NATURAL_32} 25)
			check_boolean ("+ - 1", n32 + 5 = {NATURAL_32} 24)
			check_boolean ("+ - 2", n32_ref + {NATURAL_32} 5 = {NATURAL_32} 24)
			check_boolean ("- - 1", n32 - 5 = {NATURAL_32} 14)
			check_boolean ("- - 2", n32_ref - {NATURAL_32} 5 = {NATURAL_32} 14)
			check_boolean ("* - 1", n32 * 5 = {NATURAL_32} 95)
			check_boolean ("* - 2", n32_ref * {NATURAL_32} 5 = {NATURAL_32} 95)

			n32 := 20
			n32_ref := n32
			check_boolean ("/ - 1", n32 / 2 = {REAL_64} 10.0)
			check_boolean ("/ - 2", n32_ref / {NATURAL_32} 2 = {REAL_64} 10.0)
			check_boolean ("prefix + - 1", +n32 = {NATURAL_32} 20)
			check_boolean ("prefix + - 2", +n32_ref = {NATURAL_32} 20)
			check_boolean ("// - 1", n32 // 2 = {NATURAL_32} 10)
			check_boolean ("// - 2", n32_ref // {NATURAL_32} 2 = {NATURAL_32} 10)
			check_boolean ("\\ - 1", n32 \\ 2 = {NATURAL_32} 0)
			check_boolean ("\\ - 2", n32_ref \\ {NATURAL_32} 2 = {NATURAL_32} 0)
			check_boolean ("^ - 1", n32 ^ 2 = {REAL_64} 400.0)
			check_boolean ("^ - 2", n32_ref ^ 2 = {REAL_64} 400.0)

			n32 := 0x0F
			l_n32 := 0xF0
			n32_ref := n32
			l_n32_ref := l_n32
			check_boolean ("& - 1", n32 & l_n32 = {NATURAL_32} 0x00)
			check_boolean ("& - 2", n32_ref & l_n32_ref = {NATURAL_32} 0x00)
			check_boolean ("| - 1", n32 | l_n32 = {NATURAL_32} 0xFF)
			check_boolean ("| - 2", n32_ref | l_n32_ref = {NATURAL_32} 0xFF)
			check_boolean ("xor - 1", n32.bit_xor (l_n32) = {NATURAL_32} 0xFF)
			check_boolean ("xor - 2", n32_ref.bit_xor (l_n32_ref) = {NATURAL_32} 0xFF)
			check_boolean ("bit_not - 1", n32.bit_not = {NATURAL_32} 0xFFFFFFF0)
			check_boolean ("bit_not - 2", n32_ref.bit_not = {NATURAL_32} 0xFFFFFFF0)
			check_boolean ("|<< - 1", n32 |<< 3 = {NATURAL_32} 0x78)
			check_boolean ("|<< - 2", n32_ref |<< 3 = {NATURAL_32} 0x78)
			check_boolean ("|>> - 1", n32 |>> 3 = {NATURAL_32} 0x01)
			check_boolean ("|>> - 2", n32_ref |>> 3 = {NATURAL_32} 0x01)
		end

	test_natural_64
		local
			l_i8: INTEGER_8
			l_i16: INTEGER_16
			l_i32: INTEGER_32
			l_i64: INTEGER_64
			l_n8: NATURAL_8
			l_n16: NATURAL_16
			l_n32: NATURAL_32
			l_n64: NATURAL_64
			l_n64_ref: NATURAL_64_REF
			l_r32: REAL_32
			l_r64: REAL_64
			l_c8: CHARACTER_8
			l_c32: CHARACTER_32
		do
			n64 := 10
			a := n64
			check_equals ("generating_type", a.generating_type.out, "NATURAL_64")

			n64_ref := n64
			check_boolean ("comparison ref/non-ref", n64_ref.item = n64)

			n64_ref := n64
			l_n8 := n64.as_natural_8
			check_boolean ("as_natural_8 - 1", l_n8 = 10)
			check_boolean ("as_natural_8 - 2", l_n8 = n64_ref.as_natural_8)
			l_n16 := n64.as_natural_16
			check_boolean ("as_natural_16 - 1", l_n16 = 10)
			check_boolean ("as_natural_16 - 2", l_n16 = n64_ref.as_natural_16)
			l_n32 := n64.as_natural_32
			check_boolean ("as_natural_32 - 1", l_n32 = 10)
			check_boolean ("as_natural_32 - 2", l_n32 = n64_ref.as_natural_32)
			l_n64 := n64.as_natural_64
			check_boolean ("as_natural_64 - 1", l_n64 = 10)
			check_boolean ("as_natural_64 - 2", l_n64 = n64_ref.as_natural_64)

			n64_ref := n64
			l_i8 := n64.as_integer_8
			check_boolean ("as_integer_8 - 1", l_i8 = 10)
			check_boolean ("as_integer_8 - 2", l_i8 = n64_ref.as_integer_8)
			l_i16 := n64.as_integer_16
			check_boolean ("as_integer_16 - 1", l_i16 = 10)
			check_boolean ("as_integer_16 - 2", l_i16 = n64_ref.as_integer_16)
			l_i32 := n64.as_integer_32
			check_boolean ("as_integer_32 - 1", l_i32 = 10)
			check_boolean ("as_integer_32 - 2", l_i32 = n64_ref.as_integer_32)
			l_i64 := n64.as_integer_64
			check_boolean ("as_integer_64 - 1", l_i64 = 10)
			check_boolean ("as_integer_64 - 2", l_i64 = n64_ref.as_integer_64)

			n64_ref := n64
			l_i8 := n64.to_integer_8
			check_boolean ("to_integer_8 - 1", l_i8 = 10)
			check_boolean ("to_integer_8 - 2", l_i8 = n64_ref.to_integer_8)
			l_i16 := n64.to_integer_16
			check_boolean ("to_integer_16 - 1", l_i16 = 10)
			check_boolean ("to_integer_16 - 2", l_i16 = n64_ref.to_integer_16)
			l_i32 := n64.to_integer_32
			check_boolean ("to_integer_32 - 1", l_i32 = 10)
			check_boolean ("to_integer_32 - 2", l_i32 = n64_ref.to_integer_32)
			l_i64 := n64.to_integer_64
			check_boolean ("to_integer_64 - 1", l_i64 = 10)
			check_boolean ("to_integer_64 - 2", l_i64 = n64_ref.to_integer_64)

			n64_ref := n64
			l_r32 := n64.to_real_32
			check_boolean ("to_real_32 - 1", l_r32 = 10)
			check_boolean ("to_real_32 - 2", l_r32 = n64_ref.to_real_32)

			n64_ref := n64
			l_r64 := n64.to_real_64
			check_boolean ("to_real_64 - 1", l_r64 = 10)
			check_boolean ("to_real_64 - 2", l_r64 = n64_ref.to_real_64)

			n64 := 10
			n64_ref := n64
			l_c8 := n64.to_character_8
			check_boolean ("to_character_8 - 1", l_c8 = '%/10/')
			check_boolean ("to_character_8 - 2", l_c8 = n64_ref.to_character_8)

			n64_ref := n64
			l_c32 := n64.to_character_32
			check_boolean ("to_character_32 - 1", l_c32 = '%/10/')
			check_boolean ("to_character_32 - 2", l_c32 = n64_ref.to_character_32)

			n64 := 19
			n64_ref := n64
			check_boolean ("< - 1", n64 < {NATURAL_64} 25)
			check_boolean ("< - 2", n64_ref < {NATURAL_64} 25)
			check_boolean ("+ - 1", n64 + 5 = {NATURAL_64} 24)
			check_boolean ("+ - 2", n64_ref + {NATURAL_64} 5 = {NATURAL_64} 24)
			check_boolean ("- - 1", n64 - 5 = {NATURAL_64} 14)
			check_boolean ("- - 2", n64_ref - {NATURAL_64} 5 = {NATURAL_64} 14)
			check_boolean ("* - 1", n64 * 5 = {NATURAL_64} 95)
			check_boolean ("* - 2", n64_ref * {NATURAL_64} 5 = {NATURAL_64} 95)

			n64 := 20
			n64_ref := n64
			check_boolean ("/ - 1", n64 / 2 = {REAL_64} 10.0)
			check_boolean ("/ - 2", n64_ref / {NATURAL_64} 2 = {REAL_64} 10.0)
			check_boolean ("prefix + - 1", +n64 = {NATURAL_64} 20)
			check_boolean ("prefix + - 2", +n64_ref = {NATURAL_64} 20)
			check_boolean ("// - 1", n64 // 2 = {NATURAL_64} 10)
			check_boolean ("// - 2", n64_ref // {NATURAL_64} 2 = {NATURAL_64} 10)
			check_boolean ("\\ - 1", n64 \\ 2 = {NATURAL_64} 0)
			check_boolean ("\\ - 2", n64_ref \\ {NATURAL_64} 2 = {NATURAL_64} 0)
			check_boolean ("^ - 1", n64 ^ 2 = {REAL_64} 400.0)
			check_boolean ("^ - 2", n64_ref ^ 2 = {REAL_64} 400.0)

			n64 := 0x0F
			l_n64 := 0xF0
			n64_ref := n64
			l_n64_ref := l_n64
			check_boolean ("& - 1", n64 & l_n64 = {NATURAL_64} 0x00)
			check_boolean ("& - 2", n64_ref & l_n64_ref = {NATURAL_64} 0x00)
			check_boolean ("| - 1", n64 | l_n64 = {NATURAL_64} 0xFF)
			check_boolean ("| - 2", n64_ref | l_n64_ref = {NATURAL_64} 0xFF)
			check_boolean ("xor - 1", n64.bit_xor (l_n64) = {NATURAL_64} 0xFF)
			check_boolean ("xor - 2", n64_ref.bit_xor (l_n64_ref) = {NATURAL_64} 0xFF)
			check_boolean ("bit_not - 1", n64.bit_not = {NATURAL_64} 0xFFFFFFFFFFFFFFF0)
			check_boolean ("bit_not - 2", n64_ref.bit_not = {NATURAL_64} 0xFFFFFFFFFFFFFFF0)
			check_boolean ("|<< - 1", n64 |<< 3 = {NATURAL_64} 0x78)
			check_boolean ("|<< - 2", n64_ref |<< 3 = {NATURAL_64} 0x78)
			check_boolean ("|>> - 1", n64 |>> 3 = {NATURAL_64} 0x01)
			check_boolean ("|>> - 2", n64_ref |>> 3 = {NATURAL_64} 0x01)
		end

feature {NONE} -- Implementation

	check_boolean (s: STRING; v: BOOLEAN) is
		require
			s_not_void: s /= Void
		do
			if not v then
				print ("Failure in " + s + "%N")
			end
		end

	check_equals (s: STRING; obj1, obj2: ANY) is
		require
			s_not_void: s /= Void
		do
			if not equal (obj1, obj2) then
				print ("Failure in " + s + "%N")
			end
		end

end

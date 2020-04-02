class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			test_character
			test_integer
			test_natural
			test_real
		end

feature {NONE} -- Test

	test_character
			-- Test operators on characters.
		local
			i1, j1: CHARACTER_8
			i4, j4: CHARACTER_32
		do
			io.put_string ("Tests on characters%N")
			i1 := '3'; j1 := '5'
			i4 := i1; j4 := j1
			report_character (i1 ∨ j1, '5', 0x61)
			report_character (i4 ∨ j4, '5', 0x63)
			report_character (i1 ∧ j1, '3', 0x71)
			report_character (i4 ∧ j4, '3', 0x73)
			report_integer (i1 ⋚ j1, -1, 0x81)
			report_integer (i4 ⋚ j4, -1, 0x83)
		end

	test_integer
			-- Test operators on integer numbers.
		local
			i1, j1: INTEGER_8
			i2, j2: INTEGER_16
			i4, j4: INTEGER_32
			i8, j8: INTEGER_64
		do
			io.put_string ("Tests on integers%N")
			i1 := 3; j1 := 5
			i2 := i1; j2 := j1
			i4 := i1; j4 := j1
			i8 := i1; j8 := j1
			report_integer (i1 ⊗ j1, 1, 0x01)
			report_integer (i2 ⊗ j2, 1, 0x02)
			report_integer (i4 ⊗ j4, 1, 0x03)
			report_integer (i8 ⊗ j8, 1, 0x04)
			report_integer (i1 ⦶ j1, 7, 0x11)
			report_integer (i2 ⦶ j2, 7, 0x12)
			report_integer (i4 ⦶ j4, 7, 0x13)
			report_integer (i8 ⦶ j8, 7, 0x14)
			report_integer (i1 ⊕ j1, 6, 0x21)
			report_integer (i2 ⊕ j2, 6, 0x22)
			report_integer (i4 ⊕ j4, 6, 0x23)
			report_integer (i8 ⊕ j8, 6, 0x24)
			report_integer (i1 ⧀ 2, 12, 0x31)
			report_integer (i2 ⧀ 2, 12, 0x32)
			report_integer (i4 ⧀ 2, 12, 0x33)
			report_integer (i8 ⧀ 2, 12, 0x34)
			report_integer (i1 ⧁ 1, 1, 0x41)
			report_integer (i2 ⧁ 1, 1, 0x42)
			report_integer (i4 ⧁ 1, 1, 0x43)
			report_integer (i8 ⧁ 1, 1, 0x44)
			report_integer (⊝ i1, -4, 0x51)
			report_integer (⊝ i2, -4, 0x52)
			report_integer (⊝ i4, -4, 0x53)
			report_integer (⊝ i8, -4, 0x54)
			report_integer (i1 ∨ j1, 5, 0x61)
			report_integer (i2 ∨ j2, 5, 0x62)
			report_integer (i4 ∨ j4, 5, 0x63)
			report_integer (i8 ∨ j8, 5, 0x64)
			report_integer (i1 ∧ j1, 3, 0x71)
			report_integer (i2 ∧ j2, 3, 0x72)
			report_integer (i4 ∧ j4, 3, 0x73)
			report_integer (i8 ∧ j8, 3, 0x74)
			report_integer (i1 ⋚ j1, -1, 0x81)
			report_integer (i2 ⋚ j2, -1, 0x82)
			report_integer (i4 ⋚ j4, -1, 0x83)
			report_integer (i8 ⋚ j8, -1, 0x84)
		end

	test_natural
			-- Test operators on natural numbers.
		local
			i1, j1: NATURAL_8
			i2, j2: NATURAL_16
			i4, j4: NATURAL_32
			i8, j8: NATURAL_64
		do
			io.put_string ("Tests on naturals%N")
			i1 := 3; j1 := 5
			i2 := i1; j2 := j1
			i4 := i1; j4 := j1
			i8 := i1; j8 := j1
			report_natural (i1 ⊗ j1, 1, 0x01)
			report_natural (i2 ⊗ j2, 1, 0x02)
			report_natural (i4 ⊗ j4, 1, 0x03)
			report_natural (i8 ⊗ j8, 1, 0x04)
			report_natural (i1 ⦶ j1, 7, 0x11)
			report_natural (i2 ⦶ j2, 7, 0x12)
			report_natural (i4 ⦶ j4, 7, 0x13)
			report_natural (i8 ⦶ j8, 7, 0x14)
			report_natural (i1 ⊕ j1, 6, 0x21)
			report_natural (i2 ⊕ j2, 6, 0x22)
			report_natural (i4 ⊕ j4, 6, 0x23)
			report_natural (i8 ⊕ j8, 6, 0x24)
			report_natural (i1 ⧀ 2, 12, 0x31)
			report_natural (i2 ⧀ 2, 12, 0x32)
			report_natural (i4 ⧀ 2, 12, 0x33)
			report_natural (i8 ⧀ 2, 12, 0x34)
			report_natural (i1 ⧁ 1, 1, 0x41)
			report_natural (i2 ⧁ 1, 1, 0x42)
			report_natural (i4 ⧁ 1, 1, 0x43)
			report_natural (i8 ⧁ 1, 1, 0x44)
			report_natural (⊝ i1, 0xFC, 0x51)
			report_natural (⊝ i2, 0xFFFC, 0x52)
			report_natural (⊝ i4, 0xFFFFFFFC, 0x53)
			report_natural (⊝ i8, 0xFFFFFFFFFFFFFFFC, 0x54)
			report_natural (i1 ∨ j1, 5, 0x61)
			report_natural (i2 ∨ j2, 5, 0x62)
			report_natural (i4 ∨ j4, 5, 0x63)
			report_natural (i8 ∨ j8, 5, 0x64)
			report_natural (i1 ∧ j1, 3, 0x71)
			report_natural (i2 ∧ j2, 3, 0x72)
			report_natural (i4 ∧ j4, 3, 0x73)
			report_natural (i8 ∧ j8, 3, 0x74)
			report_integer (i1 ⋚ j1, -1, 0x81)
			report_integer (i2 ⋚ j2, -1, 0x82)
			report_integer (i4 ⋚ j4, -1, 0x83)
			report_integer (i8 ⋚ j8, -1, 0x84)
		end

	test_real
			-- Test operators on natural numbers.
		local
			i4, j4: REAL_32
			i8, j8: REAL_64
		do
			io.put_string ("Tests on reals%N")
			i4 := 3; j4 := 5
			i8 := i4; j8 := j4
			report_real (i4 ∨ j4, 5, 0x61)
			report_real (i8 ∨ j8, 5, 0x62)
			report_real (i4 ∧ j4, 3, 0x73)
			report_real (i8 ∧ j8, 3, 0x74)
			report_integer (i4 ⋚ j4, -1, 0x83)
			report_integer (i8 ⋚ j8, -1, 0x84)
		end

feature {NONE} -- Report

	report_character (actual, expected: CHARACTER_32; test_number: NATURAL_8)
			-- Report whether `actual` value matches `expected` value in test `test_number`.
		do
			io.put_character (((test_number & 0xF0) |>> 4).to_hex_character)
			io.put_character (((test_number & 0x0F) |>> 0).to_hex_character)
			io.put_character (':')
			io.put_character (' ')
			if actual = expected then
				io.put_string ("OK")
			else
				io.put_string ("Failed. Actual: ")
				io.put_string (actual.natural_32_code.to_hex_string)
				io.put_string (" Expected: ")
				io.put_string (expected.natural_32_code.to_hex_string)
			end
			io.put_new_line
		end

	report_integer (actual, expected: INTEGER_64; test_number: NATURAL_8)
			-- Report whether `actual` value matches `expected` value in test `test_number`.
		do
			io.put_character (((test_number & 0xF0) |>> 4).to_hex_character)
			io.put_character (((test_number & 0x0F) |>> 0).to_hex_character)
			io.put_character (':')
			io.put_character (' ')
			if actual = expected then
				io.put_string ("OK")
			else
				io.put_string ("Failed. Actual: ")
				io.put_integer_64 (actual)
				io.put_string (" Expected: ")
				io.put_integer_64 (expected)
			end
			io.put_new_line
		end

	report_natural (actual, expected: NATURAL_64; test_number: NATURAL_8)
			-- Report whether `actual` value matches `expected` value in test `test_number`.
		do
			io.put_character (((test_number & 0xF0) |>> 4).to_hex_character)
			io.put_character (((test_number & 0x0F) |>> 0).to_hex_character)
			io.put_character (':')
			io.put_character (' ')
			if actual = expected then
				io.put_string ("OK")
			else
				io.put_string ("Failed. Actual: ")
				io.put_natural_64 (actual)
				io.put_string (" Expected: ")
				io.put_natural_64 (expected)
			end
			io.put_new_line
		end

	report_real (actual, expected: REAL_64; test_number: NATURAL_8)
			-- Report whether `actual` value matches `expected` value in test `test_number`.
		do
			io.put_character (((test_number & 0xF0) |>> 4).to_hex_character)
			io.put_character (((test_number & 0x0F) |>> 0).to_hex_character)
			io.put_character (':')
			io.put_character (' ')
			if actual = expected then
				io.put_string ("OK")
			else
				io.put_string ("Failed. Actual: ")
				io.put_real_64 (actual)
				io.put_string (" Expected: ")
				io.put_real_64 (expected)
			end
			io.put_new_line
		end

end

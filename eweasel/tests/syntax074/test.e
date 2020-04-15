class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			test_boolean
			test_character
			test_integer
			test_natural
			test_real
		end

feature {NONE} -- Test

	test_boolean
			-- Test operators on characters.
		local
			i1, j1: BOOLEAN
		do
			io.put_string ("Tests on booleans%N")
			i1 := True; j1 := False
			report_boolean (¬ i1, False, 0x141)
			report_boolean (¬ j1, True, 0x142)
			report_boolean (i1 ≡≡≡ j1, False, 0x301)
			report_boolean (i1 ≡≡≡ i1, True, 0x302)
			report_boolean (i1 ≜ j1, False, 0x311)
			report_boolean (i1 ≜ i1, True, 0x312)
		end

	test_character
			-- Test operators on characters.
		local
			i1, j1: CHARACTER_8
			i4, j4: CHARACTER_32
		do
			io.put_string ("Tests on characters%N")
			i1 := '3'; j1 := '5'
			i4 := i1; j4 := j1
			report_character (i1.plus (1), '4', 0x101)
			report_character (i4.plus (1), '4', 0x103)
			report_character (i1 − 1, '2', 0x111)
			report_character (i4 − 1, '2', 0x113)
			report_boolean (i1 ≤ j1, True, 0x201)
			report_boolean (i4 ≤ j4, True, 0x203)
			report_boolean (j1 ≤ i1, False, 0x211)
			report_boolean (j4 ≤ i4, False, 0x213)
			report_boolean (i1 ≤ i1, True, 0x221)
			report_boolean (i4 ≤ i4, True, 0x223)
			report_boolean (i1 ≥ j1, False, 0x231)
			report_boolean (i4 ≥ j4, False, 0x233)
			report_boolean (j1 ≥ i1, True, 0x241)
			report_boolean (j4 ≥ i4, True, 0x243)
			report_boolean (i1 ≥ i1, True, 0x251)
			report_boolean (i4 ≥ i4, True, 0x253)
			report_integer (i1 ⋚ j1, -1, 0x261)
			report_integer (i4 ⋚ j4, -1, 0x263)
			report_integer (j1 ⋚ i1, 1, 0x271)
			report_integer (j4 ⋚ i4, 1, 0x273)
			report_integer (i1 ⋚ i1, 0, 0x281)
			report_integer (i4 ⋚ i4, 0, 0x283)
			report_character (i1 ∨ j1, '5', 0x231)
			report_character (i4 ∨ j4, '5', 0x233)
			report_character (i1 ∧ j1, '3', 0x241)
			report_character (i4 ∧ j4, '3', 0x243)
			report_boolean (i1 ≡≡≡ j1, False, 0x301)
			report_boolean (i4 ≡≡≡ j4, False, 0x303)
			report_boolean (i1 ≡≡≡ i1, True, 0x311)
			report_boolean (i4 ≡≡≡ i4, True, 0x313)
			report_boolean (i1 ≜ j1, False, 0x321)
			report_boolean (i4 ≜ j4, False, 0x323)
			report_boolean (i1 ≜ i1, True, 0x331)
			report_boolean (i4 ≜ i4, True, 0x333)
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
			report_integer (i1.plus (j1), 8, 0x101)
			report_integer (i2.plus (j2), 8, 0x102)
			report_integer (i4.plus (j4), 8, 0x103)
			report_integer (i8.plus (j8), 8, 0x104)
			report_integer (i1 − j1, -2, 0x111)
			report_integer (i2 − j2, -2, 0x112)
			report_integer (i4 − j4, -2, 0x113)
			report_integer (i8 − j8, -2, 0x114)
			report_integer (i1 × j1, 15, 0x121)
			report_integer (i2 × j2, 15, 0x122)
			report_integer (i4 × j4, 15, 0x123)
			report_integer (i8 × j8, 15, 0x124)
			j1 := 2; j2 := 2; j4 := 2; j8 := 2
			report_real (i1 ÷ j1, 1.5, 0x131)
			report_real (i2 ÷ j2, 1.5, 0x132)
			report_real (i4 ÷ j4, 1.5, 0x133)
			report_real (i8 ÷ j8, 1.5, 0x134)
			report_integer (− j1, -2, 0x141)
			report_integer (− j2, -2, 0x142)
			report_integer (− j4, -2, 0x143)
			report_integer (− j8, -2, 0x144)
			report_boolean (i1 ≤ j1, False, 0x201)
			report_boolean (i2 ≤ j2, False, 0x202)
			report_boolean (i4 ≤ j4, False, 0x203)
			report_boolean (i8 ≤ j8, False, 0x204)
			report_boolean (j1 ≤ i1, True, 0x211)
			report_boolean (j2 ≤ i2, True, 0x212)
			report_boolean (i4 ≤ i4, True, 0x213)
			report_boolean (i8 ≤ i8, True, 0x214)
			report_boolean (i1 ≤ i1, True, 0x221)
			report_boolean (i2 ≤ i2, True, 0x222)
			report_boolean (i4 ≤ i4, True, 0x223)
			report_boolean (i8 ≤ i8, True, 0x224)
			report_boolean (i1 ≥ j1, True, 0x231)
			report_boolean (i2 ≥ j2, True, 0x232)
			report_boolean (i4 ≥ j4, True, 0x233)
			report_boolean (i8 ≥ j8, True, 0x234)
			report_boolean (j1 ≥ i1, False, 0x241)
			report_boolean (j2 ≥ i2, False, 0x242)
			report_boolean (j4 ≥ i4, False, 0x243)
			report_boolean (j8 ≥ i8, False, 0x244)
			report_boolean (i1 ≥ i1, True, 0x251)
			report_boolean (i2 ≥ i2, True, 0x252)
			report_boolean (i4 ≥ i4, True, 0x253)
			report_boolean (i8 ≥ i8, True, 0x254)
			report_integer (i1 ⋚ j1, 1, 0x261)
			report_integer (i2 ⋚ j2, 1, 0x262)
			report_integer (i4 ⋚ j4, 1, 0x263)
			report_integer (i8 ⋚ j8, 1, 0x264)
			report_integer (j1 ⋚ i1, -1, 0x271)
			report_integer (j2 ⋚ i2, -1, 0x272)
			report_integer (j4 ⋚ i4, -1, 0x273)
			report_integer (j8 ⋚ i8, -1, 0x274)
			report_integer (i1 ⋚ i1, 0, 0x281)
			report_integer (i2 ⋚ i2, 0, 0x282)
			report_integer (i4 ⋚ i4, 0, 0x283)
			report_integer (i8 ⋚ i8, 0, 0x284)
			report_integer (i1 ∨ j1, 3, 0x291)
			report_integer (i2 ∨ j2, 3, 0x292)
			report_integer (i4 ∨ j4, 3, 0x293)
			report_integer (i8 ∨ j8, 3, 0x294)
			report_integer (i1 ∧ j1, 2, 0x2A1)
			report_integer (i2 ∧ j2, 2, 0x2A2)
			report_integer (i4 ∧ j4, 2, 0x2A3)
			report_integer (i8 ∧ j8, 2, 0x2A4)
			report_boolean (i1 ≡≡≡ j1, False, 0x301)
			report_boolean (i2 ≡≡≡ j2, False, 0x302)
			report_boolean (i4 ≡≡≡ j4, False, 0x303)
			report_boolean (i8 ≡≡≡ j8, False, 0x304)
			report_boolean (i1 ≡≡≡ i1, True, 0x311)
			report_boolean (i2 ≡≡≡ i2, True, 0x312)
			report_boolean (i4 ≡≡≡ i4, True, 0x313)
			report_boolean (i8 ≡≡≡ i8, True, 0x314)
			report_boolean (i1 ≜ j1, False, 0x321)
			report_boolean (i2 ≜ j2, False, 0x322)
			report_boolean (i4 ≜ j4, False, 0x323)
			report_boolean (i8 ≜ j8, False, 0x324)
			report_boolean (i1 ≜ i1, True, 0x331)
			report_boolean (i2 ≜ i2, True, 0x332)
			report_boolean (i4 ≜ i4, True, 0x333)
			report_boolean (i8 ≜ i8, True, 0x334)
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
			report_natural (i1.plus (j1), 8, 0x101)
			report_natural (i2.plus (j2), 8, 0x102)
			report_natural (i4.plus (j4), 8, 0x103)
			report_natural (i8.plus (j8), 8, 0x104)
			report_natural (j1 − i1, 2, 0x111)
			report_natural (j2 − i2, 2, 0x112)
			report_natural (j4 − i4, 2, 0x113)
			report_natural (j8 − i8, 2, 0x114)
			report_natural (i1 × j1, 15, 0x121)
			report_natural (i2 × j2, 15, 0x122)
			report_natural (i4 × j4, 15, 0x123)
			report_natural (i8 × j8, 15, 0x124)
			j1 := 2; j2 := 2; j4 := 2; j8 := 2
			report_real (i1 ÷ j1, 1.5, 0x131)
			report_real (i2 ÷ j2, 1.5, 0x132)
			report_real (i4 ÷ j4, 1.5, 0x133)
			report_real (i8 ÷ j8, 1.5, 0x134)
			report_boolean (i1 ≤ j1, False, 0x201)
			report_boolean (i2 ≤ j2, False, 0x202)
			report_boolean (i4 ≤ j4, False, 0x203)
			report_boolean (i8 ≤ j8, False, 0x204)
			report_boolean (j1 ≤ i1, True, 0x211)
			report_boolean (j2 ≤ i2, True, 0x212)
			report_boolean (i4 ≤ i4, True, 0x213)
			report_boolean (i8 ≤ i8, True, 0x214)
			report_boolean (i1 ≤ i1, True, 0x221)
			report_boolean (i2 ≤ i2, True, 0x222)
			report_boolean (i4 ≤ i4, True, 0x223)
			report_boolean (i8 ≤ i8, True, 0x224)
			report_boolean (i1 ≥ j1, True, 0x231)
			report_boolean (i2 ≥ j2, True, 0x232)
			report_boolean (i4 ≥ j4, True, 0x233)
			report_boolean (i8 ≥ j8, True, 0x234)
			report_boolean (j1 ≥ i1, False, 0x241)
			report_boolean (j2 ≥ i2, False, 0x242)
			report_boolean (j4 ≥ i4, False, 0x243)
			report_boolean (j8 ≥ i8, False, 0x244)
			report_boolean (i1 ≥ i1, True, 0x251)
			report_boolean (i2 ≥ i2, True, 0x252)
			report_boolean (i4 ≥ i4, True, 0x253)
			report_boolean (i8 ≥ i8, True, 0x254)
			report_integer (i1 ⋚ j1, 1, 0x261)
			report_integer (i2 ⋚ j2, 1, 0x262)
			report_integer (i4 ⋚ j4, 1, 0x263)
			report_integer (i8 ⋚ j8, 1, 0x264)
			report_integer (j1 ⋚ i1, -1, 0x271)
			report_integer (j2 ⋚ i2, -1, 0x272)
			report_integer (j4 ⋚ i4, -1, 0x273)
			report_integer (j8 ⋚ i8, -1, 0x274)
			report_integer (i1 ⋚ i1, 0, 0x281)
			report_integer (i2 ⋚ i2, 0, 0x282)
			report_integer (i4 ⋚ i4, 0, 0x283)
			report_integer (i8 ⋚ i8, 0, 0x284)
			report_natural (i1 ∨ j1, 3, 0x291)
			report_natural (i2 ∨ j2, 3, 0x292)
			report_natural (i4 ∨ j4, 3, 0x293)
			report_natural (i8 ∨ j8, 3, 0x294)
			report_natural (i1 ∧ j1, 2, 0x2A1)
			report_natural (i2 ∧ j2, 2, 0x2A2)
			report_natural (i4 ∧ j4, 2, 0x2A3)
			report_natural (i8 ∧ j8, 2, 0x2A4)
			report_boolean (i1 ≡≡≡ j1, False, 0x301)
			report_boolean (i2 ≡≡≡ j2, False, 0x302)
			report_boolean (i4 ≡≡≡ j4, False, 0x303)
			report_boolean (i8 ≡≡≡ j8, False, 0x304)
			report_boolean (i1 ≡≡≡ i1, True, 0x311)
			report_boolean (i2 ≡≡≡ i2, True, 0x312)
			report_boolean (i4 ≡≡≡ i4, True, 0x313)
			report_boolean (i8 ≡≡≡ i8, True, 0x314)
			report_boolean (i1 ≜ j1, False, 0x321)
			report_boolean (i2 ≜ j2, False, 0x322)
			report_boolean (i4 ≜ j4, False, 0x323)
			report_boolean (i8 ≜ j8, False, 0x324)
			report_boolean (i1 ≜ i1, True, 0x331)
			report_boolean (i2 ≜ i2, True, 0x332)
			report_boolean (i4 ≜ i4, True, 0x333)
			report_boolean (i8 ≜ i8, True, 0x334)
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
			report_real (i4.plus (j4), 8, 0x103)
			report_real (i8.plus (j8), 8, 0x104)
			report_real (i4 − j4, -2, 0x113)
			report_real (i8 − j8, -2, 0x114)
			report_real (i4 × j4, 15, 0x123)
			report_real (i8 × j8, 15, 0x124)
			j4 := 2; j8 := 2
			report_real (i4 ÷ j4, 1.5, 0x133)
			report_real (i8 ÷ j8, 1.5, 0x134)
			report_boolean (i4 ≤ j4, False, 0x203)
			report_boolean (i8 ≤ j8, False, 0x204)
			report_boolean (i4 ≤ i4, True, 0x213)
			report_boolean (i8 ≤ i8, True, 0x214)
			report_boolean (i4 ≤ i4, True, 0x223)
			report_boolean (i8 ≤ i8, True, 0x224)
			report_boolean (i4 ≥ j4, True, 0x233)
			report_boolean (i8 ≥ j8, True, 0x234)
			report_boolean (j4 ≥ i4, False, 0x243)
			report_boolean (j8 ≥ i8, False, 0x244)
			report_boolean (i4 ≥ i4, True, 0x253)
			report_boolean (i8 ≥ i8, True, 0x254)
			report_integer (i4 ⋚ j4, 1, 0x263)
			report_integer (i8 ⋚ j8, 1, 0x264)
			report_integer (j4 ⋚ i4, -1, 0x273)
			report_integer (j8 ⋚ i8, -1, 0x274)
			report_integer (i4 ⋚ i4, 0, 0x283)
			report_integer (i8 ⋚ i8, 0, 0x284)
			report_real (i4 ∨ j4, 3, 0x293)
			report_real (i8 ∨ j8, 3, 0x294)
			report_real (i4 ∧ j4, 2, 0x2A3)
			report_real (i8 ∧ j8, 2, 0x2A4)
			report_boolean (i4 ≡≡≡ j4, False, 0x303)
			report_boolean (i8 ≡≡≡ j8, False, 0x304)
			report_boolean (i4 ≡≡≡ i4, True, 0x313)
			report_boolean (i8 ≡≡≡ i8, True, 0x314)
			report_boolean (i4 ≜ j4, False, 0x323)
			report_boolean (i8 ≜ j8, False, 0x324)
			report_boolean (i4 ≜ i4, True, 0x333)
			report_boolean (i8 ≜ i8, True, 0x334)
		end

feature {NONE} -- Report

	report_test (test_number: NATURAL_16)
			-- Report test number `test_number` followed by a colon.
		do
			io.put_character (((test_number & 0xF00) |>> 8).to_hex_character)
			io.put_character (((test_number & 0x0F0) |>> 4).to_hex_character)
			io.put_character (((test_number & 0x00F) |>> 0).to_hex_character)
			io.put_character (':')
			io.put_character (' ')
		end

	report_boolean (actual, expected: BOOLEAN; test_number: NATURAL_16)
			-- Report whether `actual` value matches `expected` value in test `test_number`.
		do
			report_test (test_number)
			if actual = expected then
				io.put_string ("OK")
			else
				io.put_string ("Failed. Actual: ")
				io.put_boolean (actual)
				io.put_string (" Expected: ")
				io.put_boolean (expected)
			end
			io.put_new_line
		end

	report_character (actual, expected: CHARACTER_32; test_number: NATURAL_16)
			-- Report whether `actual` value matches `expected` value in test `test_number`.
		do
			report_test (test_number)
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

	report_integer (actual, expected: INTEGER_64; test_number: NATURAL_16)
			-- Report whether `actual` value matches `expected` value in test `test_number`.
		do
			report_test (test_number)
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

	report_natural (actual, expected: NATURAL_64; test_number: NATURAL_16)
			-- Report whether `actual` value matches `expected` value in test `test_number`.
		do
			report_test (test_number)
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

	report_real (actual, expected: REAL_64; test_number: NATURAL_16)
			-- Report whether `actual` value matches `expected` value in test `test_number`.
		do
			report_test (test_number)
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

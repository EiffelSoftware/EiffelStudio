note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	OCTAL_UTILS_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_format_check
			-- Note test format checking features
		note
			testing:	"covers/{OCTAL_UTILS}.is_octal_natural_16_string"
			testing:	"covers/{OCTAL_UTILS}.is_octal_natural_32_string"
			testing:	"covers/{OCTAL_UTILS}.is_octal_natural_64_string"
		local
			unit_under_test: OCTAL_UTILS
			s: STRING
		do
			create unit_under_test

			-- Simple
			s := "12551"
			assert ("Basic format check (16bit)", unit_under_test.is_octal_natural_16_string (s))
			assert ("Basic format check (32bit)", unit_under_test.is_octal_natural_32_string (s))
			assert ("Basic format check (64bit)", unit_under_test.is_octal_natural_64_string (s))

			-- All zeros
			s := "0000000000000000000000000000000000000000000000000000000"
			assert ("All zeros format check (16bit)", unit_under_test.is_octal_natural_16_string (s))
			assert ("All zeros format check (32bit)", unit_under_test.is_octal_natural_32_string (s))
			assert ("All zeros format check (64bit)", unit_under_test.is_octal_natural_64_string (s))

			-- Max values
			assert ("Max 16bit format check", unit_under_test.is_octal_natural_16_string (octal_natural_16_max_value_string))
			assert ("Max 32bit format check", unit_under_test.is_octal_natural_32_string (octal_natural_32_max_value_string))
			assert ("Max 64bit format check", unit_under_test.is_octal_natural_64_string (octal_natural_64_max_value_string))

			-- Leading zero max values
			assert ("Leading zeros max 16bit format check", unit_under_test.is_octal_natural_16_string ("00000000000" + octal_natural_16_max_value_string))
			assert ("Leading zeros max 32bit format check", unit_under_test.is_octal_natural_32_string ("00000000000" + octal_natural_32_max_value_string))
			assert ("Leading zeros max 64bit format check", unit_under_test.is_octal_natural_64_string ("00000000000" + octal_natural_64_max_value_string))

			-- Negative number
			s := "-1"
			assert ("Reject negative number (16bit)", not unit_under_test.is_octal_natural_16_string (s))
			assert ("Reject negative number (32bit)", not unit_under_test.is_octal_natural_32_string (s))
			assert ("Reject negative number (64bit)", not unit_under_test.is_octal_natural_64_string (s))

			-- Too large number
			assert ("Reject too large (16bit)", not unit_under_test.is_octal_natural_16_string ("1" + octal_natural_16_max_value_string))
			assert ("Reject too large (32bit)", not unit_under_test.is_octal_natural_32_string ("1" + octal_natural_32_max_value_string))
			assert ("Reject too large (64bit)", not unit_under_test.is_octal_natural_64_string ("1" + octal_natural_64_max_value_string))

			-- Non-octal number
			s := "5327349"
			assert ("Reject non-octal number (16bit)", not unit_under_test.is_octal_natural_16_string (s))
			assert ("Reject non-octal number (32bit)", not unit_under_test.is_octal_natural_32_string (s))
			assert ("Reject non-octal number (64bit)", not unit_under_test.is_octal_natural_64_string (s))
		end

	test_parse
			-- Test parsing features
		note
			testing:	"covers/{OCTAL_UTILS}.octal_string_to_natural_16"
			testing:	"covers/{OCTAL_UTILS}.octal_string_to_natural_32"
			testing:	"covers/{OCTAL_UTILS}.octal_string_to_natural_64"
		local
			unit_under_test: OCTAL_UTILS
			s: STRING
		do
			create unit_under_test

			-- Basic functionality
			s := "141223"
			assert ("Basic parsing (16bit)", unit_under_test.octal_string_to_natural_16 (s) = 0c141223)
			assert ("Basic parsing (32bit)", unit_under_test.octal_string_to_natural_32 (s) = 0c141223)
			assert ("Basic parsing (64bit)", unit_under_test.octal_string_to_natural_64 (s) = 0c141223)

			s := "70365"
			assert ("Basic parsing 2 (16bit)", unit_under_test.octal_string_to_natural_16 (s) = 0c70365)
			assert ("Basic parsing 2 (32bit)", unit_under_test.octal_string_to_natural_32 (s) = 0c70365)
			assert ("Basic parsing 2 (64bit)", unit_under_test.octal_string_to_natural_64 (s) = 0c70365)

			-- Max values
			assert ("Max 16bit parsing", unit_under_test.octal_string_to_natural_16 (octal_natural_16_max_value_string) = {NATURAL_16}.max_value)
			assert ("Max 32bit parsing", unit_under_test.octal_string_to_natural_32 (octal_natural_32_max_value_string) = {NATURAL_32}.max_value)
			assert ("Max 64bit parsing", unit_under_test.octal_string_to_natural_64 (octal_natural_64_max_value_string) = {NATURAL_64}.max_value)

			-- All zeros
			s := "000000000000000"
			assert ("All zero parsing (16bit)", unit_under_test.octal_string_to_natural_16 (s) = 0)
			assert ("All zero parsing (32bit)", unit_under_test.octal_string_to_natural_32 (s) = 0)
			assert ("All zero parsing (64bit)", unit_under_test.octal_string_to_natural_64 (s) = 0)

			-- Leading zeros
			s := "0000000000000001"
			assert ("All zero parsing (16bit)", unit_under_test.octal_string_to_natural_16 (s) = 1)
			assert ("All zero parsing (32bit)", unit_under_test.octal_string_to_natural_32 (s) = 1)
			assert ("All zero parsing (64bit)", unit_under_test.octal_string_to_natural_64 (s) = 1)

			-- Leading zeros max values
			s := "00000000" + octal_natural_16_max_value_string
			assert ("Max 16bit parsing", unit_under_test.octal_string_to_natural_16 (s) = {NATURAL_16}.max_value)

			s := "00000000" + octal_natural_32_max_value_string
			assert ("Max 32bit parsing", unit_under_test.octal_string_to_natural_32 (s) = {NATURAL_32}.max_value)

			s := "0000000000000" +  octal_natural_64_max_value_string
			assert ("Max 64bit parsing", unit_under_test.octal_string_to_natural_64 (s) = {NATURAL_64}.max_value)
		end

	test_output
			-- Test printing features
		note
			testing:	"covers/{OCTAL_UTILS}.natural_16_to_octal_string"
			testing:	"covers/{OCTAL_UTILS}.natural_32_to_octal_string"
			testing:	"covers/{OCTAL_UTILS}.natural_64_to_octal_string"
		local
			unit_under_test: OCTAL_UTILS
			n16: NATURAL_16
			n32: NATURAL_32
			n64: NATURAL_64
		do
			create unit_under_test

			-- Basic functionality
			n16 := 0c12642
			assert ("Basic output (16bit)", unit_under_test.natural_16_to_octal_string (n16) ~ "12642")
			n32 := 0c34635231
			assert ("Basic output (32bit)", unit_under_test.natural_32_to_octal_string (n32) ~ "34635231")
			n64 := 0c1467623523
			assert ("Basic output (64bit)", unit_under_test.natural_64_to_octal_string (n64) ~ "1467623523")

			n16 := 0c12042
			assert ("Basic output 2 (16bit)", unit_under_test.natural_16_to_octal_string (n16) ~ "12042")
			n32 := 0c30635031
			assert ("Basic output 2 (32bit)", unit_under_test.natural_32_to_octal_string (n32) ~ "30635031")
			n64 := 0c1460023523
			assert ("Basic output 2 (64bit)", unit_under_test.natural_64_to_octal_string (n64) ~ "1460023523")

			-- Max values
			n16 := {NATURAL_16}.max_value
			assert ("Max 16bit output", unit_under_test.natural_16_to_octal_string (n16) ~ octal_natural_16_max_value_string)

			n32 := {NATURAL_32}.max_value
			assert ("Max 32bit output", unit_under_test.natural_32_to_octal_string (n32) ~ octal_natural_32_max_value_string)

			n64 := {NATURAL_64}.max_value
			assert ("Max 64bit output", unit_under_test.natural_64_to_octal_string (n64) ~ octal_natural_64_max_value_string)

			-- Zero
			n16 := 0
			assert ("Zero 16bit output", unit_under_test.natural_16_to_octal_string (n16) ~ "0")

			n32 := 0
			assert ("Zero 32bit output", unit_under_test.natural_32_to_octal_string (n32) ~ "0")

			n64 := 0
			assert ("Zero 64bit output", unit_under_test.natural_64_to_octal_string (n64) ~ "0")
		end

feature -- Utilities

	test_octal_conversion
			-- Test utility features
		note
			testing:	"covers/{OCTAL_UTILS}.natural_8_to_octal_character"
		local
			unit_under_test: OCTAL_UTILS
			i: NATURAL_8
		do
			-- Character conversion
			create unit_under_test
			from
				i := 0
			until
				i > 7
			loop
				assert ("Octal character conversion", i.out[1] = unit_under_test.natural_8_to_octal_character (i))
				i := i + 1
			end
		end

	test_leading_zeros
			-- Test leading zeros
		note
			testing:	"covers/{OCTAL_UTILS}.leading_zeros_count"
		local
			unit_under_test: OCTAL_UTILS
			i: NATURAL_8
			s: STRING
		do
			create unit_under_test
			-- -> all zeros
			from
				i := 1
			until
				i > 15
			loop
				s := "0"
				s.multiply (i)
				assert ("All leading zeros", unit_under_test.leading_zeros_count (s) = i - 1)
				i := i + 1
			end
			-- -> No leading zeros
			assert ("No leading zeros", unit_under_test.leading_zeros_count ("123456789") = 0)

			-- -> All zeros but last
			from
				i := 1
			until
				i > 15
			loop
				s := "0"
				s.multiply (i)
				s.append (i.out)
				assert ("Some leading zeros", unit_under_test.leading_zeros_count (s) = i)
				i := i + 1
			end

			-- -> Empty string
			assert ("Empty string", unit_under_test.leading_zeros_count ("") = 0)
		end

	test_pad
			-- Test padding
		note
			testing:	"covers/{OCTAL_UTILS}.pad"
		local
			unit_under_test: OCTAL_UTILS
			s: STRING
		do
			create unit_under_test
			s := "12345"
			unit_under_test.pad (s, 0)
			assert ("No padding", s ~ "12345")

			s := "12345"
			unit_under_test.pad (s, 5)
			assert ("Some padding", s ~ "0000012345")

			s := ""
			unit_under_test.pad (s, 1)
			assert ("Empty string", s ~ "0")
		end

	test_utility_combinations
			-- Test various combinations of the utility functions
		local
			unit_under_test: OCTAL_UTILS
			s: STRING
			i: INTEGER
		do
			create unit_under_test
			from
				i := 1
			until
				i > 16
			loop
				s := "123456789"
				unit_under_test.pad (s, i)
				assert ("Zeros added", unit_under_test.leading_zeros_count (s) = i)

				i := i + 1
			end
		end

feature {NONE} -- Constants

	octal_natural_16_max_value_string: STRING = "177777"
			-- {NATURAL_16}.max_value as octal string

	octal_natural_32_max_value_string: STRING = "37777777777"
			-- {NATURAL_32}.max_value as octal string

	octal_natural_64_max_value_string: STRING = "1777777777777777777777"
			-- {NATURAL_64}.max_value as octal string
end

indexing

	description: "[
		We are interested only in integer operations that can cause
		sign bit of the result and potential "higher" bits to
		differ. As underlying platform (e.g., C language, CIL,
		etc.) may use integer of higher precision to implement
		these operations, we should make sure that after such
		operation the result is converted back to the normal
		precision, so that sign bit and all "higher" bits are
		equal. Operations that may cause "higher" bits to differ
		from sign bit are:
			negation
			absolute value
			addition
			subtraction
			multiplication
			division
			left shift
			logical right shift (N/A in current integer classes)
			rotate (N/A in current integer classes)
			bit set
		]"

class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		do
			type_name := "INTEGER_"
			test_integer_8
			test_integer_16
			test_integer_32
			test_integer_64
			type_name := "NATURAL_"
			test_natural_8
			test_natural_16
			test_natural_32
			test_natural_64
		end

feature {NONE} -- Status report

	integer_size: INTEGER
			-- Size of integer class being tested

	type_name: STRING
			-- Size-neutral name of the type being tested

feature {NONE} -- Tests

	test_integer_8 is
			-- Test INTEGER_8.
		local
			i: INTEGER_8
			i_0: INTEGER_8
			i_4: INTEGER_8
			i_m1: INTEGER_8
			i_min: INTEGER_8
		do
				-- Initialization
			integer_size := 8
			i_0 := 0
			i_4 := 4
			i_m1 := -1
			i_min := i_m1 |<< (integer_size - 1)

				-- Negation
			i := -i_min
			i := i |>> 4
			test (negation, i = (-i_min) |>> 4)
			test (negation, i = i_min.opposite |>> 4)
				-- Absolute value
			i := i_min.abs
			i := i |>> 4
			test (abs, i = i_min.abs |>> 4)
				-- Addition
			i := i_min + i_min
			i := i |>> 4
			test (addition, i = (i_min + i_min) |>> 4)
			test (addition, i = i_min.plus (i_min) |>> 4)
				-- Subtraction
			i := i_0 - i_min
			i := i |>> 4
			test (subtraction, i = (i_0 - i_min) |>> 4)
			test (subtraction, i = i_0.minus (i_min) |>> 4)
				-- Multiplication
			i := i_min * i_4
			i := i |>> 4
			test (multiplication, i = (i_min * i_4) |>> 4)
			test (multiplication, i = i_min.product (i_4) |>> 4)
				-- Division
			i := i_min // i_m1
			i := i |>> 4
			test (division, i = (i_min // i_m1) |>> 4)
			test (division, i = i_min.integer_quotient (i_m1) |>> 4)
				-- Left shift
			i := i_min |<< 4
			i := i |>> 4
			test (bit_shift_left, i = (i_min |<< 4) |>> 4)
			test (bit_shift_left, i = i_min.bit_shift_left (4) |>> 4)
				-- Shift
			i := i_min.bit_shift (-4)
			i := i |>> 4
			test (bit_shift, i = i_min.bit_shift (-4) |>> 4)
				-- Logical right shift (N/A)
				-- Rotate (N/A)
				-- Set bit
			i := i_m1.set_bit (False, integer_size - 1)
			i := i |>> 4
			test (bit_set, i = (i_m1.set_bit (False, integer_size - 1)) |>> 4)
		end

	test_integer_16 is
			-- Test INTEGER_16.
		local
			i: INTEGER_16
			i_0: INTEGER_16
			i_4: INTEGER_16
			i_m1: INTEGER_16
			i_min: INTEGER_16
		do
				-- Initialization
			integer_size := 16
			i_0 := 0
			i_4 := 4
			i_m1 := -1
			i_min := i_m1 |<< (integer_size - 1)

				-- Negation
			i := -i_min
			i := i |>> 4
			test (negation, i = (-i_min) |>> 4)
			test (negation, i = i_min.opposite |>> 4)
				-- Absolute value
			i := i_min.abs
			i := i |>> 4
			test (abs, i = i_min.abs |>> 4)
				-- Addition
			i := i_min + i_min
			i := i |>> 4
			test (addition, i = (i_min + i_min) |>> 4)
			test (addition, i = i_min.plus (i_min) |>> 4)
				-- Subtraction
			i := i_0 - i_min
			i := i |>> 4
			test (subtraction, i = (i_0 - i_min) |>> 4)
			test (subtraction, i = i_0.minus (i_min) |>> 4)
				-- Multiplication
			i := i_min * i_4
			i := i |>> 4
			test (multiplication, i = (i_min * i_4) |>> 4)
			test (multiplication, i = i_min.product (i_4) |>> 4)
				-- Division
			i := i_min // i_m1
			i := i |>> 4
			test (division, i = (i_min // i_m1) |>> 4)
			test (division, i = i_min.integer_quotient (i_m1) |>> 4)
				-- Left shift
			i := i_min |<< 4
			i := i |>> 4
			test (bit_shift_left, i = (i_min |<< 4) |>> 4)
			test (bit_shift_left, i = i_min.bit_shift_left (4) |>> 4)
				-- Shift
			i := i_min.bit_shift (-4)
			i := i |>> 4
			test (bit_shift, i = i_min.bit_shift (-4) |>> 4)
				-- Logical right shift (N/A)
				-- Rotate (N/A)
				-- Set bit
			i := i_m1.set_bit (False, integer_size - 1)
			i := i |>> 4
			test (bit_set, i = (i_m1.set_bit (False, integer_size - 1)) |>> 4)
		end

	test_integer_32 is
			-- Test INTEGER.
		local
			i: INTEGER
			i_0: INTEGER
			i_4: INTEGER
			i_m1: INTEGER
			i_min: INTEGER
		do
				-- Initialization
			integer_size := 32
			i_0 := 0
			i_4 := 4
			i_m1 := -1
			i_min := i_m1 |<< (integer_size - 1)

				-- Negation
			i := -i_min
			i := i |>> 4
			test (negation, i = (-i_min) |>> 4)
			test (negation, i = i_min.opposite |>> 4)
				-- Absolute value
			i := i_min.abs
			i := i |>> 4
			test (abs, i = i_min.abs |>> 4)
				-- Addition
			i := i_min + i_min
			i := i |>> 4
			test (addition, i = (i_min + i_min) |>> 4)
			test (addition, i = i_min.plus (i_min) |>> 4)
				-- Subtraction
			i := i_0 - i_min
			i := i |>> 4
			test (subtraction, i = (i_0 - i_min) |>> 4)
			test (subtraction, i = i_0.minus (i_min) |>> 4)
				-- Multiplication
			i := i_min * i_4
			i := i |>> 4
			test (multiplication, i = (i_min * i_4) |>> 4)
			test (multiplication, i = i_min.product (i_4) |>> 4)
				-- Division
			test_integer_32_division
				-- Left shift
			i := i_min |<< 4
			i := i |>> 4
			test (bit_shift_left, i = (i_min |<< 4) |>> 4)
			test (bit_shift_left, i = i_min.bit_shift_left (4) |>> 4)
				-- Shift
			i := i_min.bit_shift (-4)
			i := i |>> 4
			test (bit_shift, i = i_min.bit_shift (-4) |>> 4)
				-- Logical right shift (N/A)
				-- Rotate (N/A)
				-- Set bit
			i := i_m1.set_bit (False, integer_size - 1)
			i := i |>> 4
			test (bit_set, i = (i_m1.set_bit (False, integer_size - 1)) |>> 4)
		end

	test_integer_64 is
			-- Test INTEGER_64.
		local
			i: INTEGER_64
			i_0: INTEGER_64
			i_4: INTEGER_64
			i_m1: INTEGER_64
			i_min: INTEGER_64
		do
				-- Initialization
			integer_size := 64
			i_0 := 0
			i_4 := 4
			i_m1 := -1
			i_min := i_m1 |<< (integer_size - 1)

				-- Negation
			i := -i_min
			i := i |>> 4
			test (negation, i = (-i_min) |>> 4)
			test (negation, i = i_min.opposite |>> 4)
				-- Absolute value
			i := i_min.abs
			i := i |>> 4
			test (abs, i = i_min.abs |>> 4)
				-- Addition
			i := i_min + i_min
			i := i |>> 4
			test (addition, i = (i_min + i_min) |>> 4)
			test (addition, i = i_min.plus (i_min) |>> 4)
				-- Subtraction
			i := i_0 - i_min
			i := i |>> 4
			test (subtraction, i = (i_0 - i_min) |>> 4)
			test (subtraction, i = i_0.minus (i_min) |>> 4)
				-- Multiplication
			i := i_min * i_4
			i := i |>> 4
			test (multiplication, i = (i_min * i_4) |>> 4)
			test (multiplication, i = i_min.product (i_4) |>> 4)
				-- Division
			test_integer_64_division
				-- Left shift
			i := i_min |<< 4
			i := i |>> 4
			test (bit_shift_left, i = (i_min |<< 4) |>> 4)
			test (bit_shift_left, i = i_min.bit_shift_left (4) |>> 4)
				-- Shift
			i := i_min.bit_shift (-4)
			i := i |>> 4
			test (bit_shift, i = i_min.bit_shift (-4) |>> 4)
				-- Logical right shift (N/A)
				-- Rotate (N/A)
				-- Set bit
			i := i_m1.set_bit (False, integer_size - 1)
			i := i |>> 4
			test (bit_set, i = (i_m1.set_bit (False, integer_size - 1)) |>> 4)
		end

	test_natural_8 is
			-- Test NATURAL_8.
		local
			i: NATURAL_8
			i_0: NATURAL_8
			i_4: NATURAL_8
			i_m1: NATURAL_8
			i_min: NATURAL_8
		do
				-- Initialization
			integer_size := 8
			i_0 := 0
			i_4 := 4
			i_m1 := i_0 - 1
			i_min := i_m1 |<< (integer_size - 1)

				-- Addition
			i := i_min + i_min
			i := i |>> 4
			test (addition, i = (i_min + i_min) |>> 4)
			test (addition, i = i_min.plus (i_min) |>> 4)
				-- Subtraction
			i := i_0 - i_min
			i := i |>> 4
			test (subtraction, i = (i_0 - i_min) |>> 4)
			test (subtraction, i = i_0.minus (i_min) |>> 4)
				-- Multiplication
			i := i_min * i_4
			i := i |>> 4
			test (multiplication, i = (i_min * i_4) |>> 4)
			test (multiplication, i = i_min.product (i_4) |>> 4)
				-- Left shift
			i := i_min |<< 4
			i := i |>> 4
			test (bit_shift_left, i = (i_min |<< 4) |>> 4)
			test (bit_shift_left, i = i_min.bit_shift_left (4) |>> 4)
				-- Shift
			i := i_min.bit_shift (-4)
			i := i |>> 4
			test (bit_shift, i = i_min.bit_shift (-4) |>> 4)
				-- Logical right shift
			i := i_m1 |>> 1
			i := i |>> 4
			test (bit_shift_right, i = (i_m1 |>> 1) |>> 4)
			test (bit_shift_right, i = i_m1.bit_shift_right (1) |>> 4)
				-- Rotate (N/A)
				-- Set bit
			i := i_m1.set_bit (False, integer_size - 1)
			i := i |>> 4
			test (bit_set, i = (i_m1.set_bit (False, integer_size - 1)) |>> 4)
		end

	test_natural_16 is
			-- Test NATURAL_16.
		local
			i: NATURAL_16
			i_0: NATURAL_16
			i_4: NATURAL_16
			i_m1: NATURAL_16
			i_min: NATURAL_16
		do
				-- Initialization
			integer_size := 16
			i_0 := 0
			i_4 := 4
			i_m1 := i_0 - 1
			i_min := i_m1 |<< (integer_size - 1)

				-- Addition
			i := i_min + i_min
			i := i |>> 4
			test (addition, i = (i_min + i_min) |>> 4)
			test (addition, i = i_min.plus (i_min) |>> 4)
				-- Subtraction
			i := i_0 - i_min
			i := i |>> 4
			test (subtraction, i = (i_0 - i_min) |>> 4)
			test (subtraction, i = i_0.minus (i_min) |>> 4)
				-- Multiplication
			i := i_min * i_4
			i := i |>> 4
			test (multiplication, i = (i_min * i_4) |>> 4)
			test (multiplication, i = i_min.product (i_4) |>> 4)
				-- Left shift
			i := i_min |<< 4
			i := i |>> 4
			test (bit_shift_left, i = (i_min |<< 4) |>> 4)
			test (bit_shift_left, i = i_min.bit_shift_left (4) |>> 4)
				-- Shift
			i := i_min.bit_shift (-4)
			i := i |>> 4
			test (bit_shift, i = i_min.bit_shift (-4) |>> 4)
				-- Logical right shift
			i := i_m1 |>> 1
			i := i |>> 4
			test (bit_shift_right, i = (i_m1 |>> 1) |>> 4)
			test (bit_shift_right, i = i_m1.bit_shift_right (1) |>> 4)
				-- Rotate (N/A)
				-- Set bit
			i := i_m1.set_bit (False, integer_size - 1)
			i := i |>> 4
			test (bit_set, i = (i_m1.set_bit (False, integer_size - 1)) |>> 4)
		end

	test_natural_32 is
			-- Test NATURAL_32.
		local
			i: NATURAL_32
			i_0: NATURAL_32
			i_4: NATURAL_32
			i_m1: NATURAL_32
			i_min: NATURAL_32
		do
				-- Initialization
			integer_size := 32
			i_0 := 0
			i_4 := 4
			i_m1 := i_0 - 1
			i_min := i_m1 |<< (integer_size - 1)

				-- Addition
			i := i_min + i_min
			i := i |>> 4
			test (addition, i = (i_min + i_min) |>> 4)
			test (addition, i = i_min.plus (i_min) |>> 4)
				-- Subtraction
			i := i_0 - i_min
			i := i |>> 4
			test (subtraction, i = (i_0 - i_min) |>> 4)
			test (subtraction, i = i_0.minus (i_min) |>> 4)
				-- Multiplication
			i := i_min * i_4
			i := i |>> 4
			test (multiplication, i = (i_min * i_4) |>> 4)
			test (multiplication, i = i_min.product (i_4) |>> 4)
				-- Left shift
			i := i_min |<< 4
			i := i |>> 4
			test (bit_shift_left, i = (i_min |<< 4) |>> 4)
			test (bit_shift_left, i = i_min.bit_shift_left (4) |>> 4)
				-- Shift
			i := i_min.bit_shift (-4)
			i := i |>> 4
			test (bit_shift, i = i_min.bit_shift (-4) |>> 4)
				-- Logical right shift
			i := i_m1 |>> 1
			i := i |>> 4
			test (bit_shift_right, i = (i_m1 |>> 1) |>> 4)
			test (bit_shift_right, i = i_m1.bit_shift_right (1) |>> 4)
				-- Rotate (N/A)
				-- Set bit
			i := i_m1.set_bit (False, integer_size - 1)
			i := i |>> 4
			test (bit_set, i = (i_m1.set_bit (False, integer_size - 1)) |>> 4)
		end

	test_natural_64 is
			-- Test NATURAL_64.
		local
			i: NATURAL_64
			i_0: NATURAL_64
			i_4: NATURAL_64
			i_m1: NATURAL_64
			i_min: NATURAL_64
		do
				-- Initialization
			integer_size := 64
			i_0 := 0
			i_4 := 4
			i_m1 := i_0 - 1
			i_min := i_m1 |<< (integer_size - 1)

				-- Addition
			i := i_min + i_min
			i := i |>> 4
			test (addition, i = (i_min + i_min) |>> 4)
			test (addition, i = i_min.plus (i_min) |>> 4)
				-- Subtraction
			i := i_0 - i_min
			i := i |>> 4
			test (subtraction, i = (i_0 - i_min) |>> 4)
			test (subtraction, i = i_0.minus (i_min) |>> 4)
				-- Multiplication
			i := i_min * i_4
			i := i |>> 4
			test (multiplication, i = (i_min * i_4) |>> 4)
			test (multiplication, i = i_min.product (i_4) |>> 4)
				-- Left shift
			i := i_min |<< 4
			i := i |>> 4
			test (bit_shift_left, i = (i_min |<< 4) |>> 4)
			test (bit_shift_left, i = i_min.bit_shift_left (4) |>> 4)
				-- Shift
			i := i_min.bit_shift (-4)
			i := i |>> 4
			test (bit_shift, i = i_min.bit_shift (-4) |>> 4)
				-- Logical right shift
			i := i_m1 |>> 1
			i := i |>> 4
			test (bit_shift_right, i = (i_m1 |>> 1) |>> 4)
			test (bit_shift_right, i = i_m1.bit_shift_right (1) |>> 4)
				-- Rotate (N/A)
				-- Set bit
			i := i_m1.set_bit (False, integer_size - 1)
			i := i |>> 4
			test (bit_set, i = (i_m1.set_bit (False, integer_size - 1)) |>> 4)
		end

	test (operation: STRING; succeeded: BOOLEAN) is
			-- Report that `operation' for integer of size
			-- `integer_size' has been `succeeded' or not.
		require
			valid_size:
				integer_size = 8 or else
				integer_size = 16 or else
				integer_size = 32 or else
				integer_size = 64
			operation_not_void: operation /= Void
			type_name_not_void: type_name /= Void
		do
			io.put_string (type_name)
			io.put_integer (integer_size)
			io.put_string (".")
			io.put_string (operation)
			io.put_string (": ")
			if succeeded then
				io.put_string ("ok")
			else
				io.put_string ("FAILED")
			end
			io.put_new_line
		end

	test_integer_32_division is
			-- Test INTEGER division.
		require
			integer_32: integer_size = 32
		local
			i: INTEGER
			i_m1: INTEGER
			i_min: INTEGER
			step: INTEGER
			b: BOOLEAN
		do
			i_m1 := -1
			i_min := i_m1 |<< (integer_size - 1)
			if step = 0 then
					-- No exception
				step := 1
				i := i_min // i_m1
				step := 2
				i := i |>> 4
				step := 3
				b := i = (i_min // i_m1) |>> 4
				step := 4
			elseif step = 1 then
					-- Exception should be raised in complex expression as well
				step := 4
				b := i = (i_min // i_m1) |>> 4
				step := 5
			end
			if step <= 5 then
				test (division, step = 4)
				step := 6
			end
			if step = 6 then
					-- No exception
				step := 7
				i := i_min.integer_quotient (i_m1)
				step := 8
				i := i |>> 4
				step := 9
				b := i = i_min.integer_quotient (i_m1) |>> 4
				step := 10
			elseif step = 7 then
					-- Exception should be raised in complex expression as well
				step := 10
				b := i = i_min.integer_quotient (i_m1) |>> 4
				step := 11
			end
			test (division, step = 10)
		rescue
			retry
		end

	test_integer_64_division is
			-- Test INTEGER division.
		require
			integer_64: integer_size = 64
		local
			i: INTEGER_64
			i_m1: INTEGER_64
			i_min: INTEGER_64
			step: INTEGER
			b: BOOLEAN
		do
			i_m1 := -1
			i_min := i_m1 |<< (integer_size - 1)
			if step = 0 then
					-- No exception
				step := 1
				i := i_min // i_m1
				step := 2
				i := i |>> 4
				step := 3
				b := i = (i_min // i_m1) |>> 4
				step := 4
			elseif step = 1 then
					-- Exception should be raised in complex expression as well
				step := 4
				b := i = (i_min // i_m1) |>> 4
				step := 5
			end
			if step <= 5 then
				test (division, step = 4)
				step := 6
			end
			if step = 6 then
					-- No exception
				step := 7
				i := i_min.integer_quotient (i_m1)
				step := 8
				i := i |>> 4
				step := 9
				b := i = i_min.integer_quotient (i_m1) |>> 4
				step := 10
			elseif step = 7 then
					-- Exception should be raised in complex expression as well
				step := 10
				b := i = i_min.integer_quotient (i_m1) |>> 4
				step := 11
			end
			test (division, step = 10)
		rescue
			retry
		end

feature {NONE} -- Output

	negation: STRING is "alias %"-%""
	abs: STRING is "abs"
	addition: STRING is "alias %"+%""
	subtraction: STRING is "alias %"-%""
	multiplication: STRING is "alias %"*%""
	division: STRING is "alias %"//%""

	bit_shift_left: STRING is "alias %"|<<%""
	bit_shift_right: STRING is "alias %"|>>%""
	bit_shift: STRING is "bit_shift"
	bit_set: STRING is "set_bit"

end

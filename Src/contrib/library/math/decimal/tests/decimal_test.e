note
	description:
		"Test decimal operations such as +, -, /, *, rounding and creation of decimal numbers"
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class
	DECIMAL_TEST

inherit
	ES_TEST
		redefine teardown end
create
	make

feature -- Initialization

	teardown
			--reset precision to 28
			--reset epsilon to 5
		local
			d: DECIMAL
		do
			-- default is 28 bits
			--default epsilon is 5
			--default has no exceptions disabled
			create d.make_zero
			d.epsilon.set_epsilon (5)
			d.default_context.set_digits (28)
			d.default_context.disable_exception_on_trap
		end

	run_full: BOOLEAN = True

	make
			-- Initialization for `Current'.
		do
			if run_full then
				full_suite
			else
				add_boolean_case (agent subtract_numbers_within_precision)
			end
		end

	full_suite
			-- Creation procedure.
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
			add_boolean_case (agent random_num)
			add_boolean_case (agent zero_one_create)
			add_boolean_case (agent default_context_modification)
			add_boolean_case (agent test_default_context_signals)
			add_boolean_case (agent add_numbers_within_precision)
			add_boolean_case (agent add_numbers_both_out_of_precision)
			add_boolean_case (agent add_two_negative_within_precision)
			add_boolean_case (agent add_decimal_numbers_within_precision)
			add_boolean_case (agent add_decimal_numbers_to_check_default_rounding)
			add_boolean_case (agent subtract_numbers_within_precision)
			add_boolean_case (agent subtract_numbers_out_of_precision)
			add_boolean_case (agent test_division)
			add_boolean_case (agent test_multiplication)
			add_boolean_case (agent test_infinity)
			add_boolean_case (agent test_higher_precision)
		end

feature -- Boolean Test cases


	t1: BOOLEAN

		local
			d1: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("Test create NaN")
			d1 := "NaN"
			create ctx.make_default
			Result := d1.to_scientific_string ~ "NaN"
			check Result end
			create d1.make_from_string_ctx ("NaN", ctx)
			Result := d1.to_scientific_string ~ "NaN"
			check Result end
		end

	t2: BOOLEAN
		local
			d1: DECIMAL
		do
			comment("t1: 29 bits rounds to default 28 bits")
			-- default is 28 bits
			d1 := "0.66666666666666666666666666666" -- 29 bits
			Result := d1.to_scientific_string ~ "0.6666666666666666666666666667"
			check Result end
			d1.default_context.set_digits (40)
			d1 := "0.6666666666666666666666666666666666666666" -- 40 bits
			Result := d1.to_scientific_string ~"0.6666666666666666666666666666666666666666" -- 40 bits
			check Result end
		end

	t3: BOOLEAN
		local
			d1: DECIMAL
		do
			comment("Check special numbers")
			d1 := "NaN"
			Result := d1.is_special and d1.is_nan
			check Result end
			d1 := "Infinity"
			Result := d1.is_special and d1.is_infinity and d1.sign = 1
			check Result end
			d1 := "-Infinity"
			Result := d1.is_special and d1.is_infinity and d1.sign = -1
			check Result end
			d1 := "sNaN"
			Result := d1.is_special and d1.is_signaling_nan
			check Result end
			d1 := "adsf"
			Result := d1.is_special and d1.is_signaling_nan
			check Result end
			d1 := ""
			Result := d1.is_special and d1.is_signaling_nan
			check Result end
		end

	t4: BOOLEAN
		local
			ctx, ctx2: DCM_MA_DECIMAL_CONTEXT
		do
			comment("Test different context creation")
			create ctx.make (9, 0)
			Result := ctx.precision = 9 and ctx.rounding_mode = 0 and ctx.rounding_mode = ctx.round_up
			check Result end
			create ctx.make (2, 1)
			Result := ctx.precision = 2 and ctx.rounding_mode = 1 and ctx.rounding_mode = ctx.round_down
			check Result end
			create ctx.make (10000, 2)
			Result := ctx.digits = 10000 and ctx.rounding_mode = 2 and ctx.rounding_mode = ctx.round_ceiling
			check Result end
			create ctx.make (281, 3)
			Result := ctx.precision = 281 and ctx.rounding_mode = 3 and ctx.rounding_mode = ctx.round_floor
			check Result end
			create ctx.make (28, 4)
			Result := ctx.precision = 28 and ctx.rounding_mode = 4 and ctx.rounding_mode = ctx.round_half_up
			check Result end
			create ctx.make (28, 5)
			Result := ctx.precision = 28 and ctx.rounding_mode = 5 and ctx.rounding_mode = ctx.round_half_down
			check Result end
			create ctx.make (28, 6)
			Result := ctx.precision = 28 and ctx.rounding_mode = 6 and ctx.rounding_mode = ctx.round_half_even
			check Result end
			create ctx.make (28, 7)
			Result := ctx.precision = 28 and ctx.rounding_mode = 7 and ctx.rounding_mode = ctx.round_unnecessary
			check Result end
			create ctx.make_double
			Result := ctx.precision = 57 and ctx.rounding_mode = 4 and ctx.rounding_mode = ctx.round_half_up
			check Result end
			create ctx.make_double_extended
			Result := ctx.precision = 57 and ctx.rounding_mode = 6 and ctx.rounding_mode = ctx.round_half_even
			check Result end
			create ctx.make_extended
			Result := ctx.precision = 28 and ctx.rounding_mode = 6 and ctx.rounding_mode = ctx.round_half_even
			check Result end
			create ctx2.make_default
			ctx2.copy (ctx)
			Result := ctx.precision = 28 and ctx.rounding_mode = 6 and ctx.rounding_mode = ctx.round_half_even
			check Result end
		end

	t5: BOOLEAN
		local
			d1, d2: DECIMAL
		do
			comment("Test abs operation")
			d1 := "-1.312"
			Result := d1.sign = -1 and d1.to_scientific_string ~ "-1.312"
			check Result end
			d2 := d1.abs
			Result := d2.to_scientific_string ~ "1.312" and d2.sign = 1
			check Result end
			d1 := "1.312"
			Result := d1.sign = 1 and d1.to_scientific_string ~ "1.312"
			check Result end
			d2 := d1.abs
			Result := d2.to_scientific_string ~ "1.312" and d2.sign = 1
			check Result end
		end

	t6: BOOLEAN
		local
			d1: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("Test count feature")
			d1 := "1.312"
			Result := d1.count = 4
			check Result end
			d1 := "0.000000000536"
			Result := d1.count = 3
			check Result end
			create ctx.make (9, 0)
			create d1.make_from_string_ctx ("123456789", ctx)
			Result := d1.count = 9
			check Result end
			create d1.make_from_string_ctx ("123456789012334545623123123", ctx)
			Result := d1.count = 9
			check Result end
			create d1.make_from_string_ctx ("0.12345678", ctx)
			Result := d1.count = 8
			check Result end
			create d1.make_from_string_ctx ("0.1234567890123", ctx)
			Result := d1.count = 9
			check Result end
			create d1.make_from_string_ctx ("0.000000000001234567890123", ctx)
			Result := d1.count = 9
			check Result end
			create d1.make_from_string_ctx ("0.000000123", ctx)
			Result := d1.count = 3
			check Result end
		end

	random_num: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			d1: DECIMAL
		do
			comment("Test a random number")
			create x.make_default
			x.set_digits (9)
			Result := x.digits = 9
			check Result end
			create d1.make_from_string_ctx ("9072",x)
			Result := d1.to_scientific_string ~ "9072"
			check Result end
			Result := d1.out_tuple ~ "[0,9072,0]"
			check Result end
			Result := d1.to_engineering_string ~ "9072"
			check Result end
			create d1.make_from_string ("98.7")
			Result := d1.to_scientific_string ~ "98.7"
			check Result end
			Result := d1.out_tuple ~ "[0,987,-1]"
			check Result end
			Result := d1.to_engineering_string ~ "98.7"
			check Result end
		end

	zero_one_create: BOOLEAN
		local
			d1: DECIMAL
		do
			comment ("Test creating zero and one")
			create d1.make_one
			Result := d1.to_scientific_string ~ "1"
			check Result end
			Result := d1.out_tuple ~ "[0,1,0]"
			check Result end
			Result := d1.to_engineering_string ~ "1"
			check Result end
			create d1.make_zero
			Result := d1.to_scientific_string ~ "0"
			check Result end
			Result := d1.out_tuple ~ "[0,0,0]"
			check Result end
			Result := d1.to_engineering_string ~ "0"
			check Result end
		end

	default_context_modification: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
		do
			comment ("Create default context and modify it")
			create x.make_default
			Result := x.out ~ "digits=28 rounding_mode=Round_half_up"
			check Result end
			x.set_digits (58)
			Result := x.precision = 58
			check Result end
			Result := x.out ~ "digits=58 rounding_mode=Round_half_up"
			check Result end
			x.set_digits (1)
			Result := x.out ~ "digits=1 rounding_mode=Round_half_up"
			check Result end
			x.set_digits (999999999)
			Result := x.out ~ "digits=999999999 rounding_mode=Round_half_up"
			check Result end
			x.set_digits (9)
			x.set_rounding_mode (0)
			Result := x.out ~ "digits=9 rounding_mode=Round_up"
			check Result end
			x.set_rounding_mode (1)
			Result := x.out ~ "digits=9 rounding_mode=Round_down"
			check Result end
			x.set_rounding_mode (2)
			Result := x.out ~ "digits=9 rounding_mode=Round_ceiling"
			check Result end
			x.set_rounding_mode (3)
			Result := x.out ~ "digits=9 rounding_mode=Round_floor"
			check Result end
			x.set_rounding_mode (4)
			Result := x.out ~ "digits=9 rounding_mode=Round_half_up"
			check Result end
			x.set_rounding_mode (5)
			Result := x.out ~ "digits=9 rounding_mode=Round_half_down"
			check Result end
			x.set_rounding_mode (6)
			Result := x.out ~ "digits=9 rounding_mode=Round_half_even"
			check Result end
			x.set_rounding_mode (7)
			Result := x.out ~ "digits=9 rounding_mode=Round_unnecessary"
			check Result end
			Result := x.minimum_exponent = -999999999 and x.maximum_exponent = 999999999
			check Result end
		end

	test_default_context_signals: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
		do
			comment("Test signals for default context")
			create x.make_default
			x.set_digits (9)
			Result := x.signal_division_by_zero = 1
			check Result end
			Result := x.signal_inexact = 2
			check Result end
			Result := x.signal_invalid_operation = 3
			check Result end
			Result := x.signal_lost_digits = 4
			check Result end
			Result := x.signal_overflow = 5
			check Result end
			Result := x.signal_rounded = 6
			check Result end
			Result := x.signal_underflow = 7
			check Result end
			Result := x.signal_subnormal = 8
			check Result end
		end

	add_numbers_within_precision: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment("Test addition of two numbers within precision")
			create x.make_default
			x.set_digits (9)
			create a.make_from_string_ctx ("100",x)
			create b.make_from_string_ctx ("26",x)
			c := a.add (b,x)
			Result := c.to_engineering_string ~ "126"
			check Result end
			Result := c.to_integer = 126
			check Result end
			Result := c.out_tuple ~ "[0,126,0]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = 0
			check Result end
			create a.make_from_string_ctx ("32",x)
			create b.make_from_string_ctx ("56",x)
			c := a.add (b, x)
			Result := c.to_engineering_string ~ "88"
			check Result end
			Result := c.to_integer = 88
			check Result end
			Result := c.out_tuple ~ "[0,88,0]"
			check Result end
			create a.make_from_string_ctx ("99",x)
			create b.make_from_string_ctx ("51",x)
			c := a.add (b, x)
			Result := c.to_engineering_string ~ "150"
			check Result end
			Result := c.to_integer = 150
			check Result end
			Result := c.out_tuple ~ "[0,150,0]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = 0
			check Result end
			create a.make_from_string_ctx ("-30",x)
			create b.make_from_string_ctx ("31",x)
			c := a.add (b, x)
			Result := c.to_engineering_string ~ "1"
			check Result end
			Result := c.to_integer = 1
			check Result end
			Result := c.out_tuple ~ "[0,1,0]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = 0
			check Result end
			create a.make_from_string_ctx ("1000",x)
			create b.make_from_string_ctx ("3500",x)
			c := a.add (b, x)
			Result := c.to_engineering_string ~ "4500"
			check Result end
			Result := c.to_integer = 4500
			check Result end
			Result := c.out_tuple ~ "[0,4500,0]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = 0
			check Result end

		end

	add_numbers_both_out_of_precision: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment ("Test addition of two numbers whose precision is more than 9")
			create x.make_default
			x.set_digits (9)
			create a.make_from_string_ctx ("9999999999",x)
			create b.make_from_string_ctx ("9999999999",x)
			c := a + b
			Result := c.to_scientific_string ~ "2.00000000E+10"
			check Result end
			Result := c.to_engineering_string ~ "20.0000000E+9"
			check Result end
			Result := c.out_tuple ~ "[0,200000000,2]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.to_double = 20000000000
			check Result end
			Result := c.exponent = 2
			check Result end
			create a.make_from_string_ctx ("-9999999999",x)
			create b.make_from_string_ctx ("-9999999999",x)
			c := a.add (b,x)
			Result := c.to_scientific_string ~ "-2.00000000E+10"
			check Result end
			Result := c.to_engineering_string ~ "-20.0000000E+9"
			check Result end
			Result := c.out_tuple ~ "[1,200000000,2]"
			check Result end
			Result := c.sign = -1
			check Result end
			Result := c.to_double = -20000000000
			check Result end
			Result := c.exponent = 2
			create a.make_from_string_ctx ("-9999999999",x)
			create b.make_from_string_ctx ("9999999999",x)
			c := a.add (b,x)
			Result := c.to_scientific_string ~ "0E+2"
			check Result end
			Result := c.to_engineering_string ~ "0"
			check Result end
			Result := c.out_tuple ~ "[0,0,2]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = 2
			check Result end
		end

	add_two_negative_within_precision: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment ("Test addition of two negative numbers whose precision is less than or equal to 9")
			create x.make_default
			x.set_digits (9)
			create a.make_from_string_ctx ("-26",x)
			create b.make_from_string_ctx ("-16",x)
			c := a + b
			Result := c.to_scientific_string ~ "-42"
			check Result end
			Result := c.to_engineering_string ~ "-42"
			check Result end
			Result := c.out_tuple ~ "[1,42,0]"
			check Result end
			Result := c.sign = -1
			check Result end
			Result := c.to_double = -42
			check Result end
			Result := c.exponent = 0
			check Result end
			create a.make_from_string_ctx ("-999999998", x)
			create b.make_from_string_ctx ("-1", x)
			c := a + b
			Result := c.to_scientific_string ~ "-999999999"
			check Result end
			Result := c.to_engineering_string ~ "-999999999"
			check Result end
			Result := c.out_tuple ~ "[1,999999999,0]"
			check Result end
			Result := c.sign = -1
			check Result end
			Result := c.to_double = -999999999
			check Result end
			Result := c.exponent = 0
			check Result end
			create a.make_from_string_ctx ("-30", x)
			create b.make_from_string_ctx ("-12", x)
			c := a + b
			Result := c.to_scientific_string ~ "-42"
			check Result end
			Result := c.to_engineering_string ~ "-42"
			check Result end
			Result := c.out_tuple ~ "[1,42,0]"
			check Result end
			Result := c.sign = -1
			check Result end
			Result := c.to_double = -42
			check Result end
			Result := c.exponent = 0
			check Result end
			create a.make_from_string_ctx ("-30000", x)
			create b.make_from_string_ctx ("-1", x)
			c := a + b
			Result := c.to_scientific_string ~ "-30001"
			check Result end
			Result := c.to_engineering_string ~ "-30001"
			check Result end
			Result := c.out_tuple ~ "[1,30001,0]"
			check Result end
			Result := c.sign = -1
			check Result end
			Result := c.to_double = -30001
			check Result end
			Result := c.exponent = 0
			check Result end
			create a.make_from_string_ctx ("-80", x)
			create b.make_from_string_ctx ("-80", x)
			c := a + b
			Result := c.to_scientific_string ~ "-160"
			check Result end
			Result := c.to_engineering_string ~ "-160"
			check Result end
			Result := c.out_tuple ~ "[1,160,0]"
			check Result end
			Result := c.sign = -1
			check Result end
			Result := c.to_double = -160
			check Result end
			Result := c.exponent = 0
			check Result end

		end

	add_decimal_numbers_within_precision: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c, d, e: DECIMAL
		do
			comment ("Test addition of decimal numbers within precision of 9")
			create x.make_default
			x.set_digits (9)
			create a.make_from_string_ctx ("0.1", x)
			create b.make_from_string_ctx ("0.1", x)
			create c.make_from_string_ctx ("0.1", x)
			create d.make_from_string_ctx ("-0.3", x)
			e := a + b + c + d
			Result := e.to_engineering_string ~ "0.0"
			check Result end
			Result := e.to_scientific_string ~ "0.0"
			check Result end
			Result := e.out_tuple ~ "[0,0,-1]"
			check Result end
			Result := e.sign = 1
			check Result end
			Result := e.exponent = -1
			check Result end
			Result := e.to_double = 0.0
			check Result end
			Result := e.to_integer = 0
			check Result end
			create a.make_from_string_ctx ("0.5", x)
			create b.make_from_string_ctx ("0.9", x)
			create c.make_from_string_ctx ("-0.7", x)
			create d.make_from_string_ctx ("0.2", x)
			e := a + b + c + d
			Result := e.to_engineering_string ~ "0.9"
			check Result end
			Result := e.to_scientific_string ~ "0.9"
			check Result end
			Result := e.out_tuple ~ "[0,9,-1]"
			check Result end
			Result := e.sign = 1
			check Result end
			Result := e.exponent = -1
			check Result end
			Result := e.to_double = 0.9
			check Result end
			create a.make_from_string_ctx ("2.4", x)
			create b.make_from_string_ctx ("1.9", x)
			create c.make_from_string_ctx ("-1.7", x)
			create d.make_from_string_ctx ("-2.2", x)
			e := a + b + c + d
			Result := e.to_engineering_string ~ "0.4"
			check Result end
			Result := e.to_scientific_string ~ "0.4"
			check Result end
			Result := e.out_tuple ~ "[0,4,-1]"
			check Result end
			Result := e.sign = 1
			check Result end
			Result := e.exponent = -1
			check Result end
			Result := e.to_double = 0.4
			check Result end
			create a.make_from_string_ctx ("3.2", x)
			create b.make_from_string_ctx ("2.9", x)
			create c.make_from_string_ctx ("-2.9", x)
			create d.make_from_string_ctx ("-3.2", x)
			e := a + b + c + d
			Result := e.to_engineering_string ~ "0.0"
			check Result end
			Result := e.to_scientific_string ~ "0.0"
			check Result end
			Result := e.out_tuple ~ "[0,0,-1]"
			check Result end
			Result := e.sign = 1
			check Result end
			Result := e.exponent = -1
			check Result end
			Result := e.to_double = 0.0
			check Result end
		end

	add_decimal_numbers_to_check_default_rounding: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment ("Test addition of decimal numbers to check default rounding")
			create x.make_default
			x.set_digits (9)
			create a.make_from_string_ctx ("9.78965798", x)
			create b.make_from_string_ctx ("9.78965798", x)
			c := a.add (b, x)
			Result := c.to_engineering_string ~ "19.5793160"
			check Result end
			Result := c.to_scientific_string ~ "19.5793160"
			check Result end
			Result := c.out_tuple ~ "[0,195793160,-7]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = -7
			check Result end
			Result := c.to_double = 19.5793160
			check Result end
			create a.make_from_string_ctx ("8.98736414", x)
			create b.make_from_string_ctx ("8.98736414", x)
			c := a.add (b, x)
			Result := c.to_engineering_string ~ "17.9747283"
			check Result end
			Result := c.to_scientific_string ~ "17.9747283"
			check Result end
			Result := c.out_tuple ~ "[0,179747283,-7]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = -7
			check Result end
			Result := c.to_double = 17.9747283
			check Result end

		end

	subtract_numbers_within_precision: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment ("Test subtraction of numbers within precision of 9")
			create x.make_default
			x.set_digits (9)
			create a.make_from_string_ctx ("29", x)
			create b.make_from_string_ctx ("19", x)
			c := a.subtract (b,x)
			Result := c.to_engineering_string ~ "10"
			check Result end
			Result := c.to_scientific_string ~ "10"
			check Result end
			Result := c.out_tuple ~ "[0,10,0]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = 0
			check Result end
			--Decimal Testing
			create a.make_from_string_ctx ("17.817991", x)
			create b.make_from_string_ctx ("10.238811", x)
			c := a - b
			Result := c.to_engineering_string ~ "7.579180"
			check Result end
			Result := c.to_scientific_string ~ "7.579180"
			check Result end
			Result := c.out_tuple ~ "[0,7579180,-6]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = -6
			check Result end
			create a.make_from_string_ctx ("8.9873641", x)
			create b.make_from_string_ctx ("7.3456789", x)
			c := a - b
			Result := c.to_engineering_string ~ "1.6416852"
			check Result end
			Result := c.to_scientific_string ~ "1.6416852"
			check Result end
			Result := c.out_tuple ~ "[0,16416852,-7]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = -7
			check Result end
			Result := c.to_double = 1.6416852
			check Result end
			create a.make_from_string_ctx ("0.00000001", x)
			create b.make_from_string_ctx ("0.00000001", x)
			c := a - b
			Result := c.to_engineering_string ~ "0E-9"
			check Result end
			Result := c.to_scientific_string ~ "0E-8"
			check Result end
			Result := c.out_tuple ~ "[0,0,-8]"
			check Result end
			Result := c.sign = 1
			check Result end
			Result := c.exponent = -8
			check Result end
			create a.make_from_string_ctx ("0.00000001", x)
			create b.make_from_string_ctx ("0.00000009", x)
			c := a - b
			Result := c.to_engineering_string ~ "-80E-9"
			check Result end
			Result := c.to_scientific_string ~ "-8E-8"
			check Result end
			Result := c.out_tuple ~ "[1,8,-8]"
			check Result end
			Result := c.sign = -1
			check Result end
			Result := c.exponent = -8
			check Result end
		end

	subtract_numbers_out_of_precision: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment ("Test subtraction of numbers whose precision is greater than 9")
			create x.make_default
			x.set_digits (9)
			create a.make_from_string_ctx ("30.78905686", x)
			create b.make_from_string_ctx ("10.81937037456", x)
			Result := a.to_scientific_string ~ "30.7890569" and a.to_engineering_string ~ "30.7890569"
			check Result end
			Result := b.to_engineering_string ~ "10.8193704" and b.to_scientific_string ~ "10.8193704"
			check Result end
			c := a - b
			Result := c.to_engineering_string ~ "19.9696865" and c.to_scientific_string ~ "19.9696865"
			check Result end
			Result := c.out_tuple ~ "[0,199696865,-7]"
			check Result end
			Result := c.sign = 1 and c.exponent = -7
			check Result end
			create a.make_from_string_ctx ("0.0000000000000000000000001", x)
			create b.make_from_string_ctx ("0.0000000000000000000000001", x)
			Result := a.to_engineering_string ~ "100E-27" and b.to_engineering_string ~ "100E-27"
			check Result end
			Result := b.to_scientific_string ~ "1E-25" and b.to_scientific_string ~ "1E-25"
			c := a - b
			Result := c.to_engineering_string ~ "0E-27"
			check Result end
			Result := c.to_scientific_string ~ "0E-25"
			check Result end
			Result := c.out_tuple ~ "[0,0,-25]"
			check Result end
			Result := c.sign = 1 and c.exponent = -25
			check Result end
		end

	test_division: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment ("Test division of numbers")
			create x.make_default
			x.set_digits (9)
			create a.make_from_string_ctx ("10", x)
			create b.make_from_string_ctx ("5", x)
			c := a.divide (b, x)
			Result := c.to_engineering_string ~ "2" and c.to_scientific_string ~ "2"
			check Result end
			Result := c.out_tuple ~ "[0,2,0]"
			check Result end
			Result := c.sign = 1 and c.exponent = 0
			check Result end
			--Decimal division
			create a.make_from_string_ctx ("0.27683", x)
			create b.make_from_string_ctx ("0.21344123", x)
			c := a.divide (b, x)
			Result := c.to_engineering_string ~ "1.29698465" and c.to_scientific_string ~ "1.29698465"
			check Result end
			Result := c.out_tuple ~ "[0,129698465,-8]"
			check Result end
			Result := c.sign = 1 and c.exponent = -8
			check Result end
			--Division with result greater than 9 precision digits
			create a.make_from_string_ctx ("1", x)
			create b.make_from_string_ctx ("7", x)
			c := a.divide (b, x)
			Result := c.to_engineering_string ~ "0.142857143" and c.to_scientific_string ~ "0.142857143"
			check Result end
			Result := c.out_tuple ~ "[0,142857143,-9]"
			check Result end
			Result := c.sign = 1 and c.exponent = -9
			check Result end
			--Division with negative numbers
			create a.make_from_string_ctx ("-1", x)
			create b.make_from_string_ctx ("7", x)
			c := a.divide (b, x)
			Result := c.to_engineering_string ~ "-0.142857143" and c.to_scientific_string ~ "-0.142857143"
			check Result end
			Result := c.out_tuple ~ "[1,142857143,-9]"
			check Result end
			Result := c.sign = -1 and c.exponent = -9
			check Result end
			create a.make_from_string_ctx ("-1", x)
			create b.make_from_string_ctx ("-7", x)
			c := a.divide (b, x)
			Result := c.to_engineering_string ~ "0.142857143" and c.to_scientific_string ~ "0.142857143"
			check Result end
			Result := c.out_tuple ~ "[0,142857143,-9]"
			check Result end
			Result := c.sign = 1 and c.exponent = -9
			check Result end
			create a.make_from_string_ctx ("1", x)
			create b.make_from_string_ctx ("-7", x)
			c := a.divide (b, x)
			Result := c.to_engineering_string ~ "-0.142857143" and c.to_scientific_string ~ "-0.142857143"
			check Result end
			Result := c.out_tuple ~ "[1,142857143,-9]"
			check Result end
			Result := c.sign = -1 and c.exponent = -9
			check Result end
		end

	test_multiplication: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment ("Test multiplication of numbers")
			create x.make_default
			x.set_digits (9)
			create a.make_from_string_ctx ("10", x)
			create b.make_from_string_ctx ("20", x)
			c := a.multiply (b, x)
			Result := c.to_engineering_string ~ "200" and c.to_scientific_string ~ "200"
			check Result end
			Result := c.out_tuple ~ "[0,200,0]"
			check Result end
			Result := c.sign = 1 and c.exponent = 0
			check Result end
			--Decimal multiplication within precision digits
			create a.make_from_string_ctx ("15.87", x)
			create b.make_from_string_ctx ("16.27", x)
			c := a.multiply (b, x)
			Result := c.to_engineering_string ~ "258.2049" and c.to_scientific_string ~ "258.2049"
			check Result end
			Result := c.out_tuple ~ "[0,2582049,-4]"
			check Result end
			Result := c.sign = 1 and c.exponent = -4
			check Result end
			--Decimal multiplication with precision greater than 9
			create a.make_from_string_ctx ("0.1739379", x)
			create b.make_from_string_ctx ("9.1803077", x)
			c := a.multiply (b, x)
			Result := c.to_engineering_string ~ "1.59680344" and c.to_scientific_string ~ "1.59680344"
			check Result end
			Result := c.out_tuple ~ "[0,159680344,-8]"
			check Result end
			Result := c.sign = 1 and c.exponent = -8
			check Result end
			create a.make_from_string_ctx ("1.87396408732", x)
			create b.make_from_string_ctx ("12.4729570039138", x)
			c := a.multiply (b, x)
			Result := c.to_engineering_string ~ "23.3738735" and c.to_scientific_string ~ "23.3738735"
			check Result end
			Result := c.sign = 1 and c.exponent = -7
			check Result end
			Result := c.out_tuple ~ "[0,233738735,-7]"
			check Result end
			--Negative numbers
			create a.make_from_string_ctx ("-1.87396408732", x)
			create b.make_from_string_ctx ("12.4729570039138", x)
			c := a.multiply (b, x)
			Result := c.to_engineering_string ~ "-23.3738735" and c.to_scientific_string ~ "-23.3738735"
			check Result end
			Result := c.sign = -1 and c.exponent = -7
			check Result end
			Result := c.out_tuple ~ "[1,233738735,-7]"
			check Result end
			create a.make_from_string_ctx ("-1.87396408732", x)
			create b.make_from_string_ctx ("-12.4729570039138", x)
			c := a.multiply (b, x)
			Result := c.to_engineering_string ~ "23.3738735" and c.to_scientific_string ~ "23.3738735"
			check Result end
			Result := c.sign = 1 and c.exponent = -7
			check Result end
			Result := c.out_tuple ~ "[0,233738735,-7]"
			check Result end
			create a.make_from_string_ctx ("1.87396408732", x)
			create b.make_from_string_ctx ("-12.4729570039138", x)
			c := a.multiply (b, x)
			Result := c.to_engineering_string ~ "-23.3738735" and c.to_scientific_string ~ "-23.3738735"
			check Result end
			Result := c.sign = -1 and c.exponent = -7
			check Result end
			Result := c.out_tuple ~ "[1,233738735,-7]"
			check Result end
			create a.make_from_string_ctx ("-15.87", x)
			create b.make_from_string_ctx ("16.27", x)
			c := a.multiply (b, x)
			Result := c.to_engineering_string ~ "-258.2049" and c.to_scientific_string ~ "-258.2049"
			check Result end
			Result := c.out_tuple ~ "[1,2582049,-4]"
			check Result end
			Result := c.sign = -1 and c.exponent = -4
			check Result end
		end

	test_infinity: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment ("Test division by 0 which results in +/- infinity")
			create x.make_default
			create a.make_from_string_ctx ("1", x)
			create b.make_from_string_ctx ("0", x)
			x.disable_trap (1)
			x.disable_exception_on_trap
			c := a.divide (b, x)
			Result := c.to_scientific_string ~ "Infinity" and c.to_engineering_string ~ "Infinity"
			check Result end
			Result := c.out_tuple ~ "[0,inf]"
			check Result end
			Result := c.sign = 1 and c.exponent = 0
			check Result end
			create a.make_from_string_ctx ("-1", x)
			create b.make_from_string_ctx ("0", x)
			c := a.divide (b, x)
			Result := c.to_engineering_string ~ "-Infinity" and c.to_scientific_string ~ "-Infinity"
			check Result end
			Result := c.sign = -1 and c.exponent = 0
			check Result end
			Result := c.out_tuple ~ "[1,inf]"
			check Result end
		end

	test_higher_precision: BOOLEAN
		local
			x: DCM_MA_DECIMAL_CONTEXT
			a, b, c: DECIMAL
		do
			comment ("Test precision of greater than 9")
			create x.make_default
			Result := x.digits = 28
			check Result end
			--Precision is 28 digits
			create a.make_from_string_ctx ("1", x)
			create b.make_from_string_ctx ("7", x)
			c := a.divide (b, x)
			Result := c.to_scientific_string ~ "0.1428571428571428571428571429" and c.to_engineering_string ~ "0.1428571428571428571428571429"
			check Result end
			Result := c.out_tuple ~ "[0,1428571428571428571428571429,-28]"
			check Result end
			Result := c.sign = 1 and c.exponent = -28
			check Result end
			create a.make_from_string_ctx ("999999", x)
			create b.make_from_string_ctx ("999999", x)
			c := a.multiply (b, x)
			Result := c.to_scientific_string ~ "999998000001" and c.to_engineering_string ~ "999998000001"
			check Result end
			Result := c.out_tuple ~ "[0,999998000001,0]"
			check Result end
			Result := c.sign = 1 and c.exponent = 0
			check Result end
			--Precision = 54 digits
			x.set_digits (54)
			Result := x.digits = 54
			check Result end
			create a.make_from_string_ctx ("1", x)
			create b.make_from_string_ctx ("7", x)
			c := a.divide (b, x)
			Result := c.to_engineering_string ~ "0.142857142857142857142857142857142857142857142857142857" and c.to_scientific_string ~ "0.142857142857142857142857142857142857142857142857142857"
			check Result end
			Result := c.out_tuple ~ "[0,142857142857142857142857142857142857142857142857142857,-54]"
			check Result end
			Result := c.sign = 1 and c.exponent = -54
			check Result end
			--Precision = 78 digits
			x.set_digits (78)
			Result := x.digits = 78
			check Result end
			create a.make_from_string_ctx ("1", x)
			create b.make_from_string_ctx ("7", x)
			c := a.divide (b, x)
			Result := c.to_engineering_string ~ "0.142857142857142857142857142857142857142857142857142857142857142857142857142857" and c.to_scientific_string ~ "0.142857142857142857142857142857142857142857142857142857142857142857142857142857"
			check Result end
			Result := c.out_tuple ~ "[0,142857142857142857142857142857142857142857142857142857142857142857142857142857,-78]"
			check Result end
			Result := c.sign = 1 and c.exponent = -78
			check Result end
		end

note
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT license"
	details: "[
			Originally developed by Jonathan Ostroff, Moksh Khurana, and Alex Fevga. See class DECIMAL.
		]"
end

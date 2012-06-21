note
	description:
		"All the new features are tested here which run fast without finalizing the system."
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_TESTS
inherit
	ES_TEST
		redefine
			teardown
		end

	DCM_MA_DECIMAL_TEST

create
	make

feature {NONE} -- Initialization

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
				add_boolean_case (agent t11)
			end
		end

	full_suite
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
			add_boolean_case (agent t7)
			add_boolean_case (agent t8)
			add_boolean_case (agent t9)
			add_boolean_case (agent t10)
			add_boolean_case (agent t11)
			add_boolean_case (agent t12)
			add_boolean_case (agent t13)
			add_boolean_case (agent t14)
			add_violation_case_with_tag ("curr_not_negative_if_exp_pos", agent t15)
			add_violation_case_with_tag ("greater_than_equal_zero", agent t16)
			add_violation_case_with_tag ("greater_than_equal_zero", agent t17)
			add_violation_case_with_tag ("invalid_op", agent t18)
			add_violation_case_with_tag ("invalid_op", agent t19)
			add_violation_case_with_tag ("invalid_op", agent t20)
			add_violation_case_with_tag ("invalid_op", agent t21)
			add_boolean_case (agent t22)
			add_boolean_case (agent t23)
			add_violation_case_with_tag ("exception_trap", agent t24)
			add_violation_case_with_tag ("exception_trap", agent t25)
			add_boolean_case (agent t26)
			add_boolean_case (agent t27)
			add_boolean_case (agent t28)
		end

feature -- tests

	t1: BOOLEAN
		local
			d1,d2,d3: DECIMAL
			r1 : REAL_64
		do
			comment("t1: test 0.1 + 0.1 + 0.1 = 0.3")
			r1 := 0.1
			create d1.make_from_string ("0.1")
			create d3.make_from_string ("0.3")
			d2 := d1 + d1 + d1
			check d1.out ~ "0.1" end
			Result := d2.out ~ "0.3"
		end

	t2: BOOLEAN
		local
			d1,d2,d3: DECIMAL
		do
			comment("t2: testing 1/3 and 1/6")
			create d1.make_from_string ("1")
			create d2.make_from_string ("3")
			d3 := d1/d2
			check d3.out ~ "0.3333333333333333333333333333" end
			d3 := d3 + d3
			Result := d3.out ~ "0.6666666666666666666666666666"
		end

	t3: BOOLEAN
		local
			d1,d2,d3: DECIMAL
			r1,r2, r3: REAL_64
		do
			comment("t3: test 0.1*10 = 1")
			r1 := 0.1
			r2 := 10
			r3 := r1*r2
			check r3 = 1 end
			create d1.make_from_string (".1")
			create d2.make_from_string ("10")
			d3 := d1*d2
			Result := d3.out ~ "1.0"
		end


	t4: BOOLEAN
		local
			d1,d2,d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t4: rounding")
			create d1.make_from_string ("123.45")
			d1.default_context.reset_flags
			create d2.make_from_string ("1")
			d2.default_context.reset_flags
			d3 := d1 + d2
			Result := d3.out ~ "124.45"
			check Result end
			Result := not d2.default_context.is_flagged (2)  -- precise arithmetic
			check Result end
			create d2.make_from_string(".88888888888888888888888888888")
			Result := d2.default_context.is_flagged (2) and d2.default_context.is_flagged (6)
			check Result end
			d3 := d1 + d2
			Result := d3.default_context.is_flagged (2) and d3.default_context.is_flagged (6)
			check Result end
			Result := d3.out ~ "124.3388888888888888888888889"
			create ctx.make_default
			create d1.make_from_string_ctx ("1.2345678901234567890123456789", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.out ~ "2.234567890123456789012345679"
			check Result end
		end

	t5: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			x: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t5: no execptions on divide by zero")
			create x.make_default
			create d1.make_from_string_ctx("1",x)
			create d2.make_from_string_ctx("0",x)
			d3 := d1.divide (d2, x)
			Result := d3.out ~ "Infinity"
		end

	t6: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t6: Test division by zero")
			d1 := "1"
			d2 := "0"
			d1.default_context.disable_exception_on_trap
			d3 := d1 / d2
			Result := d3.out ~ "Infinity"
			check Result end
			create c.make_default
			d3 := d1.divide (d2, c)
			Result := d3.out ~ "Infinity"
			check Result end
		end

	t7: BOOLEAN
		local
			d1,d2,d3: DECIMAL
		do
			comment("t7: test max/min)")
			d1 := "5.6"
			d2 := "4.3"
			Result := d1.max_ctx (d2, d1.default_context).out ~ d1
			check Result end
			Result := d1.min_ctx (d2, d1.default_context).out ~ d2
			check Result end
			d3 := "-7.899"
			Result := d3.abs.out ~ "7.899"
			check Result end
		end

	t8: BOOLEAN
		local
			d1: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
			i: INTEGER
		do
			comment("t8: test position_of_decimal_point(positive)")
			d1 := "1234.56"
			c := d1.default_context
			i := d1.position_of_decimal_point_wrt_ctx (c)
			Result := i = 1
			check Result end
			d1 := "1.1"
			i := d1.position_of_decimal_point_wrt_ctx (c)
			Result := i = 0
			check Result end
			d1 := "1000000000"
			i := d1.position_of_decimal_point_wrt_ctx (c)
			Result := i = 1
			check Result end
			d1 := "10000000000"
			i := d1.position_of_decimal_point_wrt_ctx (c)
			Result := i = 2
			check Result end
		end

	t9: BOOLEAN
		local
			d1: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
			i: INTEGER
		do
			comment("t9: test position_of_decimal_point(negative)")
			d1 := ".56"
			c := d1.default_context
			i := d1.position_of_decimal_point_wrt_ctx (c)
			Result := i = 0
			check Result end
			d1 := ".0098"
			c := d1.default_context
			i := d1.position_of_decimal_point_wrt_ctx (c)
			Result := i = 1
			check Result end
		end

	t10: BOOLEAN
		local
			d1, d2: DECIMAL
		do
			comment("t10: test epsilon feature")
			create d1.make_from_string ("NaN")
			create d2.make_from_string ("5E-27")
			Result := d1 |~ d2 = False
			check Result end
			d1 := "5E-27"
			d2 := "NaN"
			Result := d1 |~ d2 = False
			check Result end
			d1 := "-Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d1 := "Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d1 := "NaN"
			d2 := "Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d2 := "-Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d1 := "Infinity"
			d2 := "Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d2 := "-Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d1 := "-Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d2 := "Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d1 := "Infinity"
			d2 := "5E-27"
			Result := d1 |~ d2 = False
			check Result end
			d1 := "-Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d1 := "5E-27"
			d2 := "Infinity"
			Result := d1 |~ d2 = False
			check Result end
			d2 := "-Infinity"
			Result := d1 |~ d2 = False
			check Result end
			create d1.make_from_string ("9.999999999999999999999999985")
			create d2.make_from_string ("9.999999999999999999999999990")
			Result := d2 |~ d1
			check Result end
			create d2.make_from_string ("9.999999999999999999999999980")
			Result := d2 |~ d1
			check Result end
			create d2.make_from_string ("9.999999999999999999999999979")
			Result := d2 |~ d1 = False
			check Result end
			create d2.make_from_string ("9.999999999999999999999999991")
			Result := d2 |~ d1 = False
			check Result end
			create d2.make_from_string ("9.999999999999999999999999960")
			Result := d2 |~ d1 = False
			check Result end
			create d2.make_from_string ("9.999999999999999999999999999")
			Result := d2 |~ d1 = False
			check Result end
			d1.epsilon.set_epsilon (1)
			create d2.make_from_string ("9.999999999999999999999999983")
			Result := d2 |~ d1 = False
			check Result end
			create d2.make_from_string ("9.999999999999999999999999984")
			Result := d2 |~ d1
			check Result end
			create d2.make_from_string ("9.999999999999999999999999985")
			Result := d2 |~ d1
			check Result end
			create d2.make_from_string ("9.999999999999999999999999986")
			Result := d2 |~ d1
			check Result end
			create d2.make_from_string ("9.999999999999999999999999987")
			Result := d2 |~ d1 = False
			check Result end
			create d2.make_from_string ("9.999999999999999999999999990")
			Result := d2 |~ d1 = False
			check Result end
			create d2.make_from_string ("9.999999999999999999999999980")
			Result := d2 |~ d1 = False
			check Result end
		end

	t11: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t11: test epsilon feature")
			create c.make_default
			d1 := "9.999999999999999999999999985"
			d2 := "9.999999999999999999999999990"
			Result := d1 |~ d2
			check Result end
			d2 := "9.999999999999999999999999980"
			Result := d1 |~ d2
			check Result end
			d2 := "9.999999999999999999999999979"
			Result := not (d1 |~ d2)
			check Result end
			d2 := "9.999999999999999999999999991"
			Result := not (d1 |~ d2)
			check Result end
			d2 := "9.999999999999999999999999960"
			Result := not (d1 |~ d2)
			check Result end
			d2 := "9.999999999999999999999999999"
			Result := not (d1 |~ d2)
			check Result end
			d1 := "7.225973768125749258177477042"
			d2 := "7.225973768125749258177477033"
			Result := not (d1 |~ d2)
			check Result end
			Result := d1.approximately_equal_epsilon (d2, "20E-27")
			check Result end
			d1.epsilon.set_epsilon (20)
			Result := d1 |~ d2
			check Result end
			d1.epsilon.set_epsilon (9)
			Result := d1 |~ d2
			check Result end
			d1.epsilon.set_epsilon (8)
			Result := not (d1 |~ d2)
			check Result end
			Result := not d1.approximately_equal_epsilon (d2, "8E-27")
			check Result end
		end

	t12: BOOLEAN
		local
			d1: DECIMAL
		do
			comment("t12: test no_digits_after_point feature")
			d1 := "0.00005"
			Result := d1.no_digits_after_point = 5
			check Result end
			d1 := "5000.00"
			Result := d1.no_digits_after_point = 2
			check Result end
			d1 := "5000"
			Result := d1.no_digits_after_point = 0
			check Result end
			d1 := "5E+30"
			Result := d1.no_digits_after_point = 0
			check Result end
			d1 := "512.4567"
			Result := d1.no_digits_after_point = 4
			check Result end
			d1 := "5E-37"
			Result := d1.no_digits_after_point = 37
			check Result end
		end

	t13: BOOLEAN
		local
			d1,d2: DECIMAL
		do
			comment("t13: test approximately_equal")
			d1 := "1.6005"
			Result := d1.no_digits_after_point = 4
			check Result end
			d2 := "1.6000"
			Result := d1.no_digits_after_point = 4
			check Result end
			Result := d1.approximately_equal (d2)
			check Result end
			Result := d1 |~ d2
			check Result end
			d2 := "1.5999"
			Result := not d1.approximately_equal (d2)
			check Result end
			Result := not (d1 |~ d2)
			check Result end
			d2 := "23.67896455"
			Result := not d1.approximately_equal (d2)
			check Result end
			d1 := "23.67896460"
			Result := d1.no_digits_after_point = 8
			check Result end
			Result := d1.approximately_equal (d2)
			check Result end
			d2 := "23.678964600001"
			Result := d2.no_digits_after_point = 12
			check Result end
			Result := d1.approximately_equal (d2)
			check Result end
			d2 := "23.678964600006"
			Result := d2.no_digits_after_point = 12
			check Result end
			Result := not d1.approximately_equal (d2)
			check Result end
		end

	t14: BOOLEAN
		local
			x,y: DECIMAL
		do
			comment("t14: test round_to feature")
			x := "1.556"
			y := "1.882"
			Result := (x*y).out_tuple ~ "[0,2928392,-6]"
			check Result end
			Result := (x*y).round_to(2).out ~ "2.93"
			check Result end
			x := "1234567890123456789012345678"
			Result := x.round_to (2).out ~ "1234567890123456789012345678.00"
			check Result end
			x := "12345678901234567890123456"
			Result := x.round_to (2).out ~ "12345678901234567890123456.00"
			check Result end
			Result := x.round_to (3).out ~ "12345678901234567890123456.000"
			check Result end
			Result := x.round_to (1).out ~ "12345678901234567890123456.0"
			check Result end
			x := "123456789012345678901234567890"
			Result := x.round_to (2).out ~ "123456789012345678901234567900.00"
			check Result end
			x := "0.527017"
			Result := x.round_to (1).out ~ "0.5"
			check Result end
			Result := x.round_to (2).out ~ "0.53"
			check Result end
			Result := x.round_to (3).out ~ "0.527"
			check Result end
			Result := x.round_to (4).out ~ "0.5270"
			check Result end
			Result := x.round_to (5).out ~ "0.52702"
			check Result end
			Result := x.round_to (6).out ~ "0.527017"
			check Result end
			Result := x.round_to (7).out ~ "0.5270170"
			check Result end
			x := "0.000756"
			Result := x.round_to (2).out ~ "0.00"
			check Result end
			Result := x.round_to (4).out ~ "0.0008"
			check Result end
			x := "0.0000000000123456789012345678901"
			Result := x.round_to (13).out ~ "1.23E-11"
			check Result end
			x := "1.78"
			Result := x.round_to (0).out ~ "2"
			check Result end
			x := "91.1010"
			Result := x.round_to (0).out ~ "91"
			check Result end
			x := "-1.19177"
			Result := x.round_to (1).out ~ "-1.2"
			check Result end
			x := "-1.19177"
			Result := x.round_to (2).out ~ "-1.19"
			check Result end
			x := "-1.19177"
			Result := x.round_to (3).out ~ "-1.192"
			check Result end
			x := "-1.19177"
			Result := x.round_to (4).out ~ "-1.1918"
			check Result end
			x := "-1.19177"
			Result := x.round_to (5).out ~ "-1.19177"
			check Result end
			x := "-1.19177"
			Result := x.round_to (6).out ~ "-1.191770"
			check Result end
			x := "81.919"
			Result := x.round_to (-1).out ~ "80"
			check Result end
			x := "478.45"
			y := x.round_to(0)
			Result := y.out ~ "478"
			check Result end
			x := "478.55"
			y := x.round_to (0)
			Result := y.out ~ "479"
			check Result end
			x := "718.7171"
			y := x.round_to (5)
			Result := y.out ~ "718.71710"
			check Result end
			x := "61.717"
			y := x.round_to (2)
			Result := y.out ~ "61.72"
			check Result end
			x := "0.0005819"
			y := x.round_to (2)
			Result := y.out ~ "0.00"
			check Result end
			x := "0.0005819"
			y := x.round_to (4)
			Result := y.out ~ "0.0006"
			check Result end
			x := "153.76"
			y := x.round_to (-1)
			Result := y.out ~ "150"
			check Result end
			x := "153.76"
			y := x.round_to (-2)
			Result := y.out ~ "200"
			check Result end
			x := "153.76"
			y := x.round_to (-3)
			Result := y.out ~ "0"
			check Result end
			x := "153.76"
			y := x.round_to (-4)
			Result := y.out ~ "0"
			check Result end
			x := "0.7671"
			y := x.round_to (1)
			Result := y.out ~ "0.8"
			check Result end
			x := "0.7671"
			y := x.round_to (2)
			Result := y.out ~ "0.77"
			check Result end
			x := "0.7671"
			y := x.round_to (3)
			Result := y.out ~ "0.767"
			check Result end
			x := "0.7671"
			y := x.round_to (4)
			Result := y.out ~ "0.7671"
			check Result end
			x := "0.7671"
			y := x.round_to (0)
			Result := y.out ~ "1"
			check Result end
			x := "0.7671"
			y := x.round_to (-1)
			Result := y.out ~ "0"
			check Result end
			x := "0.7671"
			y := x.round_to (-2)
			Result := y.out ~ "0"
			check Result end
			x := "1856"
			y := x.round_to (-1)
			Result := y.out ~ "1860"
			check Result end
			x := "1856"
			y := x.round_to (-2)
			Result := y.out ~ "1900"
			check Result end
			x := "1856"
			y := x.round_to (-3)
			Result := y.out ~ "2000"
			check Result end
			x := "1856"
			y := x.round_to (-4)
			Result := y.out ~ "0"
			check Result end
			x := "1856"
			y := x.round_to (-5)
			Result := y.out ~ "0"
			check Result end
			x := "10.12345678901234567890123456789011"
			y := x.round_to (-1)
			Result := y.out ~ "10"
			check Result end
			x := "10.12345678901234567890123456789011"
			y := x.round_to (-2)
			Result := y.out ~ "0"
			check Result end
			x := "10.12345678901234567890123456789011"
			y := x.round_to (-3)
			Result := y.out ~ "0"
			check Result end
			x := "10.12345678901234567890123456789011"
			y := x.round_to (-4)
			Result := y.out ~ "0"
			check Result end
			x := "NaN"
			y := x.round_to (1)
			Result := y.out ~ "NaN"
			check Result end
			x := "NaN"
			y := x.round_to (0)
			Result := y.out ~ "NaN"
			check Result end
			x := "NaN"
			y := x.round_to (-1)
			Result := y.out ~ "NaN"
			check Result end
			x := "Infinity"
			y := x.round_to (1)
			Result := y.out ~ "NaN"
			check Result end
			x := "Infinity"
			y := x.round_to (0)
			Result := y.out ~ "NaN"
			check Result end
			x := "Infinity"
			y := x.round_to (-1)
			Result := y.out ~ "NaN"
			check Result end
			x := "-Infinity"
			y := x.round_to (1)
			Result := y.out ~ "NaN"
			check Result end
			x := "-Infinity"
			y := x.round_to (0)
			Result := y.out ~ "NaN"
			check Result end
			x := "-Infinity"
			y := x.round_to (-1)
			Result := y.out ~ "NaN"
			check Result end
			x := "abcd"
			y := x.round_to (1)
			Result := y.out ~ "NaN"
			check Result end
			x := "abcd"
			y := x.round_to (0)
			Result := y.out ~ "NaN"
			check Result end
			x := "abcd"
			y := x.round_to (-1)
			Result := y.out ~ "NaN"
			check Result end
			x := "1.12348182374908172394789772983479812734980172394070192734097991789127349"
			y := x.round_to (2)
			Result := y.out ~ "1.12"
			check Result end
			x := "1283618726387196237891627386182369812631862389126387162387162839"
			y := x.round_to (4)
			Result := y.out ~ "1.28361872638719623789162738600000000E+63"
			check Result end
		end

	t15
		local
			d1,d2,d3: DECIMAL
		do
			comment("t15: test x^y where x,y are real and x is negative: Precondition violation")
			d1 := "-9.818"
			d2 := "8.71"
			d1.default_context.enable_exception_on_trap
			d3 := d1.power (d2)
		end

	t16
		local
			d1, d2: DECIMAL
		do
			comment("t16: test x.sqrt() where x < 0: Precondition violation")
			d1 := "-9.818"
			d1.default_context.enable_exception_on_trap
			d2 := d1.sqrt
		end

	t17
		local
			d1, d2: DECIMAL
		do
			comment("t17: test x.log10() where x < 0: Precondition violation")
			d1 := "-1.081"
			d1.default_context.enable_exception_on_trap
			d2 := d1.log10
		end

	t18
		local
			d1, d2, d3: DECIMAL
		do
			comment("t18: test x.nth_root(y) where x < 0: Precondition violation")
			d1 := "-1.081"
			d1.default_context.enable_exception_on_trap
			d2 := "8"
			d3 := d1.nth_root (d2)
		end

	t19
		local
			d1, d2, d3: DECIMAL
		do
			comment("t19: test x.nth_root(y) where y < 0: Precondition violation")
			d1 := "7.91"
			d1.default_context.enable_exception_on_trap
			d2 := "-3"
			d3 := d1.nth_root (d2)
		end

	t20
		local
			d1, d2, d3: DECIMAL
		do
			comment("t20: test x.nth_root(y) where x < 0 and y < 0: Precondition violation")
			d1 := "-1.081"
			d1.default_context.enable_exception_on_trap
			d2 := "-4"
			d3 := d1.nth_root (d2)
		end

	t21
		local
			d1, d2, d3: DECIMAL
		do
			comment("t21: test x.nth_root(y) where y not an integer: Precondition violation")
			d1 := "9.8178"
			d1.default_context.enable_exception_on_trap
			d2 := "1.91"
			d3 := d1.nth_root (d2)
		end

	t22: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t22: test floor feature")
			d1 := "1.8"
			d2 := d1.floor
			Result := d2.out ~ "1"
			check Result end
			d1 := "-0.718"
			d2 := d1.floor
			Result := d2.out ~ "-0"
			check Result end
			d1 := "-0"
			d2 := d1.floor
			Result := d2.out ~ "-0"
			check Result end
			d1 := "-1829.919"
			d2 := d1.floor
			Result := d2.out ~ "-1829"
			check Result end
			d1 := "7919"
			d2 := d1.floor
			Result := d2.out ~ "7919"
			check Result end
			create c.make_default
			create d1.make_from_string_ctx ("81.81901", c)
			d2 := d1.floor_wrt_ctx (c)
			Result := d2.out ~ "81"
			check Result end
			d1 := "1.2"
			d2 := d1.floor
			Result := d2.out ~ "1"
			check Result end
			d1 := "0.8"
			d2 := d1.floor
			Result := d2.out ~ "0"
			check Result end
			d1 := "-1"
			d2 := d1.floor
			Result := d2.out ~ "-1"
			check Result end
			d1 := "-282730.3928"
			d2 := d1.floor
			Result := d2.out ~ "-282730"
			check Result end
			d1 := "9000"
			d2 := d1.floor
			Result := d2.out ~ "9000"
			check Result end
		end

	t23: BOOLEAN
		local
			d1, d2: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t23: test ceiling feature")
			d1 := "1.8"
			d2 := d1.ceiling
			Result := d2.out ~ "2"
			check Result end
			d1 := "-0.718"
			d2 := d1.ceiling
			Result := d2.out ~ "-1"
			check Result end
			d1 := "0.1"
			d2 := d1.ceiling
			Result := d2.out ~ "1"
			check Result end
			d1 := "-0.1"
			d2 := d1.ceiling
			Result := d2.out ~ "-1"
			check Result end
			create c.make_default
			c.set_digits (9)
			create d1.make_from_string_ctx ("7291.81919", c)
			d2 := d1.ceiling_wrt_ctx (c)
			Result := d2.out ~ "7292"
			check Result end
			d1 := "9.2"
			d2 := d1.ceiling
			Result := d2.out ~ "10"
			check Result end
			d1 := "0.1"
			d2 := d1.ceiling
			Result := d2.out ~ "1"
			check Result end
			d1 := "-0.1"
			d2 := d1.ceiling
			Result := d2.out ~ "-1"
			check Result end
		    d1 := "30284.1"
			d2 := d1.ceiling
			Result := d2.out ~ "30285"
			check Result end
			 d1 := "2.01"
			d2 := d1.ceiling
			Result := d2.out ~ "3"
			check Result end
		end

	t24
		local
			d1,d2,d3: DECIMAL
		do
			comment("t24: test division by zero exception without context")
			d1 := "1"
			d2 := "0"
			d1.default_context.enable_exception_on_trap
			d3 := d1 / d2
		end

	t25
		local
			d1,d2,d3: DECIMAL
			c: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t25: test division by zero exception with context")
			d1 := "1"
			d2 := "0"
			create c.make_default
			c.enable_exception_on_trap
			d3 := d1.divide (d2, c)
		end

	t26: BOOLEAN
		local
			d: DECIMAL
			inf, nan, snan: DECIMAL
		do
			comment ("t26: creating special decimals")
			create d.make_zero
			inf := d.negative_infinity
			nan := d.nan
			snan := d.snan
			Result := True
		end

	t27: BOOLEAN
		local
			d: DECIMAL
			inf, nan, snan: DECIMAL
		do
			comment ("t27: twin from existing decimal should not violate invariant")
			create d.make_zero
			inf := d.negative_infinity
			nan := d.nan
			snan := d.snan
			Result := inf.twin.is_infinity and nan.twin.is_nan and snan.twin.is_nan
		end

	t28: BOOLEAN
		local
			d1, d2, d3: DECIMAL
		do
			comment ("t28: test inf and NaN")
			d1 := create {DECIMAL}.make_from_string ("1")
			d2 := create {DECIMAL}.make_from_string ("0")
			d3 := d1 / d2
			Result := not d3.is_nan and d3.is_infinity and d3.is_special
			check
				Result
			end
			d3 := d2 / d2
			Result := d3.is_nan
		end

note
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT license"
	details: "[
			Originally developed by Jonathan Ostroff, and Moksh Khurana. See class DECIMAL.
		]"


end

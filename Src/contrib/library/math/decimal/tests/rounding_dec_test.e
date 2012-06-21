note
	description:
		"Rounding test cases corresponding to rounding.decTest file from http://speleotrove.com/decimal/"
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class
	ROUNDING_DEC_TEST

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
				add_boolean_case (agent t1)
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
			add_boolean_case (agent t15)
			add_boolean_case (agent t16)
			add_boolean_case (agent t17)
			add_boolean_case (agent t18)
			add_boolean_case (agent t19)
			add_boolean_case (agent t20)
			add_boolean_case (agent t21)
			add_boolean_case (agent t22)
			add_boolean_case (agent t23)
			add_boolean_case (agent t24)
			add_boolean_case (agent t25)
			add_boolean_case (agent t26)
			add_boolean_case (agent t27)
			add_boolean_case (agent t28)
			add_boolean_case (agent t29)
			add_boolean_case (agent t30)
			add_boolean_case (agent t31)
			add_boolean_case (agent t32)
			add_boolean_case (agent t33)
			add_boolean_case (agent t34)
			add_boolean_case (agent t35)
		end

feature -- tests

	t1: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t1: test round down")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (1)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			Result := not ctx.is_flagged (2)
			check Result end
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags

			create d1.make_from_string_ctx ("12346", ctx)
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags

			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t2: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t2: test round half_down")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (5)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12346", ctx)
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t3: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t3: test round half_even")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (6)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12346", ctx)
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t4: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t4: test round half_up")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (4)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12346", ctx)
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t5: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t5: test round up")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (0)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12346", ctx)
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t6: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t6: test round floor")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (3)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12346", ctx)
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t7: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t7: test round ceiling")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (2)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12346", ctx)
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	--Negative Numbers


	t8: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t8: test round down for negative numbers")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (1)
			create d1.make_from_string_ctx ("-12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			Result := not ctx.is_flagged (2)
			check Result end
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags

			create d1.make_from_string_ctx ("-12346", ctx)
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags

			create d1.make_from_string_ctx ("-12345", ctx)
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t9: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t9: test round half_down for negative numbers")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (5)
			create d1.make_from_string_ctx ("-12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("-12346", ctx)
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t10: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t10: test round half_even for negative numbers")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (6)
			create d1.make_from_string_ctx ("-12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("-12346", ctx)
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t11: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t11: test round half_up for negative numbers")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (4)
			create d1.make_from_string_ctx ("-12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("-12346", ctx)
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t12: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t12: test round up for negative numbers")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (0)
			create d1.make_from_string_ctx ("-12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("-12346", ctx)
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t13: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t13: test round floor for negative numbers")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (3)
			create d1.make_from_string_ctx ("-12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("-12346", ctx)
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t14: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t14: test round ceiling for negative numbers")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (2)
			create d1.make_from_string_ctx ("-12345", ctx)
			create d2.make_from_string_ctx ("-0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("-0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.000001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.00001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.0001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.01", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.4", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.499", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.501", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.51", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.6", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("-12346", ctx)
			create d2.make_from_string_ctx ("0.50001", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("0.49999", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-12345" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

-- Check cancellation subtractions
-- (The IEEE 854 'curious rule' in $6.3)

	t15: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t15: test round down curious rule")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (1)
			create d1.make_from_string_ctx ("0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("1", ctx)
			create d2.make_from_string_ctx ("-1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-1", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("1.5", ctx)
			create d2.make_from_string_ctx ("-1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("-1.5", ctx)
			create d2.make_from_string_ctx ("1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("2", ctx)
			create d2.make_from_string_ctx ("-2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-2", ctx)
			create d2.make_from_string_ctx ("2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
		end

	t16: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t16: test round up curious rule")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (0)
			create d1.make_from_string_ctx ("0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("1", ctx)
			create d2.make_from_string_ctx ("-1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-1", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("1.5", ctx)
			create d2.make_from_string_ctx ("-1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("-1.5", ctx)
			create d2.make_from_string_ctx ("1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("2", ctx)
			create d2.make_from_string_ctx ("-2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-2", ctx)
			create d2.make_from_string_ctx ("2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
		end

	t17: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t17: test round half_up curious rule")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (4)
			create d1.make_from_string_ctx ("0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("1", ctx)
			create d2.make_from_string_ctx ("-1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-1", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("1.5", ctx)
			create d2.make_from_string_ctx ("-1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("-1.5", ctx)
			create d2.make_from_string_ctx ("1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("2", ctx)
			create d2.make_from_string_ctx ("-2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-2", ctx)
			create d2.make_from_string_ctx ("2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
		end

	t18: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t18: test round half_down curious rule")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (5)
			create d1.make_from_string_ctx ("0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("1", ctx)
			create d2.make_from_string_ctx ("-1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-1", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("1.5", ctx)
			create d2.make_from_string_ctx ("-1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("-1.5", ctx)
			create d2.make_from_string_ctx ("1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("2", ctx)
			create d2.make_from_string_ctx ("-2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-2", ctx)
			create d2.make_from_string_ctx ("2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
		end

	t19: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t19: test round half_even curious rule")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (6)
			create d1.make_from_string_ctx ("0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("1", ctx)
			create d2.make_from_string_ctx ("-1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-1", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("1.5", ctx)
			create d2.make_from_string_ctx ("-1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("-1.5", ctx)
			create d2.make_from_string_ctx ("1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("2", ctx)
			create d2.make_from_string_ctx ("-2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-2", ctx)
			create d2.make_from_string_ctx ("2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
		end

	t20: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t20: test round floor curious rule")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (3)
			create d1.make_from_string_ctx ("0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("-0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("1", ctx)
			create d2.make_from_string_ctx ("-1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("-1", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("1.5", ctx)
			create d2.make_from_string_ctx ("-1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0.0"
			check Result end
			create d1.make_from_string_ctx ("-1.5", ctx)
			create d2.make_from_string_ctx ("1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0.0"
			check Result end
			create d1.make_from_string_ctx ("2", ctx)
			create d2.make_from_string_ctx ("-2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("-2", ctx)
			create d2.make_from_string_ctx ("2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
		end

	t21: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t21: test round ceiling curious rule")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (2)
			create d1.make_from_string_ctx ("0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-0", ctx)
			create d2.make_from_string_ctx ("0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d2.make_from_string_ctx ("-0", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "-0"
			check Result end
			create d1.make_from_string_ctx ("1", ctx)
			create d2.make_from_string_ctx ("-1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-1", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("1.5", ctx)
			create d2.make_from_string_ctx ("-1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("-1.5", ctx)
			create d2.make_from_string_ctx ("1.5", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0.0"
			check Result end
			create d1.make_from_string_ctx ("2", ctx)
			create d2.make_from_string_ctx ("-2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
			create d1.make_from_string_ctx ("-2", ctx)
			create d2.make_from_string_ctx ("2", ctx)
			d3 := d1.add (d2, ctx)
			Result := d3.to_scientific_string ~ "0"
			check Result end
		end

-- Division operators -------------------------------------------------

	t22: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t22: test round down with division operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (1)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12343" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12332" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12222" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "11222" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.2" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.1" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2519.3" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2473.9" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.4" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2468.9" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2468.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2464.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2420.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.7" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.6" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t23: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t23: test round half_down with division operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (5)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12333" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "11223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.2" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.2" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2519.4" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2473.9" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2468.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2464.1" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2420.6" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.7" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.7" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t24: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t24: test round half_even with division operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (6)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12333" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "11223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.2" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.2" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2519.4" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2473.9" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2468.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2464.1" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2420.6" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.8" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.7" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t25: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t25: test round half_up with division operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (4)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12333" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "11223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.3" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.2" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2519.4" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2473.9" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2468.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2464.1" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2420.6" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.8" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.7" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t26: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t26: test round up with division operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (0)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12333" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "11223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.3" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.2" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2519.4" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2474.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.1" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2468.6" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2464.1" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2420.6" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.8" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.7" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t27: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t27: test round floor with division operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (3)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12343" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12332" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12222" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "11222" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.2" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.1" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2519.3" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2473.9" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.4" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2468.9" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2468.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2464.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2420.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.7" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.6" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t28: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t28: test round ceiling with division operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (2)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12344" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12333" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "12223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "11223" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.3" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3086.2" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2519.4" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2474.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.1" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2469.0" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2468.6" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2464.1" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.1", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "2420.6" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.8" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.divide (d2, ctx)
			Result := d3.to_scientific_string ~ "3088.7" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

-- [divideInteger and remainder unaffected]

-- Multiplication operators --------------------------------------------

	t29: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t29: test round down with multiplication operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (1)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12357" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12468" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "13579" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49380" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49381" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "60490" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61601" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61712" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61723" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61725" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61726" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61737" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61848" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4814E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6048E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4826E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6061E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t30: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t30: test round half_down with multiplication operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (5)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12357" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12468" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "13579" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49380" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49381" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "60490" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61602" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61713" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61724" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61725" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61726" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61737" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61848" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4814E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6048E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4826E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6061E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t31: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t31: test round half_even with multiplication operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (6)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12357" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12468" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "13580" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49380" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49381" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "60490" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61602" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61713" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61724" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61725" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61726" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61737" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61848" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4814E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6048E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4826E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6062E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t32: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t32: test round half_up with multiplication operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (4)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12357" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12468" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "13580" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49380" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49381" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "60491" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61602" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61713" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61724" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61725" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61726" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61737" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61848" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4814E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6049E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4826E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6062E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t33: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t33: test round up with multiplication operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (0)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12358" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12469" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "13580" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49380" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49382" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "60491" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61602" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61713" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61724" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61725" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61727" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61738" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61849" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4814E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6049E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4826E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6062E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t34: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t34: test round floor with multiplication operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (3)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12346" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12357" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12468" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "13579" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49380" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49381" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "60490" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61601" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61712" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61723" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61725" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61726" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61737" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61848" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4814E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6048E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4826E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6061E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

	t35: BOOLEAN
		local
			d1, d2, d3: DECIMAL
			ctx: DCM_MA_DECIMAL_CONTEXT
		do
			comment("t35: test round ceiling with multiplication operator")
			create ctx.make_extended
			ctx.set_digits (5)
			ctx.set_exponent_limit (999)
			ctx.set_rounding_mode (2)
			create d1.make_from_string_ctx ("12345", ctx)
			create d2.make_from_string_ctx ("1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12345" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12347" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12358" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "12469" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("1.1", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "13580" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49380" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "49382" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "60491" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.99", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61602" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61713" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("4.9999", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61724" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61725" and not ctx.is_flagged (2) and not ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.0001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61727" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.001", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61738" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("5.01", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "61849" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4814E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6049E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d1.make_from_string_ctx ("12355", ctx)
			create d2.make_from_string_ctx ("12", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.4826E+5" and not ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
			create d2.make_from_string_ctx ("13", ctx)
			d3 := d1.multiply (d2, ctx)
			Result := d3.to_scientific_string ~ "1.6062E+5" and ctx.is_flagged (2) and ctx.is_flagged (6)
			check Result end
			ctx.reset_flags
		end

-- Power operator -----------------------------------------------------

note
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT license"
	details: "[
			Originally developed by http://speleotrove.com/decimal/
			Revised by Jonathan Ostroff, and Moksh Khurana. See class DECIMAL.
		]"


end

Decimal library.
Use decimal.ecf or decimal-safe.ecf to include as library
Based on http://speleotrove.com/decimal/
Only some of the official tests have been implemented.
See folder "tests".
Class {FAST} has some basic tests, e.g:

t1: BOOLEAN
	local
		d1,d2,d3: DECIMAL
		r1 : REAL_64
	do
		comment("t1: test 0.1 + 0.1 + 0.1 = 0.3")
		r1 := 0.1
		d1 := "0.1"
		d3 := "0.3"
		d2 := d1 + d1 + d1
		check d1.out ~ "0.1" end
		Result := d2.out ~ "0.3"
	end

January 25, 2012
======================


-----------------------
Working infrastructure
-----------------------

-- Basic operators +. -, *, \, abs, floor, ceiling etc.
-- Default precision set to 28
-- Default roundoff is round-half-up
-- See {FAST} test cases

-- By default contracts (e.g. 4/0) are turned off
To turn on contracts, d1.default_context.enable_exception_on_trap.
This will cause 4/0 to generate a precondition exception.

-- d1.round_to(2) will round to 2 decimal places. As in Excel.

-- Approximately equal: d1.approximately_equal(d2) or "d1 |~ d2" 
Feature d1.no_digit_after_point returns the number of digits after the decimal point
(which we abbreviate as d1.ndap).
Let ndap = max(d1.ndap, d2.ndap), then
d1 |~ d2 iff |d1-d2| <= 5E-ndap
There is also a function to specify a specific epsilion, default = 5.

-- d1.log10, d1.log2, d1.sqrt and d1.nth_root(n:INT) have been added
(and appear to be working, although not yet efficient)


--------------------
EXPERIMENTAL
--------------------

--d1.sin, d1.cos, d1.tan, t1.cot, d1.sec, d1.csc are working but not well tested.
Degrees (not radians)

--d1.exp(x) fails on large numbers (e.g. x=500) can be very inaccurate
e.g. to 10 ULP (units in the last place).
d1.pow(x) also fails as it depends on exp(x)


==========================
LICENSE
==========================
note
	description:
		"DECIMAL numbers. Following the 'General Decimal Arithmetic Specification'."
	copyright: "Copyright (c) 2004, Paul G. Crismer and others."
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT License"
	date: "$Date: 2012-01-02 22:26:29 -0500 (Mon, 02 Jan 2012) $"
	revision: "$Revision: 359 $"

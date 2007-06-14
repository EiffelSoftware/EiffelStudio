indexing

	description:

		"Routines that ought to be in class DOUBLE"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2003-2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_DOUBLE_ROUTINES

inherit













	MATH
		rename
			log as old_log,
			exp as old_exp
		export
			{NONE} all
		end



	KL_SHARED_PLATFORM

feature -- Logarithms

	log (d: DOUBLE): DOUBLE is
			-- Natural logarithm of `d'
		require
			d_positive: d > 0.0
		do







			Result := old_log (d.truncated_to_real)

		end

	log2 (d: DOUBLE): DOUBLE is
			-- Base 2 logarithm of `d'
		require
			d_positive: d > 0.0

		local





			a: REAL

		do




			a := 2.0





			Result := old_log (d.truncated_to_real) / log (a)

		end

	log10 (d: DOUBLE): DOUBLE is
			-- Base 10 logarithm of `d'
		require
			d_positive: d > 0.0
		do







			Result := log (d) / log (10.0)

		end

feature -- Exponent

	exp (d: DOUBLE): DOUBLE is
			-- Inverse of the natural logarithm
		do







			Result := old_exp (d.truncated_to_real)

		end

	nth_root (d, n: DOUBLE): DOUBLE is
			-- `n'-th root of `d'
		require

			divisible: (1.0).divisible (n.truncated_to_real)



		do

			Result := d ^ (1.0 / n)




		end

feature -- Conversion

	truncated_to_integer (d: DOUBLE): INTEGER is
			-- Integer part (Same sign, largest absolute
			-- value no greater than current object's)
		require
			d_large_enough: d >= Platform.Minimum_integer
			d_small_enough: d <= Platform.Maximum_integer
		do
			Result := d.truncated_to_integer
		end

	rounded_to_integer (d: DOUBLE): INTEGER is
			-- Rounded integral value
		require
			d_large_enough: (d.abs + 0.5) >= Platform.Minimum_integer
			d_small_enough: (d.abs + 0.5) < (Platform.Maximum_integer + 1.0)
		do



			Result := d.sign * floor_to_integer (d.abs + 0.5)

		ensure
			definition: Result = d.sign * floor_to_integer (d.abs + 0.5)
		end

	floor_to_integer (d: DOUBLE): INTEGER is
			-- INTEGER floor
			-- (floor returns integer in ELKS, but a floating point value with SE2)
		require
			d_large_enough: d >= Platform.Minimum_integer
			d_small_enough: d < (Platform.Maximum_integer + 1.0)
		do
			Result := d.truncated_to_integer
			if d.floor /= Result then
				Result := Result - 1
			end
		ensure
			definition: Result = d.floor
		end

feature -- Constants

	plus_infinity: DOUBLE is
			-- Positive infinity


















		local
			p: RTS_MEMORY_MAPPED_AREA_ARRAY [CHARACTER]
		once
				-- Binary representation of IEEE 754 '+infinity'.
				-- See: http://en.wikipedia.org/wiki/IEEE_754
			create p.make ($Result, 8)
			p.put ('%/0/', 1)
			p.put ('%/0/', 2)
			p.put ('%/0/', 3)
			p.put ('%/0/', 4)
			p.put ('%/0/', 5)
			p.put ('%/0/', 6)
			p.put ('%/240/', 7)
			p.put ('%/127/', 8)
















		ensure
			positive: Result > 0
		end

	minus_infinity: DOUBLE is
			-- Negative infinity


















		local
			p: RTS_MEMORY_MAPPED_AREA_ARRAY [CHARACTER]
		once
				-- Binary representation of IEEE 754 '+infinity'.
				-- See: http://en.wikipedia.org/wiki/IEEE_754
			create p.make ($Result, 8)
			p.put ('%/0/', 1)
			p.put ('%/0/', 2)
			p.put ('%/0/', 3)
			p.put ('%/0/', 4)
			p.put ('%/0/', 5)
			p.put ('%/0/', 6)
			p.put ('%/240/', 7)
			p.put ('%/255/', 8)



















		ensure
			negative: Result < 0
		end

end

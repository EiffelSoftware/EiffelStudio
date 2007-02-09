indexing

	description:

		"Routines that ought to be in class DOUBLE"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2003-2006, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class KL_DOUBLE_ROUTINES

inherit


	DOUBLE_MATH
		rename
			log as old_log,
			log10 as old_log10,
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




			Result := old_log (d)




		end

	log2 (d: DOUBLE): DOUBLE is
			-- Base 2 logarithm of `d'
		require
			d_positive: d > 0.0









		do

			Result := log_2 (d)










		end

	log10 (d: DOUBLE): DOUBLE is
			-- Base 10 logarithm of `d'
		require
			d_positive: d > 0.0
		do




			Result := old_log10 (d)




		end

feature -- Exponent

	exp (d: DOUBLE): DOUBLE is
			-- Inverse of the natural logarithm
		do




			Result := old_exp (d)




		end

	nth_root (d, n: DOUBLE): DOUBLE is
			-- `n'-th root of `d'
		require



			divisible: (1.0).divisible (n)

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

			Result := d.rounded



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
			p: MANAGED_POINTER
		once
				-- Binary representation of IEEE 754 '+infinity'.
				-- See: http://en.wikipedia.org/wiki/IEEE_754
			create p.make (8)
			p.put_natural_8 (0, 0)
			p.put_natural_8 (0, 1)
			p.put_natural_8 (0, 2)
			p.put_natural_8 (0, 3)
			p.put_natural_8 (0, 4)
			p.put_natural_8 (0, 5)
			p.put_natural_8 (240, 6)
			p.put_natural_8 (127, 7)
			Result := p.read_real_64 (0)
































		ensure
			positive: Result > 0
		end

	minus_infinity: DOUBLE is
			-- Negative infinity

		local
			p: MANAGED_POINTER
		once
				-- Binary representation of IEEE 754 '-infinity'.
				-- See: http://en.wikipedia.org/wiki/IEEE_754
			create p.make (8)
			p.put_natural_8 (0, 0)
			p.put_natural_8 (0, 1)
			p.put_natural_8 (0, 2)
			p.put_natural_8 (0, 3)
			p.put_natural_8 (0, 4)
			p.put_natural_8 (0, 5)
			p.put_natural_8 (240, 6)
			p.put_natural_8 (255, 7)
			Result := p.read_real_64 (0)



































		ensure
			negative: Result < 0
		end

end

indexing
	description: "Actual type for integer type."
	date: "$Date$"
	revision: "$Revision $"

class
	INTEGER_A

inherit
	BASIC_A
		rename
			make as cl_make
		redefine
			is_integer, associated_class,
			same_as, is_numeric, weight, internal_conform_to
		end

create
	make,
	make_for_constant

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create instance of INTEGER_A represented by `n' bits.
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			size := n.to_integer_8
			compatibility_size := n.to_integer_8
		ensure
			size_set: size = n
			compatibility_size_set: compatibility_size = n
		end

	make_for_constant (n, m: INTEGER) is
			-- Create instance of INTEGER_A represented by `n' bits
			-- whose value can hold at list `m' bits.
		require
			valid_n: n = 32 or n = 64
			valid_m: m = 8 or m = 16 or m = 32 or m = 64
		do
			size := n.to_integer_8
			compatibility_size := m.to_integer_8
		ensure
			size_set: size = n
			compatibility_size_set: compatibility_size = m
		end

feature -- Property

	is_integer: BOOLEAN is True
			-- Is the current type an integer type ?

	size: INTEGER_8
			-- Current is stored on `size' bits.
	
	compatibility_size: INTEGER_8
			-- Minimum integer size that can hold current.
			-- Used for manifest integers that are of size `32' or `64'
			-- by default, but their value might be able to fit
			-- on an integer of size `8' or `16' as well.

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			i: like Current
		do
			Result := other.is_integer
			if Result then
				i ?= other
				Result := size = i.size
			end
		end

	associated_class: CLASS_C is
			-- Class INTEGER
		do
			inspect size
			when 8 then Result := System.integer_8_class.compiled_class
			when 16 then Result := System.integer_16_class.compiled_class
			when 32 then Result := System.integer_32_class.compiled_class
			when 64 then Result := System.integer_64_class.compiled_class
			end
		end

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		local
			int: like Current
		do
			if in_generics then
				Result := same_as (other)
			else
				if other.is_integer then
					int ?= other
					Result := int.compatibility_size >= compatibility_size
				else
					Result := Precursor {BASIC_A} (other, False)
						or else other.is_real
						or else other.is_double
				end
			end
		end

	is_numeric: BOOLEAN is True
			-- Is the current type a numeric type ?

	weight: INTEGER is
			-- Weight of Current.
			-- Used to evaluate type of an expression with balancing rule.
		do
			inspect
				size
			when 8 then Result := 1
			when 16 then Result := 2
			when 32 then Result := 3
			when 64 then Result := 4
			end
		end

	type_i: LONG_I is
			-- C type
		do
			create Result.make (size)
		end

invariant
	correct_size: size = 8 or size = 16 or size = 32 or size = 64
	valid_compatibility_size: compatibility_size <= size

end -- class INTEGER_A

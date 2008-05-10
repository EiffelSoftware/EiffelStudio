class NATURAL_8

feature -- Comparison

	infix "<" (other: NATURAL_8): BOOLEAN is
			-- Is current integer less than `other'?
		do
			Result := Precursor (other)
		end

feature -- Basic operations

	infix "+" (other: NATURAL_8): NATURAL_8 is
			-- Sum with `other'
		do
			Result := Precursor (other)
		end

	infix "-" (other: NATURAL_8): NATURAL_8 is
			-- Result of subtracting `other'
		do
			Result := Precursor (other)
		end

	infix "*" (other: NATURAL_8): NATURAL_8 is
			-- Product by `other'
		do
			Result := Precursor (other)
		end

	infix "/" (other: NATURAL_8): REAL_64 is
			-- Division by `other'
		do
			Result := Precursor (other)
		end

	prefix "+": NATURAL_8 is
			-- Unary plus
		do
			Result := Precursor
		end

	infix "//" (other: NATURAL_8): NATURAL_8 is
			-- Integer division of Current by `other'
		do
			Result := Precursor (other)
		end

	infix "\\" (other: NATURAL_8): NATURAL_8 is
			-- Remainder of the integer division of Current by `other'
		do
			Result := Precursor (other)
		end

	infix "^" (other: REAL_64): REAL_64 is
			-- Integer power of Current by `other'
		do
			Result := Precursor (other)
		end

feature -- Conversion

	as_natural_8: NATURAL_8 is
			-- Convert `item' into an NATURAL_8 value.
		do
			Result := Precursor
		end

	as_natural_16: NATURAL_16 is
			-- Convert `item' into an NATURAL_16 value.
		do
			Result := Precursor
		end

	as_natural_32: NATURAL_32 is
			-- Convert `item' into an NATURAL_32 value.
		do
			Result := Precursor
		end

	as_natural_64: NATURAL_64 is
			-- Convert `item' into an NATURAL_64 value.
		do
			Result := Precursor
		end

	as_integer_8: INTEGER_8 is
			-- Convert `item' into an INTEGER_8 value.
		do
			Result := Precursor
		end

	as_integer_16: INTEGER_16 is
			-- Convert `item' into an INTEGER_16 value.
		do
			Result := Precursor
		end

	as_integer_32: INTEGER_32 is
			-- Convert `item' into an INTEGER_32 value.
		do
			Result := Precursor
		end

	as_integer_64: INTEGER_64 is
			-- Convert `item' into an INTEGER_64 value.
		do
			Result := Precursor
		end

	to_real_32: REAL_32 is
			-- Convert `item' into a REAL_32
		do
			Result := Precursor
		end

	to_real_64: REAL_64 is
			-- Convert `item' into a REAL_64
		do
			Result := Precursor
		end

	to_character_8: CHARACTER_8 is
			-- Associated character in 8 bit version.
		do
			Result := Precursor
		end

	to_character_32: CHARACTER_32 is
			-- Associated character in 32 bit version.
		do
			Result := Precursor
		end

feature -- Bit operations

	bit_and (i: NATURAL_8): NATURAL_8 is
			-- Bitwise and between Current' and `i'.
		do
			Result := Precursor (i)
		end

	bit_or (i: NATURAL_8): NATURAL_8 is
			-- Bitwise or between Current' and `i'.
		do
			Result := Precursor (i)
		end

	bit_xor (i: NATURAL_8): NATURAL_8 is
			-- Bitwise xor between Current' and `i'.
		do
			Result := Precursor (i)
		end

	bit_not: NATURAL_8 is
			-- One's complement of Current.
		do
			Result := Precursor
		end

	bit_shift_left (n: INTEGER): NATURAL_8 is
			-- Shift Current from `n' position to left.
		do
			Result := Precursor (n)
		end

	bit_shift_right (n: INTEGER): NATURAL_8 is
			-- Shift Current from `n' position to right.
		do
			Result := Precursor (n)
		end

end

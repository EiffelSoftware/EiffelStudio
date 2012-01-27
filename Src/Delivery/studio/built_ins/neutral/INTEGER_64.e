class INTEGER_64

feature -- Comparison

	is_less alias "<" (other: INTEGER_64): BOOLEAN
			-- Is current integer less than `other'?
		do
			Result := Precursor (other)
		end
	infix "<" (other: INTEGER_64): BOOLEAN
			-- Is current integer less than `other'?
		do
			Result := Precursor (other)
		end

feature -- Basic operations

	plus alias "+" (other: INTEGER_64): INTEGER_64
			-- Sum with `other'
		do
			Result := Precursor (other)
		end

	minus alias "-" (other: INTEGER_64): INTEGER_64
			-- Result of subtracting `other'
		do
			Result := Precursor (other)
		end

	product alias "*" (other: INTEGER_64): INTEGER_64
			-- Product by `other'
		do
			Result := Precursor (other)
		end

	quotient alias "/" (other: INTEGER_64): REAL_64
			-- Division by `other'
		do
			Result := Precursor (other)
		end

	identity alias "+": INTEGER_64
			-- Unary plus
		do
			Result := Precursor
		end

	opposite alias "-": INTEGER_64
			-- Unary minus
		do
			Result := Precursor
		end

	integer_quotient alias "//" (other: INTEGER_64): INTEGER_64
			-- Integer division of Current by `other'
		do
			Result := Precursor (other)
		end

	integer_remainder alias "\\" (other: INTEGER_64): INTEGER_64
			-- Remainder of the integer division of Current by `other'
		do
			Result := Precursor (other)
		end

	power alias "^" (other: REAL_64): REAL_64
			-- Integer power of Current by `other'
		do
			Result := Precursor (other)
		end

	infix "+" (other: INTEGER_64): INTEGER_64
			-- Sum with `other'
		do
			Result := Precursor (other)
		end

	infix "-" (other: INTEGER_64): INTEGER_64
			-- Result of subtracting `other'
		do
			Result := Precursor (other)
		end

	infix "*" (other: INTEGER_64): INTEGER_64
			-- Product by `other'
		do
			Result := Precursor (other)
		end

	infix "/" (other: INTEGER_64): REAL_64
			-- Division by `other'
		do
			Result := Precursor (other)
		end

	prefix "+": INTEGER_64
			-- Unary plus
		do
			Result := Precursor
		end

	prefix "-": INTEGER_64
			-- Unary minus
		do
			Result := Precursor
		end

	infix "//" (other: INTEGER_64): INTEGER_64
			-- Integer division of Current by `other'
		do
			Result := Precursor (other)
		end

	infix "\\" (other: INTEGER_64): INTEGER_64
			-- Remainder of the integer division of Current by `other'
		do
			Result := Precursor (other)
		end

	infix "^" (other: REAL_64): REAL_64
			-- Integer power of Current by `other'
		do
			Result := Precursor (other)
		end

feature -- Conversion

	as_natural_8: NATURAL_8
			-- Convert `item' into an NATURAL_8 value.
		do
			Result := Precursor
		end

	as_natural_16: NATURAL_16
			-- Convert `item' into an NATURAL_16 value.
		do
			Result := Precursor
		end

	as_natural_32: NATURAL_32
			-- Convert `item' into an NATURAL_32 value.
		do
			Result := Precursor
		end

	as_natural_64: NATURAL_64
			-- Convert `item' into an NATURAL_64 value.
		do
			Result := Precursor
		end

	as_integer_8: INTEGER_8
			-- Convert `item' into an INTEGER_8 value.
		do
			Result := Precursor
		end

	as_integer_16: INTEGER_16
			-- Convert `item' into an INTEGER_16 value.
		do
			Result := Precursor
		end

	as_integer_32: INTEGER_32
			-- Convert `item' into an INTEGER_32 value.
		do
			Result := Precursor
		end

	as_integer_64: INTEGER_64
			-- Convert `item' into an INTEGER_64 value.
		do
			Result := Precursor
		end

	to_real: REAL_32
			-- Convert `item' into a REAL_32
		do
			Result := Precursor
		end

	to_double: REAL_64
			-- Convert `item' into a REAL_64
		do
			Result := Precursor
		end

	to_character_8: CHARACTER_8
			-- Associated character in 8 bit version.
		do
			Result := Precursor
		end

	to_character_32: CHARACTER_32
			-- Associated character in 32 bit version.
		do
			Result := Precursor
		end

feature -- Bit operations

	bit_and (i: INTEGER_64): INTEGER_64
			-- Bitwise and between Current' and `i'.
		do
			Result := Precursor (i)
		end

	bit_or (i: INTEGER_64): INTEGER_64
			-- Bitwise or between Current' and `i'.
		do
			Result := Precursor (i)
		end

	bit_xor (i: INTEGER_64): INTEGER_64
			-- Bitwise xor between Current' and `i'.
		do
			Result := Precursor (i)
		end

	bit_not: INTEGER_64
			-- One's complement of Current.
		do
			Result := Precursor
		end

	bit_shift_left (n: INTEGER): INTEGER_64
			-- Shift Current from `n' position to left.
		do
			Result := Precursor (n)
		end

	bit_shift_right (n: INTEGER): INTEGER_64
			-- Shift Current from `n' position to right.
		do
			Result := Precursor (n)
		end

end

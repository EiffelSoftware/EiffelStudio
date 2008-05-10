class REAL_32

feature -- Comparison

	infix "<" (other: REAL_32): BOOLEAN is
			-- Is `other' greater than current real?
		do
			Result := Precursor (other)
		end

feature -- Conversion

	truncated_to_integer: INTEGER_32 is
			-- Integer part (same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := Precursor
		end

	truncated_to_integer_64: INTEGER_64 is
			-- Integer part (same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := Precursor
		end

	to_double: REAL_64 is
			-- Current seen as a double
		do
			Result := Precursor
		end

	ceiling_real_32: REAL_32 is
			-- Smallest integral value no smaller than current object
		do
			Result := Precursor
		end

	floor_real_32: REAL_32 is
			-- Greatest integral value no greater than current object
		do
			Result := Precursor
		end

feature -- Basic operations

	infix "+" (other: REAL_32): REAL_32 is
			-- Sum with `other'
		do
			Result := Precursor (other)
		end

	infix "-" (other: REAL_32): REAL_32 is
			-- Result of subtracting `other'
		do
			Result := Precursor (other)
		end

	infix "*" (other: REAL_32): REAL_32 is
			-- Product by `other'
		do
			Result := Precursor (other)
		end

	infix "/" (other: REAL_32): REAL_32 is
			-- Division by `other'
		do
			Result := Precursor (other)
		end

	infix "^" (other: REAL_64): REAL_64 is
			-- Current real to the power `other'
		do
			Result := Precursor (other)
		end

	prefix "+": REAL_32 is
			-- Unary plus
		do
			Result := Precursor
		end

	prefix "-": REAL_32 is
			-- Unary minus
		do
			Result := Precursor
		end

feature -- Output

	out: STRING is
			-- Printable representation of real value
		do
			Result := Precursor
		end

end

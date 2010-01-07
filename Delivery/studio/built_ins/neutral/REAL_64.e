class REAL_64

feature -- Comparison

	is_less alias "<" (other: REAL_64): BOOLEAN is
			-- Is `other' greater than current double?
		do
			Result := Precursor (other)
		end

	infix "<" (other: REAL_64): BOOLEAN is
			-- Is `other' greater than current double?
		do
			Result := Precursor (other)
		end

feature -- Status report

	is_nan: BOOLEAN
		do
			Result := Precursor
		end

feature -- Conversion

	truncated_to_integer: INTEGER_32 is
			-- Integer part (Same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := Precursor
		end

	truncated_to_integer_64: INTEGER_64 is
			-- Integer part (Same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := Precursor
		end

	truncated_to_real: REAL_32 is
			-- Real part (Same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := Precursor
		end

	ceiling_real_64: REAL_64 is
			-- Smallest integral value no smaller than current object
		do
			Result := Precursor
		end

	floor_real_64: REAL_64 is
			-- Greatest integral value no greater than current object
		do
			Result := Precursor
		end

feature -- Basic operations

	plus alias "+" (other: REAL_64): REAL_64 is
			-- Sum with `other'
		do
			Result := Precursor (other)
		end

	minus alias "-" (other: REAL_64): REAL_64 is
			-- Result of subtracting `other'
		do
			Result := Precursor (other)
		end

	product alias "*" (other: REAL_64): REAL_64 is
			-- Product with `other'
		do
			Result := Precursor (other)
		end

	quotient alias "/" (other: REAL_64): REAL_64 is
			-- Division by `other'
		do
			Result := Precursor (other)
		end

	power alias "^" (other: REAL_64): REAL_64 is
			-- Current double to the power `other'
		do
			Result := Precursor (other)
		end

	identity alias "+": REAL_64 is
			-- Unary plus
		do
			Result := Precursor
		end

	opposite alias "-": REAL_64 is
			-- Unary minus
		do
			Result := Precursor
		end

	infix "+" (other: REAL_64): REAL_64 is
			-- Sum with `other'
		do
			Result := Precursor (other)
		end

	infix "-" (other: REAL_64): REAL_64 is
			-- Result of subtracting `other'
		do
			Result := Precursor (other)
		end

	infix "*" (other: REAL_64): REAL_64 is
			-- Product with `other'
		do
			Result := Precursor (other)
		end

	infix "/" (other: REAL_64): REAL_64 is
			-- Division by `other'
		do
			Result := Precursor (other)
		end

	infix "^" (other: REAL_64): REAL_64 is
			-- Current double to the power `other'
		do
			Result := Precursor (other)
		end

	prefix "+": REAL_64 is
			-- Unary plus
		do
			Result := Precursor
		end

	prefix "-": REAL_64 is
			-- Unary minus
		do
			Result := Precursor
		end

feature -- Output

	out: STRING is
			-- Printable representation of double value
		do
			Result := Precursor
		end

end	

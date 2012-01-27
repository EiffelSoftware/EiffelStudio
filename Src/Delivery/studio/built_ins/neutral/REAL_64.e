class REAL_64

feature -- Comparison

	is_less alias "<" (other: REAL_64): BOOLEAN
			-- Is `other' greater than current double?
		do
			Result := Precursor (other)
		end

	infix "<" (other: REAL_64): BOOLEAN
			-- Is `other' greater than current double?
		do
			Result := Precursor (other)
		end

feature -- Status report

	is_nan: BOOLEAN
		do
			Result := Precursor
		end

	is_negative_infinity: BOOLEAN
		do
			Result := Precursor
		end

	is_positive_infinity: BOOLEAN
		do
			Result := Precursor
		end

feature -- Conversion

	truncated_to_integer: INTEGER_32
			-- Integer part (Same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := Precursor
		end

	truncated_to_integer_64: INTEGER_64
			-- Integer part (Same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := Precursor
		end

	truncated_to_real: REAL_32
			-- Real part (Same sign, largest absolute
			-- value no greater than current object's)
		do
			Result := Precursor
		end

	ceiling_real_64: REAL_64
			-- Smallest integral value no smaller than current object
		do
			Result := Precursor
		end

	floor_real_64: REAL_64
			-- Greatest integral value no greater than current object
		do
			Result := Precursor
		end

feature -- Basic operations

	plus alias "+" (other: REAL_64): REAL_64
			-- Sum with `other'
		do
			Result := Precursor (other)
		end

	minus alias "-" (other: REAL_64): REAL_64
			-- Result of subtracting `other'
		do
			Result := Precursor (other)
		end

	product alias "*" (other: REAL_64): REAL_64
			-- Product with `other'
		do
			Result := Precursor (other)
		end

	quotient alias "/" (other: REAL_64): REAL_64
			-- Division by `other'
		do
			Result := Precursor (other)
		end

	power alias "^" (other: REAL_64): REAL_64
			-- Current double to the power `other'
		do
			Result := Precursor (other)
		end

	identity alias "+": REAL_64
			-- Unary plus
		do
			Result := Precursor
		end

	opposite alias "-": REAL_64
			-- Unary minus
		do
			Result := Precursor
		end

	infix "+" (other: REAL_64): REAL_64
			-- Sum with `other'
		do
			Result := Precursor (other)
		end

	infix "-" (other: REAL_64): REAL_64
			-- Result of subtracting `other'
		do
			Result := Precursor (other)
		end

	infix "*" (other: REAL_64): REAL_64
			-- Product with `other'
		do
			Result := Precursor (other)
		end

	infix "/" (other: REAL_64): REAL_64
			-- Division by `other'
		do
			Result := Precursor (other)
		end

	infix "^" (other: REAL_64): REAL_64
			-- Current double to the power `other'
		do
			Result := Precursor (other)
		end

	prefix "+": REAL_64
			-- Unary plus
		do
			Result := Precursor
		end

	prefix "-": REAL_64
			-- Unary minus
		do
			Result := Precursor
		end

feature -- Output

	out: STRING
			-- Printable representation of double value
		do
			Result := Precursor
		end

end	

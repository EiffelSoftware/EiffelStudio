class REAL_64

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than current double?
		do
			Result := Precursor (other)
		end

feature -- Conversion

	truncated_to_integer: INTEGER is
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

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			Result := Precursor (other)
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			Result := Precursor (other)
		end

	infix "*" (other: like Current): like Current is
			-- Product with `other'
		do
			Result := Precursor (other)
		end

	infix "/" (other: like Current): like Current is
			-- Division by `other'
		do
			Result := Precursor (other)
		end

	infix "^" (other: DOUBLE): DOUBLE is
			-- Current double to the power `other'
		do
			Result := Precursor (other)
		end

	prefix "+": like Current is
			-- Unary plus
		do
			Result := Precursor
		end

	prefix "-": like Current is
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

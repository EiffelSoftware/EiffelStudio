class POINTER

feature -- Access

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := Precursor
		end

feature -- Operations

	infix "+" (offset: INTEGER): POINTER is
			-- Pointer moved by an offset of `offset' bytes.
		do
			Result := Precursor (offset)
		end

feature -- Conversion

	to_integer_32: INTEGER_32 is
			-- Convert `item' into an INTEGER_32 value.
		do
			Result := Precursor
		end

feature -- Output

	out: STRING is
			-- Printable representation of pointer value
		do
			Result := Precursor
		end

end

class POINTER

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		do
			Result := Precursor
		end

feature -- Operations

	plus alias "+" (offset: INTEGER): POINTER
			-- Pointer moved by an offset of `offset' bytes.
		do
			Result := Precursor (offset)
		end

	infix "+" (offset: INTEGER): POINTER
			-- Pointer moved by an offset of `offset' bytes.
		do
			Result := Precursor (offset)
		end

feature -- Conversion

	to_integer_32: INTEGER_32
			-- Convert `item' into an INTEGER_32 value.
		do
			Result := Precursor
		end

feature -- Output

	out: STRING
			-- Printable representation of pointer value
		do
			Result := Precursor
		end

end

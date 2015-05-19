class TEST

create
	make

convert
	to_integer_8: {INTEGER_8},
	to_integer_32: {INTEGER_32}

feature {NONE} -- Creation

	make
		do
			Current.item (Current) := Current
			io.put_integer (value)
			io.put_new_line
			Current [Current] := Current
			io.put_integer (value)
			io.put_new_line
		end

feature -- Access

	item alias "[]" (i8: INTEGER_8): INTEGER_32 assign put
		do
			Result := value
		end

	to_integer_8: INTEGER_8 = 8

	to_integer_32: INTEGER_32 = 32

feature -- Modification

	put (v: INTEGER_32; i8: INTEGER_8)
		do
			value := v
		end

feature {NONE} -- Access

	value: INTEGER_32

end

class INT_VAL_B 

inherit

	INTERVAL_VAL_B
		redefine
			make_byte_code
		end

creation

	make

	
feature 

	value: INTEGER;

	make (i: INTEGER) is
		do
			value := i;
		end;

	infix "<" (other: INT_VAL_B): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := value < other.value;
		end;

	display (st: STRUCTURED_TEXT) is
		do
			st.add_int (value);
		end;

	generation_value: INTEGER is
			-- Value to generate
		do
			Result := value;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant in an
			-- interval
		do
			ba.append (Bc_int);
			ba.append_integer (value);
		end;

end

class CHAR_VAL_B 

inherit

	INTERVAL_VAL_B
		redefine
			make_byte_code
		end

creation

	make

	
feature 

	value: CHARACTER;
			-- Integer value

	generation_value: CHARACTER is
			-- Value to generate
		do
			Result := value;
		end;

	make (i: CHARACTER) is
		do
			value := i;
		end;

	infix "<" (other: CHAR_VAL_B): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := value < other.value;
		end;

	display (st: STRUCTURED_TEXT) is
		do
			st.add_char ('%'');
			st.add_char (value);
			st.add_char ('%'');
		end;

feature --- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a character constant in an
			-- interval
		do
			ba.append (Bc_char);
			ba.append (value);
		end;

end



class BITS_DESC 

inherit

	ATTR_DESC
		redefine
			is_bits
		end
	
feature 

	value: INTEGER;
			-- Bits value

	set_value (i: INTEGER) is
			-- Assign `i' to `value'.
		do
			value := i;
		end;

	is_bits: BOOLEAN is True;
			-- Is the attribute a bits one ?

	level: INTEGER is
			-- Level comparasion
		once
			Result := Bits_level;
		end;

	generate_code (file: UNIX_FILE) is
			-- Generate type code for current attribute description in
			-- file `file'.
		do
			file.putstring ("SK_BIT + ");
			file.putint (value);
		end;

	sk_value: INTEGER is
			-- Sk value
		do
--			Result := Sk_bit + value
			Result := 671088640 + value
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[BITS ");
			io.error.putint (value);
			io.error.putstring ("]");
		end;

end

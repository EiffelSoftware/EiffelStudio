

class BITS_DESC 

inherit

	ATTR_DESC
		redefine
			is_bits, same_as
		select
			same_as
		end;
	ATTR_DESC
		rename
			same_as as basic_same_as
		redefine
			is_bits
		end;
	
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

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_BIT + ");
			buffer.putint (value);
		end;

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_bits: BITS_DESC;
		do
			if basic_same_as (other) then
				other_bits ?= other;
				Result := other_bits.value = value
			end;
		end;

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_bit + value
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[BITS ");
			io.error.putint (value);
			io.error.putstring ("]");
		end;

end

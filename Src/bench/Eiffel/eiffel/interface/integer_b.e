-- Internal representation of class INTEGER

class INTEGER_B 

inherit
	CLASS_B
		rename
			make as basic_make
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

create
	make
	
feature -- Initialization

	make (l: CLASS_I; n: INTEGER) is
			-- Creation of basic class
		require
			good_argument: l /= Void
			valid_n: n = 8 or n = 16 or n =32 or n = 64
		do
			basic_make (l)
			size := n
		ensure
			size_set: size = n
		end

feature -- Property

	size: INTEGER
			-- `size' in bits of current representation of INTEGER.

feature -- Access

	actual_type: INTEGER_A is
			-- Actual integer type
		do
			inspect size
			when 8 then Result := Integer_8_type
			when 16 then Result := Integer_16_type
			when 32 then Result := Integer_type
			when 64 then Result := Integer_64_type
			end
		end;

	generate_cecil_value is
			-- Generate Cecil type value
		do
			inspect size
			when 8 then generation_buffer.putstring ("SK_INT8")
			when 16 then generation_buffer.putstring ("SK_INT16")
			when 32 then generation_buffer.putstring ("SK_INT32")
			when 64 then generation_buffer.putstring ("SK_INT64")
			end
		end;

	cecil_value: INTEGER is
			-- Cecil value
		do
			inspect size
			when 8 then Result := Sk_int8
			when 16 then Result := Sk_int16
			when 32 then Result := Sk_int32
			when 64 then Result := Sk_int64
			end
		end;

invariant
	correct_size: size = 8 or size = 16 or size = 32 or size = 64

end

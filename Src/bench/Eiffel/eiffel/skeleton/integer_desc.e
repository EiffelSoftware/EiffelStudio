indexing
	description: "Integer description"
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_DESC

inherit
	ATTR_DESC

create
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create instance of INTEGER_DESC represented on `n' bits.
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			size := n
		ensure
			size_set: size = n
		end
	
feature -- Access

	size: INTEGER
			-- Current is stored on `size' bits.

	level: INTEGER is
			-- Comparison criteria
		do
			inspect size
			when 8 then Result := Integer_8_level
			when 16 then Result := Integer_16_level
			when 32 then Result := Integer_32_level
			when 64 then Result := Integer_64_level
			end
		end

	sk_value: INTEGER is
		do
			inspect size
			when 8 then Result := Sk_int8
			when 16 then Result := Sk_int16
			when 32 then Result := Sk_int32
			when 64 then Result := Sk_int64
			end
		end
		
	type_i: TYPE_I is
			-- 
		do
			inspect size
			when 8 then Result := Int8_c_type
			when 16 then Result := Int16_c_type
			when 32 then Result := Long_c_type
			when 64 then Result := Int64_c_type
			end
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_INT")
			buffer.putint (size)
		end

feature -- Debug

	trace is
		do
			io.error.putstring (attribute_name)
			io.error.putstring ("[INTEGER_")
			io.error.putint (size)
			io.error.putstring ("]")
		end

invariant
	correct_size: size = 8 or size = 16 or size = 32 or size = 64

end

indexing
	description: "natural description"
	date: "$Date$"
	revision: "$Revision$"

class NATURAL_DESC

inherit
	ATTR_DESC

create
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create instance of NATURAL_DESC represented on `n' bits.
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
			when 8 then Result := natural_8_level
			when 16 then Result := natural_16_level
			when 32 then Result := natural_32_level
			when 64 then Result := natural_64_level
			end
		end

	sk_value: INTEGER is
			-- Skeleton characteristic value
		do
			inspect size
			when 8 then Result := Sk_uint8
			when 16 then Result := Sk_uint16
			when 32 then Result := Sk_uint32
			when 64 then Result := Sk_uint64
			end
		end
		
	type_i: TYPE_I is
			-- Corresponding TYPE_I instance
		do
			inspect size
			when 8 then Result := uint8_c_type
			when 16 then Result := uint16_c_type
			when 32 then Result := uint32_c_type
			when 64 then Result := uint64_c_type
			end
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.put_string ("SK_UINT")
			buffer.put_integer (size)
		end

feature -- Debug

	trace is
		do
			io.error.put_string (attribute_name)
			io.error.put_string ("[NATURAL_")
			io.error.put_integer (size)
			io.error.put_string ("]")
		end

invariant
	correct_size: size = 8 or size = 16 or size = 32 or size = 64

end

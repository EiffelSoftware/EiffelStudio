indexing
	description: "Double description"
	date: "$Date$"
	revision: "$Revision$"

class REAL_64_DESC 

inherit
	ATTR_DESC
		rename
			real_64_level as level,
			real64_c_type as type_i
		end
	
feature -- Access

	sk_value: INTEGER is
		do
			Result := Sk_real64
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.put_string ("SK_REAL64")
		end

feature -- Debug

	trace is
		do
			io.error.put_string (attribute_name)
			io.error.put_string ("[DOUBLE]")
		end

end

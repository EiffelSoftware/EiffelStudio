indexing
	description: "Pointer description"
	date: "$Date$"
	revision: "$Revision$"

class POINTER_DESC 

inherit
	ATTR_DESC
		rename
			Pointer_level as level,
			Pointer_c_type as type_i
		end
	
feature -- Access

	sk_value: INTEGER is
		do
			Result := Sk_pointer
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_POINTER")
		end

feature -- Debug

	trace is
		do
			io.error.putstring (attribute_name)
			io.error.putstring ("[POINTER]")
		end

end

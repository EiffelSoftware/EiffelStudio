indexing
	description: "Double description"
	date: "$Date$"
	revision: "$Revision$"

class DOUBLE_DESC 

inherit
	ATTR_DESC
		rename
			Double_level as level,
			Double_c_type as type_i
		end
	
feature -- Access

	sk_value: INTEGER is
		do
			Result := Sk_double
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_DOUBLE")
		end

feature -- Debug

	trace is
		do
			io.error.putstring (attribute_name)
			io.error.putstring ("[DOUBLE]")
		end

end

indexing
	description: "Boolean description"
	date: "$Date$"
	revision: "$Revision$"
	
class BOOLEAN_DESC 

inherit
	ATTR_DESC
		rename
			Boolean_level as level,
			Boolean_c_type as type_i
		end
	
feature -- Access

	sk_value: INTEGER is
		do
			Result := Sk_bool
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_BOOL");
		end;

feature -- Debug

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[BOOLEAN]");
		end;

end

class REFERENCE_DESC 

inherit
	ATTR_DESC
		rename
			Reference_level as level
		redefine
			is_reference
		end

feature 

	class_type_i: CL_TYPE_I;
			-- Class type of a reference attribute

	set_class_type_i (i: CL_TYPE_I) is
			-- Assign `i' to `class_type_i'.
		do
			class_type_i := i;
		ensure
			set: class_type_i = i
		end;

	sk_value: INTEGER is
		do
			Result := Sk_ref
		end

	is_reference: BOOLEAN is True;
			-- Is the attribute a reference ?

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_REF");
		end;

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[REFERENCE]");
		end;

end

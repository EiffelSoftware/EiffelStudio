class REFERENCE_DESC 

inherit

	ATTR_DESC
		redefine
			is_reference, real_sk_value
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

	is_reference: BOOLEAN is True;
			-- Is the attribute a reference ?

	level: INTEGER is
			-- Level descritpion
		once
			Result := Reference_level;
		end;

	generate_code (file: INDENT_FILE) is
			-- Generate type code for current attribute description in
			-- file `file'.
		do
			file.putstring ("SK_REF");
		end;

	sk_value: INTEGER is
			-- Sk value
		once
			Result := Sk_ref
		end;

	real_sk_value : INTEGER is
		do
			if class_type_i /= Void then
				Result := class_type_i.sk_value
			else
				Result := Sk_ref
			end
		end

	trace is
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("[REFERENCE]");
		end;

end

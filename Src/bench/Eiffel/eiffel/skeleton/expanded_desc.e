class EXPANDED_DESC 

inherit

	ATTR_DESC
		redefine
			is_expanded
		end
	
feature 

	class_type: CLASS_TYPE;
			-- Class type of the exapnded attribute

	set_class_type (i: CLASS_TYPE) is
			-- Assign `i' to `class_type'.
		do
			class_type := i;
		end;

	type_id: INTEGER is
			-- Type id of the expanded type of the attribute
		require
			class_type_exists: class_type /= Void
		do
			Result := class_type.type_id
		end;
			
	is_expanded: BOOLEAN is True;
			-- Is the attribute an expanded one ?

	generate_code (file: UNIX_FILE) is
			-- Generate type code for current attribute description in
			-- file `file'.
		do
			file.putstring ("SK_EXP + ");
			file.putint (type_id - 1);
		end;

	level: INTEGER is
			-- level comparison
		once
			Result := Expanded_level;
		end;

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_exp + type_id - 1;
		end;

	trace is
		do
			io.error.putstring ("[EXPANDED ");
			io.error.putstring (class_type.associated_class.class_name);
			io.error.putstring ("]");
		end;

end

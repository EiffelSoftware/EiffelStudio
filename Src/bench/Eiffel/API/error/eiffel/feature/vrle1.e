-- Error when a local variable name is a feature name also

class VRLE1 

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end;

feature

	local_name: STRING;
			-- Local variable name in conflict

	set_local_name (s: STRING) is
			-- Assign `s' to `local_name'.
		do
			local_name := s;
		end;

	code: STRING is "VRLE";
			-- Error code

	subcode: INTEGER is
		do
			Result := 1;
		end;

	build_explain is
		do
			put_string ("Local entity name: ");
			put_string (local_name);
			new_line;
		end;

end

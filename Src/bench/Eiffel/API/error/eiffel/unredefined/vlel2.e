-- A feature name of an export clause is not a final name of the parent

class VLEL2 

inherit

	VLEL
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is
		do
			Result := 2
		end;

	feature_name: STRING;
			-- Feature name involved

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

	build_explain is
		do
			put_string ("Invalid feature name: ");
			put_string (feature_name);
			new_line;
			print_parent;
		end;

end

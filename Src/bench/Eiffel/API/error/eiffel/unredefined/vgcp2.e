-- Error when a name of a creation clause is not a final name of the
-- associated class

class VGCP2 

inherit

	VGCP
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is 2;

	feature_name: STRING;
			-- Feature name repeated in the creation clause of the class
			-- of id `class_id'

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

	build_explain is
		do
			put_string ("Invalid creation procedure name: ");
			put_string (feature_name);
			new_line;
		end;

end

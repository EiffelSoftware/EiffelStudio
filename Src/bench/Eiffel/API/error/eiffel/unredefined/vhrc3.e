-- Error for unvalid renaming

class VHRC3 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;
	
feature 

	parent_id: INTEGER;
			-- Id of the invloved parent

	feature_name: STRING;
			-- Feature name renamed as itself

	code: STRING is "VHRC";
			-- Error for unvalid renaming

	set_parent_id (i: INTEGER) is
			-- Assgn `i' to `parent_id'.
		do
			parent_id := i;
		end;

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

	build_explain is
		do
			put_string ("%TRename clause of ");
			put_string (feature_name);
			put_string (":%N%TRenaming a feature as itself is not valid%N");
		end;

end

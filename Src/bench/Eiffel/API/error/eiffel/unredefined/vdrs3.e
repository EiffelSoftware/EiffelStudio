-- Error when a feature name is twice in a redefine clause

class VDRS3 

inherit

	EIFFEL_ERROR
		redefine
			subcode, build_explain
		end;

feature 

	parent_name: STRING;
			-- Parent

	feature_name: STRING;
			-- Feature name node

	set_parent_name (p: STRING) is
		do
			parent_name := p;
		end;

	set_feature_name (f: STRING) is
			-- Assign `f' to `feature_name'.
		do
			feature_name := f;
		end;

	code: STRING is
			-- Error code
		do
			Result := "VDRS";
		end;

	subcode: INTEGER is
		do
			Result := 3;
		end;

	build_explain is
		do
			put_string ("Duplicate name: ");
			put_string (feature_name);
			put_string ("%NIn Redefine clause for parent: ");
			put_string (parent_name);
			new_line;
		end;

end

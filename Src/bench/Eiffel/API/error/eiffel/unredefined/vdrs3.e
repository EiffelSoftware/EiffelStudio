indexing

	description: 
		"Error when a feature name is twice in a redefine clause.";
	date: "$Date$";
	revision: "$Revision $"

class VDRS3 

inherit

	EIFFEL_ERROR
		redefine
			subcode, build_explain
		end;

feature -- Properties

	parent_name: STRING;
			-- Parent

	feature_name: STRING;
			-- Feature name node

	code: STRING is
			-- Error code
		do
			Result := "VDRS";
		end;

	subcode: INTEGER is
		do
			Result := 3;
		end;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Duplicate name: ");
			ow.put_string (feature_name);
			ow.put_string ("%NIn Redefine clause for parent: ");
			ow.put_string (parent_name);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_parent_name (p: STRING) is
		do
			parent_name := p;
		end;

	set_feature_name (f: STRING) is
			-- Assign `f' to `feature_name'.
		do
			feature_name := f;
		end;

end -- class VDRS3

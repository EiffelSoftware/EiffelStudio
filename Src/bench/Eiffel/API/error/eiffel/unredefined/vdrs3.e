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
		once
			Result := "VDRS";
		end;

	subcode: INTEGER is
		do
			Result := 3;
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Duplicate name: ");
			st.add_string (feature_name);
			st.add_new_line;
			st.add_string ("In Redefine clause for parent: ");
			st.add_string (parent_name);
			st.add_new_line;
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

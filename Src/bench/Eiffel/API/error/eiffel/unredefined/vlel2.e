indexing

	description: 
		"A feature name of an export clause is not a final %
		%name of the of the parent.";
	date: "$Date$";
	revision: "$Revision $"

class VLEL2 

inherit

	VLEL
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is
		do
			Result := 2
		end;

	feature_name: STRING;
			-- Feature name involved

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Invalid feature name: ");
			st.add_string (feature_name);
			st.add_new_line;
			print_parent (st);
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

end -- class VLEL2

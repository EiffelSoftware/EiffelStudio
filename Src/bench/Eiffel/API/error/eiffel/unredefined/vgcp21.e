indexing

	description: 
		"Error when a creation procedure is not a procedure or %
		%a once procedure.";
	date: "$Date$";
	revision: "$Revision $"

class VGCP21 

inherit

	VGCP
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is
		do
			Result := 2;
		end;

	creation_feature: STRING;
			-- Feature involved

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Creation procedure name: ");
			st.add_string (creation_feature);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (s: STRING) is
			-- Assign `f' to `creation_feature'.
		do
			creation_feature := s;
		end;

end -- class VGCP21

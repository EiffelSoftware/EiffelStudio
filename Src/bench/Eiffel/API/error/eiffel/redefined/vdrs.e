indexing

	description: 
		"Error when the compiler cannot find a final name for a redefinition.";
	date: "$Date$";
	revision: "$Revision $"

class VDRS
	
inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end
	
feature -- Properties

	parent_id: INTEGER;
			-- Parent id

	feature_name: STRING;
			-- Feature name involved

	code: STRING is "VDRS";

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
            -- Build specific explanation explain for current error
            -- in `st'.
        do
			st.add_string ("%TFeature: ");
			st.add_string (feature_name);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (fn: STRING) is
			-- Assign `fn' to `feature_name'.
		do
			feature_name := fn;
		end;

	set_parent_id (i: INTEGER) is
			-- Assign `i' to `parent_id'.
		do
			parent_id := i;
		end;

end -- class VDRS

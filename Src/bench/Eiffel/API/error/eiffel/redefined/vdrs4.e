indexing

	description: 
		"Error when the compiler cannot find an effective redefinition.";
	date: "$Date$";
	revision: "$Revision $"

class VDRS4 
	
inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end

feature -- Properties

	feature_name: STRING;
			-- Feature name involved

	code: STRING is "VDRS";
			-- Error code

	subcode: INTEGER is 4;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Feature name: ");
			st.add_string (feature_name);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (fn: STRING) is
			-- Assign `fn' to `feature_name'.
		do
			feature_name := fn;
		end;

end -- class VDRS4

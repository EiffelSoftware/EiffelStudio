indexing

	description: 
		"Error for a root class having bad creation procedure arguments.";
	date: "$Date$";
	revision: "$Revision $"

class VSRC3

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end;

feature -- Properties

	code: STRING is "VSRC";

	subcode: INTEGER is 3;

	creation_feature: E_FEATURE;
			-- Creation procedure name involved in the error

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				creation_feature /= Void
		ensure then
			valid_creation_feature: Result implies creation_feature /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Creation feature: ");
			creation_feature.append_signature (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_creation_feature (f: FEATURE_I) is
			-- Assign `s' to `creation_name'.
		require
			valid_f: f /= Void
		do
			creation_feature := f.api_feature (f.written_in);
		end;

end -- class VSRC3

indexing

	description: 
		"Error when argument name is also a feature name.";
	date: "$Date$";
	revision: "$Revision $"

class VRFA 

inherit

	FEATURE_ERROR
		redefine
			build_explain, is_defined
		end;
	
feature -- Properties

	other_feature: E_FEATURE;
			-- Argument name violating the VRFA rule

	code: STRING is "VRFA";
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				other_feature /= Void
		ensure then
			valid_other_feature: Result implies other_feature /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Formal argument name: ");
			st.add_string (other_feature.name);
			st.add_string (" is defined as a feature: ");
			other_feature.append_signature (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_other_feature (f: FEATURE_I) is
		require
			valid_f: f /= Void
		do
			other_feature := f.api_feature (f.written_in)
		end;

end -- class VRFA

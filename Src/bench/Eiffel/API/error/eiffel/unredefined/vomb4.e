indexing

	description: 
		"Error when there is two unique with the same name involved %
		%in a inspect instruction.";
	date: "$Date$";
	revision: "$Revision $"

class VOMB4 

inherit

	VOMB
		redefine
			subcode, build_explain, is_defined
		end

feature -- Properties

	subcode: INTEGER is 4;

	unique_feature: E_FEATURE;
			-- Unique feature name

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				unique_feature /= Void
		ensure then
			valid_unique_feature: Result implies unique_feature /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Duplicate name: ");
			unique_feature.append_name (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_unique_feature (f: FEATURE_I) is
			-- Assign `s' to `unique_name'.
		require
			valid_f: f /= Void
		do
			unique_feature := f.api_feature (f.written_in);
		end;

end -- class VOMB4

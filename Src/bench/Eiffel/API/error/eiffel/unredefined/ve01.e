indexing

	description: 
		"Error when an external is redefined into a non-external feature or %
		%when a non-external one is redefined into an external feature.";
	date: "$Date$";
	revision: "$Revision $"

class VE01 obsolete "NOT DEFINED IN THE BOOK"

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode, is_defined
		end;

feature -- Properties

	old_feature: E_FEATURE;
			-- Features involved in the error

	code: STRING is "VDRD";
			-- Error code

	subcode: INTEGER is 7

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				old_feature /= Void
		ensure then
			valid_old_feature: Result implies old_feature /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		local
			wclass: CLASS_C
		do
			wclass := old_feature.written_class;
			st.add_string ("Redeclared routine: ");
			old_feature.append_name (st);
			st.add_string (" from ");
			wclass.append_name (st);
			if old_feature.is_external then
				st.add_string (" is an external routine")
			else
				st.add_string (" is not an external routine")
			end;
			st.add_new_line
		end;

feature {COMPILER_EXPORTER}

	set_old_feature (f: FEATURE_I) is
			-- Assign `f' to `feature2'.
		require
			valid_f: f /= Void
		do
			old_feature := f.api_feature (f.written_in);
		end;

end -- class VE01

indexing

	description: 
		"Error that occured within a feature.";
	date: "$Date$";
	revision: "$Revision $"

deferred class FEATURE_ERROR 

inherit

	EIFFEL_ERROR
		redefine
			trace, is_defined
		end;

feature -- Properties

	e_feature: E_FEATURE;
			-- Feature involved in the error

	feature_name: STRING;
			-- If e_feature is Void then use feature name 
			-- (if this is Void then feature occurred in
			-- the invariant)

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined
		ensure then
			is_feature_defined: Result implies is_feature_defined
		end;

	is_feature_defined: BOOLEAN is
			-- Is the feature defined for error?
		do
			Result := True
		ensure
			always_true: Result
		end;

feature -- Output

	trace (st: STRUCTURED_TEXT) is
		do
			print_error_message (st);
			st.add_string ("Class: ");
			e_class.append_signature (st);
			st.add_new_line;
			if e_feature /= Void then
				st.add_string ("Feature: ");
				e_feature.append_name (st);
			elseif feature_name /= Void then
				st.add_string ("Feature: ");
				st.add_string (feature_name);
			else
				st.add_string ("Feature: invariant");
			end;
			st.add_new_line;
			build_explain (st)
		end;

feature {COMPILER_EXPORTER}

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `feature'.
		require
			valid_f: f /= Void;
			non_void_e_class: e_class /= Void
		do
			e_feature := f.api_feature (e_class.id)
		end;

end -- class FEATURE_ERROR

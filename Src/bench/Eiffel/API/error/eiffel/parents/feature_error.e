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
			Result := e_feature /= Void
		ensure
			yes_implies_valid_feature: Result implies e_feature /= Void
		end;

feature -- Output

	trace (ow: OUTPUT_WINDOW) is
		do
			print_error_message (ow);
			ow.put_string ("Class: ");
			e_class.append_signature (ow);
			ow.put_string ("%NFeature: ");
			e_feature.append_name (ow, e_class);
			ow.new_line;
			build_explain (ow);
		end;

feature {COMPILER_EXPORTER}

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `feature'.
		require
			valid_f: f /= Void
		do
			e_feature := f.api_feature
		end;

end -- class FEATURE_ERROR

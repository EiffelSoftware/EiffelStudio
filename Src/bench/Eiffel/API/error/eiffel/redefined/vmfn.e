indexing

	description: 
		"Name clash of features.";
	date: "$Date$";
	revision: "$Revision $"

class VMFN 

inherit
	
	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end

feature -- Properties

	a_feature: E_FEATURE;
			-- Feature implemented in the class of id `class_id'
			-- responsible for the name clash

	other_feature: E_FEATURE;
			-- Inherited feature


	code: STRING is "VMFN";
			-- Error code
feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				a_feature /= Void and then
				other_feature /= Void
		ensure then
			valid_a_feature: Result implies a_feature /= Void;
			valid_other_feature: Result implies other_feature /= Void
		end

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		do
			ow.put_string ("Feature: ");
			a_feature.append_signature (ow, a_feature.written_class);
			ow.put_string (" Version from: ");
			a_feature.written_class.append_name (ow);
			ow.put_string ("%NFeature: ");
			other_feature.append_signature (ow, other_feature.written_class);
			ow.put_string (" Version from: ");
			other_feature.written_class.append_name (ow);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER}

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		require
			valid_f: f /= Void
		do
			a_feature := f.api_feature (f.written_in);
		end;

	set_other_feature (f: FEATURE_I) is
			-- Assign `f' to `other_feature'.
		require
			valid_f: f /= Void
		do
			other_feature := f.api_feature (other_feature.written_in);
		end;

end -- class VMFN

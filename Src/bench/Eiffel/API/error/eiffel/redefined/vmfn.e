-- Name clash of features

class VMFN 

inherit
	
	EIFFEL_ERROR
		redefine
			build_explain
		end

feature

	a_feature: FEATURE_I;
			-- Feature implemented in the class of id `class_id'
			-- responsible for the name clash

	other_feature: FEATURE_I;
			-- Inherited feature

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f;
		end;

	set_other_feature (f: FEATURE_I) is
			-- Assign `f' to `other_feature'.
		do
			other_feature := f;
		end;

	code: STRING is "VMFN";
			-- Error code

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

end

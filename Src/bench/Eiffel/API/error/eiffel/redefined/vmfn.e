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

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("Feature: ");
			a_feature.append_clickable_signature (error_window, a_feature.written_class);
			put_string (" written in: ");
			a_feature.written_class.append_clickable_name (error_window);
			put_string ("%NFeature: ");
			other_feature.append_clickable_signature (error_window, other_feature.written_class);
			put_string (" written in: ");
			other_feature.written_class.append_clickable_name (error_window);
			new_line;
		end;

end

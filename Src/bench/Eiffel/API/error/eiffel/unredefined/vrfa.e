-- Error when argument name is also a feature name

class VRFA 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;
	
feature 

	other_feature: FEATURE_I;
			-- Argument name violating the VRFA rule

	code: STRING is "VRFA";
			-- Error code

	set_other_feature (f: FEATURE_I) is
		do
			other_feature := f
		end;

	build_explain is
		do
			put_string ("Formal argument name: ");
			put_string (other_feature.feature_name);
			put_string (" is defined as a feature: ");
			other_feature.append_clickable_signature (error_window, other_feature.written_class);
			new_line;
		end;

end

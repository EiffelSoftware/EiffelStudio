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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Formal argument name: ");
			ow.put_string (other_feature.feature_name);
			ow.put_string (" is defined as a feature: ");
			other_feature.append_signature (ow, other_feature.written_class);
			ow.new_line;
		end;

end

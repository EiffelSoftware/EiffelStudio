-- Error for a feature call

class VUAR 

inherit

	FEATURE_ERROR
	
feature 

	called_feature: FEATURE_I;

	set_called_feature (f: FEATURE_I) is
		do
			called_feature := f;
		end;

	code: STRING is "VUAR";

	print_called_feature is
		local
			c_class: CLASS_C
		do
			c_class := called_feature.written_class;
			put_string ("Called feature: ");
			called_feature.append_clickable_signature (error_window, c_class);
			put_string (" written in ");
			c_class.append_clickable_name (error_window);
			new_line;
		end;

end

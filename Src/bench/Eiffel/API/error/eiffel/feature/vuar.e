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

	print_called_feature (ow: OUTPUT_WINDOW) is
		local
			c_class: CLASS_C
		do
			c_class := called_feature.written_class;
			ow.put_string ("Called feature: ");
			called_feature.append_signature (ow, c_class);
			ow.put_string (" from ");
			c_class.append_name (ow);
			ow.new_line;
		end;

end

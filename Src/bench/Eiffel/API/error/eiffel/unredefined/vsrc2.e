-- Error for a root class having bad creation procedure arguments

class VSRC2 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end;

feature

	code: STRING is "VSRC";

	subcode: INTEGER is 2;
	
feature

	creation_feature: FEATURE_I;
			-- Creation procedure name involved in the error

	set_creation_feature (f: FEATURE_I) is
			-- Assign `s' to `creation_name'.
		do
			creation_feature := f;
		end;

	build_explain is
		do
			put_string ("Creation feature: ");
			creation_feature.append_clickable_signature (error_window,
				creation_feature.written_class);
			new_line;
		end;

end

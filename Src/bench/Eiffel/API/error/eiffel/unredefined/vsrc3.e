-- Error for a root class having bad creation procedure arguments

class VSRC3

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end;

feature

	code: STRING is "VSRC";

	subcode: INTEGER is 3;

feature

	creation_feature: FEATURE_I;
			-- Creation procedure name involved in the error

	set_creation_feature (f: FEATURE_I) is
			-- Assign `s' to `creation_name'.
		do
			creation_feature := f;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Creation feature: ");
			creation_feature.append_signature (ow,
				creation_feature.written_class);
			ow.new_line;
		end;

end

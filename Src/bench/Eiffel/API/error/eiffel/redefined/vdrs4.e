-- Error when the compiler cannot find an effective redefinition

class VDRS4 
	
inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end

feature 

	feature_name: STRING;
			-- Feature name involved

	set_feature_name (fn: STRING) is
			-- Assign `fn' to `feature_name'.
		do
			feature_name := fn;
		end;

	code: STRING is "VDRS";
			-- Error code

	subcode: INTEGER is 4;

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		do
			ow.put_string ("Feature name: ");
			ow.put_string (feature_name);
			ow.new_line;
		end;

end

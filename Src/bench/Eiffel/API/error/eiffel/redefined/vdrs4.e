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

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("Feature name: ");
			put_string (feature_name);
			new_line;
		end;

end

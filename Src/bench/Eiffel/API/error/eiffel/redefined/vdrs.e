-- Error when the compiler cannot find a final name for a redefinition

class VDRS
	
inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end
	
feature 

	parent_id: INTEGER;
			-- Parent id

	feature_name: STRING;
			-- Feature name involved

	set_feature_name (fn: STRING) is
			-- Assign `fn' to `feature_name'.
		do
			feature_name := fn;
		end;

	set_parent_id (i: INTEGER) is
			-- Assign `i' to `parent_id'.
		do
			parent_id := i;
		end;

	code: STRING is "VDRS";

	build_explain (ow: OUTPUT_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `ow'.
        do
			ow.put_string ("%TFeature: ");
			ow.put_string (feature_name);
			ow.new_line;
		end;

end

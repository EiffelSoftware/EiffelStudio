-- Error when the compiler cannot find a final name for a redefinition

class VDRS1 
	
inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
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

	code: STRING is 
			-- Error code
		do
			Result := "VDRS";
		end;

	subcode: INTEGER is 1;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("%Tfeature: ");
			put_string (feature_name);
			new_line;
		end;

end

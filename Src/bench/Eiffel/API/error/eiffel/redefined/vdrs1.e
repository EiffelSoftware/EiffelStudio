class VDRS1 
	
inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end
	
feature 

	parent: CLASS_C;
			-- Parent

	feature_name: STRING;
			-- Feature name involved

	set_feature_name (fn: STRING) is
			-- Assign `fn' to `feature_name'.
		do
			feature_name := fn;
		end;

	set_parent (p: CLASS_C) is
		do
			parent := p;
		end;

	code: STRING is 
			-- Error code
		do
			Result := "VDRS";
		end;

	subcode: INTEGER is 1;

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		do
			ow.put_string ("Invalid feature name: ");
			ow.put_string (feature_name);
			ow.put_string ("%NIn Redefine clause for parent: ");
			parent.append_name (ow);
			ow.new_line;
		end;

end

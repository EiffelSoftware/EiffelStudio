-- Error when the compiler find a redefinition of a frozen feature
-- or a constant-attribute

class VDRS2 
	
inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end
	
feature 

	feature_name: STRING;
			-- Feature name involved

	parent: CLASS_C;
			-- Parent class involving the non-valid
			-- redefinition

	set_feature_name (fn: STRING) is
			-- Assign `fn' to `feature_name'.
		do
			feature_name := fn;
		end;

	set_parent (p: CLASS_C) is
		do
			parent := p;
		end;

	code: STRING is "VDRS";
			-- Error code

	subcode: INTEGER is 2;

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		do
			ow.put_string ("Feature name: ");
			ow.put_string (feature_name);
			ow.put_string ("%NIn Redefine clause for parent: ");
			parent.append_name (ow);
			ow.new_line;
		end;

end

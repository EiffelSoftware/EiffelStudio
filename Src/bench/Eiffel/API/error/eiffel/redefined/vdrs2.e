-- Error when the compiler find a redefinition of a frozen feature
-- or a constant-attribute

class VDRS2 
	
inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select		
			build_explain
		end
	
feature 

	feature_name: STRING;
			-- Feature name involved

	body_id: INTEGER;
			-- Body id of the feature redefined

	parent_id: INTEGER;
			-- Parent id of the parent class involving the non-valid
			-- redefinition

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

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

	code: STRING is "VDRS";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
            old_build_explain (a_clickable);
			io.error.putstring ("%Tfeature name: ");
			io.error.putstring (feature_name);
			io.error.new_line;
		end;

end

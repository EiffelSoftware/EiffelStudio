-- Error when the compiler cannot find a final name for a redefinition

class VDRS1 
	
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

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
            old_build_explain (a_clickable);
			a_clickable.put_string ("%Tfeature: ");
			a_clickable.put_string (feature_name);
			a_clickable.new_line;
		end;

end

-- Error for useless selections

class VMSS2 

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
			-- Feature name selected

	parent_id: INTEGER;
			-- Class id of the involved parent

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

	set_parent_id (i: INTEGER) is
			-- Assign `i' to `parent_id'.
		do
			parent_id := i;
		end;

	code: STRING is "VMSS";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
            old_build_explain (a_clickable);
			a_clickable.put_string ("%Tfeature: ");
-- FIXME 
			a_clickable.put_string (feature_name);
			a_clickable.put_string (" in parent ");
			System.class_of_id (parent_id).append_clickable_signature (a_clickable);
			a_clickable.new_line;
		end;

end

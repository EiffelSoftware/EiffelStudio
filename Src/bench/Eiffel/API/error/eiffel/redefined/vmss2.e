-- Error for useless selections

class VMSS2 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
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

	subcode: INTEGER is 2;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("%Tfeature: ");
-- FIXME 
			put_string (feature_name);
			put_string (" in parent ");
			System.class_of_id (parent_id).append_clickable_signature (error_window);
			new_line;
		end;

end

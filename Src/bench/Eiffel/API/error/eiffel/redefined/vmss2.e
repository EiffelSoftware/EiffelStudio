-- Error for useless selections

class VMSS2 obsolete "NOT DEFINED IN THE BOOK%N%
			%VMSS2 is in fact in class VMSS3"

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end
	
feature 

	feature_name: STRING;
			-- Feature name selected

	parent: CLASS_C;
			-- Class id of the involved parent

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

	set_parent (c: CLASS_C) is
			-- Assign `i' to `parent_id'.
		do
			parent := c;
		end;

	code: STRING is "VMSS";
			-- Error code

	subcode: INTEGER is
		do
			Result := 2
		end;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("Feature name: ");
			put_string (feature_name);
			put_string ("%NIn Select subclause for parent: ");
			parent.append_clickable_signature (error_window);
			new_line;
		end;

end

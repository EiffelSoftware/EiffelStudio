indexing

	description: 
		"Error for useless selections. The selection is not needed or there are two %
		%different selection of the same feature.";
	date: "$Date$";
	revision: "$Revision $"

class VMSS2 obsolete "NOT DEFINED IN THE BOOK%N%
			%VMSS2 is in fact in class VMSS3"

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end
	
feature -- Properties

	feature_name: STRING;
			-- Feature name selected

	parent: CLASS_C;
			-- Class id of the involved parent

	code: STRING is "VMSS";
			-- Error code

	subcode: INTEGER is
		do
			Result := 3
		end;

feature -- Access

    is_defined: BOOLEAN is
            -- Is the error fully defined?
        do
			Result := is_class_defined and then
				parent /= Void and then
				feature_name /= Void
		ensure then
			valid_parent: Result implies parent /= Void;
			valid_feature_name: Result implies feature_name /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Feature name: ");
			st.add_string (feature_name);
			st.add_new_line;
			st.add_string ("In Select subclause for parent: ");
			parent.append_signature (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		require
			valid_s: s /= Void
		do
			feature_name := s;
		end;

	set_parent (c: CLASS_C) is
			-- Assign `i' to `parent_id'.
		require
			valid_c: c /= Void
		do
			parent := c
		end;

end -- class VMSS2

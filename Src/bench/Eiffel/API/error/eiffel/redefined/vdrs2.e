indexing

	description: 
		"Error when the compiler find a redefinition of a frozen feature %
		%or a constant-attribute";
	date: "$Date$";
	revision: "$Revision $"

class VDRS2 
	
inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end
	
feature -- Properties

	feature_name: STRING;
			-- Feature name involved

	parent: CLASS_C;
			-- Parent class involving the non-valid
			-- redefinition

	code: STRING is "VDRS";
			-- Error code

	subcode: INTEGER is 2;

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
			st.add_string ("In Redefine clause for parent: ");
			parent.append_name (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_feature_name (fn: STRING) is
			-- Assign `fn' to `feature_name'.
		do
			feature_name := fn;
		end;

	set_parent (p: CLASS_C) is
		require
			valid_p: p /= Void
		do
			parent := p
		end;

end -- class VDRS2

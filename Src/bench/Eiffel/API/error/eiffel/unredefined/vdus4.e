indexing

	description: 
		"Error when there is twice or more a feature name %
		%in an undefining clause.";
	date: "$Date$";
	revision: "$Revision $"

class VDUS4 

inherit

	VDRS3
		redefine
			code, subcode, build_explain
		end
	
feature -- Properties

	code: STRING is "VDUS";
			-- Error code

	subcode: INTEGER is 4;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Duplicate name: ");
			st.add_string (feature_name);
			st.add_string ("%NIn Undefine clause for parent: ");
			st.add_string (parent_name);
			st.add_new_line;
		end;

end -- class VDUS4

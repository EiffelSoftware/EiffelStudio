indexing

	description: 
		"Error when a feature name in an undefining clause is not %
		%a final name of the associated parent.";
	date: "$Date$";
	revision: "$Revision $"

class VDUS1 

inherit

	VDRS1
		redefine
			code, build_explain
		end
	
feature -- Properties

	code: STRING is "VDUS";
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Invalid feature name: ");
			st.add_string (feature_name);
			st.add_new_line;
			st.add_string ("In Undefine clause for parent: ");
			parent.append_name (st);
			st.add_new_line;
		end;

end -- class VDUS1

indexing

	description: 
		"Error when the target of an assignment or a reverse %
		%assignment is not a writable one or is of NONE type.";
	date: "$Date$";
	revision: "$Revision $"

class VE03 obsolete "NOT IN THE BOOK"

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature

	target: ACCESS_AS;
			-- Target of attachment involved in the error

	set_target (t: ACCESS_AS) is
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	code: STRING is "VJAW";
			-- Error code

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Target: ");
			st.add_string (target.access_name);
			st.add_new_line;
		end;

end -- class VE03

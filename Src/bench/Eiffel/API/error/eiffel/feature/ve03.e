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

	target: ACCESS_AS_B;
			-- Target of attachment involved in the error

	set_target (t: ACCESS_AS_B) is
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	code: STRING is "VJAW";
			-- Error code

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Target: ");
			ow.put_string (target.access_name);
			ow.new_line;
		end;

end -- class VE03

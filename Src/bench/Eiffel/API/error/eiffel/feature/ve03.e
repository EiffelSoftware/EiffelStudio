-- Error when the target of an assignment or a reverse assignment is not
-- a writable one or is of NONE type

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

	build_explain is
		do
			put_string ("Target: ");
			put_string (target.access_name);
			new_line;
		end;

end

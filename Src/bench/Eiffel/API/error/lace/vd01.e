-- Error for an unexisting cluster path, or a cluster path which doesn't
-- correpond to a directory or a readable directory

class VD01

inherit

	ERROR
		redefine
			build_explain
		end;

feature

	path: STRING;
			-- Unvalid path

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	code: STRING is "VD01";	
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string (path);
			a_clickable.put_string (" is not a valid path%N");
		end;

end

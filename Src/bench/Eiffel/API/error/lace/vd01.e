-- Error for an unexisting cluster path, or a cluster path which doesn't
-- correpond to a directory or a readable directory

class VD01

inherit

	ERROR

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

end

-- Error when two local variables (or more) have the same name

class VRLE2 

inherit

	FEATURE_ERROR
	
feature 

	local_name: ID_AS;
			-- Local variable name in conflict

	set_local_name (s: like local_name) is
			-- Assign `s' to `local_name'.
		do
			local_name := s;
		end;

	code: STRING is "VRLE";
			-- Error code

end

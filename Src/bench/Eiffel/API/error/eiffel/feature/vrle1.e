-- Error when a local variable name is a feature name also

class VRLE1 

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

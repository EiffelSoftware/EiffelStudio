-- Error when a local entity is used in a precondition or a postcondition

class VEEN2B 

inherit

	FEATURE_ERROR
	
feature 

	local_name: STRING;
			-- Local variable name

	set_local_name (s: STRING) is
			-- Assing `s' to `local_name'.
		do
			local_name := s;
		end;

	code: STRING is "VEEN2B";
			-- Error code

end

-- Error for unvalid reverse assignment attempt

class VJRV 

inherit

	FEATURE_ERROR
	
feature 

	target_type: TYPE_A;
			-- Target type

	set_target_type (t: TYPE_A) is
			-- Assign `t' to `target_type'.
		do
			target_type := t;
		end; -- set_target_type

	code: STRING is "VJRV";
			-- Error code

end 

-- Error when the target of an assignment or a reverse assignment is not
-- a writable one or is of NONE type

class VE03 

inherit

	FEATURE_ERROR
	
feature

	target: ACCESS_AS;
			-- Target of attachment involved in the error

	set_target (t: ACCESS_AS) is
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	code: STRING is "VE03";
			-- Error code

end

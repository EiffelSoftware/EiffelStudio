-- Error for join rule when the types are not the same

class VDJR1 

inherit

	VDJR
		redefine
			subcode
		end;

feature

	subcode: INTEGER is
		do
			Result := 1
		end;

feature

	type: TYPE_A;
			-- Type of `new_feature'

	old_type: TYPE_A;
			-- Type of `old_feature'

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	set_old_type (t: TYPE_A) is
			-- Assign `t' to `old_type'.
		do
			old_type := t;
		end;

end

-- Error for a rename clause where the old name appears more than once
-- in rename clauses

class VHRC2 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature 

	parent: PARENT_AS;
			-- Parent where the conflict appears

	conflict_name: FEATURE_NAME;
			-- Old confict name of the rename clause

	code: STRING is "VHRC";
			-- Error code

	subcode:INTEGER is 2;

	set_parent (p: PARENT_AS) is
			-- Assign `p' to `parent'.
		do
			parent := p;
		end;

	set_conflict_name (n: FEATURE_NAME) is
			-- Assign `n' to `conflict_name'.
		do
			conflict_name := n;
		end;

end

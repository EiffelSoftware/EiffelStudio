-- Error for violation of the constrained genericity rule by a parent type

class VTGG4 

inherit

	VTGG
	
feature 

	parent_type: CL_TYPE_A;
			-- Parent type involved in the error

	set_parent_type (p: CL_TYPE_A) is
			-- Assign `p' to `parent_type'.
		do
			parent_type := p;
		end;

end

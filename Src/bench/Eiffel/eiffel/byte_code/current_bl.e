-- Enlarged access to Current

class CURRENT_BL 

inherit

	CURRENT_B
		redefine
			parent, generate, set_parent, used,
			analyze, free_register, propagate
		end;
	
feature 

	parent: NESTED_BL;
			-- Parent of access
	
	set_parent (p: NESTED_BL) is
			-- Assign `p' to `parent'
		do
			parent := p;
		end;

	propagate (r: REGISTRABLE) is
			-- Do nothing
		do
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' the "Current" entity ?
		do
			Result := r.is_current;
		end;

	analyze is
			-- Mark current as used
		do
			context.mark_current_used
		end;

	generate is
			-- Do nothing
		do
		end;

	free_register is
			-- Do nothing
		do
		end;

end

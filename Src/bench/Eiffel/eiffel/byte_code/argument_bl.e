-- Enlarged access to an argument

class ARGUMENT_BL 

inherit

	ARGUMENT_B
		redefine
			analyze, generate, free_register,
			used, parent, set_parent, propagate
		end;

feature 

	parent: NESTED_BL;
			-- Parent of access
	
	set_parent (p: NESTED_BL) is
			-- Set `parent' to `p'
		do
			parent := p;
		end;

	propagate (r: REGISTRABLE) is
			-- Do nothing
		do
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' the same as us ?
		local
			argument_b: ARGUMENT_B;
		do
			if r.is_argument then
				argument_b ?= r;	-- Cannot fail
				if argument_b.position = position then
					Result := true;
				end;
			end;
		end;

	fill_from (l: ARGUMENT_B) is
			-- Fill in node from local `l'
		do
			position := l.position;
		end;

	analyze is
			-- Compute an index in the local variable array if type is pointer
		do
			if c_type.is_pointer then
				context.set_local_index (register_name, Current);
			end;
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

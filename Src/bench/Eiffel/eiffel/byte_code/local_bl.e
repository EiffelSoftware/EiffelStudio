-- Enlarged access to a local

class LOCAL_BL 

inherit

	LOCAL_B
		redefine
			type, free_register,
			analyze, generate, propagate,
			used, parent, set_parent
		end;
	
feature 

	parent: NESTED_BL;
			-- Parent of access

	type: TYPE_I;
			-- Local variable type
	
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
			local_b: LOCAL_B;
		do
			if r.is_local then
				local_b ?= r;	-- Cannot fail
				if local_b.position = position then
					Result := true;
				end;
			end;
		end;

	fill_from (l: LOCAL_B) is
			-- Fill in node from local `l'
		do
			position := l.position;
			type := l.type;
		end;

	analyze is
			-- Mark local as used
		do
			context.mark_local_used (position);
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
		end

end

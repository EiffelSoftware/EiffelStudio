class INLINED_LOCAL_B

inherit
	LOCAL_B
		redefine
			type, propagate, analyze, generate, free_register,
			print_register, enlarged, Current_register,
			is_local
		end

feature

	type: TYPE_I;

feature

	fill_from (l: LOCAL_B) is
		do
			parent := l.parent;
			position := l.position;
			type := l.type
		end

	enlarged: INLINED_LOCAL_B is
		do
			Result := Current
		end

	is_local: BOOLEAN is
		do
		end

feature -- Register and code generation

	Current_register: INLINED_CURRENT_B is
		once
			!!Result
		end

	propagate (r: REGISTRABLE) is
			-- Do nothing
		do
		end

	analyze is
			-- Do nothing
		do
		end;

	generate is
			-- Do nothing
		do
		end;

	free_register is
			-- Do nothing
		do
		end;

	print_register is
		do
			System.remover.inliner.inlined_feature.local_regs.item (position).print_register
		end;

end

class INLINED_ARG_B

inherit
	ARGUMENT_B
		redefine
			enlarged, propagate, analyze, generate,
			free_register, print_register, type,
			current_register
		end

feature

	fill_from (a: ARGUMENT_B) is
		do
			parent := a.parent;
			position := a.position
		end

	enlarged: INLINED_ARG_B is
		do
			Result := Current
		end

feature -- Register and code generation

	Current_register: INLINED_CURRENT_B is
		once
			!!Result
		end

	propagate (r: REGISTRABLE) is
			-- Do nothing
		do
		end;

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
			System.remover.inliner.inlined_feature
				.argument_regs.item (position).print_register
		end;

feature

	type: TYPE_I is
		do
			Result := System.remover.inliner.inlined_feature
				.argument_type (position)
		end

end

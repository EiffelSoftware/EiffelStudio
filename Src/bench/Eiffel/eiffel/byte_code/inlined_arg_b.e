class INLINED_ARG_B

inherit
	ARGUMENT_B
		redefine
			enlarged, propagate, analyze, generate,
			free_register, print_register
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

end

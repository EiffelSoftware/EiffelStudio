class INLINED_CURRENT_B

inherit

	CURRENT_B
		redefine
			enlarged, propagate, analyze, generate,
			free_register, print_register
		end

feature

	enlarged: INLINED_CURRENT_B is
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
				.current_reg.print_register
		end;

end

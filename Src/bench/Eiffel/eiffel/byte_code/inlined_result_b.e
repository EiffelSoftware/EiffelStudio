class INLINED_RESULT_B

inherit
	RESULT_B
		redefine
			enlarged, propagate, analyze, generate,
			free_register, print_register
		end

feature

	enlarged: INLINED_RESULT_B is
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
				.result_reg.print_register
		end;


end

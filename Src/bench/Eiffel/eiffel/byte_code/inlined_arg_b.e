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
		local
			inlined_feature: INLINED_FEAT_B
			current_type: CL_TYPE_I
			current_reg: REGISTRABLE
		do
				-- We need to go back to the caller's context to
				-- generate the argument as, if no temporary register
				-- is needed, calling `print_register' may have to
				-- evaluate types.
			inlined_feature := System.remover.inliner.inlined_feature

			current_type := Context.current_type
			current_reg := Context.inlined_current_register

			Context.set_current_type (inlined_feature.caller_type)
			Context.set_inlined_current_register (Void)

			inlined_feature.argument_regs.item (position).print_register

			Context.set_current_type (current_type)
			Context.set_inlined_current_register (current_reg)
		end;

feature

	type: TYPE_I is
		do
			Result := System.remover.inliner.inlined_feature.argument_type (position)
		end

end

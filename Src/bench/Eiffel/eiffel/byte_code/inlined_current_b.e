class INLINED_CURRENT_B

inherit

	CURRENT_B
		redefine
			enlarged, propagate, analyze, generate,
			free_register, print_register, Current_register,
			register_name, is_current
		end

feature

	enlarged: INLINED_CURRENT_B is
		do
			Result := Current
		end

	is_current: BOOLEAN is
			-- `is_current' is used for dtype optimization
			-- hence it should return false for inlined code
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
			--Context.current_register.print_register
			--System.remover.inliner.inlined_feature.current_reg.print_register
			inlined_feature := System.remover.inliner.inlined_feature

			current_type := Context.current_type
			current_reg := Context.inlined_current_register

			Context.set_current_type (inlined_feature.caller_type)
			Context.set_inlined_current_register (Void)

			inlined_feature.current_reg.print_register

			Context.set_current_type (current_type)
			Context.set_inlined_current_register (current_reg)

		end;

	register_name: STRING is
		do
			--Result := Context.current_register.register_name
			Result := System.remover.inliner.inlined_feature.current_reg.register_name
		end

end

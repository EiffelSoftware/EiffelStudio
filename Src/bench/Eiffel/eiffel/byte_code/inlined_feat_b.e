class INLINED_FEAT_B

inherit
	FEATURE_BL
		rename
			analyze_on as feat_bl_analyze_on,
			generate_parameters as feat_bl_generate_parameters,
			unanalyze as feat_bl_unanalyze
		redefine
			enlarged, perused,
			generate_end, fill_from
		end
	FEATURE_BL
		redefine
			enlarged, analyze_on,
			generate_end, fill_from,
			generate_parameters,
			unanalyze, perused
		select
			analyze_on, generate_parameters, unanalyze
		end

feature

	perused: BOOLEAN is True;
		--| The registers used by the parameters must be kept for the assignment
		--| Eabc(l[2], l[3], l[4]) cannot be replaced by
		--| l[3] = l[2]
		--| l[5] = l[3]
		--| i.e. we loose the value of l[3]

	fill_from (f: FEATURE_B) is
		do
			feature_name := f.feature_name;
			feature_id := f.feature_id;
			type := f.type;
			parameters := f.parameters;
			if parameters /= Void then
				parameters := parameters.inlined_byte_code
			end
			
		end

	enlarged: INLINED_FEAT_B is
		local
			old_current_type: CL_TYPE_I
		do
			--old_current_type := Context.current_type;
			--Context.set_current_type (current_type);

			Result := Current
			enlarge_parameters;

			inliner.set_inlined_feature (Current);

			compound := byte_code.compound;
			if compound /= Void then
				compound.enlarge_tree
			end;

			saved_compound := deep_clone (compound);

			inliner.set_inlined_feature (Void);
			--Context.set_current_type (old_current_type);
		end

	unanalyze is
		do
			feat_bl_unanalyze;
			compound := deep_clone (saved_compound)
		end

	analyze_on (reg: REGISTRABLE) is
		local
			result_type: TYPE_I
			old_current_type: CL_TYPE_I
			reg_type: TYPE_C
		do
				-- First, standard analysis of the call
			feat_bl_analyze_on (reg);

			reg_type := reg.c_type;

				-- Instantiation of the result type (used by
				-- INLINED_RESULT_B)
			type := real_type (type);
			inliner.set_inlined_feature (Current);

			old_current_type := Context.current_type;
			Context.set_current_type (current_type);

			current_reg := get_current_register (reg_type);
			Context.set_inlined_current_register (current_reg);

			local_regs := get_inlined_registers (byte_code.locals);
				-- FIXME: USE THE PARAMETER REGISTERS IF THEY EXIST
				-- Now, the code can look like:
				-- l[1] = l[0]
				-- Edgdj(l[1])
				-- l[1] should not be used
			argument_regs := get_inlined_registers (byte_code.arguments);

			result_type := byte_code.result_type;
			if not result_type.is_void then
				result_reg := get_inline_register (real_type (result_type))
			end;

			if compound /= Void then
				compound.analyze;
			end;
			inlined_dt_current := context.inlined_dt_current;

			context.reset_inlined_dt_current;

				-- Free resources
			free_inlined_registers (local_regs);
			free_inlined_registers (argument_regs);
			if result_reg /= Void then
				result_reg.free_register
			end;
			current_reg.free_register

			inliner.set_inlined_feature (Void);

			Context.set_current_type (old_current_type);
			Context.set_inlined_current_register (Void);
		end

	argument_type (pos: INTEGER): TYPE_I is
			-- Type of the arguemtn at postion `pos'
		do
			Result := real_type (byte_code.arguments.item (pos))
		end

feature -- Generation

	generate_parameters (gen_reg: REGISTRABLE) is
		local
			i, count: INTEGER
			expr: EXPR_B;
			current_t: CL_TYPE_I
			old_current_type: CL_TYPE_I
		do
			feat_bl_generate_parameters (gen_reg)

			inliner.set_inlined_feature (Current);

			generated_file.putchar ('{');
			generated_file.new_line;

			generated_file.putstring ("/* INLINED CODE (");
			generated_file.putstring (feature_name);
			generated_file.putstring (") */");
			generated_file.new_line;

			if parameters /= void then
					-- Assign the parameter values to the registers
				from
					parameters.start
					i := 1
				until
					parameters.after
				loop
					expr := parameters.item;
					argument_regs.item (i).print_register;
					generated_file.putstring (" = ");
					expr.print_register;
					generated_file.putchar (';');
					generated_file.new_line;
					parameters.forth;
					i := i + 1
				end
			end;
			if local_regs /= Void then
					-- Set the value of the local registers to the default
				from
					i := 1;
					count := local_regs.count
				until
					i > count
				loop
					reset_register_value (local_regs.item (i))
					i := i + 1
				end;
			end

			if result_reg /= Void then
					-- Set the value of the result register to the default
				reset_register_value (result_reg)
			end;

			old_current_type := Context.current_type;
			current_t := current_type;

			Context.set_current_type (current_t);
			Context.set_inlined_current_register (current_reg);

			current_register.print_register;
			generated_file.putstring (" = ");

				-- `print_register' on `gen_reg' must be generated
				-- with the old context

			Context.set_current_type (old_current_type);
			Context.set_inlined_current_register (Void);

			gen_reg.print_register;
			generated_file.putchar (';');
			generated_file.new_line

			generated_file.new_line

			Context.set_current_type (current_t);
			Context.set_inlined_current_register (current_reg);

			if inlined_dt_current > 1 then
				context.set_inlined_dt_current (inlined_dt_current);
				generated_file.putchar ('{');
				generated_file.new_line;
				generated_file.putstring ("int inlined_dtype = ");
				generated_file.putstring (gc_upper_dtype_lparan);
				current_reg.print_register_by_name;
				generated_file.putstring (");");
				generated_file.new_line
			end;

			if compound /= Void then
				compound.generate
			end

			if inlined_dt_current > 1 then
				generated_file.putchar ('}');
				generated_file.new_line
				context.set_inlined_dt_current (0);
			end

			Context.set_inlined_current_register (Void);

			generated_file.putstring ("/* END INLINED CODE */");
			generated_file.new_line;

			generated_file.putchar ('}');
			generated_file.new_line;

			Context.set_current_type (old_current_type);

			inliner.set_inlined_feature (Void);
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I; meta: BOOLEAN) is
		do
			Context.set_inlined_current_register (current_reg);
			if result_reg /= Void then
					-- print the value of the result register
				result_reg.print_register
			end;
			Context.set_inlined_current_register (Void)

			release_hector_protection
		end

feature -- Registers

	local_regs: ARRAY [REGISTER];

	argument_regs: ARRAY [REGISTER];

	result_reg: REGISTER;

	Current_reg: REGISTRABLE;

feature {NONE}

	get_current_register (reg_type: TYPE_C): REGISTRABLE is
		local
			tmp_reg: REGISTER
		do
	--io.error.putstring ("FIXME: get_current_register%N");
	--		if reg.is_temporary then
	--			Result := reg
	--		else
				!!tmp_reg.make (reg_type);
				Result := tmp_reg
	--		end
		end

	inliner: INLINER is
		do
			Result := System.remover.inliner
		end

feature {NONE} -- Registers

	get_inlined_registers (a: ARRAY [TYPE_I]): ARRAY [REGISTER] is
		local
			i ,count: INTEGER
		do
			if a /= Void then
				from
					i := 1
					count := a.count;
					!!Result.make (1, count);
				until
					i > count
				loop
					Result.put (get_inline_register(real_type (a.item (i))), i)
					i := i + 1
				end
			end
		end

	get_inline_register (type_i: TYPE_I): REGISTER is
		do
			!!Result.make (type_i.c_type);
		end

	free_inlined_registers (a: ARRAY [REGISTER]) is
		local
			i, count: INTEGER
		do
			if a /= Void then
				from
					i := 1
					count := a.count
				until
					i > count
				loop
					a.item (i).free_register
					i := i + 1
				end
			end
		end

	reset_register_value (reg: REGISTER) is
		do
			reg.print_register;
			generated_file.putstring (" = ");
			reg.c_type.generate_cast (generated_file);
			generated_file.putstring (" 0;");
			generated_file.new_line;
		end

	inlined_dt_current: INTEGER;
		-- Do we optimize the access to the Dynamic type of Current?

feature -- Code to inline

	byte_code: STD_BYTE_CODE

	compound: BYTE_LIST [BYTE_NODE];
			-- Code to inline

	saved_compound: like compound;

	set_inlined_byte_code (b: STD_BYTE_CODE) is
		do
			byte_code := b
		end

end

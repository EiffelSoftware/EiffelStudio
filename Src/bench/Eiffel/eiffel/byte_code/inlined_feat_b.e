class INLINED_FEAT_B

inherit
	FEATURE_BL
		redefine
			enlarged, analyze, free_register,
			generate_end, fill_from
		end

feature

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
			compound: BYTE_LIST [BYTE_NODE]
		do
			Result := Current
			enlarge_parameters;

			compound := byte_code.compound;
			if compound /= Void then
				compound.enlarge_tree
			end
		end

	analyze is
		local
			inliner: INLINER
			result_type: TYPE_I
			compound: BYTE_LIST [BYTE_NODE]
		do
			inliner := system.remover.inliner;
			inliner.set_inlined_feature (Current);

			local_regs := get_inlined_registers (byte_code.locals);
			argument_regs := get_inlined_registers (byte_code.arguments);

			result_type := byte_code.result_type;
			if not result_type.is_void then
				result_reg := get_inline_register (result_type)
			end;

			analyze_on (Current_register);
			get_register;

			compound := byte_code.compound
			if compound /= Void then
				compound.analyze;
			end
		end

	free_register is
		local
			inliner: INLINER
		do
			inliner := system.remover.inliner;
			inliner.set_inlined_feature (Current);

				-- Free resources
			inliner.set_inlined_feature (Void);
			free_inlined_registers (local_regs);
			free_inlined_registers (argument_regs);
			if result_reg /= Void then
				free_inlined_register (result_reg)
			end;
		end

feature -- Generation

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I; meta: BOOLEAN) is
		local
			i, count: INTEGER
			expr: EXPR_B;
			compound: BYTE_LIST [BYTE_NODE]
		do
			if parameters /= void then
					-- Assign the parameter values to the registers
				from
					parameters.start
					i := 1
				until
					parameters.after
				loop
					expr ?= parameters.item;
					argument_regs.item (i).print_register;
					generated_file.putstring (" = ");
					expr.print_register;
					generated_file.putstring (";%N");
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

			current_reg := gen_reg;

			compound := byte_code.compound
			if compound /= Void then
				compound.generate
			end

			release_hector_protection
		end

feature -- Registers

	local_regs: ARRAY [REGISTER];

	argument_regs: ARRAY [REGISTER];

	result_reg: REGISTER;

	Current_reg: REGISTRABLE;

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
					Result.put (get_inline_register(a.item (i)), i)
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
					free_inlined_register (a.item (i))
					i := i + 1
				end
			end
		end

	free_inlined_register (reg: REGISTER) is
		do
			reg.free_register
		end

	reset_register_value (reg: REGISTER) is
		do
			reg.print_register;
			generated_file.putstring (" = ");
			reg.c_type.generate_cast (generated_file);
			generated_file.putstring (" 0;%N");
		end

feature -- Code to inline

	byte_code: INLINED_BYTE_CODE

	set_inlined_byte_code (b: INLINED_BYTE_CODE) is
		do
			byte_code := b
		end

end

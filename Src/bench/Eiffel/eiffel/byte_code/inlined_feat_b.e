class INLINED_FEAT_B

inherit
	FEATURE_BL
		redefine
			enlarged, analyze_on, generate_metamorphose_end, 
			generate_end, fill_from,
			generate_parameters,
			unanalyze, perused,
			free_register
		end

feature

	perused: BOOLEAN is True;
		--| The registers used by the parameters must be kept for the assignment
		--| Eabc(l[2], l[3], l[4]) cannot be replaced by
		--| l[3] = l[2]
		--| l[5] = l[3]
		--| i.e. we lose the value of l[3]

	is_current_temporary: BOOLEAN;
			-- Is Current a temporary register?

	temporary_parameters: ARRAY [BOOLEAN];

	fill_from (f: FEATURE_B) is
		do
			feature_name_id := f.feature_name_id;
			feature_id := f.feature_id;
			type := f.type;
			routine_id := f.routine_id
			parameters := f.parameters;
			if parameters /= Void then
				parameters := parameters.inlined_byte_code
			end
			
		end

	enlarged: INLINED_FEAT_B is
		local
			local_inliner: INLINER
		do
			Result := Current
			enlarge_parameters;

			local_inliner := inliner
			local_inliner.set_inlined_feature (Current);

			compound := byte_code.compound;
			if compound /= Void then
				compound.enlarge_tree
			end;
			saved_compound := deep_clone (compound);

			local_inliner.set_inlined_feature (Void);
		end


	free_register is
            -- Free registers
		do
			{FEATURE_BL} Precursor;
			if result_reg /= Void then
				result_reg.free_register
			end
		end

	unanalyze is
		do
			{FEATURE_BL} Precursor;
			compound := deep_clone (saved_compound)
		end

	analyze_on (reg: REGISTRABLE) is
		local
			result_type: TYPE_I;
			old_current_type: CL_TYPE_I;
			reg_type: TYPE_C;
			local_is_current_temporary: BOOLEAN;
			a: ATTRIBUTE_BL;
			access: ACCESS_EXPR_B
			local_inliner: INLINER
		do
				-- First, standard analysis of the call
			{FEATURE_BL} Precursor (reg);

			reg_type := reg.c_type;

				-- Instantiation of the result type (used by INLINED_RESULT_B)
			type := real_type (type);
			local_inliner := inliner
			local_inliner.set_inlined_feature (Current);

			old_current_type := Context.current_type;
			Context.set_current_type (current_type);

			-- current_reg := get_current_register (reg_type);
			local_is_current_temporary := reg.is_temporary or reg.is_predefined;

			if local_is_current_temporary then
				current_reg := reg
			else
				-- We have to check if `Current' is an attribute. A much nicer way
				-- would be to define a feature in REGISTRABLE which would indicate
				-- whether the register can be used during inlining, and to 
				-- redefine it in the appropriate descendants.

				a ?= reg;
				if a /= Void then
					current_reg := a.register;
					if current_reg /= Void then
						local_is_current_temporary := current_reg.is_temporary
					end
				else
					-- There is the case where `reg' is of type ACCESS_EXPR_B (if the 
					-- feature is an infixed routine). The attribute is stored in 
					-- field `expr'.
					access ?= reg;
					if access /= Void then
						a ?= access.expr;
						if a /= Void then
							current_reg := a.register;
							if current_reg /= Void then
								local_is_current_temporary := current_reg.is_temporary
							end
						end
					end
				end
			end;

			is_current_temporary := local_is_current_temporary;

			if not local_is_current_temporary then
				!REGISTER! current_reg.make (reg_type)
			end;

			Context.set_inlined_current_register (current_reg);

			local_regs := get_inlined_registers (byte_code.locals);
			argument_regs := get_inlined_param_registers (byte_code.arguments);

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
			free_inlined_param_registers (argument_regs);

			if not local_is_current_temporary then
				current_reg.free_register
			end;

			local_inliner.set_inlined_feature (Void);

			Context.set_current_type (old_current_type);
			Context.set_inlined_current_register (Void);
		end

	argument_type (pos: INTEGER): TYPE_I is
			-- Type of the argument at position `pos'
		do
			Result := real_type (byte_code.arguments.item (pos))
		end

feature -- Generation

	generate_parameters (gen_reg: REGISTRABLE) is
		local
			expr: EXPR_B;
			current_t: CL_TYPE_I
			buf: GENERATION_BUFFER
			local_inliner: INLINER
			p: like parameters
			l_area: SPECIAL [EXPR_B]
			b_area: SPECIAL [BOOLEAN]
			i, count: INTEGER
		do
			{FEATURE_BL} Precursor (gen_reg)

			local_inliner := inliner
			local_inliner.set_inlined_feature (Current);

			buf := buffer
			buf.putchar ('{');
			buf.new_line;

			buf.putstring ("/* INLINED CODE (");
			buf.putstring (escaped_feature_name);
			buf.putstring (") */");
			buf.new_line;

			if parameters /= Void then
					-- Assign the parameter values to the registers
				from
					b_area := temporary_parameters.area
					p := parameters
					l_area := p.area
					count := p.count
					p := Void
				until
					i = count
				loop
					if (not b_area.item (i)) then
						expr := l_area.item (i)
						argument_regs.item (i + 1).print_register;
						buf.putstring (" = ");
						expr.print_register;
						buf.putchar (';');
						buf.new_line
					end;
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
				
			caller_type := Context.current_type;
			current_t := current_type;

			Context.set_current_type (current_t);
			Context.set_inlined_current_register (current_reg);

			if not is_current_temporary then

				current_register.print_register;
				buf.putstring (" = ");

				-- `print_register' on `gen_reg' must be generated
				-- with the old context
				
				Context.set_current_type (caller_type);
				Context.set_inlined_current_register (Void);
				
				gen_reg.print_register;
				buf.putchar (';');
				buf.new_line
				
				buf.new_line
				
				Context.set_current_type (current_t);
				Context.set_inlined_current_register (current_reg);

			end;

			if inlined_dt_current > 1 then
				context.set_inlined_dt_current (inlined_dt_current);
				buf.putchar ('{');
				buf.new_line;
				buf.putstring ("int inlined_dtype = ");
				buf.putstring (gc_upper_dtype_lparan);
				current_reg.print_register;
				buf.putstring (");");
				buf.new_line
			end;

			if compound /= Void then
				compound.generate
			end

			if inlined_dt_current > 1 then
				buf.putchar ('}');
				buf.new_line
				context.set_inlined_dt_current (0);
			end

			Context.set_inlined_current_register (Void);

			buf.putstring ("/* END INLINED CODE */");
			buf.new_line;

			buf.putchar ('}');
			buf.new_line;

			Context.set_current_type (caller_type);
			caller_type := Void;

			local_inliner.set_inlined_feature (Void);
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I; is_class_separate: BOOLEAN) is
		do
			Context.set_inlined_current_register (current_reg);
			if result_reg /= Void then
					-- print the value of the result register
				result_reg.print_register
			end;
			Context.set_inlined_current_register (Void)
		end

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_I;
		basic_type: BASIC_I; buf: GENERATION_BUFFER) is
			-- Generate final portion of C code.
		do
			generate_end (gen_reg, class_type, class_type.is_separate)
		end

feature -- Registers

	local_regs: ARRAY [REGISTER];

	argument_regs: ARRAY [REGISTRABLE];

	result_reg: REGISTER;

	Current_reg: REGISTRABLE;

feature -- Type information

	caller_type: CL_TYPE_I
		-- Caller type

feature {NONE}

	inliner: INLINER is
		do
			Result := System.remover.inliner
		end

feature {NONE} -- Registers

	get_inlined_registers (a: ARRAY [TYPE_I]): ARRAY [REGISTER] is
		local
			i, count: INTEGER
		do
			if a /= Void then
				from
					i := 1
					count := a.count;
					!!Result.make (1, count)
				until
					i > count
				loop
					Result.put (get_inline_register(real_type (a.item (i))), i);
					i := i + 1
				end
			end
		end;

	get_inlined_param_registers (a: ARRAY [TYPE_I]): ARRAY [REGISTRABLE] is
		local
			i ,count: INTEGER
			is_param_temporary_reg: BOOLEAN
			local_reg: REGISTRABLE
			p: PARAMETER_B
			expr: EXPR_B
			nest, msg: NESTED_B
			void_reg: VOID_REGISTER
		do
			if a /= Void then
				from
					i := 1;
					count := a.count;
					check
						same_count: count = parameters.count
					end;
					!!Result.make (1, count);
					!! temporary_parameters.make (1, count);
					parameters.start
				until
					i > count
				loop
					is_param_temporary_reg := false;

					expr := parameters.item;

						-- First, let's check if we have a local (LOCAL_BL):
					if expr.is_temporary or expr.is_predefined then
						local_reg := expr;
						is_param_temporary_reg := True
					else
						local_reg := expr.register;
						if local_reg = Void then
								-- Let's check if we have a parameter (PARAMETER_BL):
							p ?= expr;
							if p /= Void then
									-- We have a parameter.
								expr := p.expression;
									-- If the rest fails, at least local_reg will be this, 
									-- which includes the ATTRIBUTE_BL case.
								local_reg := expr.register;
									-- Do we have a local (LOCAL_BL)?
								if expr.is_temporary or expr.is_predefined then
									local_reg := expr;
									is_param_temporary_reg := True
								else
										-- We might have a nested call: `a.b.c.d'. The 
										-- register we're looking for is d's, but we have to 
										-- traverse the nested calls first:
									nest ?= expr;
									if nest /= Void then
										from
											msg := nest;
										until
											msg = Void
										loop
											nest := msg;
											msg ?= msg.message
										end;
										local_reg := nest.register
									end
								end
							end
						end
					end;

					if (local_reg /= Void) then
						is_param_temporary_reg := local_reg.is_temporary;
						if is_param_temporary_reg then
							void_reg ?= local_reg;
							is_param_temporary_reg := void_reg = Void
						else
							is_param_temporary_reg := local_reg.is_predefined
						end
					end;

					temporary_parameters.put (is_param_temporary_reg, i);

					if is_param_temporary_reg then
						Result.put (local_reg, i)
					else
						Result.put (get_inline_register(real_type (a.item (i))), i)
					end;

					i := i + 1;
					parameters.forth
				end
			end
		end;


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
					i := 1;
					count := a.count
				until
					i > count
				loop
					a.item (i).free_register;
					i := i + 1
				end
			end
		end;

	free_inlined_param_registers (a: ARRAY [REGISTRABLE]) is
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
					if (not temporary_parameters.item (i)) then
						a.item (i).free_register
					end;
					i := i + 1
				end
			end
		end

	reset_register_value (reg: REGISTER) is
		local
			buf: GENERATION_BUFFER
		do
			reg.print_register;
			buf := buffer
			buf.putstring (" = ");
			reg.c_type.generate_cast (buf);
			buf.putstring (" 0;");
			buf.new_line;
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

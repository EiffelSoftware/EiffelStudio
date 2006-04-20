indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	context_type_id: INTEGER
			-- Class type ID of the class type from which the feature is called

	written_type_id: INTEGER
			-- Class type ID of the class type where the feature is written

	fill_from (f: FEATURE_B) is
		do
			feature_name_id := f.feature_name_id;
			feature_id := f.feature_id;
			type := real_type (f.type);
			routine_id := f.routine_id
			parameters := f.parameters;
			if parameters /= Void then
				parameters := parameters.inlined_byte_code
			end
		end

	set_context_type (context_class_type, written_class_type: CLASS_TYPE) is
			-- Set a class type on which the feature is called
			-- and a class type where the feature is written in.
		require
			context_class_type_not_void: context_class_type /= Void
			written_class_type_not_void: written_class_type /= Void
		do
			context_type_id := context_class_type.type_id
			written_type_id := written_class_type.type_id
		ensure
			context_type_id_set: context_type_id = context_class_type.type_id
			written_type_id_set: written_type_id = written_class_type.type_id
		end

	enlarged: INLINED_FEAT_B is
		local
			local_inliner: INLINER
		do
			Result := Current
			enlarge_parameters

			local_inliner := inliner
			local_inliner.set_inlined_feature (Current)
			Context.change_class_type_context
				(system.class_type_of_id (context_type_id), system.class_type_of_id (written_type_id))

			compound := byte_code.compound;
			if compound /= Void then
				compound.enlarge_tree
				saved_compound := compound.deep_twin
			else
				saved_compound := Void
			end

			Context.restore_class_type_context
			local_inliner.set_inlined_feature (Void)
		end

	free_register is
            -- Free registers
		do
			Precursor {FEATURE_BL};
			if result_reg /= Void then
				result_reg.free_register
			end
		end

	unanalyze is
		do
			Precursor {FEATURE_BL};
			if saved_compound /= Void then
				compound := saved_compound.deep_twin
			else
				compound := Void
			end
		end

	analyze_on (reg: REGISTRABLE) is
		local
			result_type: TYPE_I;
			reg_type: TYPE_C;
			local_is_current_temporary: BOOLEAN;
			a: ATTRIBUTE_BL;
			access: ACCESS_EXPR_B
			local_inliner: INLINER
			cl_type_i: CL_TYPE_I
		do
				-- First, standard analysis of the call
			Precursor {FEATURE_BL} (reg);

			reg_type := reg.c_type;

				-- Instantiation of the result type (used by INLINED_RESULT_B)
			type := real_type (type)
			local_inliner := inliner
			local_inliner.set_inlined_feature (Current)

			cl_type_i ?= context_type
			Context.change_class_type_context (cl_type_i.associated_class_type, current_class_type)

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
				create {REGISTER} current_reg.make (reg_type)
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
			inlined_dftype_current := context.inlined_dftype_current;

			context.reset_inlined_dt_current;
			context.reset_inlined_dftype_current;

				-- Free resources
			free_inlined_registers (local_regs);
			free_inlined_param_registers (argument_regs);

			if not local_is_current_temporary then
				current_reg.free_register
			end;

			local_inliner.set_inlined_feature (Void);

			Context.restore_class_type_context
			Context.set_inlined_current_register (Void)
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
			context_class_type: CLASS_TYPE
			written_class_type: CLASS_TYPE
			buf: GENERATION_BUFFER
			local_inliner: INLINER
			p: like parameters
			l_area: SPECIAL [EXPR_B]
			b_area: SPECIAL [BOOLEAN]
			i, count: INTEGER
		do
			Precursor {FEATURE_BL} (gen_reg)

			local_inliner := inliner
			local_inliner.set_inlined_feature (Current);

			buf := buffer
			buf.put_character ('{');
			buf.put_new_line;

			buf.put_string ("/* INLINED CODE (");
			buf.put_string (feature_name);
			buf.put_string (") */");
			buf.put_new_line;

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
						buf.put_string (" = ");
						expr.print_register;
						buf.put_character (';');
						buf.put_new_line
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
					reset_register_value (byte_code.locals.item (i), local_regs.item (i))
					i := i + 1
				end;
			end

			if result_reg /= Void then
					-- Set the value of the result register to the default
				reset_register_value (byte_code.result_type, result_reg)
			end;

			context_class_type := system.class_type_of_id (context_type_id)
			written_class_type := system.class_type_of_id (written_type_id)

			Context.change_class_type_context (context_class_type, written_class_type)
			Context.set_inlined_current_register (current_reg)

			if not is_current_temporary then

				current_register.print_register;
				buf.put_string (" = ");

				-- `print_register' on `gen_reg' must be generated
				-- with the old context

				Context.restore_class_type_context
				Context.set_inlined_current_register (Void)

				gen_reg.print_register
				buf.put_character (';')
				buf.put_new_line

				buf.put_new_line

				Context.change_class_type_context (context_class_type, written_class_type)
				Context.set_inlined_current_register (current_reg)
			end

			if inlined_dt_current > 1 or inlined_dftype_current > 1 then
				buf.put_character ('{')
				if inlined_dftype_current > 1 then
					context.set_inlined_dftype_current (inlined_dftype_current)
					buf.put_new_line
					buf.put_string ("int inlined_dftype = ")
					buf.put_string (gc_upper_dftype_lparan)
					current_reg.print_register
					buf.put_string (");")
				end
				if inlined_dt_current > 1 then
					context.set_inlined_dt_current (inlined_dt_current)
					buf.put_new_line
					buf.put_string ("int inlined_dtype = ")
					buf.put_string (gc_upper_dtype_lparan)
					current_reg.print_register
					buf.put_string (");")
				end
				buf.put_new_line
			end

			if compound /= Void then
				compound.generate
			end

			if inlined_dt_current > 1 or inlined_dftype_current > 1 then
				buf.put_character ('}');
				buf.put_new_line
				if inlined_dt_current > 1 then
					context.set_inlined_dt_current (0);
				end
				if inlined_dftype_current > 1 then
					context.set_inlined_dftype_current (0);
				end
			end

			buf.put_string ("/* END INLINED CODE */");
			buf.put_new_line;

			buf.put_character ('}');
			buf.put_new_line;

			Context.restore_class_type_context
			Context.set_inlined_current_register (Void)

			local_inliner.set_inlined_feature (Void)
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I) is
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
			generate_end (gen_reg, class_type)
		end

feature -- Registers

	local_regs: ARRAY [REGISTER];

	argument_regs: ARRAY [REGISTRABLE];

	result_reg: REGISTER;

	Current_reg: REGISTRABLE;

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
					create Result.make (1, count)
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
					create Result.make (1, count);
					create temporary_parameters.make (1, count);
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

					if is_param_temporary_reg and p /= Void then
							-- We only forbid inlining if basic types are not matching,
							-- to force a C cast to be performed.
						is_param_temporary_reg := not expr.type.is_basic or else
							expr.type.same_as (p.attachment_type)
					end

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
			create Result.make (type_i.c_type);
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

	reset_register_value (a_type: TYPE_I; reg: REGISTER) is
		local
			buf: GENERATION_BUFFER
		do
			reg.print_register;
			buf := buffer
			buf.put_string (" = ");
			reg.c_type.generate_cast (buf);
			buf.put_string (" 0;");
			buf.put_new_line
			if a_type.is_true_expanded then
				a_type.generate_expanded_creation (buf, reg.register_name)
			end
		end

	inlined_dt_current: INTEGER;
			-- Do we optimize the access to the Dynamic type of Current?

	inlined_dftype_current: INTEGER
			-- Do we optimize access to full dynamic type of Current?

feature -- Code to inline

	byte_code: STD_BYTE_CODE

	compound: BYTE_LIST [BYTE_NODE];
			-- Code to inline

	saved_compound: like compound;

	set_inlined_byte_code (b: STD_BYTE_CODE) is
		do
			byte_code := b
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class INLINED_FEAT_B

inherit
	FEATURE_BL
		redefine
			analyze_on,
			context_cl_type,
			enlarged,
			enlarged_on,
			generate_metamorphose_end,
			generate_end,
			generate_parameters,
			fill_from,
			free_param_registers,
			free_register,
			is_polymorphic,
			perused,
			unanalyze
		end

create
	fill_from

feature {NONE} -- Creation

	fill_from (f: FEATURE_B)
			-- Fill in node with feature `f`.
		do
			if attached f.precursor_type as p then
				precursor_type := p
				call_kind := call_kind_unqualified
			else
				call_kind := call_kind_qualified
			end
			feature_name_id := f.feature_name_id
			feature_id := f.feature_id
			written_in := f.written_in
			type := real_type (f.type)
			routine_id := f.routine_id
			parameters := f.parameters
			if parameters /= Void then
				set_parameters (parameters.inlined_byte_code)
			end
			is_once := f.is_once
			is_process_relative := f.is_process_relative
			is_object_relative := f.is_object_relative
			is_instance_free := f.is_instance_free
			if f.has_multi_constraint_static then
				multi_constraint_static := real_type (f.multi_constraint_static)
			end
		end

feature

	perused: BOOLEAN = True;
		--| The registers used by the parameters must be kept for the assignment
		--| Eabc(l[2], l[3], l[4]) cannot be replaced by
		--| l[3] = l[2]
		--| l[5] = l[3]
		--| i.e. we lose the value of l[3]

	is_polymorphic: BOOLEAN = False
			-- Optimization as all inlined calls are definitely not polymorphic.

	is_current_temporary: BOOLEAN;
			-- Is Current a temporary register?

	temporary_parameters: ARRAY [BOOLEAN];

	context_type_id: INTEGER
			-- Class type ID of the class type from which the feature is called

	written_type_id: INTEGER
			-- Class type ID of the class type where the feature is written

	context_cl_type, written_cl_type: CL_TYPE_A
			-- Type from where the feature is written.

	result_type: TYPE_A
			-- Type of an inlined feature
		do
			Result := byte_code.result_type
		end

	set_context_type (context_class_type: CLASS_TYPE; a_context_cl_type: CL_TYPE_A; written_class_type: CLASS_TYPE; a_written_cl_type: CL_TYPE_A)
			-- Set a class type on which the feature is called
			-- and a class type where the feature is written in.
		require
			attached context_class_type
			attached written_class_type
			attached a_context_cl_type
			attached a_written_cl_type
			a_context_cl_type.associated_class_type (context_cl_type) = context_class_type
			a_written_cl_type.associated_class_type (context_cl_type) = written_class_type
		do
			context_type_id := context_class_type.type_id
			written_type_id := written_class_type.type_id
			context_cl_type := a_context_cl_type
			written_cl_type := a_written_cl_type
		ensure
			context_type_id_set: context_type_id = context_class_type.type_id
			written_type_id_set: written_type_id = written_class_type.type_id
			context_cl_type = a_context_cl_type
			written_cl_type = a_written_cl_type
		end

	enlarged: INLINED_FEAT_B
		do
			Result := Current
			enlarge_parameters

			Context.put_inline_context (Current,
				system.class_type_of_id (context_type_id), context_cl_type,
				system.class_type_of_id (written_type_id), written_cl_type)

			compound := byte_code.compound
			if compound /= Void then
				compound.enlarge_tree
				saved_compound := compound.deep_twin
			else
				saved_compound := Void
			end

			Context.remove_inline_context
		end

	enlarged_on (t: TYPE_A): CALL_ACCESS_B
			-- <Precursor>
		do
			Result := enlarged
		end

	free_register
            -- <Precursor>
		do
			Precursor
			if attached result_reg as r then
				r.free_register
			end
		end

	unanalyze
		do
			Precursor
			if saved_compound /= Void then
				compound := saved_compound.deep_twin
			else
				compound := Void
			end
		end

	analyze_on (r: REGISTRABLE)
			-- <Precursor>
		local
			r_type: TYPE_A
			reg_type: TYPE_C
			local_is_current_temporary: BOOLEAN
			reg: REGISTRABLE
		do
				-- First, standard analysis of the call.
			Precursor (r)
			reg := target_register (r)
			reg_type := reg.c_type

			context.change_class_type_context
				(system.class_type_of_id (context_type_id), context_cl_type,
				system.class_type_of_id (written_type_id), written_cl_type)

			local_regs := get_inlined_registers (byte_code.locals)
			argument_regs := get_inlined_param_registers (byte_code.arguments, byte_code.has_hector)

				-- Instantiation of the result type (used by INLINED_RESULT_B)
			r_type := real_type (result_type)
			if not r_type.is_void then
				result_reg := get_inline_register (r_type)
			end

			if reg.is_temporary or reg.is_predefined then
				local_is_current_temporary := True
				current_reg := reg
			else
				create {REGISTER} current_reg.make (reg_type)
			end
			is_current_temporary := local_is_current_temporary

			context.restore_class_type_context
			context.put_inline_context (Current,
				system.class_type_of_id (context_type_id), context_cl_type,
				system.class_type_of_id (written_type_id), written_cl_type)
			Context.set_inlined_current_register (current_reg)

			if attached compound as l_compound then
				l_compound.analyze
			end
			inlined_dt_current := context.inlined_dt_current
			inlined_dftype_current := context.inlined_dftype_current

			context.reset_inlined_dt_current
			context.reset_inlined_dftype_current

				-- Free resources
			free_inlined_registers (local_regs)
			free_inlined_param_registers (argument_regs)

			if not local_is_current_temporary then
				current_reg.free_register
			end
			context.remove_inline_context
			Context.set_inlined_current_register (Void)
		end

	argument_type (pos: INTEGER): TYPE_A
			-- Type of the argument at position `pos'
		do
				-- No need to call `real_type' here, it was already done when `byte_code' was
				-- processed by `pre_inlined_code'.
			Result := byte_code.arguments.item (pos)
		end

feature -- Generation

	generate_parameters (gen_reg: REGISTRABLE)
		local
			expr: PARAMETER_B
			context_class_type: CLASS_TYPE
			written_class_type: CLASS_TYPE
			buf: GENERATION_BUFFER
			p: like parameters
			l_area: SPECIAL [PARAMETER_B]
			b_area: SPECIAL [BOOLEAN]
			i, count: INTEGER
		do
			Precursor {FEATURE_BL} (gen_reg)

			buf := buffer
			buf.generate_block_open
			buf.put_new_line
			buf.put_string (inline_comment_start_open)
			if
				written_in > 0 and then
				system.has_class_of_id (written_in) and then
				attached system.class_of_id (written_in) as c
			then
				buf.put_string (c.name)
				buf.put_character ('.')
			end
			buf.put_string (feature_name)
			buf.put_four_character (')', ' ', '*', '/')

				-- We disable the generation of the RTHOOK so that the
				-- callstack is easy to debug.			
			context.enter_hidden_code

			p := parameters
			if p /= Void then
					-- Assign the parameter values to the registers.
				from
					b_area := temporary_parameters.area
					l_area := p.area
					count := p.count
				until
					i = count
				loop
					if not b_area [i] then
						expr := l_area [i]
						buf.put_new_line
						argument_regs [i + 1].print_register
						buf.put_string (" = ")
						expr.print_register
						buf.put_character (';')
					end;
					i := i + 1
				end
			end

			context_class_type := system.class_type_of_id (context_type_id)
			written_class_type := system.class_type_of_id (written_type_id)

			Context.put_inline_context (Current,
				context_class_type, context_cl_type,
				written_class_type, written_cl_type)
			Context.set_inlined_current_register (current_reg)

			if attached local_regs as l_local_regs then
					-- Set the value of the local registers to the default
				from
					i := 1
					count := l_local_regs.count
				until
					i > count
				loop
					reset_register_value (byte_code.locals.item (i), l_local_regs.item (i))
					i := i + 1
				end
			end

			if attached result_reg as l_result_reg then
					-- Set the value of the result register to the default
				reset_register_value (real_type (result_type), l_result_reg)
			end

			if not is_current_temporary then
				buf.put_new_line
				current_register.print_register
				buf.put_string (" = ")

				-- `print_register' on `gen_reg' must be generated
				-- with the old context

				context.suspend_inline_context
				Context.set_inlined_current_register (Void)

				gen_reg.print_register
				buf.put_character (';')

				context.resume_inline_context
				Context.set_inlined_current_register (current_reg)
			end

				-- Generate a check that Current is not Void (see test#final088 when class removal is disabled).
			if not current_reg.is_current then
				buf.put_new_line
				buf.put_string ({C_CONST}.ignore_value)

				context.suspend_inline_context
				Context.set_inlined_current_register (Void)

				current_reg.print_checked_target_register

				context.resume_inline_context
				Context.set_inlined_current_register (current_reg)

				buf.put_character (';')
			end

			if inlined_dt_current > 1 or inlined_dftype_current > 1 then
				buf.put_new_line
				buf.put_character ('{')
				if inlined_dftype_current > 1 then
					context.set_inlined_dftype_current (inlined_dftype_current)
					buf.put_new_line
					buf.put_string ({C_CONST}.eif_type_index)
					buf.put_character (' ')
					buf.put_string ("inlined_dftype = ")
					buf.put_string ({C_CONST}.dftype)
					buf.put_character ('(')
					current_register.print_register
					buf.put_two_character (')', ';')
				end
				if inlined_dt_current > 1 then
					context.set_inlined_dt_current (inlined_dt_current)
					buf.put_new_line
					buf.put_string ({C_CONST}.eif_type_index)
					buf.put_character (' ')
					buf.put_string ("inlined_dtype = ")
					buf.put_string ({C_CONST}.dtype)
					buf.put_character ('(')
					current_register.print_register
					buf.put_two_character (')', ';')
				end
			end

			if attached compound as l_compound then
				l_compound.generate
			end

			if inlined_dt_current > 1 or inlined_dftype_current > 1 then
				buf.put_new_line
				buf.put_character ('}');
				if inlined_dt_current > 1 then
					context.set_inlined_dt_current (0);
				end
				if inlined_dftype_current > 1 then
					context.set_inlined_dftype_current (0);
				end
			end

				-- We restore the generation of RTHOOK now that we done
				-- with inlining.
			context.exit_hidden_code

			buf.put_new_line
			buf.put_string (inline_comment_end)

			buf.generate_block_close

			Context.remove_inline_context
			Context.set_inlined_current_register (Void)
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A)
		do
			Context.set_inlined_current_register (current_reg);
			if result_reg /= Void then
					-- print the value of the result register
				result_reg.print_register
			end;
			Context.set_inlined_current_register (Void)
		end

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_A;
		basic_type: BASIC_A; buf: GENERATION_BUFFER)
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

	inliner: INLINER
		do
			Result := System.remover.inliner
		end

feature {NONE} -- Registers

	get_inlined_registers (a: detachable ARRAY [TYPE_A]): detachable ARRAY [REGISTER]
		local
			i, count: INTEGER
		do
			if attached a and then not a.is_empty then
				from
					count := a.count
					create Result.make_filled (get_inline_register(real_type (a [1])), 1, count)
					i := 2
				until
					i > count
				loop
					Result [i] := get_inline_register(real_type (a [i]))
					i := i + 1
				end
			end
		end

	get_inlined_param_registers (a: ARRAY [TYPE_A]; has_hector: BOOLEAN): ARRAY [REGISTRABLE]
		local
			i ,count: INTEGER
			is_param_temporary_reg: BOOLEAN
			local_reg: REGISTRABLE
			l_param: PARAMETER_B
			expr, msg: EXPR_B
			nest: NESTED_B
		do
			if a /= Void then
				from
					i := 1
					count := a.count
					check
						same_count: count = parameters.count
					end
					create Result.make_filled (no_register, 1, count)
					create temporary_parameters.make_filled (False, 1, count)
					parameters.start
				until
					i > count
				loop
					is_param_temporary_reg := False
					l_param := parameters.item
					expr := l_param
					if l_param.is_temporary then
							-- It is safe to use a temporary register as an argument.
						local_reg := l_param
						is_param_temporary_reg := True
					elseif
						l_param.is_predefined or else
						(l_param.is_fast_as_local and then l_param.is_constant_expression)
					then
							-- It is safe to use a predefined register or a constant
							-- unless it is going to be accessed/changed by using address of the argument.
						if has_hector then
							local_reg := Void
						else
							local_reg := l_param
							is_param_temporary_reg := True
						end
					else
						local_reg := l_param.register
						if local_reg = Void then
								-- We have a parameter.
							expr := l_param.expression
							local_reg := expr.register
							if expr.is_temporary then
									-- It is safe to use a temporary register as an argument.
								local_reg := expr
								is_param_temporary_reg := True
							elseif expr.is_predefined then
									-- It is safe to use a predefined register
									-- unless it is going to be accessed/changed by using address of the argument.
								if has_hector then
									local_reg := Void
								else
									local_reg := expr
									is_param_temporary_reg := True
								end
							else
									-- We might have a nested call: `a.b.c.d'. The
									-- register we're looking for is d's, but we have to
									-- traverse the nested calls first:
								from
									nest := Void
									msg := expr
								until
									not attached {NESTED_B} msg as l_nested
								loop
									nest := l_nested
									msg := l_nested.message
								end
								if nest /= Void then
									local_reg := nest.register
								end
							end
						end
					end

					if not is_param_temporary_reg and then attached local_reg then
						is_param_temporary_reg :=
							if local_reg.is_temporary then
								local_reg /= no_register
							else
								local_reg.is_predefined and then not has_hector
							end
					end

					if is_param_temporary_reg then
							-- We only forbid inlining if basic types are not matching,
							-- to force a C cast to be performed.
						is_param_temporary_reg :=
							expr.type.is_basic implies expr.type.same_as (l_param.attachment_type)
					end
					temporary_parameters.put (is_param_temporary_reg, i)
					if is_param_temporary_reg then
						Result [i] := local_reg
					else
							-- The argument register (if any) is not used, it can be freed now.
						l_param.free_register
						Result [i] := get_inline_register (real_type (a.item (i)))
					end
					i := i + 1
					parameters.forth
				end
			end
		end

	get_inline_register (type_i: TYPE_A): REGISTER
		do
			create Result.make (type_i.c_type)
		end

	free_inlined_registers (a: ARRAY [REGISTER])
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

	free_inlined_param_registers (a: ARRAY [REGISTRABLE])
		require
			attached a implies attached parameters
		local
			i, count: INTEGER
		do
			if attached a and then attached parameters as p then
				check a.count = p.count end
				from
					i := 1
					count := a.count
				until
					i > count
				loop
					if not temporary_parameters [i] then
							-- The register has been allocated here.
						a [i].free_register
					end
					i := i + 1
				end
			end
		end

	free_param_registers
			-- <Precursor>
		local
			i: INTEGER
			n: INTEGER
			a: SPECIAL [BOOLEAN]
		do
			if attached parameters as p then
				from
					n := p.count
					i := 1
					a := temporary_parameters.area
				until
					i > n
				loop
					if a [i - 1] then
						p [i].free_register
					end
					i := i + 1
				end
			end
		end

	reset_register_value (a_type: TYPE_A; reg: REGISTER)
		local
			buf: GENERATION_BUFFER
			l_class_type: CLASS_TYPE
		do
			buf := buffer
			buf.put_new_line
			reg.print_register;
			buf.put_string (" = ");
			reg.c_type.generate_cast (buf);
			buf.put_string (" 0;");
			if a_type.is_true_expanded then
				l_class_type := a_type.associated_class_type (context.context_class_type.type)
				l_class_type.generate_expanded_creation (buf, reg.register_name, a_type, context.context_class_type)
				l_class_type.generate_expanded_initialization (buf, reg.register_name, reg.register_name, True)
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

	set_inlined_byte_code (b: STD_BYTE_CODE)
		do
			byte_code := b
		end

feature {NONE} -- Code generation

	inline_comment_start_open: STRING = "/* INLINED CODE ("
			-- The beginning of a leading comment for inlined feature.

	inline_comment_end: STRING = "/* END INLINED CODE */"
			-- The trailing comment for inlined feature.

note
	date: "$Date$"
	version: "$Revision$"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

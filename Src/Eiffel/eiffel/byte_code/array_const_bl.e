indexing
	description: "Enlarged byte code for manifest arrays"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ARRAY_CONST_BL

inherit
	ARRAY_CONST_B
		redefine
			analyze, generate,
			register, set_register,
			free_register, unanalyze
		end
	SHARED_TABLE
	SHARED_DECLARATIONS
	SHARED_TYPE_I
		export {NONE}
			all
		end

create
	make

feature

	register: REGISTRABLE
			-- Register for array

	item_register: REGISTER
			-- Register for array item

	array_area_reg: REGISTER
			-- Register for array area

	arg1_register: REGISTER
			-- Register for 1st argument of `make'

	arg2_register: REGISTER
			-- Register for 2nd argument of `make'

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'.
		do
			register := r
		end

	analyze is
			-- Analyze expression.
		local
			expr: EXPR_B
			real_ty: GEN_TYPE_A
			target_gen_type: TYPE_A
		do
			-- We need 'Current'
			context.add_dftype_current
			info.analyze

			real_ty ?= context.real_type (type)
			target_gen_type := real_ty.generics.item (1)

			get_register
			create array_area_reg.make (Reference_c_type)
			from
				expressions.start
			until
				expressions.after
			loop
				expr ?= expressions.item
				if item_register = Void and then expr.is_register_required (target_gen_type) then
					create item_register.make (target_gen_type.c_type)
				end
				expr.analyze
				expr.free_register
				expressions.forth
			end
			if context.workbench_mode then
				arg1_register := context.get_argument_register (int32_c_type)
				arg2_register := context.get_argument_register (int32_c_type)
			end
		end

	unanalyze is
			-- Unanalyze expression.
		local
			expr: EXPR_B
		do
			array_area_reg := Void
			set_register (Void)
			from
				expressions.start
			until
				expressions.after
			loop
				expr ?= expressions.item
				expr.unanalyze
				expressions.forth
			end;
			item_register := Void
			arg1_register := Void
			arg2_register := Void
		end

	free_register is
			-- Free the registers.
		do
			Precursor {ARRAY_CONST_B}
			if array_area_reg /= Void then
				array_area_reg.free_register
			end;
			if item_register /= Void then
				item_register.free_register
			end
			if arg1_register /= Void then
				arg1_register.free_register
			end
			if arg2_register /= Void then
				arg2_register.free_register
			end
		end

	generate is
			-- Generate expression
		local
			real_ty: GEN_TYPE_A
			workbench_mode: BOOLEAN
			target_gen_type: TYPE_A
		do
			real_ty ?= context.real_type (type)
			target_gen_type := real_ty.generics.item (1)
			workbench_mode := context.workbench_mode
			generate_array_creation (real_ty, workbench_mode)
			if workbench_mode then
				generate_wk_array_make (real_ty)
			else
				generate_final_array_make (real_ty)
			end;
			fill_array (target_gen_type)
		end

feature {NONE} -- C code generation

	generate_array_creation (real_ty: GEN_TYPE_A; workbench_mode: BOOLEAN) is
			-- Generate the object creation of
			-- manifest array.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			info.generate_start (buf)
			info.generate_gen_type_conversion (0)
			buf.put_new_line
			print_register
			buf.put_string (" = ")
			info.generate
			buf.put_character (';')
			info.generate_end (buf)
		end

	fill_array (target_type: TYPE_A) is
			-- Generate the registers for the expressions
			-- to fill the manifest array.
		local
			expr: EXPR_B;
			actual_type: TYPE_A;
			is_expanded: BOOLEAN;
			position: INTEGER;
			buf: GENERATION_BUFFER
			l_target_type: CL_TYPE_A
			l_exp_class_type: CLASS_TYPE
		do
			is_expanded := target_type.is_true_expanded;
			buf := buffer
			buf.put_new_line
			array_area_reg.print_register;
			buf.put_string (" = * (EIF_REFERENCE *) ");
			print_register;
			buf.put_character (';');
			if (is_expanded and then expressions.count > 0) then
				buf.put_new_line;
				buf.put_character ('{');
				buf.indent;
				buf.put_new_line;
				buf.put_string ("EIF_INTEGER elem_size;");
				buf.put_new_line;
				buf.put_string ("elem_size = *(EIF_INTEGER *) (");
				array_area_reg.print_register;
				buf.put_string (" + (HEADER(");
				array_area_reg.print_register;
				buf.put_string (")->ov_size & B_SIZE) - LNGPAD(2) + sizeof(EIF_INTEGER));");
			end;
			from
				expressions.start;
				position := 0;
			until
				expressions.after
			loop
				expr ?= expressions.item;
				actual_type := context.real_type (expr.type);
				expr.generate_for_type (item_register, target_type)
				buf.put_new_line
				if is_expanded then
					if context.workbench_mode then
						buf.put_string ("ecopy(");
						item_print_register (expr, target_type)
						buf.put_string (gc_comma);
						array_area_reg.print_register;
						buf.put_string (" + OVERHEAD + elem_size * ");
						buf.put_integer (position);
						buf.put_character (')');
					else
						l_target_type ?= target_type
						check
							l_target_type_not_void_since_expanded: l_target_type /= Void
						end
						l_exp_class_type := l_target_type.associated_class_type (context.context_class_type.type)
						if l_exp_class_type.skeleton.has_references then
							buf.put_string ("ecopy(");
							item_print_register (expr, target_type)
							buf.put_string (gc_comma);
							array_area_reg.print_register;
							buf.put_string (" + OVERHEAD + elem_size * ");
							buf.put_integer (position);
							buf.put_character (')');
						else
							buf.put_string ("memcpy(")
							array_area_reg.print_register
							buf.put_string (" + ")
							buf.put_integer (position)
							buf.put_string (" * ")
							l_exp_class_type.skeleton.generate_size (buf)
							buf.put_string (",")
							item_print_register (expr, target_type)
							buf.put_string (", ")
							l_exp_class_type.skeleton.generate_size (buf)
							buf.put_character (')')
						end
					end
				else
					buf.put_character ('*');
					buf.put_character ('(');
					target_type.c_type.generate_access_cast (buf);
					array_area_reg.print_register;
					buf.put_character('+');
					buf.put_integer (position);
					buf.put_character (')');
					buf.put_string (" = ");
					target_type.c_type.generate_cast (buf);
					item_print_register (expr, target_type)
						-- Generation of the RTAR protection
						-- if the array contains references
					if target_type.is_reference or target_type.is_bit then
						buf.put_character (';');
						buf.put_new_line
						buf.put_string ("RTAR(");
						array_area_reg.print_register;
						buf.put_character (',');
						item_print_register (expr, target_type)
						buf.put_character (')');
					end
				end
				buf.put_character (';')
				expressions.forth
				position := position + 1
			end
			if (is_expanded and expressions.count > 0) then
				buf.exdent
				buf.put_new_line
				buf.put_character ('}')
			end
		end

	generate_final_array_make (real_ty: GEN_TYPE_A)	is
				-- Generate code to call the make routine
				-- of the manifest array in final mode.
		local
			rout_table: ROUT_TABLE
			internal_name: STRING
			rout_id: INTEGER
		do
			rout_id := real_ty.associated_class.feature_table.item_id (make_name_id).rout_id_set.first;
			rout_table ?= Eiffel_table.poly_table (rout_id);

				-- Generate the signature of the function
			rout_table.goto_implemented (real_ty.type_id (context.context_class_type.type))
			check
				is_implemented: rout_table.is_implemented
			end
			internal_name := rout_table.feature_name.twin
			buffer.put_new_line
			buffer.put_string ("(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))")
			buffer.put_string (internal_name);
			buffer.put_string (")")

				-- Generate the arguments
			generate_array_make_arguments;

				-- Remember extern routine declaration
				-- Since `make' from ARRAY is a procedure, the return type is `Void_type'
				--| Note: it used to be `real_ty.c_type' but it was the C type of
				--| the array itself and not of the `make' routine and thus was incorrect.
			Extern_declarations.add_routine_with_signature (Void_c_type.c_string, internal_name,
							<<"EIF_REFERENCE", "EIF_INTEGER", "EIF_INTEGER">>)
		end;

	generate_wk_array_make (real_ty: GEN_TYPE_A)	is
				-- Generate code to call the make routine
				-- of the manifest array in workbench mode.
		local
			f_table: FEATURE_TABLE;
			feat_i: FEATURE_I;
			r_id: INTEGER;
			rout_info: ROUT_INFO;
			base_class: CLASS_C
			buf: GENERATION_BUFFER
		do
			base_class := real_ty.associated_class
			f_table := base_class.feature_table
			feat_i := f_table.item_id (make_name_id)
			buf := buffer
			buf.put_new_line
			arg1_register.print_register
			buf.put_string (" = 1L;")
			buf.put_new_line
			arg2_register.print_register
			buf.put_string (" = ")
			buf.put_integer (expressions.count)
			buf.put_string ("L;")
			buf.put_new_line
			buf.put_string ("(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE))");
			if
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				buf.put_string (" RTWPF(");
				r_id := feat_i.rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				buf.put_class_id (rout_info.origin);
				buf.put_string (gc_comma);
				buf.put_integer (rout_info.offset);
			else
				buf.put_string (" RTWF(");
				buf.put_static_type_id (real_ty.static_type_id (context.context_class_type.type));
				buf.put_string (gc_comma);
				buf.put_integer (feat_i.feature_id);
			end;
			buf.put_string (gc_comma);
			buf.put_string (gc_upper_dtype_lparan);
			print_register;
			buf.put_string (")))");
			buf.put_character ('(')
			print_register
			buf.put_string (gc_comma)
			context.print_argument_register (arg1_register, buf)
			buf.put_string (gc_comma)
			context.print_argument_register (arg2_register, buf)
			buf.put_string (gc_rparan_semi_c)
		end;

	generate_array_make_arguments is
			-- Generate the arguments for the array creation.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_character ('(');
			print_register;
			buf.put_string (gc_comma);
			buf.put_string ("1L, ");
			buf.put_integer (expressions.count);
			buf.put_string ("L);");
		end;

	item_print_register (expr: EXPR_B; target_type: TYPE_A) is
			-- Print register for `expr' taking into account
			-- that its value may be stored in `item_register'.
		require
			expr_not_void: expr /= Void
			target_type_not_void: target_type /= Void
			item_register_not_void: expr.is_register_required (target_type) implies item_register /= Void
		do
			if expr.is_register_required (target_type) then
				item_register.print_register
			else
				expr.print_register
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

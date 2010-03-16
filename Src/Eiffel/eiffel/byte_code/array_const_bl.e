note
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
	make_from_other

feature {NONE} -- Initialization

	make_from_other (a_other: ARRAY_CONST_B)
			-- Initialize Current from `a_other' instance.
		require
			a_other_not_void: a_other /= Void
		do
			expressions := a_other.expressions
			type := a_other.type
			special_info := a_other.special_info
		ensure
			expression_set: expressions = a_other.expressions
			type_set: type = a_other.type
			special_info_set: special_info = a_other.special_info
		end

feature

	register: REGISTRABLE
			-- Register for array

	item_register: REGISTER
			-- Register for array item

	array_area_reg: REGISTER
			-- Register for array area

	arg_count_parameter: PARAMETER_BL
			-- Expression to hold SPECIAL count

	set_register (r: REGISTRABLE)
			-- Set `register' to `r'.
		do
			register := r
		end

	analyze
			-- Analyze expression.
		local
			expr: EXPR_B
			real_ty: GEN_TYPE_A
			target_gen_type: TYPE_A
			l_count: INTEGER_CONSTANT
		do
			special_info := special_info.updated_info
			special_info.analyze

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

			create l_count.make_with_value (expressions.count)
			create arg_count_parameter
			arg_count_parameter.set_attachment_type (integer_32_type)
			arg_count_parameter.set_expression (l_count)
			arg_count_parameter.analyze
		end

	unanalyze
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
			if arg_count_parameter /= Void then
				arg_count_parameter.unanalyze
				arg_count_parameter := Void
			end
			item_register := Void
		end

	free_register
			-- Free the registers.
		do
			Precursor {ARRAY_CONST_B}
			if array_area_reg /= Void then
				array_area_reg.free_register
			end;
			if item_register /= Void then
				item_register.free_register
			end
			if arg_count_parameter /= Void then
				arg_count_parameter.free_register
			end
		end

	generate
			-- Generate expression
		local
			real_ty: TYPE_A
			target_gen_type: TYPE_A
		do
			real_ty := context.real_type_in (special_info.type, context.context_cl_type)
			target_gen_type := real_ty.generics.item (1)
			generate_special_creation (target_gen_type)
			fill_special (target_gen_type)
			if context.workbench_mode then
				generate_wk_array_make (real_ty)
			else
				generate_final_array_make (real_ty)
			end;
		end

feature {NONE} -- C code generation

	generate_special_creation (target_type: TYPE_A)
			-- Generate the object creation of
			-- manifest array.
		local
			buf: GENERATION_BUFFER
			l_special_type: TYPE_A
			l_special_class_type: SPECIAL_CLASS_TYPE
		do
			buf := buffer

			l_special_type := special_info.type
			check
				is_special_type: l_special_type /= Void and then l_special_type.associated_class.lace_class = System.special_class
			end
			l_special_class_type ?= l_special_type.associated_class_type (Context.context_class_type.type)
			check
				l_class_type_not_void: l_special_class_type /= Void
			end

			arg_count_parameter.generate

			special_info.generate_start (buf)
			special_info.generate_gen_type_conversion (0)
			l_special_class_type.generate_creation (buf, special_info, array_area_reg, arg_count_parameter, False, False, False)

			if not target_type.is_true_expanded and then system.is_using_new_special then
				buffer.put_new_line
				buffer.put_string ("RT_SPECIAL_COUNT(")
				array_area_reg.print_register
				buffer.put_four_character (')', ' ', '=', ' ')
				buffer.put_integer (expressions.count)
				buffer.put_two_character ('L', ';')
					-- For arrays of basic type we initialize them in workbench mode
					-- in case the debugger would show the SPECIAL content and we don't
					-- want users to see garbage there.
				if not target_type.is_basic or else context.workbench_mode then
					buffer.put_new_line
					buffer.put_string ("memset(")
					array_area_reg.print_register
					buffer.put_string (", 0, RT_SPECIAL_VISIBLE_SIZE(")
					array_area_reg.print_register
					buffer.put_string ("));")
				end
			end

			special_info.generate_end (buf)
		end

	fill_special (target_type: TYPE_A)
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
			if (is_expanded and then expressions.count > 0) then
				buf.put_new_line;
				buf.put_character ('{');
				buf.indent;
				buf.put_new_line;
				buf.put_string ("rt_uint_ptr elem_size;");
				buf.put_new_line;
				buf.put_string ("elem_size = RT_SPECIAL_ELEM_SIZE(")
				array_area_reg.print_register;
				buf.put_two_character (')', ';')
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
						buf.put_string (" + OVERHEAD + (rt_uint_ptr) elem_size * (rt_uint_ptr) ");
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
							buf.put_string (" + OVERHEAD + (rt_uint_ptr) elem_size * (rt_uint_ptr) ");
							buf.put_integer (position);
							buf.put_character (')');
						else
							buf.put_string ("memcpy(")
							array_area_reg.print_register
							buf.put_string (" + (rt_uint_ptr) ")
							buf.put_integer (position)
							buf.put_string (" * (rt_uint_ptr) ")
							l_exp_class_type.skeleton.generate_size (buf, True)
							buf.put_string (",")
							item_print_register (expr, target_type)
							buf.put_string (", ")
							l_exp_class_type.skeleton.generate_size (buf, True)
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
				if system.is_using_new_special and target_type.is_true_expanded then
						-- Count is already set in `generate_special_creation' for SPECIAL of references and basic types.
					buf.put_string ("RT_SPECIAL_COUNT(")
					array_area_reg.print_register
					buf.put_string (")++;")
				end
				expressions.forth
				position := position + 1
			end
			if (is_expanded and expressions.count > 0) then
				buf.exdent
				buf.put_new_line
				buf.put_character ('}')
			end
		end

	generate_final_array_make (real_ty: TYPE_A)
				-- Generate code to call the make routine
				-- of the manifest array in final mode.
		local
			rout_table: ROUT_TABLE
			internal_name: STRING
			rout_id: INTEGER
		do
				-- Get the type of the SPECIAL.
			rout_id := real_ty.associated_class.feature_table.item_id ({PREDEFINED_NAMES}.to_array_name_id).rout_id_set.first;
			rout_table ?= Eiffel_table.poly_table (rout_id);

				-- Generate the signature of the function
			rout_table.goto_implemented (real_ty, context.context_class_type)
			check
				is_implemented: rout_table.is_implemented
			end
			internal_name := rout_table.feature_name.string
			buffer.put_new_line
			print_register
			buffer.put_four_character (' ', '=', ' ', '(')
			reference_c_type.generate_function_cast (buffer, << "EIF_REFERENCE" >>, False)
			buffer.put_string (internal_name);
			buffer.put_string (")")

				-- Generate the arguments
			buffer.put_character ('(');
			array_area_reg.print_register;
			buffer.put_two_character (')', ';');

				-- Remember extern routine declaration
				-- Since `make_from_special' from ARRAY is a procedure, the return type is `Void_type'
				--| Note: it used to be `real_ty.c_type' but it was the C type of
				--| the array itself and not of the `make' routine and thus was incorrect.
			Extern_declarations.add_routine_with_signature (reference_c_type.c_string, internal_name,
				<<"EIF_REFERENCE">>)
		end;

	generate_wk_array_make (real_ty: TYPE_A)
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
			feat_i := f_table.item_id ({PREDEFINED_NAMES}.to_array_name_id)
			buf := buffer
			buf.put_new_line
			print_register
			buffer.put_four_character (' ', '=', ' ', '(')
			reference_c_type.generate_function_cast (buffer, << "EIF_REFERENCE" >>, True)
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
			array_area_reg.print_register
			buf.put_string (")))");
			buf.put_character ('(')
			array_area_reg.print_register
			buf.put_two_character (')', '.')
			reference_c_type.generate_typed_field (buf)
			buf.put_character (';')
		end;

	generate_array_make_arguments
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

	item_print_register (expr: EXPR_B; target_type: TYPE_A)
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

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

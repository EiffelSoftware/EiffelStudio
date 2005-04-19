indexing
	description: "Enlarged byte code for manifest arrays"
	date: "$Date$"
	revision: "$Revision$"

class ARRAY_CONST_BL

inherit
	ARRAY_CONST_B
		redefine
			analyze, generate, 
			register, set_register, 
			free_register, unanalyze
		end;
	SHARED_TABLE;
	SHARED_DECLARATIONS;

create
	make

feature 

	register: REGISTRABLE;
			-- Register for array

	array_area_reg: REGISTER;
			-- Register for array area

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r' 
		do
			register := r;	
		end;

	analyze is
			-- Analyze expression
		local
			expr: EXPR_B;
		do
			-- We need 'Current'
			context.add_dftype_current;
			info.analyze

			get_register;
			create array_area_reg.make (Reference_c_type.c_type);
			from
				expressions.start
			until
				expressions.after 
			loop
				expr ?= expressions.item;
				expr.analyze;
				expr.free_register;
				expressions.forth
			end;
		end;

	unanalyze is
			-- Unanalyze expression
		local
			expr: EXPR_B;
		do
			array_area_reg := Void;
			set_register (Void)	
			from
				expressions.start
			until
				expressions.after
			loop
				expr ?= expressions.item;
				expr.unanalyze;
				expressions.forth
			end;
		end;

	free_register is
			-- Free the registers.
		do
			Precursor {ARRAY_CONST_B}
			if array_area_reg /= Void then
				array_area_reg.free_register
			end;
		end;

	generate is
			-- Generate expression
		local
			real_ty: GEN_TYPE_I;
			workbench_mode: BOOLEAN;
			target_gen_type: TYPE_I;
		do
			real_ty ?= context.real_type (type);
			target_gen_type := real_ty.meta_generic.item (1);
			workbench_mode := context.workbench_mode;
			generate_array_creation (real_ty, workbench_mode);
			if workbench_mode then
				generate_wk_array_make (real_ty)
			else
				generate_final_array_make (real_ty)
			end;
			fill_array (target_gen_type);
		end;

feature {NONE} -- C code generation

	generate_array_creation (real_ty: GEN_TYPE_I; workbench_mode: BOOLEAN) is
			-- Generate the object creation of 
			-- manifest array.
		local
			buf: GENERATION_BUFFER
		do
			info.generate_start (Current)
			info.generate_gen_type_conversion (Current)
			print_register;
			buf := buffer
			buf.put_string (" = ");
			info.generate
			buf.put_character (';');
			buf.put_new_line;
			generate_block_close;
		end;

	fill_array (target_type: TYPE_I) is
			-- Generate the registers for the expressions
			-- to fill the manifest array.
		local
			expr: EXPR_B;
			actual_type: TYPE_I;
			is_expanded: BOOLEAN;
			position: INTEGER;
			buf: GENERATION_BUFFER
			l_target_type: CL_TYPE_I
			l_exp_class_type: CLASS_TYPE
		do
			is_expanded := target_type.is_true_expanded;
			array_area_reg.print_register;
			buf := buffer
			buf.put_string (" = * (EIF_REFERENCE *) ");
			print_register;
			buf.put_character (';');
			buf.put_new_line;
			if (is_expanded and then expressions.count > 0) then
				buf.put_character ('{');
				buf.put_new_line;
				buf.indent;
				buf.put_string ("EIF_INTEGER elem_size;");
				buf.put_new_line;
				buf.put_string ("elem_size = *(EIF_INTEGER *) (");
				array_area_reg.print_register;
				buf.put_string (" + (HEADER(");
				array_area_reg.print_register;
				buf.put_string (")->ov_size & B_SIZE) - LNGPAD(2) + sizeof(EIF_INTEGER));");
				buf.put_new_line;
			end;
			from
				expressions.start;
				position := 0;
			until
				expressions.after
			loop
				expr ?= expressions.item;
				actual_type := context.real_type (expr.type);
				expr.generate;
				if is_expanded then
					if context.workbench_mode then
						buf.put_string ("ecopy(");
						expr.print_register;
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
						l_exp_class_type := l_target_type.associated_class_type
						if l_exp_class_type.skeleton.has_references then
							buf.put_string ("ecopy(");
							expr.print_register;
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
							expr.print_register
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
					expr.print_register;
						-- Generation of the RTAR protection
						-- if the array contains references
					if target_type.is_reference or target_type.is_bit then
						buf.put_character (';');
						buf.put_new_line
						buf.put_string ("RTAR(");
						array_area_reg.print_register;
						buf.put_character (',');
						expr.print_register;
						buf.put_character (')');
					end
				end
				buf.put_character (';')
				buf.put_new_line
				expressions.forth
				position := position + 1
			end
			if (is_expanded and expressions.count > 0) then
				buf.exdent
				buf.put_character ('}')
				buf.put_new_line
			end
		end

	generate_final_array_make (real_ty: GEN_TYPE_I)	is
				-- Generate code to call the make routine 
				-- of the manifest array in final mode.
		local
			rout_table: ROUT_TABLE
			internal_name: STRING
			rout_id: INTEGER
		do
			rout_id := real_ty.base_class.feature_table.item_id (make_name_id).rout_id_set.first;
			rout_table ?= Eiffel_table.poly_table (rout_id);

				-- Generate the signature of the function
			rout_table.goto_implemented (real_ty.type_id)
			check
				is_implemented: rout_table.is_implemented
			end
			internal_name := rout_table.feature_name.twin
			buffer.put_string ("(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))")
			buffer.put_string (internal_name);
			buffer.put_string (")")

				-- Generate the arguments
			generate_array_make_arguments;

				-- Remember extern routine declaration
				-- Since `make' from ARRAY is a procedure, the return type is `Void_c_type'
				--| Note: it used to be `real_ty.c_type' but it was the C type of
				--| the array itself and not of the `make' routine and thus was incorrect.
			Extern_declarations.add_routine_with_signature (Void_c_type, internal_name,
							<<"EIF_REFERENCE", "EIF_INTEGER", "EIF_INTEGER">>)
		end;

	generate_wk_array_make (real_ty: GEN_TYPE_I)	is
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
			base_class := real_ty.base_class;
			f_table := base_class.feature_table;
			feat_i := f_table.item_id (make_name_id);
			buf := buffer
			buf.put_string ("(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))");
			if 
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				buf.put_string ("RTWPF(");
				r_id := feat_i.rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				buf.put_class_id (rout_info.origin);
				buf.put_string (gc_comma);
				buf.put_integer (rout_info.offset);
			else
				buf.put_string (" RTWF(");
				buf.put_static_type_id (real_ty.associated_class_type.static_type_id);
				buf.put_string (gc_comma);
				buf.put_integer (feat_i.feature_id);
			end;
			buf.put_string (gc_comma);
			buf.put_string (gc_upper_dtype_lparan);
			print_register;
			buf.put_string (")))");
			generate_array_make_arguments;
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
			buf.put_new_line;
		end;

end

-- Enlarged byte code for manifest arrays

class ARRAY_CONST_BL

inherit

	ARRAY_CONST_B
		redefine
			analyze, generate, 
			register, set_register, 
			free_register, unanalyze,
			allocates_memory,
			has_call
		end;
	SHARED_TABLE;
	SHARED_DECLARATIONS;
	
feature 

	register: REGISTRABLE;
			-- Register for array

	array_area_reg: REGISTER;
			-- Register for array area

	metamorphose_reg: REGISTER;
			-- Register for metamorphosis

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r' 
		do
			register := r;	
		end;

	analyze is
			-- Analyze expression
		local
			target_gen_type: TYPE_I;
			real_ty: GEN_TYPE_I;
			expr: EXPR_B;
			require_meta: BOOLEAN
		do
			-- We need 'Current'
			context.mark_current_used;

			real_ty ?= context.real_type (type);
			target_gen_type := real_ty.meta_generic.item (1);
			get_register;
			!!array_area_reg.make (ref_type.c_type);
			from
				expressions.start
			until
				expressions.after 
			loop
				expr ?= expressions.item;
				if 
					need_metamorphosis (context.real_type (expr.type)) 
				then
					require_meta := True;
				end;
				expr.analyze;
				expr.free_register;
				expressions.forth
			end;
			if require_meta then
				!!metamorphose_reg.make (target_gen_type.c_type);
			end;
		end;

	unanalyze is
			-- Unanalyze expression
		local
			expr: EXPR_B;
		do
			array_area_reg := Void;
			metamorphose_reg := Void;
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
			if array_area_reg /= Void then
				array_area_reg.free_register
			end;
			if metamorphose_reg /= Void then
				metamorphose_reg.free_register
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

	has_call: BOOLEAN is
		local
			expr: EXPR_B;
		do
			from
				expressions.start
			until
				expressions.after or else Result
			loop
				expr ?= expressions.item;
				Result := expr.has_call;
				expressions.forth
			end;
		end;

	allocates_memory: BOOLEAN is True;

feature {NONE} -- C code generation

	generate_array_creation (real_ty: GEN_TYPE_I; workbench_mode: BOOLEAN) is
			-- Generate the object creation of 
			-- manifest array.
		local
			buf: GENERATION_BUFFER
		do
			generate_block_open;
			generate_gen_type_conversion (real_ty);
			print_register;
			buf := buffer
			buf.putstring (" = ");
			buf.putstring ("RTLN(typres);");
			buf.new_line;
			generate_block_close;
		end;

	fill_array (target_type: TYPE_I) is
			-- Generate the registers for the expressions
			-- to fill the manifest array.
		local
			expr: EXPR_B;
			actual_type: TYPE_I;
			basic_i: BASIC_I;
			metamorphosed: BOOLEAN;
			is_expanded: BOOLEAN;
			position: INTEGER;
			buf: GENERATION_BUFFER
		do
			is_expanded := target_type.is_expanded;
			array_area_reg.print_register;
			buf := buffer
			buf.putstring (" = * (char **) ");
			print_register;
			buf.putchar (';');
			buf.new_line;
			if (is_expanded and then expressions.count > 0) then
				buf.putchar ('{');
				buf.new_line;
				buf.indent;
				buf.putstring ("long elem_size;");
				buf.new_line;
				buf.putstring ("elem_size = *(long *) (");
				array_area_reg.print_register;
				buf.putstring (" + (HEADER(");
				array_area_reg.print_register;
				buf.putstring (")->ov_size & B_SIZE) - LNGPAD(2) + sizeof(long));");
				buf.new_line;
			end;
			from
				expressions.start;
				position := 0;
			until
				expressions.after
			loop
				metamorphosed := False;
				expr ?= expressions.item;
				actual_type := context.real_type (expr.type);
				if need_metamorphosis (actual_type) then
					basic_i ?= actual_type;
					expr.generate;
					basic_i.metamorphose 
						(metamorphose_reg, expr, buf, context.workbench_mode);
					buf.putchar (';');
					buf.new_line;
					metamorphosed := True
				else
					expr.generate;
				end;
				if is_expanded then
					buf.putstring ("ecopy(");
					expr.print_register;
					buf.putstring (gc_comma);
					array_area_reg.print_register;
					buf.putstring (" + OVERHEAD + elem_size * ");
					buf.putint (position);
					buf.putchar (')');
				else
						-- Generation of the RTAS protection if the array contains references
					if target_type.is_reference then
						buf.putstring ("RTAS(");
						if metamorphosed then
							metamorphose_reg.print_register
						else
							expr.print_register;
						end;
						buf.putstring (", ");
						array_area_reg.print_register;
						buf.putstring (");");
						buf.new_line;
					end
					buf.putchar ('*');
					target_type.c_type.generate_access_cast (buf);
					buf.putchar ('(');
					array_area_reg.print_register;
					buf.putstring (gc_plus);
					buf.putint (position);
					buf.putstring (gc_star);
					target_type.c_type.generate_size (buf);
					buf.putchar (')');
					buf.putstring (" = ");
					if metamorphosed then
						metamorphose_reg.print_register
					else
						expr.print_register;
					end;
				end;
				buf.putchar (';');
				buf.new_line;
				expressions.forth;
				position := position + 1;
			end;
			if (is_expanded and expressions.count > 0) then
				buf.exdent;
				buf.putchar ('}');
				buf.new_line;
			end;
		end;

	generate_final_array_make (real_ty: GEN_TYPE_I)	is
				-- Generate code to call the make routine 
				-- of the manifest array in final mode.
		local
			entry: POLY_TABLE [ENTRY];
			rout_table: ROUT_TABLE;
			internal_name, table_name: STRING;
			rout_id: ROUTINE_ID;
		do
			rout_id := real_ty.base_class.feature_table.item ("make").rout_id_set.first;
			entry := Eiffel_table.poly_table (rout_id);
			rout_table ?= entry;

				-- Generate the signature of the function
			internal_name := clone (rout_table.feature_name (real_ty.type_id))
			buffer.putstring ("(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))")
			buffer.putstring (internal_name);
			buffer.putstring (")")

				-- Generate the arguments
			generate_array_make_arguments;

				-- Remember extern routine declaration
				-- Since `make' from ARRAY is a procedure, the return type is `Void_c_type'
				--| Note: it used to be `real_ty.c_type' but it was the C type of
				--| the array itself and not of the `make' routine and thus was incorrect.
			Extern_declarations.add_routine (Void_c_type, internal_name)
		end;

	generate_wk_array_make (real_ty: GEN_TYPE_I)	is
				-- Generate code to call the make routine 
				-- of the manifest array in workbench mode.
		local
			f_table: FEATURE_TABLE;
			feat_i: FEATURE_I;
			r_id: ROUTINE_ID;
			rout_info: ROUT_INFO;
			base_class: CLASS_C
			buf: GENERATION_BUFFER
		do
			base_class := real_ty.base_class;
			f_table := base_class.feature_table;
			feat_i := f_table.item ("make");
			buf := buffer
			buf.putstring ("(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))");
			if 
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				buf.putstring ("RTWPF(");
				r_id := feat_i.rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				rout_info.origin.generated_id (buf);
				buf.putstring (gc_comma);
				buf.putint (rout_info.offset);
			else
				buf.putstring (" RTWF(");
				buf.putint (real_ty.associated_class_type.id.id - 1);
				buf.putstring (gc_comma);
				buf.putint (feat_i.feature_id);
			end;
			buf.putstring (gc_comma);
			buf.putstring (gc_upper_dtype_lparan);
			print_register;
			buf.putstring (")))");
			generate_array_make_arguments;
		end;

	generate_array_make_arguments is
			-- Generate the arguments for the array creation.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putchar ('(');
			print_register;
			buf.putstring (gc_comma);
			buf.putstring ("1L, ");
			buf.putint (expressions.count);
			buf.putstring ("L);");
			buf.new_line;
		end;

end

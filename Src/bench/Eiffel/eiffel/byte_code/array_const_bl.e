-- Enlarged byte code for manifest arrays

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
		do
			array_area_reg := Void;
			metamorphose_reg := Void;
			set_register (Void)	
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
		do
			real_ty ?= context.real_type (type);
			generate_array_creation (real_ty);
			if context.workbench_mode then
				generate_wk_array_make (real_ty)
			else
				generate_final_array_make (real_ty)
			end;
			fill_array (real_ty);
		end;

feature {NONE} -- C code generation

	generate_array_creation (real_ty: GEN_TYPE_I) is
			-- Generate the object creation of 
			-- manifest array.
		do
			print_register;
			generated_file.putstring (" = ");
			generated_file.putstring ("RTLN(");
			generated_file.putint (real_ty.type_id - 1);
			generated_file.putstring (");");
			generated_file.new_line;
		end;

	fill_array (real_ty: GEN_TYPE_I) is
			-- Generate the registers for the expressions
			-- to fill the manifest array.
		local
			expr: EXPR_B;
			actual_type: TYPE_I;
			basic_i: BASIC_I;
			metamorphosed: BOOLEAN
		do
			array_area_reg.print_register;
			generated_file.putstring (" = *");
			real_ty.c_type.generate_access_cast (generated_file);
			print_register;
			generated_file.putchar (';');
			generated_file.new_line;
			from
				expressions.start
			until
				expressions.after
			loop
				metamorphosed := False;
				expr ?= expressions.item;
				actual_type := context.real_type (expr.type);
				if need_metamorphosis (actual_type) then
					if actual_type.is_expanded then
						-- Expanded objects are cloned
						metamorphose_reg.print_register;
                		generated_file.putstring (" = ");
                		generated_file.putstring ("RTCL(");
                		metamorphose_reg.print_register;
                		generated_file.putchar(')');
					else
						basic_i ?= actual_type;
						basic_i.metamorphose 
							(metamorphose_reg, expr, generated_file, context.workbench_mode);
					end;
					generated_file.putchar (';');
					generated_file.new_line;
					metamorphosed := True
				else
					expr.generate;
				end;
				generated_file.putstring ("*(");
				real_ty.c_type.generate_access_cast (generated_file);
				array_area_reg.print_register;
				generated_file.putstring (")++ = ");
				if metamorphosed then
					metamorphose_reg.print_register
				else
					expr.print_register;
				end;
				generated_file.putstring (";");
				generated_file.new_line;
				expressions.forth;
			end;
		end;

	generate_final_array_make (real_ty: GEN_TYPE_I)	is
				-- Generate code to call the make routine 
				-- of the manifest array in final mode.
		local
			entry: POLY_TABLE [ENTRY];
			rout_table: ROUT_TABLE;
			internal_name, table_name: STRING;
			rout_id: INTEGER;
		do
			rout_id := real_ty.base_class.feature_table.item 
							("make").rout_id_set.first;
			entry := Eiffel_table.item_id (rout_id);
			rout_table ?= entry;
			internal_name := rout_table.feature_name (real_ty.type_id).twin;
			generated_file.putstring (internal_name);
			generate_array_make_arguments;
				-- Remember extern routine declaration
			Extern_declarations.add_routine
				(real_ty.c_type, internal_name)
		end;

	generate_wk_array_make (real_ty: GEN_TYPE_I)	is
				-- Generate code to call the make routine 
				-- of the manifest array in workbench mode.
		local
			f_table: FEATURE_TABLE;
			feat_i: FEATURE_I;
			feat_id: INTEGER;
		do
			f_table := real_ty.base_class.feature_table;
			feat_i := f_table.item ("make");
			feat_id := feat_i.feature_id;
			generated_file.putstring ("((void (*)())");
			generated_file.putstring ("RTWF(");
			generated_file.putint (real_ty.associated_class_type.id - 1);
			generated_file.putstring (", ");
			generated_file.putint (feat_id);
			generated_file.putstring (", ");
			generated_file.putint (real_ty.type_id - 1);
			generated_file.putstring ("))");
			generate_array_make_arguments;
		end;

	generate_array_make_arguments is
			-- Generate the arguments for the array creation.
		do
			generated_file.putchar ('(');
			print_register;
			generated_file.putstring (", ");
			generated_file.putstring ("1L, ");
			generated_file.putint (expressions.count);
			generated_file.putstring ("L");
			generated_file.putchar (')');
			generated_file.putchar (';');
			generated_file.new_line;
		end;

end

-- Enlarged byte code for manifest tuples

class TUPLE_CONST_BL

inherit

	TUPLE_CONST_B
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

	register: REGISTRABLE
			-- Register for array

	array_area_reg: REGISTER
			-- Register for array area

	metamorphose_regs: ARRAY [REGISTER]
			-- Registers for metamorphosis

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r' 
		do
			register := r
		end

	analyze is
			-- Analyze expression
		local
			real_ty: TUPLE_TYPE_I
			expr_type: TYPE_I
			expr: EXPR_B
			i: INTEGER
			reg : REGISTER
			ref_i: REFERENCE_I
			require_meta: BOOLEAN
		do
			-- We need 'Current'
			context.mark_current_used

			real_ty ?= context.real_type (type)

			get_register
			!!array_area_reg.make (Reference_c_type.c_type)
			from
				i := 0
				expressions.start
			until
				expressions.after 
			loop
				expr ?= expressions.item
				expr_type := context.real_type (expr.type)

				if expr_type.is_basic then 
					require_meta := True
				end
				expr.analyze
				expr.free_register
				expressions.forth
				i := i + 1
			end
			if require_meta then
				from
					!!ref_i
					!!metamorphose_regs.make (1, i)
					expressions.start
					i := 1
				until
					expressions.after 
				loop
					expr ?= expressions.item
					expr_type := context.real_type (expr.type)

					if expr_type.is_basic then 
						!!reg.make (ref_i.c_type)
						metamorphose_regs.put (reg, i)
					end
					expressions.forth
					i := i + 1
				end
			end
		end

	unanalyze is
			-- Unanalyze expression
		local
			expr: EXPR_B
		do
			array_area_reg := Void
			metamorphose_regs := Void
			set_register (Void)	
			from
				expressions.start
			until
				expressions.after
			loop
				expr ?= expressions.item
				expr.unanalyze
				expressions.forth
			end
		end

	free_register is
			-- Free the registers.
		local
			i   : INTEGER
			reg : REGISTER
		do
			Precursor {TUPLE_CONST_B}
			if array_area_reg /= Void then
				array_area_reg.free_register
			end
			if metamorphose_regs /= Void then
				from
					i := metamorphose_regs.count
				until
					i < 1
				loop
					reg := metamorphose_regs.item (i)

					if reg /= Void then
						reg.free_register
					end
					i := i - 1
				end
			end
		end

	generate is
			-- Generate expression
		local
			real_ty: TUPLE_TYPE_I
			workbench_mode: BOOLEAN
		do
			real_ty ?= context.real_type (type)
			workbench_mode := context.workbench_mode
			generate_tuple_creation (real_ty, workbench_mode)
			if workbench_mode then
				generate_wk_tuple_make (real_ty)
			else
				generate_final_tuple_make (real_ty)
			end
			fill_tuple (real_ty.meta_generic)
		end

	has_call: BOOLEAN is
		local
			expr: EXPR_B
		do
			from
				expressions.start
			until
				expressions.after or else Result
			loop
				expr ?= expressions.item
				Result := expr.has_call
				expressions.forth
			end
		end

	allocates_memory: BOOLEAN is True

feature {NONE} -- C code generation

	generate_tuple_creation (real_ty: TUPLE_TYPE_I; workbench_mode: BOOLEAN) is
			-- Generate the object creation of 
			-- manifest tuple.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			generate_block_open
			generate_gen_type_conversion (real_ty)
			print_register
			buf.putstring (" = ")
			if workbench_mode then
				buf.putstring ("RTLN(typres");
			else
				buf.putstring ("RTLNS(typres, ");
				buf.putint (real_ty.type_id - 1)
				buf.putstring (", ")
				real_ty.associated_class_type.skeleton.generate_size (buf)
			end
			buf.putstring (");");
			buf.new_line;
			generate_block_close
		end

	fill_tuple (target_types: META_GENERIC) is
			-- Generate the registers for the expressions
			-- to fill the manifest tuple.
		local
			expr: EXPR_B
			actual_type: TYPE_I
			target_type: REFERENCE_I
			basic_i: BASIC_I
			metamorphosed: BOOLEAN
			is_expanded: BOOLEAN
			i, position: INTEGER
			buf: GENERATION_BUFFER
		do
			buf := buffer
			from
				i := target_types.count
			until
				(i < 1) or is_expanded
			loop
				is_expanded := target_types.item(i).is_true_expanded
				i := i - 1
			end

			!!target_type
			array_area_reg.print_register
			buf.putstring (" = * (EIF_REFERENCE *) ")
			print_register
			buf.putchar (';')
			buf.new_line
			if (is_expanded and then expressions.count > 0) then
				buf.putchar ('{')
				buf.new_line
				buf.indent
				buf.putstring ("long elem_size;")
				buf.new_line
				buf.putstring ("elem_size = *(long *) (")
				array_area_reg.print_register
				buf.putstring (" + (HEADER(")
				array_area_reg.print_register
				buf.putstring (")->ov_size & B_SIZE) - LNGPAD(2) + sizeof(long));")
				buf.new_line
			end
			from
				expressions.start
				i := 1
				position := 0
			until
				expressions.after
			loop
				metamorphosed := False
				expr ?= expressions.item
				actual_type := context.real_type (expr.type)
				if actual_type.is_basic then
					basic_i ?= actual_type
					expr.generate
					basic_i.metamorphose 
						(metamorphose_regs.item (i), expr, buf, context.workbench_mode)
					buf.putchar (';')
					buf.new_line
					metamorphosed := True
				else
					expr.generate
				end
				if is_expanded then
					buf.putstring ("ecopy(")
					if metamorphosed then
						metamorphose_regs.item (i).print_register
					else
						expr.print_register
					end
					buf.putstring (gc_comma)
					array_area_reg.print_register
					buf.putstring (" + OVERHEAD + elem_size * ")
					buf.putint (position)
					buf.putchar (')')
				else
					buf.putchar ('*')
					buf.putchar ('(')
					target_type.c_type.generate_access_cast (buf)
					array_area_reg.print_register
					buf.putchar('+');
					buf.putint (position)
					buf.putchar (')')
					buf.putstring (" = ")
					if metamorphosed then
						metamorphose_regs.item (i).print_register
					else
						expr.print_register
					end
					buf.putchar (';')
					buf.new_line
						-- Generation of the RTAS_OPT protection
						-- since the array contains references
					buf.putstring ("RTAS_OPT(")
					if metamorphosed then
						metamorphose_regs.item (i).print_register
					else
						expr.print_register
					end
					buf.putchar (',')
					buf.putint (position)
					buf.putchar (',')
					array_area_reg.print_register
					buf.putchar (')')
					buf.new_line
				end
				buf.putchar (';')
				buf.new_line
				expressions.forth
				position := position + 1
				i := i + 1
			end
			if (is_expanded and expressions.count > 0) then
				buf.exdent
				buf.putchar ('}')
				buf.new_line
			end
		end

	generate_final_tuple_make (real_ty: TUPLE_TYPE_I)	is
				-- Generate code to call the make routine 
				-- of the manifest tuple in final mode.
		local
			rout_table: ROUT_TABLE
			internal_name: STRING
			rout_id: INTEGER
			buf: GENERATION_BUFFER
		do
			buf := buffer
			rout_id := real_ty.base_class.feature_table.item_id (make_name_id).rout_id_set.first
			rout_table ?= Eiffel_table.poly_table (rout_id)

				-- Generate the signature of the function
			rout_table.goto_implemented (real_ty.type_id)
			check
				is_implemented: rout_table.is_implemented
			end
			internal_name := clone (rout_table.feature_name)
			buf.putstring ("(FUNCTION_CAST(void, (EIF_REFERENCE))")
			buf.putstring (internal_name);
			buf.putstring (")")

				-- Generate arguments
			generate_tuple_make_arguments

				-- Remember extern routine declaration
				-- Since `make' from TUPLE is a procedure, the return type is `Void_c_type'
				--| Note: it used to be `real_ty.c_type' but it was the C type of
				--| the TUPLE itself and not of the `make' routine and thus was incorrect.
			Extern_declarations.add_routine_with_signature (Void_c_type, internal_name, <<"EIF_REFERENCE">>)
		end

	generate_wk_tuple_make (real_ty: TUPLE_TYPE_I)	is
				-- Generate code to call the make routine 
				-- of the manifest tuple in workbench mode.
		local
			f_table: FEATURE_TABLE
			feat_i: FEATURE_I
			r_id: INTEGER
			rout_info: ROUT_INFO
			base_class: CLASS_C
			buf: GENERATION_BUFFER
		do
			buf := buffer
			base_class := real_ty.base_class
			f_table := base_class.feature_table
			feat_i := f_table.item_id (make_name_id)
			buf.putstring ("(FUNCTION_CAST(void, (EIF_REFERENCE))")
			if 
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				buf.putstring ("RTWPF(")
				r_id := feat_i.rout_id_set.first
				rout_info := System.rout_info_table.item (r_id)
				buf.generate_class_id (rout_info.origin)
				buf.putstring (gc_comma)
				buf.putint (rout_info.offset)
			else
				buf.putstring (" RTWF(")
				buf.putint (real_ty.associated_class_type.static_type_id - 1)
				buf.putstring (gc_comma)
				buf.putint (feat_i.feature_id)
			end
			buf.putstring (gc_comma)
			buf.putstring (gc_upper_dtype_lparan)
			print_register
			buf.putstring (")))")
			generate_tuple_make_arguments
		end

	generate_tuple_make_arguments is
			-- Generate the arguments for the tuple creation.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putchar ('(')
			print_register
			buf.putstring (");")
			buf.new_line
		end
end


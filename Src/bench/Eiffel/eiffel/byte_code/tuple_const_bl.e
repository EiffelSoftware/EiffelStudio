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
			!!array_area_reg.make (ref_type.c_type)
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
			buf.putstring ("RTLN(typres);")
			buf.new_line
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
				is_expanded := target_types.item(i).is_expanded
				i := i - 1
			end

			!!target_type
			array_area_reg.print_register
			buf.putstring (" = * (char **) ")
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
					expr.print_register
					buf.putstring (gc_comma)
					array_area_reg.print_register
					buf.putstring (" + OVERHEAD + elem_size * ")
					buf.putint (position)
					buf.putchar (')')
				else
					-- Generation of the RTAS protection
					-- since the array contains references
					buf.putstring ("RTAS(")
					if metamorphosed then
						metamorphose_regs.item (i).print_register
					else
						expr.print_register
					end
					buf.putstring (", ")
					array_area_reg.print_register
					buf.putstring (");")
					buf.new_line
					buf.putchar ('*')
					target_type.c_type.generate_access_cast (buf)
					buf.putchar ('(')
					array_area_reg.print_register
					buf.putstring (gc_plus)
					buf.putint (position)
					buf.putstring (gc_star)
					target_type.c_type.generate_size (buf)
					buf.putchar (')')
					buf.putstring (" = ")
					if metamorphosed then
						metamorphose_regs.item (i).print_register
					else
						expr.print_register
					end
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
			entry: POLY_TABLE [ENTRY]
			rout_table: ROUT_TABLE
			internal_name, table_name: STRING
			rout_id: ROUTINE_ID
			buf: GENERATION_BUFFER
		do
			buf := buffer
			rout_id := real_ty.base_class.feature_table.item ("make").rout_id_set.first
			entry := Eiffel_table.poly_table (rout_id)
			rout_table ?= entry
			internal_name := clone (rout_table.feature_name (real_ty.type_id))
			buf.putstring (internal_name)
			generate_tuple_make_arguments
				-- Remember extern routine declaration
			Extern_declarations.add_routine (real_ty.c_type, internal_name)
		end

	generate_wk_tuple_make (real_ty: TUPLE_TYPE_I)	is
				-- Generate code to call the make routine 
				-- of the manifest tuple in workbench mode.
		local
			f_table: FEATURE_TABLE
			feat_i: FEATURE_I
			r_id: ROUTINE_ID
			rout_info: ROUT_INFO
			base_class: CLASS_C
			buf: GENERATION_BUFFER
		do
			buf := buffer
			base_class := real_ty.base_class
			f_table := base_class.feature_table
			feat_i := f_table.item ("make")
			buf.putstring ("(FUNCTION_CAST(void, (EIF_REFERENCE))")
			if 
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				buf.putstring ("RTWPF(")
				r_id := feat_i.rout_id_set.first
				rout_info := System.rout_info_table.item (r_id)
				rout_info.origin.generated_id (buf)
				buf.putstring (gc_comma)
				buf.putint (rout_info.offset)
			else
				buf.putstring (" RTWF(")
				buf.putint (real_ty.associated_class_type.id.id - 1)
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

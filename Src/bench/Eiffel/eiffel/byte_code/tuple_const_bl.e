indexing
	description: "Enlarged byte code for manifest tuples"
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_CONST_BL

inherit
	TUPLE_CONST_B
		redefine
			analyze, generate, 
			register, set_register, 
			free_register, unanalyze
		end;
	SHARED_TABLE
	SHARED_DECLARATIONS
	
feature 

	register: REGISTRABLE
			-- Register for TUPLE

	metamorphose_reg: REGISTER
			-- Register for metamorphosis

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
			require_meta: BOOLEAN
		do
			-- We need 'Current'
			context.add_dftype_current

			real_ty ?= context.real_type (type)

			get_register
			from
				i := 0
				expressions.start
			until
				expressions.after 
			loop
				expr ?= expressions.item
				expr_type := context.real_type (expr.type)

				if expr_type.is_true_expanded then 
					require_meta := True
				end
				expr.analyze
				expr.free_register
				expressions.forth
				i := i + 1
			end
			if require_meta then
				create metamorphose_reg.make (Reference_c_type)
			end
		end

	unanalyze is
			-- Unanalyze expression
		local
			expr: EXPR_B
		do
			metamorphose_reg := Void
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
		do
			Precursor {TUPLE_CONST_B}
			if metamorphose_reg /= Void then
				metamorphose_reg.free_register
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
			fill_tuple (real_ty.meta_generic)
		end

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
			buf.putstring ("RTLNTS(typres, ");
			buf.putint (real_ty.true_generics.count + 1)
			buf.putstring (", ")
			if real_ty.is_basic_uniform then
				buf.putint (1)
			else
				buf.putint (0)
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
			metamorphosed: BOOLEAN
			i: INTEGER
			buf: GENERATION_BUFFER
		do
			buf := buffer
			from
				expressions.start
				i := 1
			until
				expressions.after
			loop
				metamorphosed := False
				expr ?= expressions.item
				actual_type := context.real_type (expr.type)
					-- If `actual_type' is NONE, it means we are handling `Void'
					-- and therefore nothing has to be done.
				if not actual_type.is_none then
					if actual_type.is_true_expanded then
						expr.generate
						metamorphose_reg.print_register
						buf.putstring (" = RTCL(")
						expr.print_register
						buf.putstring (");")
						buf.new_line
						metamorphosed := True
					else
						expr.generate
					end
					-- Generate initializations of values.
					buf.putstring ("((EIF_TYPED_ELEMENT *)")
					print_register
					buf.putchar('+');
					buf.putint (i)
					buf.putstring (")->element.")
					buf.putstring (actual_type.c_type.union_tag)
					buf.putstring (" = ")
					if metamorphosed then
						metamorphose_reg.print_register
					else
						expr.print_register
					end
					buf.putchar (';')
					buf.new_line
						-- Generation of the RTAR protection
						-- since the array contains references
					if not actual_type.is_basic then
						buf.putstring ("RTAR(")
						print_register
						buf.putchar (',')
						if metamorphosed then
							metamorphose_reg.print_register
						else
							expr.print_register
						end
						buf.putchar (')')
						buf.putchar (';')
						buf.new_line
					end
				end
				expressions.forth
				i := i + 1
			end
		end

end

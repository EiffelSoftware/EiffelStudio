indexing
	description: "Special inlining for SPECIAL classes"
	author: "Emmanuel STAPF"
	date: "$Date$"
	revision: "$Revision$"

class
	SPECIAL_INLINED_FEAT_B

inherit
	INLINED_FEAT_B
		redefine
			generate_parameters
		end

feature -- Generation

	generate_parameters (gen_reg: REGISTRABLE) is
		local
			i, count: INTEGER
			expr: EXPR_B
			current_t: CL_TYPE_I
			buf: GENERATION_BUFFER
			local_inliner: INLINER
			type_c: TYPE_C
		do
			if feature_name.is_equal ("put") then
				parameters.generate
				buf := buffer
				buf.putchar ('{')
				buf.new_line
	
				buf.putstring ("/* INLINED CODE (SPECIAL.put) */")
				buf.new_line

					-- Get the type of the generic parameter of SPECIAL
				type_c := argument_regs.item (1).c_type
				inspect
					type_c.level
				when C_char then
					buf.putstring ("*((EIF_CHARACTER *)")
				when C_long then
					buf.putstring ("*((EIF_INTEGER *)")
				when C_float then
					buf.putstring ("*((EIF_REAL *)")
				when C_double then
					buf.putstring ("*((EIF_DOUBLE *)")
				when C_pointer then
					buf.putstring ("*((EIF_POINTER *)")
				when C_ref then
						--! Could be bit or ref
					buf.putstring ("RTAS(")
					argument_regs.item(1).print_register
					buf.putstring (", ")
					current_reg.print_register
					buf.putstring (");")
					buf.new_line
					buf.putstring ("*((EIF_REFERENCE *)")
				end

				current_reg.print_register
				buf.putstring (" + (")
				parameters.i_th (2).print_register
				buf.putstring (")) = ")
				parameters.i_th (1).print_register
				buf.putstring (";")
				buf.new_line
				buf.putstring ("/* END INLINED CODE */")
				buf.new_line
	
				buf.putchar ('}')
				buf.new_line
			elseif feature_name.is_equal ("item") then
				parameters.generate
				buf := buffer
				buf.putchar ('{')
				buf.new_line
	
				buf.putstring ("/* INLINED CODE (SPECIAL.item) */")
				buf.new_line

					-- Get the type of the generic parameter of SPECIAL
				type_c := result_reg.c_type

				result_reg.print_register
				buf.putstring (" = ")
				inspect
					type_c.level
				when C_char then
					buf.putstring ("*((EIF_CHARACTER *)")
				when C_long then
					buf.putstring ("*((EIF_INTEGER *)")
				when C_float then
					buf.putstring ("*((EIF_REAL *)")
				when C_double then
					buf.putstring ("*((EIF_DOUBLE *)")
				when C_pointer then
					buf.putstring ("*((EIF_POINTER *)")
				when C_ref then
						--! Could be bit or ref
					buf.putstring ("*((EIF_REFERENCE *)")
				end
				
				current_reg.print_register
				buf.putstring (" + (")
				parameters.i_th (1).print_register
				buf.putstring ("));")
				buf.new_line
				buf.putstring ("/* END INLINED CODE */")
				buf.new_line
	
				buf.putchar ('}')
				buf.new_line
			else
				{INLINED_FEAT_B} Precursor (gen_reg)
			end
		end

		
end -- class SPECIAL_INLINED_FEAT_B

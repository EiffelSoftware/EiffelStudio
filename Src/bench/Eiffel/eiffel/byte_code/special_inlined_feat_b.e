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

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Generation

	generate_parameters (gen_reg: REGISTRABLE) is
		local
			buf: GENERATION_BUFFER
			type_c: TYPE_C
		do
			if feature_name_id = put_name_id then
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
				when C_wide_char then
					buf.putstring ("*((EIF_WIDE_CHAR *)")
				when C_int8 then
					buf.putstring ("*((EIF_INTEGER_8 *)")
				when C_int16 then
					buf.putstring ("*((EIF_INTEGER_16 *)")
				when C_int32 then
					buf.putstring ("*((EIF_INTEGER_32 *)")
				when C_int64 then
					buf.putstring ("*((EIF_INTEGER_64 *)")
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

				gen_reg.print_register
				buf.putstring (" + (")
				parameters.i_th (2).print_register
				buf.putstring (")) = ")
				parameters.i_th (1).print_register
				buf.putstring (";")
				buf.new_line
				if type_c.level = C_ref then
					buf.putstring ("RTAS_OPT(")
					argument_regs.item(1).print_register
					buf.putchar (',')
					parameters.i_th (2).print_register
					buf.putchar (',')
					gen_reg.print_register
					buf.putstring (");")
					buf.new_line
				end
				buf.putstring ("/* END INLINED CODE */")
				buf.new_line
	
				buf.putchar ('}')
				buf.new_line
			elseif feature_name_id = item_name_id then
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
				when C_wide_char then
					buf.putstring ("*((EIF_WIDE_CHAR *)")
				when C_int8 then
					buf.putstring ("*((EIF_INTEGER_8 *)")
				when C_int16 then
					buf.putstring ("*((EIF_INTEGER_16 *)")
				when C_int32 then
					buf.putstring ("*((EIF_INTEGER_32 *)")
				when C_int64 then
					buf.putstring ("*((EIF_INTEGER_64 *)")
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
				
				gen_reg.print_register
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

feature {NONE} -- Constant

	put_name_id: INTEGER is
			-- Id of "put" in NAMES_HEAP.
		once
			Result := Names_heap.id_of ("put")
		end

	item_name_id: INTEGER is
			-- Id of "item" in NAMES_HEAP.
		once
			Result := Names_heap.id_of ("item")
		end

end -- class SPECIAL_INLINED_FEAT_B

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
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_I
			type_c: TYPE_C
		do
			inspect feature_name_id
			when feature {PREDEFINED_NAMES}.put_name_id then
				parameters.generate
				buf := buffer
				buf.putstring ("/* INLINED CODE (SPECIAL.put) */")
				buf.new_line

					-- Get the type of the generic parameter of SPECIAL
				l_gen_param := generic_type
				if l_gen_param.is_true_expanded then
					buf.putstring ("ecopy(")
					parameters.i_th (1).print_register
					buf.putstring (", ")
					gen_reg.print_register
					buf.putstring (" + OVERHEAD + ")
					parameters.i_th (2).print_register
					buf.putstring (" * sp_elem_size(")
					gen_reg.print_register
					buf.putstring ("));")
					buf.new_line
				else
					type_c := l_gen_param.c_type
					buf.putstring ("*(")
					type_c.generate_access_cast (buf)
					gen_reg.print_register
					buf.putstring (" + (")
					parameters.i_th (2).print_register
					buf.putstring (")) = ")
					parameters.i_th (1).print_register
					buf.putstring (";")
					buf.new_line
					if type_c.level = C_ref then
						buf.putstring ("RTAS_OPT(")
						parameters.i_th (1).print_register
						buf.putchar (',')
						parameters.i_th (2).print_register
						buf.putchar (',')
						gen_reg.print_register
						buf.putstring (");")
						buf.new_line
					end
				end
				buf.putstring ("/* END INLINED CODE */")
				buf.new_line
			when feature {PREDEFINED_NAMES}.item_name_id then
				parameters.generate
				buf := buffer
				buf.putstring ("/* INLINED CODE (SPECIAL.item) */")
				buf.new_line

					-- Get the type of the generic parameter of SPECIAL
				l_gen_param := generic_type

				if l_gen_param.is_true_expanded then
					result_reg.print_register 
					buf.putstring (" = ")
					gen_reg.print_register
					buf.putstring (" + OVERHEAD + ")
					parameters.i_th (1).print_register
					buf.putstring (" * sp_elem_size(")
					gen_reg.print_register
					buf.putstring (");")
					buf.new_line
				else
					type_c := l_gen_param.c_type
					result_reg.print_register
					buf.putstring (" = *(")
					type_c.generate_access_cast (buf)
					gen_reg.print_register
					buf.putstring (" + (")
					parameters.i_th (1).print_register
					buf.putstring ("));")
					buf.new_line
				end
				buf.putstring ("/* END INLINED CODE */")
				buf.new_line
			when feature {PREDEFINED_NAMES}.base_address_name_id then
				buf := buffer

				buf.putstring ("/* INLINED CODE (SPECIAL.base_address) */")
				buf.new_line
				result_reg.print_register
				buf.putstring (" = ")
				gen_reg.print_register
				buf.putstring (";")
				buf.new_line
				buf.putstring ("/* END INLINED CODE */")
				buf.new_line
			when feature {PREDEFINED_NAMES}.element_address_name_id then
				parameters.generate
				buf := buffer

				buf.putstring ("/* INLINED CODE (SPECIAL.element_address) */")
				buf.new_line
				result_reg.print_register
				buf.putstring (" = ")
				gen_reg.print_register

				l_gen_param := generic_type
				if l_gen_param.is_true_expanded then
					buf.putstring (" + OVERHEAD + ")
					parameters.i_th (1).print_register
					buf.putstring (" * sp_elem_size (")
					gen_reg.print_register
				else
					type_c := l_gen_param.c_type
					buf.putstring (" + ")
					parameters.i_th (1).print_register
					buf.putstring (" * sizeof(")
					type_c.generate (buf)
				end
				buf.putchar (')')
				buf.putchar (';')
				buf.new_line
				buf.putstring ("/* END INLINED CODE */")
				buf.new_line
			else
				Precursor {INLINED_FEAT_B} (gen_reg)
			end
		end

	generic_type: TYPE_I is
				-- Extract type of generic parameter G in SPECIAL [G].
			local
				l_special_type: GEN_TYPE_I
			do
				if parent = Void then
						-- When there is no parent it means that the call is done
						-- within the SPECIAL class. So we can safely extract the type
						-- from the current class type being generated.
					l_special_type ?= Context.current_type
				else
					if parent.target = Current then
							-- This is the case of (area.item (i).feature_call).
						l_special_type ?= Context.real_type (parent.parent.target.type)
					else
							-- We go back to the target of current call to get its type.
						l_special_type ?= Context.real_type (parent.target.type) 
					end
				end
				check
					l_special_type_not_void: l_special_type /= Void
				end
				Result := l_special_type.meta_generic.item (1)
			end

end -- class SPECIAL_INLINED_FEAT_B

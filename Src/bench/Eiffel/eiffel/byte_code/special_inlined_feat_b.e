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
				buf.put_string ("/* INLINED CODE (SPECIAL.put) */")
				buf.put_new_line

					-- Get the type of the generic parameter of SPECIAL
				l_gen_param := generic_type
				if l_gen_param.is_true_expanded then
					buf.put_string ("ecopy(")
					parameters.i_th (1).print_register
					buf.put_string (", ")
					gen_reg.print_register
					buf.put_string (" + OVERHEAD + ")
					parameters.i_th (2).print_register
					buf.put_string (" * sp_elem_size(")
					gen_reg.print_register
					buf.put_string ("));")
					buf.put_new_line
				else
					type_c := l_gen_param.c_type
					buf.put_string ("*(")
					type_c.generate_access_cast (buf)
					gen_reg.print_register
					buf.put_string (" + (")
					parameters.i_th (2).print_register
					buf.put_string (")) = ")
					parameters.i_th (1).print_register
					buf.put_string (";")
					buf.put_new_line
					if type_c.level = C_ref then
						buf.put_string ("RTAR(")
						gen_reg.print_register
						buf.put_character (',')
						parameters.i_th (1).print_register
						buf.put_string (");")
						buf.put_new_line
					end
				end
				buf.put_string ("/* END INLINED CODE */")
				buf.put_new_line
			when feature {PREDEFINED_NAMES}.item_name_id then
				parameters.generate
				buf := buffer
				buf.put_string ("/* INLINED CODE (SPECIAL.item) */")
				buf.put_new_line

					-- Get the type of the generic parameter of SPECIAL
				l_gen_param := generic_type

				if l_gen_param.is_true_expanded then
					result_reg.print_register 
					buf.put_string (" = ")
					gen_reg.print_register
					buf.put_string (" + OVERHEAD + ")
					parameters.i_th (1).print_register
					buf.put_string (" * sp_elem_size(")
					gen_reg.print_register
					buf.put_string (");")
					buf.put_new_line
				else
					type_c := l_gen_param.c_type
					result_reg.print_register
					buf.put_string (" = *(")
					type_c.generate_access_cast (buf)
					gen_reg.print_register
					buf.put_string (" + (")
					parameters.i_th (1).print_register
					buf.put_string ("));")
					buf.put_new_line
				end
				buf.put_string ("/* END INLINED CODE */")
				buf.put_new_line
			when feature {PREDEFINED_NAMES}.base_address_name_id then
				buf := buffer

				buf.put_string ("/* INLINED CODE (SPECIAL.base_address) */")
				buf.put_new_line
				result_reg.print_register
				buf.put_string (" = ")
				gen_reg.print_register
				buf.put_string (";")
				buf.put_new_line
				buf.put_string ("/* END INLINED CODE */")
				buf.put_new_line
			when feature {PREDEFINED_NAMES}.item_address_name_id then
				parameters.generate
				buf := buffer

				buf.put_string ("/* INLINED CODE (SPECIAL.item_address) */")
				buf.put_new_line
				result_reg.print_register
				buf.put_string (" = ")
				gen_reg.print_register

				l_gen_param := generic_type
				if l_gen_param.is_true_expanded then
					buf.put_string (" + OVERHEAD + ")
					parameters.i_th (1).print_register
					buf.put_string (" * sp_elem_size (")
					gen_reg.print_register
				else
					type_c := l_gen_param.c_type
					buf.put_string (" + ")
					parameters.i_th (1).print_register
					buf.put_string (" * sizeof(")
					type_c.generate (buf)
				end
				buf.put_character (')')
				buf.put_character (';')
				buf.put_new_line
				buf.put_string ("/* END INLINED CODE */")
				buf.put_new_line
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

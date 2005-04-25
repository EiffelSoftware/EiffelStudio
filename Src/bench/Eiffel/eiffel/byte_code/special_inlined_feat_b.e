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
			-- Generate inlined routines.
		local
			buf: like buffer
		do
			inspect feature_name_id
			when {PREDEFINED_NAMES}.put_name_id then
				generate_put (gen_reg)
			when {PREDEFINED_NAMES}.item_name_id, {PREDEFINED_NAMES}.infix_at_name_id then
				generate_item (gen_reg)
			when {PREDEFINED_NAMES}.base_address_name_id then
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
			when {PREDEFINED_NAMES}.item_address_name_id then
				generate_item_address (gen_reg)
			else
				Precursor {INLINED_FEAT_B} (gen_reg)
			end
		end

feature {NONE} -- Implementation

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

	generate_item (gen_reg: REGISTRABLE) is
			-- Generate inlined version of `item'.
		require
			gen_reg_not_void: gen_reg /= Void
		local
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_I
			type_c: TYPE_C
			l_param_is_expanded: BOOLEAN
			l_exp_type: CL_TYPE_I
			l_exp_class_type: CLASS_TYPE
		do
			parameters.generate
			buf := buffer
			buf.put_string ("/* INLINED CODE (SPECIAL.item) */")
			buf.put_new_line

				-- Get the type of the generic parameter of SPECIAL
			l_gen_param := generic_type
			l_param_is_expanded := l_gen_param.is_true_expanded

			if l_param_is_expanded then
				l_exp_type ?= l_gen_param;
				l_exp_class_type := l_exp_type.associated_class_type
				if l_exp_class_type.skeleton.has_references then
					result_reg.print_register 
					buf.put_string (" = RTCL(")
					gen_reg.print_register
					buf.put_string (" + OVERHEAD + ")
					parameters.i_th (1).print_register
					buf.put_string (" * (")
					l_exp_class_type.skeleton.generate_size (buf)
					buf.put_string (" + OVERHEAD));")
					buf.put_new_line
				else
						-- No need to protect target register, because it is
						-- protected by the routine calling `item'.
					l_exp_type.generate_expanded_creation (buf, result_reg.register_name)
					buf.put_string ("memcpy (")
					result_reg.print_register
					buf.put_string (", ")
					gen_reg.print_register
					buf.put_string (" + ")
					parameters.i_th (1).print_register
					buf.put_string (" * (");
					l_exp_class_type.skeleton.generate_size (buf)
					buf.put_string ("), ")
					l_exp_class_type.skeleton.generate_size (buf)
					buf.put_string (");")
					buf.put_new_line
				end
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
		end

	generate_item_address (gen_reg: REGISTRABLE) is
			-- Generate inlined version of `item_address'.
		require
			gen_reg_not_void: gen_reg /= Void
		local
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_I
			type_c: TYPE_C
			l_param_is_expanded: BOOLEAN
			l_exp_type: CL_TYPE_I
			l_exp_class_type: CLASS_TYPE
		do
			parameters.generate
			buf := buffer

			buf.put_string ("/* INLINED CODE (SPECIAL.item_address) */")
			buf.put_new_line
			result_reg.print_register
			buf.put_string (" = ")
			gen_reg.print_register

			l_gen_param := generic_type

			l_param_is_expanded := l_gen_param.is_true_expanded

			if l_param_is_expanded then
				l_exp_type ?= l_gen_param
				l_exp_class_type := l_exp_type.associated_class_type
				if l_exp_class_type.skeleton.has_references then
					buf.put_string (" + OVERHEAD + ")
					parameters.i_th (1).print_register
					buf.put_string (" * (")
					l_exp_class_type.skeleton.generate_size (buf)
					buf.put_string (" + OVERHEAD)")
				else
					buf.put_string (" + ")
					parameters.i_th (1).print_register
					buf.put_string (" * ")
					l_exp_class_type.skeleton.generate_size (buf)
				end
			else
				type_c := l_gen_param.c_type
				buf.put_string (" + ")
				parameters.i_th (1).print_register
				buf.put_string (" * sizeof(")
				type_c.generate (buf)
				buf.put_character (')')
			end
			buf.put_character (';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
			buf.put_new_line
		end

	generate_put (gen_reg: REGISTRABLE) is
			-- Generate inlined version of `put'.
		require
			gen_reg_not_void: gen_reg /= Void
		local
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_I
			type_c: TYPE_C
			l_param_is_expanded: BOOLEAN
			l_exp_type: CL_TYPE_I
			l_exp_class_type: CLASS_TYPE
		do
			parameters.generate
			buf := buffer
			buf.put_string ("/* INLINED CODE (SPECIAL.put) */")
			buf.put_new_line

				-- Get the type of the generic parameter of SPECIAL
			l_gen_param := generic_type
			l_param_is_expanded := l_gen_param.is_true_expanded

			if l_param_is_expanded then
				l_exp_type ?= l_gen_param
				l_exp_class_type := l_exp_type.associated_class_type
				if l_exp_class_type.skeleton.has_references then
					buf.put_string ("ecopy(")
					parameters.i_th (1).print_register
					buf.put_string (", ")
					gen_reg.print_register
					buf.put_string (" + OVERHEAD + ")
					parameters.i_th (2).print_register
					buf.put_string (" * (")
					l_exp_class_type.skeleton.generate_size (buf)
					buf.put_string (" + OVERHEAD));")
					buf.put_new_line
				else
					buf.put_string ("memcpy(")
					gen_reg.print_register
					buf.put_string (" + ")
					parameters.i_th (2).print_register
					buf.put_string (" * ")
					l_exp_class_type.skeleton.generate_size (buf)
					buf.put_string (",")
					parameters.i_th (1).print_register
					buf.put_string (", ")
					l_exp_class_type.skeleton.generate_size (buf)
					buf.put_character (')')
					buf.put_character (';')
					buf.put_new_line
				end
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
		end

end -- class SPECIAL_INLINED_FEAT_B

indexing
	description: "Special inlining for SPECIAL classes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
				buf.put_character (';')
				buf.put_new_line
				buf.put_string ("/* END INLINED CODE */")
				buf.put_new_line
			when {PREDEFINED_NAMES}.item_address_name_id then
				generate_item_address (gen_reg)
			when {PREDEFINED_NAMES}.copy_data_name_id then
				if is_expanded_with_references then
					Precursor {INLINED_FEAT_B} (gen_reg)
				else
					generate_copy_data (gen_reg)
				end
			when {PREDEFINED_NAMES}.non_overlapping_move_name_id then
				if is_expanded_with_references then
					Precursor {INLINED_FEAT_B} (gen_reg)
				else
					generate_move (gen_reg, False)
				end
			when
				{PREDEFINED_NAMES}.move_data_name_id,
				{PREDEFINED_NAMES}.overlapping_move_name_id
			then
				if is_expanded_with_references then
					Precursor {INLINED_FEAT_B} (gen_reg)
				else
					generate_move (gen_reg, True)
				end
			when {PREDEFINED_NAMES}.count_name_id then
				buf := buffer
				buf.put_string ("/* INLINED CODE (SPECIAL.count) */")
				buf.put_new_line

				result_reg.print_register
				buf.put_string (" = ")
				buf.put_string ("(*(EIF_INTEGER *) (char *) ((")
				gen_reg.print_register
				buf.put_string (") + (HEADER(")
				gen_reg.print_register
				buf.put_string (")->ov_size & B_SIZE) - LNGPAD_2));")
				buf.put_new_line
				buf.put_string ("/* END INLINED CODE */")
				buf.put_new_line
			else
				Precursor {INLINED_FEAT_B} (gen_reg)
			end
		end

feature {NONE} -- Status report

	is_expanded_with_references: BOOLEAN is
			-- Is current type of generic parameter G in SPECIAL [G] is
			-- expanded with references?
		local
			l_cl_item_type: CL_TYPE_I
		do
			l_cl_item_type ?= generic_type
			if l_cl_item_type /= Void and l_cl_item_type.is_true_expanded then
				Result := l_cl_item_type.associated_class_type.skeleton.has_references
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

feature {NONE} -- Implementation

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

	generate_move (gen_reg: REGISTRABLE; is_overlapping: BOOLEAN) is
			-- Generate inlined version of `move_data' and `overlapping_move'.
		require
			gen_reg_not_void: gen_reg /= Void
			not_is_expanded_with_references: not is_expanded_with_references
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
			buf.put_string ("/* INLINED CODE (SPECIAL.move_data/overlapping_move) */")
			buf.put_new_line

				-- Get the type of the generic parameter of SPECIAL
			l_gen_param := generic_type
			l_param_is_expanded := l_gen_param.is_true_expanded

			if is_overlapping then
				buf.put_string ("memmove")
			else
				buf.put_string ("memcpy")
			end

			if l_param_is_expanded then
				l_exp_type ?= l_gen_param
				l_exp_class_type := l_exp_type.associated_class_type

				buf.put_string ("((char *)")
				gen_reg.print_register
				buf.put_string (" + ")
				parameters.i_th (2).print_register
				buf.put_string (" * ")
				l_exp_class_type.skeleton.generate_size (buf)
				buf.put_string (", (char *) ")
				gen_reg.print_register
				buf.put_string (" + ")
				parameters.i_th (1).print_register
				buf.put_string (" * ")
				l_exp_class_type.skeleton.generate_size (buf)
				buf.put_string (", ")
				parameters.i_th (3).print_register
				buf.put_string (" * ")
				l_exp_class_type.skeleton.generate_size (buf)
			else
				type_c := l_gen_param.c_type
				buf.put_string ("(")
				type_c.generate_access_cast (buf)
				gen_reg.print_register
				buf.put_string (" + (")
				parameters.i_th (2).print_register
				buf.put_string ("),")
				type_c.generate_access_cast (buf)
				gen_reg.print_register
				buf.put_string (" + ")
				parameters.i_th (1).print_register
				buf.put_string (", ")
				type_c.generate_size (buf)
				buf.put_string (" * ")
				parameters.i_th (3).print_register
			end
			buf.put_character (')')
			buf.put_character (';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
			buf.put_new_line
		end

	generate_copy_data (gen_reg: REGISTRABLE) is
			-- Generate inlined version of `copy_data'.
		require
			gen_reg_not_void: gen_reg /= Void
			not_is_expanded_with_references: not is_expanded_with_references
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
			buf.put_string ("/* INLINED CODE (SPECIAL.copy_data) */")
			buf.put_new_line

				-- Get the type of the generic parameter of SPECIAL
			l_gen_param := generic_type
			l_param_is_expanded := l_gen_param.is_true_expanded

			if l_param_is_expanded then
				l_exp_type ?= l_gen_param
				l_exp_class_type := l_exp_type.associated_class_type

				buf.put_string ("memmove((char *)")
				gen_reg.print_register
				buf.put_string (" + ")
				parameters.i_th (3).print_register
				buf.put_string (" * ")
				l_exp_class_type.skeleton.generate_size (buf)
				buf.put_string (", (char *) ")
				parameters.i_th (1).print_register
				buf.put_string (" + ")
				parameters.i_th (2).print_register
				buf.put_string (" * ")
				l_exp_class_type.skeleton.generate_size (buf)
				buf.put_string (", ")
				parameters.i_th (4).print_register
				buf.put_string (" * ")
				l_exp_class_type.skeleton.generate_size (buf)
				buf.put_character (')')
				buf.put_character (';')
			else
				if l_gen_param.is_reference then
						-- Because we need to do the aging test in case `source' and `target' are
						-- not the same SPECIAL, we call the run-time helper function `sp_copy_data'.
					buf.put_string ("sp_copy_data(")
					gen_reg.print_register
					buf.put_character (',')
					parameters.i_th (1).print_register
					buf.put_character (',')
					parameters.i_th (2).print_register
					buf.put_character (',')
					parameters.i_th (3).print_register
					buf.put_character (',')
					parameters.i_th (4).print_register
				else
					type_c := l_gen_param.c_type
					buf.put_string ("memmove(")
					type_c.generate_access_cast (buf)
					gen_reg.print_register
					buf.put_string (" + (")
					parameters.i_th (3).print_register
					buf.put_string ("),")
					type_c.generate_access_cast (buf)
					parameters.i_th (1).print_register
					buf.put_string (" + ")
					parameters.i_th (2).print_register
					buf.put_string (", ")
					type_c.generate_size (buf)
					buf.put_string (" * ")
					parameters.i_th (4).print_register
				end
				buf.put_character (')')
				buf.put_character (';')
			end

			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
			buf.put_new_line
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SPECIAL_INLINED_FEAT_B

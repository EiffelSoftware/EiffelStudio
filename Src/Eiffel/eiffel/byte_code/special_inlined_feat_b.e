note
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

	SHARED_INCLUDE

feature -- Generation

	generate_parameters (gen_reg: REGISTRABLE)
			-- Generate inlined routines.
		local
			buf: like buffer
		do
			inspect feature_name_id
			when {PREDEFINED_NAMES}.put_name_id then
				generate_put (gen_reg)
--			when {PREDEFINED_NAMES}.put_default_name_id then
--				generate_put_default (gen_reg)
			when
				{PREDEFINED_NAMES}.item_name_id,
				{PREDEFINED_NAMES}.infix_at_name_id,
				{PREDEFINED_NAMES}.at_name_id
			then
				generate_item (gen_reg)
			when {PREDEFINED_NAMES}.base_address_name_id then
				buf := buffer
				buf.put_new_line
				buf.put_string ("/* INLINED CODE (SPECIAL.base_address) */")
				buf.put_new_line
				result_reg.print_register
				buf.put_string (" = ")
				gen_reg.print_register
				buf.put_character (';')
				buf.put_new_line
				buf.put_string ("/* END INLINED CODE */")
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
			when {PREDEFINED_NAMES}.clear_all_name_id then
				if generic_type.is_true_expanded then
					Precursor {INLINED_FEAT_B} (gen_reg)
				else
					generate_clear_all (gen_reg)
				end

			when {PREDEFINED_NAMES}.count_name_id then
				buf := buffer
				buf.put_new_line
				buf.put_string ("/* INLINED CODE (SPECIAL.count) */")

				buf.put_new_line
				result_reg.print_register
				buf.put_string (" = RT_SPECIAL_COUNT(")
				gen_reg.print_register
				buf.put_two_character (')', ';')
				buf.put_new_line
				buf.put_string ("/* END INLINED CODE */")
			else
				Precursor {INLINED_FEAT_B} (gen_reg)
			end
		end

feature {NONE} -- Status report

	is_expanded_with_references: BOOLEAN
			-- Is current type of generic parameter G in SPECIAL [G] is
			-- expanded with references?
		local
			l_cl_item_type: TYPE_A
		do
			l_cl_item_type := generic_type
			if l_cl_item_type.is_true_expanded then
				Result := l_cl_item_type.associated_class_type (context.context_class_type.type).skeleton.has_references
			end
		end

	generic_type: TYPE_A
				-- Extract type of generic parameter G in SPECIAL [G].
			local
				l_special_type: GEN_TYPE_A
			do
				if parent = Void then
						-- When there is no parent it means that the call is done
						-- within the SPECIAL class. So we can safely extract the type
						-- from the current class type being generated.
					l_special_type ?= Context.context_cl_type
				else
					if parent.target = Current then
							-- This is the case of (area.item (i).feature_call).
						l_special_type ?= parent.parent.target.type.associated_class_type (context.context_class_type.type).type
					else
							-- We go back to the target of current call to get its type.
						l_special_type ?= parent.target.type.associated_class_type (context.context_class_type.type).type
					end
				end
				check
					l_special_type_not_void: l_special_type /= Void
				end
				Result := l_special_type.generics.item (1)
			end

feature {NONE} -- Implementation

	generate_item (gen_reg: REGISTRABLE)
			-- Generate inlined version of `item'.
		require
			gen_reg_not_void: gen_reg /= Void
		local
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_A
			type_c: TYPE_C
			l_param_is_expanded: BOOLEAN
			l_exp_class_type: CLASS_TYPE
			l_old_reg: REGISTRABLE
		do
			parameters.generate
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.item) */")

				-- Get the type of the generic parameter of SPECIAL
			l_gen_param := generic_type
			l_param_is_expanded := l_gen_param.is_true_expanded

			if l_param_is_expanded then
				l_exp_class_type := l_gen_param.associated_class_type (context.context_class_type.type)
				if l_exp_class_type.skeleton.has_references then
					buf.put_new_line
					result_reg.print_register
					buf.put_string (" = RTCL(")
					gen_reg.print_register
					buf.put_string (" + OVERHEAD + (rt_uint_ptr)")
					parameters.i_th (1).print_register
					buf.put_string (" * (rt_uint_ptr)(")
					l_exp_class_type.skeleton.generate_size (buf, True)
					buf.put_string (" + OVERHEAD));")
					buf.put_new_line
				else
						-- No need to protect target register, because it is
						-- protected by the routine calling `item'.
						-- Note: We also need to set the inlined register to `gen_reg' (not to `current_reg
						-- because `current_reg' would need to be initialized and we do not do that for
						-- inlined features of SPECIAL) so that the creation is done using the proper object.
						-- We also need to change the context otherwise it fails at execution time
						-- (see eweasel test#exec147)
					context.change_class_type_context (system.class_type_of_id (context_type_id), context_cl_type,
						system.class_type_of_id (written_type_id), written_cl_type)
					context.set_inlined_current_register (gen_reg)
					l_old_reg := current_reg
					current_reg := gen_reg
					inliner.set_inlined_feature (Current)
					l_exp_class_type.generate_expanded_creation (buf, result_reg.register_name,
						create {FORMAL_A}.make (False, False, 1), context.context_class_type)
					current_reg := l_old_reg
					context.restore_class_type_context
					inliner.set_inlined_feature (Void)
					context.set_inlined_current_register (Void)

					buf.put_new_line
					buf.put_string ("memcpy (")
					result_reg.print_register
					buf.put_string (", ")
					gen_reg.print_register
					buf.put_string (" + (rt_uint_ptr)")
					parameters.i_th (1).print_register
					buf.put_string (" * (rt_uint_ptr)(");
					l_exp_class_type.skeleton.generate_size (buf, True)
					buf.put_string ("), ")
					l_exp_class_type.skeleton.generate_size (buf, True)
					buf.put_string (");")
					buf.put_new_line
				end
			else
				buf.put_new_line
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
		end

	generate_item_address (gen_reg: REGISTRABLE)
			-- Generate inlined version of `item_address'.
		require
			gen_reg_not_void: gen_reg /= Void
		local
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_A
			type_c: TYPE_C
			l_param_is_expanded: BOOLEAN
			l_exp_class_type: CLASS_TYPE
		do
			parameters.generate
			buf := buffer

			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.item_address) */")

			buf.put_new_line
			result_reg.print_register
			buf.put_string (" = ")
			gen_reg.print_register

			l_gen_param := generic_type
			l_param_is_expanded := l_gen_param.is_true_expanded

			if l_param_is_expanded then
				l_exp_class_type := l_gen_param.associated_class_type (context.context_class_type.type)
				if l_exp_class_type.skeleton.has_references then
					buf.put_string (" + OVERHEAD + (rt_uint_ptr)")
					parameters.i_th (1).print_register
					buf.put_string (" * (rt_uint_ptr)(")
					l_exp_class_type.skeleton.generate_size (buf, True)
					buf.put_string (" + OVERHEAD)")
				else
					buf.put_string (" + (rt_uint_ptr)")
					parameters.i_th (1).print_register
					buf.put_string (" * (rt_uint_ptr)")
					l_exp_class_type.skeleton.generate_size (buf, True)
				end
			else
				type_c := l_gen_param.c_type
				buf.put_string (" + (rt_uint_ptr)")
				parameters.i_th (1).print_register
				buf.put_three_character (' ', '*', ' ')
				type_c.generate_size (buffer)
			end
			buf.put_character (';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_put (gen_reg: REGISTRABLE)
			-- Generate inlined version of `put'.
		require
			gen_reg_not_void: gen_reg /= Void
		local
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_A
			type_c: TYPE_C
			l_param_is_expanded: BOOLEAN
			l_exp_class_type: CLASS_TYPE
		do
			parameters.generate
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.put) */")

				-- Get the type of the generic parameter of SPECIAL
			l_gen_param := generic_type
			l_param_is_expanded := l_gen_param.is_true_expanded

			buf.put_new_line
			if l_param_is_expanded then
				l_exp_class_type := l_gen_param.associated_class_type (context.context_class_type.type)
				if l_exp_class_type.skeleton.has_references then
					buf.put_string ("ecopy(")
					parameters.i_th (1).print_register
					buf.put_string (", ")
					gen_reg.print_register
					buf.put_string (" + OVERHEAD + (rt_uint_ptr)")
					parameters.i_th (2).print_register
					buf.put_string (" * (rt_uint_ptr)(")
					l_exp_class_type.skeleton.generate_size (buf, True)
					buf.put_string (" + OVERHEAD));")
					buf.put_new_line
				else
					buf.put_string ("memcpy(")
					gen_reg.print_register
					buf.put_string (" + (rt_uint_ptr)")
					parameters.i_th (2).print_register
					buf.put_string (" * (rt_uint_ptr)")
					l_exp_class_type.skeleton.generate_size (buf, True)
					buf.put_string (",")
					parameters.i_th (1).print_register
					buf.put_string (", ")
					l_exp_class_type.skeleton.generate_size (buf, True)
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
		end

	generate_move (gen_reg: REGISTRABLE; is_overlapping: BOOLEAN)
			-- Generate inlined version of `move_data' and `overlapping_move'.
		require
			gen_reg_not_void: gen_reg /= Void
			not_is_expanded_with_references: not is_expanded_with_references
		local
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_A
			type_c: TYPE_C
			l_param_is_expanded: BOOLEAN
			l_exp_class_type: CLASS_TYPE
		do
			parameters.generate
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.move_data/overlapping_move) */")

				-- Get the type of the generic parameter of SPECIAL
			l_gen_param := generic_type
			l_param_is_expanded := l_gen_param.is_true_expanded

			buf.put_new_line
			if is_overlapping then
				buf.put_string ("memmove")
			else
				buf.put_string ("memcpy")
			end

			if l_param_is_expanded then
				l_exp_class_type := l_gen_param.associated_class_type (context.context_class_type.type)
				buf.put_string ("((char *)")
				gen_reg.print_register
				buf.put_string (" + (rt_uint_ptr)")
				parameters.i_th (2).print_register
				buf.put_string (" * (rt_uint_ptr)")
				l_exp_class_type.skeleton.generate_size (buf, True)
				buf.put_string (", (char *) ")
				gen_reg.print_register
				buf.put_string (" + (rt_uint_ptr)")
				parameters.i_th (1).print_register
				buf.put_string (" * (rt_uint_ptr)")
				l_exp_class_type.skeleton.generate_size (buf, True)
				buf.put_string (", (rt_uint_ptr)")
				parameters.i_th (3).print_register
				buf.put_string (" * (rt_uint_ptr)")
				l_exp_class_type.skeleton.generate_size (buf, True)
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
				buf.put_string (", (rt_uint_ptr)")
				type_c.generate_size (buf)
				buf.put_string (" * (rt_uint_ptr)")
				parameters.i_th (3).print_register
			end
			buf.put_character (')')
			buf.put_character (';')

				-- Add `eif_helpers.h' for C compilation where `eif_max_int32' function is declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
			buf.put_new_line
			buf.put_string("RT_SPECIAL_COUNT(");
			gen_reg.print_register
			buf.put_string (") = eif_max_int32(RT_SPECIAL_COUNT(")
			gen_reg.print_register
			buf.put_three_character (')', ',', ' ')
			parameters.i_th (2).print_register
			buf.put_three_character (' ', '+', ' ')
			parameters.i_th (3).print_register
			buf.put_two_character (')', ';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_copy_data (gen_reg: REGISTRABLE)
			-- Generate inlined version of `copy_data'.
		require
			gen_reg_not_void: gen_reg /= Void
			not_is_expanded_with_references: not is_expanded_with_references
		local
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_A
			type_c: TYPE_C
			l_param_is_expanded: BOOLEAN
			l_exp_class_type: CLASS_TYPE
		do
			parameters.generate
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.copy_data) */")

				-- Get the type of the generic parameter of SPECIAL
			l_gen_param := generic_type
			l_param_is_expanded := l_gen_param.is_true_expanded

			buf.put_new_line
			if l_param_is_expanded then
				l_exp_class_type := l_gen_param.associated_class_type (context.context_class_type.type)

				buf.put_string ("memmove((char *)")
				gen_reg.print_register
				buf.put_string (" + (rt_uint_ptr)")
				parameters.i_th (3).print_register
				buf.put_string (" * (rt_uint_ptr)")
				l_exp_class_type.skeleton.generate_size (buf, True)
				buf.put_string (", (char *) ")
				parameters.i_th (1).print_register
				buf.put_string (" + (rt_uint_ptr)")
				parameters.i_th (2).print_register
				buf.put_string (" * (rt_uint_ptr)")
				l_exp_class_type.skeleton.generate_size (buf, True)
				buf.put_string (", (rt_uint_ptr)")
				parameters.i_th (4).print_register
				buf.put_string (" * (rt_uint_ptr)")
				l_exp_class_type.skeleton.generate_size (buf, True)
				buf.put_character (')')
				buf.put_character (';')
			else
				type_c := l_gen_param.c_type
				if type_c.level = C_ref then
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
					buf.put_string (", (rt_uint_ptr)")
					type_c.generate_size (buf)
					buf.put_string (" * (rt_uint_ptr)")
					parameters.i_th (4).print_register
				end
				buf.put_character (')')
				buf.put_character (';')
			end

				-- Add `eif_helpers.h' for C compilation where `eif_max_int32' function is declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
			buf.put_new_line
			buf.put_string("RT_SPECIAL_COUNT(");
			gen_reg.print_register
			buf.put_string (") = eif_max_int32(RT_SPECIAL_COUNT(")
			gen_reg.print_register
			buf.put_three_character (')', ',', ' ')
			parameters.i_th (3).print_register
			buf.put_three_character (' ', '+', ' ')
			parameters.i_th (4).print_register
			buf.put_two_character (')', ';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

	generate_clear_all (gen_reg: REGISTRABLE)
			-- Generate inlined version of `clear_all'.
		require
			gen_reg_not_void: gen_reg /= Void
			not_is_expanded_with_side_effect: not generic_type.is_true_expanded
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_new_line
			buf.put_string ("/* INLINED CODE (SPECIAL.clear_all) */")
			buf.put_new_line
			buf.put_string ("memset (")
			gen_reg.print_register
			buf.put_string (", 0, RT_SPECIAL_VISIBLE_SIZE(")
			gen_reg.print_register
			buf.put_three_character (')', ')', ';')
			buf.put_new_line
			buf.put_string ("/* END INLINED CODE */")
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class SPECIAL_INLINED_FEAT_B

note
	description: "Special inlining for SPECIAL classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	generate_parameters (gen_reg: REGISTRABLE)
			-- Generate inlined routines.
		local
			g: TYPE_A
		do
			inspect feature_name_id
			when {PREDEFINED_NAMES}.put_name_id then
				parameters.generate
				buffer.put_new_line
				generate_special_put (gen_reg, generic_type)
			when
				{PREDEFINED_NAMES}.item_name_id,
				{PREDEFINED_NAMES}.infix_at_name_id,
				{PREDEFINED_NAMES}.at_name_id
			then
				generate_item (gen_reg)
			when {PREDEFINED_NAMES}.base_address_name_id then
				generate_special_base_address (result_reg, gen_reg)
			when {PREDEFINED_NAMES}.item_address_name_id then
				parameters.generate
				generate_special_item_address (result_reg, gen_reg, generic_type)
			when {PREDEFINED_NAMES}.copy_data_name_id then
				g := generic_type
				if is_special_actual_expanded_with_references (g) then
					Precursor (gen_reg)
				else
					parameters.generate
					buffer.put_new_line
					generate_special_copy_data (gen_reg, g)
				end
			when {PREDEFINED_NAMES}.non_overlapping_move_name_id then
				g := generic_type
				if is_special_actual_expanded_with_references (g) then
					Precursor (gen_reg)
				else
					parameters.generate
					buffer.put_new_line
					generate_special_move (gen_reg, g, False)
				end
			when
				{PREDEFINED_NAMES}.move_data_name_id,
				{PREDEFINED_NAMES}.overlapping_move_name_id
			then
				g := generic_type
				if is_special_actual_expanded_with_references (g) then
					Precursor (gen_reg)
				else
					parameters.generate
					buffer.put_new_line
					generate_special_move (gen_reg, g, True)
				end
			when {PREDEFINED_NAMES}.clear_all_name_id then
				g := generic_type
				if g.is_true_expanded then
					Precursor (gen_reg)
				else
					buffer.put_new_line
					generate_special_clear_all (gen_reg, g)
				end
			when {PREDEFINED_NAMES}.count_name_id then
				generate_special_count (result_reg, gen_reg)
			else
				Precursor (gen_reg)
			end
		end

feature {NONE} -- Status report

	generic_type: TYPE_A
				-- Extract type of generic parameter G in SPECIAL [G].
			local
				l_special_type: CL_TYPE_A
			do
				if parent = Void then
						-- When there is no parent it means that the call is done
						-- within the SPECIAL class. So we can safely extract the type
						-- from the current class type being generated.
					l_special_type := Context.context_cl_type
				else
					if parent.target = Current then
							-- This is the case of (area.item (i).feature_call).
						l_special_type := parent.parent.target.type.associated_class_type (context.context_class_type.type).type
					else
							-- We go back to the target of current call to get its type.
						l_special_type := parent.target.type.associated_class_type (context.context_class_type.type).type
					end
				end
				check
					l_special_type_not_void: l_special_type /= Void
					l_special_type_has_generic: attached l_special_type.generics as g and then g.count >= 1
				end
				Result := l_special_type.generics.first
			end

feature {NONE} -- Implementation

	generate_item (gen_reg: REGISTRABLE)
			-- Generate inlined version of `item'.
		require
			gen_reg_not_void: gen_reg /= Void
		local
			buf: GENERATION_BUFFER
			l_gen_param: TYPE_A
			l_exp_class_type: CLASS_TYPE
			l_old_reg: REGISTRABLE
		do
			parameters.generate
				-- Get the type of the generic parameter of SPECIAL
			l_gen_param := generic_type
			if l_gen_param.is_true_expanded then
				l_exp_class_type := l_gen_param.associated_class_type (context.context_class_type.type)
				if l_exp_class_type.skeleton.has_references then
					generate_special_item_with_references (result_reg, gen_reg, l_exp_class_type)
				else
					buf := buffer
					buf.put_new_line
					buf.put_string ("/* INLINED CODE (SPECIAL.item) */")
						-- No need to protect target register, because it is
						-- protected by the routine calling `item'.
						-- Note: We also need to set the inlined register to `gen_reg' (not to `current_reg
						-- because `current_reg' would need to be initialized and we do not do that for
						-- inlined features of SPECIAL) so that the creation is done using the proper object.
						-- We also need to change the context otherwise it fails at execution time
						-- (see eweasel test#exec147)
					context.put_inline_context (Current,
						system.class_type_of_id (context_type_id), context_cl_type,
						system.class_type_of_id (written_type_id), written_cl_type)
					context.set_inlined_current_register (gen_reg)
					l_old_reg := current_reg
					current_reg := gen_reg
					l_exp_class_type.generate_expanded_creation (buf, result_reg.register_name,
						create {FORMAL_A}.make (False, False, 1), context.context_class_type)
					current_reg := l_old_reg
					context.remove_inline_context
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
					buf.put_string ("/* END INLINED CODE */")
				end
			else
				generate_special_item_basic (result_reg, gen_reg, l_gen_param)
			end
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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

end

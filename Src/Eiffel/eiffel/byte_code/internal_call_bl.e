note
	description: "A finalized node for a monomorphic internal feature call."

class INTERNAL_CALL_BL

inherit
	FEATURE_BL
		redefine
			analyze_on,
			generate_end,
			is_polymorphic
		end

create
	make

feature {NONE} -- Creation

	make (other: ROUTINE_B; e: like routine_entry)
			-- Initialize from `other` with a direct feature call entry `e`.
		require
			context.final_mode
		do
			fill_from (other)
			routine_entry := e
		ensure
			routine_entry = e
		end

feature {NONE} -- Access

	routine_entry: ROUT_ENTRY
			-- A routine entry associated with the feature to be called.

feature -- Status report

	is_polymorphic: BOOLEAN = False
			-- <Precursor>

feature -- C code generation

	analyze_on (r: REGISTRABLE)
			-- <Precursor>
		do
			analyze_non_object_call_target
			analyze_basic_type
			if attached parameters as arguments then
					-- If no arguments allocate memory, they can be generated inline.
				if
					not across arguments as a some a.item.allocates_memory end and then
						-- Avoid propagation for certain inlined code.
					(System.inlining_on and then
					attached {CL_TYPE_A} context_type as class_type and then
					class_type.base_class.is_special implies
					are_arguments_inlinable (class_type))
				then
					across
						arguments as a
					loop
						context.init_propagation
						a.item.propagate (No_register)
					end
				end
				arguments.analyze
					-- If No_register has been propagated, then this call will
					-- be expanded in line. It might be part of a more complex
					-- expression, hence temporary registers used by the
					-- parameters may not be released now.
				if not perused then
					free_param_registers
				end
			end
			if target_register (r).is_current then
				context.mark_current_used
			end
		end

	generate_end (reg: REGISTRABLE; class_type: CL_TYPE_A)
			-- Generate final portion of C code.
		local
			buf: GENERATION_BUFFER
			has_generated: BOOLEAN
			routine_name: STRING
			type_c: TYPE_C
			entry: like routine_entry
			f: FEATURE_I
			l_index: INTEGER
		do
			buf := buffer
			if
				System.inlining_on and then
				class_type.base_class.is_special
			then
				inspect feature_name_id
				when {PREDEFINED_NAMES}.base_address_name_id then
					buf.indent
					generate_special_base_address (Void, reg)
					buf.exdent
					has_generated := True
				when {PREDEFINED_NAMES}.clear_all_name_id then
					if
						attached class_type.generics.first as parameter_type and then
						not parameter_type.is_true_expanded
					then
						generate_special_clear_all (reg, parameter_type)
						has_generated := True
					end
				when {PREDEFINED_NAMES}.copy_data_name_id then
					if
						attached class_type.generics.first as parameter_type and then
						not is_special_actual_expanded_with_references (parameter_type)
					then
						generate_special_copy_data (reg, parameter_type)
						has_generated := True
					end
				when {PREDEFINED_NAMES}.count_name_id then
					buf.indent
					generate_special_count (Void, reg)
					buf.exdent
					has_generated := True
				when
					{PREDEFINED_NAMES}.item_name_id,
					{PREDEFINED_NAMES}.infix_at_name_id,
					{PREDEFINED_NAMES}.at_name_id
				then
					if attached class_type.generics.first as parameter_type then
						if not parameter_type.is_true_expanded then
							buf.indent
							generate_special_item_basic (Void, reg, parameter_type)
							buf.exdent
							has_generated := True
						elseif
							attached parameter_type.associated_class_type (context.context_class_type.type) as argument_class_type and then
							argument_class_type.skeleton.has_references
						then
							buf.indent
							generate_special_item_with_references (Void, reg, argument_class_type)
							buf.exdent
							has_generated := True
						end
					end
				when
					{PREDEFINED_NAMES}.move_data_name_id,
					{PREDEFINED_NAMES}.overlapping_move_name_id
				then
					if
						attached class_type.generics.first as parameter_type and then
						not is_special_actual_expanded_with_references (parameter_type)
					then
						generate_special_move (reg, parameter_type, True)
						has_generated := True
					end
				when {PREDEFINED_NAMES}.non_overlapping_move_name_id then
					if
						attached class_type.generics.first as parameter_type and then
						not is_special_actual_expanded_with_references (parameter_type)
					then
						generate_special_move (reg, parameter_type, False)
						has_generated := True
					end
				when {PREDEFINED_NAMES}.put_name_id then
					generate_special_put (reg, class_type.generics.first)
					has_generated := True
				else
				end
			end
			if not has_generated then
				type_c := (if is_once_creation then class_type else real_type (type) end).c_type
				entry := routine_entry
				routine_name := entry.routine_name
				f := system.class_of_id (entry.class_id).feature_of_feature_id (entry.feature_id)
				if f.is_process_or_thread_relative_once and then context.is_once_call_optimized then
						-- Routine contracts (require, ensure, invariant) should not be checked
						-- and value of already called once routine can be retrieved from memory
					is_direct_once.put (True)
					l_index := entry.body_index
					context.generate_once_optimized_call_start (type_c, l_index, is_process_relative, is_object_relative, buf)
				end
				if entry.access_type_id /= Context.original_class_type.type_id then
						-- Remember extern routine declaration if not written in the same class.
					Extern_declarations.add_routine_with_signature
						(type_c.c_string, routine_name, argument_types)
					if l_index > 0 then
						Extern_declarations.add_once (type_c, l_index, is_process_relative, is_object_relative)
					end
				end
				generate_nested_flag (True)
				buf.put_string (routine_name)
				if is_direct_once.item then
					if is_right_parenthesis_needed.item then
						buf.put_character (')')
					end
					buf.put_two_character (',', ' ')
					generate_arguments (reg, True)
					buf.put_character (')')
				else
					generate_arguments (reg, True)
					if is_right_parenthesis_needed.item then
						buf.put_character (')')
					end
				end
			end
		end

feature {NONE} -- Inlining

	are_arguments_inlinable (class_type: CL_TYPE_A): BOOLEAN
			-- Can arguments be inlined when the corresponding feature called on `class_type` is inlined?
	require
		System.inlining_on
		class_type.base_class.is_special
	do
		inspect feature_name_id
		when {PREDEFINED_NAMES}.clear_all_name_id then
			Result :=
				attached class_type.generics.first as parameter_type implies
				parameter_type.is_true_expanded
		when
			{PREDEFINED_NAMES}.copy_data_name_id,
			{PREDEFINED_NAMES}.move_data_name_id,
			{PREDEFINED_NAMES}.overlapping_move_name_id,
			{PREDEFINED_NAMES}.non_overlapping_move_name_id
		then
			Result :=
				attached class_type.generics.first as parameter_type implies
				is_special_actual_expanded_with_references (parameter_type)
		when {PREDEFINED_NAMES}.put_name_id then
			Result :=
				attached class_type.generics.first as parameter_type implies
				(parameter_type.is_true_expanded or else parameter_type.c_type.level /= c_ref)
		else
				-- The call is inlined and it's OK to inline arguments or
				-- the call is not inlined, therefore, arguments can be inlined.
			Result := True
		end
	end

invariant
	context.final_mode

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

note
	description: "A finalized node for a polymorphic feature call."

class POLYMORPHIC_CALL_BL

inherit
	FEATURE_BL
		redefine
			analyze_on,
			generate_end,
			is_polymorphic
		end

create
	make

feature {NONE} --Initialisation

	make (other: ROUTINE_B; i: like array_index)
			-- Fill in node with feature `f` and polymorphic array index `array_index`.
		require
			other.is_polymorphic
			i >= 0
		do
			fill_from (other)
			array_index := i
		ensure
			array_index = i
		end

feature -- Status report

	is_polymorphic: BOOLEAN = True
			-- <Precursor>

feature -- Access

	array_index: INTEGER
			-- Minimum type ID for lookup in the associated polymorphic table.

feature -- C code generation

	analyze_on (r: REGISTRABLE)
			-- <Precursor>
		local
			reg: REGISTRABLE
--			l_optimizable: BOOLEAN
		do
			analyze_non_object_call_target
			reg := target_register (r)
			if
				not reg.is_predefined and
				attached {ACCESS_B} reg as access and then
				access.register = No_register
			then
					-- BEWARE!! The function call is polymorphic hence we'll
					-- need to evaluate `reg' twice: once to get its dynamic
					-- type and once as a parameter for Current. Hence we
					-- must make sure it is not held in a No_register--RAM.
				access.set_register (Void)
				access.get_register
			end
			if attached parameters as arguments then
					-- If no arguments allocate memory, they can be generated inline.
--					-- If we have only one parameter and it is a single access to
--					-- an attribute, then expand it in-line.
--				from
--					l_optimizable := True
--					arguments.start
--				until
--					arguments.after
--				loop
--					if
--						(attached {ACCESS_B} arguments.item.expression as access_b implies not access_b.is_attribute) and then
--						(attached {NESTED_B} arguments.item.expression as l_nested implies
--							(not (l_nested.target.is_predefined or l_nested.target.is_attribute) or not l_nested.message.is_attribute))
--					then
--						l_optimizable := False
--						arguments.finish
--					end
--					arguments.forth
--				end
--				if l_optimizable then
				if not across arguments as a some a.item.allocates_memory end then
					from
						arguments.start
					until
						arguments.after
					loop
						context.init_propagation
						arguments.item.propagate (No_register)
						arguments.forth
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
			if reg.is_current then
				context.mark_current_used
				context.add_dt_current
			end
		end

	generate_end (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- <Precursor>
		local
			table_name: STRING
			type_i: TYPE_A
			type_c: TYPE_C
			buf: GENERATION_BUFFER
		do
			check
				final_mode: context.final_mode
			end
			buf := buffer
			type_i := real_type (type)
			type_c := type_i.c_type
				-- The call is polymorphic, so generate access to the
				-- routine table. The dereferenced function pointer has
				-- to be enclosed in parenthesis.
			generate_nested_flag (True)
			table_name := Encoder.routine_table_name (routine_id)
				-- It is pretty important that we use `actual_type.is_formal' and not
				-- just `is_formal' because otherwise if you have `like x' and `x: G'
				-- then we would fail to detect that.
			if
				system.seed_of_routine_id (routine_id).type.actual_type.is_formal and then
				type_i.is_basic and then not has_one_signature
			then
					-- Feature returns a reference that needs to be used as a basic one.
				if not is_right_parenthesis_needed.item then
					is_right_parenthesis_needed.put (True)
					buf.put_character ('(')
				end
				buf.put_string ("eif_optimize_return = 1, *")
				type_c.generate_access_cast (buf)
				type_c := reference_c_type
			end
			buf.put_character ('(')
			type_c.generate_function_cast (buf, argument_types, False)
				-- Generate the following dispatch:
				-- table [Actual_offset - base_offset]
			buf.put_string (table_name)
			buf.put_character ('[')
			if reg.is_current then
				context.generate_current_dtype
			else
				buf.put_string ({C_CONST}.dtype)
				buf.put_character ('(')
				reg.print_checked_target_register
				buf.put_character (')')
			end
			buf.put_character ('-')
			buf.put_integer (array_index)
			buf.put_two_character (']', ')')
				-- Mark routine id used.
			eiffel_table.mark_used (routine_id)
				-- Remember routine table declaration.
			extern_declarations.add_routine_table (table_name)
			generate_arguments (reg, False)
			if is_right_parenthesis_needed.item then
				buf.put_character (')')
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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

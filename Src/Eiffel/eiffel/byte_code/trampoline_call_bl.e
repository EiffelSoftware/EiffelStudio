note
	description: "A finalized node for a feature call using a trampoline to adjust argument and/or result types."

class TRAMPOLINE_CALL_BL

inherit
	FEATURE_BL
		redefine
			analyze_on,
			generate_end
		end

create
	make

feature {NONE} -- Creation

	make (other: ROUTINE_B; t, c: ROUT_ENTRY; p: ROUT_TABLE)
			-- Initialize a trampoline call object from `other` with a target entry `t` (the feature to be called) and
			-- a context entry `c` (the feature that was expected in the call) from the table `p`.
		do
			fill_from (other)
			target_entry := t
			context_entry := c
			trampoline_name := p.trampoline_name (t, c)
		end

feature {NONE} -- Access

	target_entry: ROUT_ENTRY
			-- A routine entry associated with the feature to be called.

	context_entry: ROUT_ENTRY
			-- A routine entry associated with the feature initially used in the call.

	trampoline_name: STRING_8
			-- The name of the trampoline.

feature -- C code generation

	analyze_on (r: REGISTRABLE)
			-- Analyze feature call on `r`.
		do
			analyze_non_object_call_target
			if attached {BASIC_A} context_type as basic_i and then not is_feature_special (True, basic_i) then
					-- Get a register to store the metamorphosed basic type,
					-- on which the attribute access is made. The lifetime of
					-- this temporary is really short: just the time to make
					-- the call...
					-- We need it only when a metamorphose occurs or if we
					-- are handling BIT objects.
				create {REGISTER} basic_register.make (Reference_c_type)
			end
			if attached parameters as arguments then
					-- If no arguments allocate memory, they can be generated inline.
				if not across arguments as a some a.item.allocates_memory end then
					across
						arguments as a
					loop
						context.init_propagation
						a.item.propagate (No_register)
					end
				end
				parameters.analyze
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
		do
			buf := buffer
			system.request_trampoline (target_entry, context_entry, routine_id)
				-- Remember extern routine declaration if not written in the same class or if a trampoline is used.
			Extern_declarations.add_routine_with_signature
				(real_type (type).c_type.c_string, trampoline_name, argument_types)
			generate_nested_flag (True)
			buf.put_string (trampoline_name)
			generate_arguments (reg, not is_polymorphic)
			if is_right_parenthesis_needed.item then
				buf.put_character (')')
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
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

note
	description: "C code generation for a routine call."

deferred class ROUTINE_BL

inherit
	ROUTINE_B
		undefine
			allocates_memory,
			analyze_on,
			call_kind,
			current_needed_for_access,
			enlarged,
			enlarged_on,
			generate_access,
			generate_access_on_type,
			generate_end,
			generate_on,
			generate_parameters_list,
			inlined_byte_code,
			is_constant_expression,
			is_external,
			is_feature,
			is_feature_call,
			is_special_feature,
			is_unsafe,
			need_target,
			set_call_kind
		redefine
			analyze,
			basic_register,
			free_register,
			has_one_signature,
			is_polymorphic,
			parent,
			register,
			set_parent,
			set_register
		end

feature -- Access

	parent: NESTED_BL
			-- Parent of access

	register: REGISTRABLE
			-- In which register the expression is stored

	basic_register: REGISTRABLE
			-- Register used to store the metamorphosed simple type

feature -- Modification

	set_register (r: REGISTRABLE)
			-- Set current register to `r'
		do
			register := r
		end

	set_parent (p: NESTED_BL)
			-- Assign `p' to `parent'
		do
			parent := p
		end

feature -- Code generation

	analyze
			-- Build a proper context for code generation.
		do
			analyze_on (Current_register)
			get_register
		end

	free_register
			-- Free registers.
		do
			Precursor
			if basic_register /= Void then
				basic_register.free_register
			end
		end

feature -- Optimization

	is_polymorphic: BOOLEAN
			-- Is access polymorphic ?
		local
			type_i: TYPE_A
		do
			type_i := context_type
			if not type_i.is_basic and then precursor_type = Void then
				Result := Eiffel_table.is_polymorphic (routine_id, type_i, context.context_class_type, True) >= 0
			end
		end

	has_one_signature: BOOLEAN
			-- <Precursor>
		do
			Result := Eiffel_table.poly_table (routine_id).has_one_signature
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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

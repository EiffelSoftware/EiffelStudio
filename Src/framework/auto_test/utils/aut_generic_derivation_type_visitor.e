note
	description: "Visitor to generate generic derivation of a type"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_GENERIC_DERIVATION_TYPE_VISITOR

inherit
	TYPE_A_VISITOR

	COMPILER_EXPORTER

feature -- Basic operation

	derived_type (a_type: TYPE_A; a_context_class: CLASS_C): TYPE_A
			-- Generic derivation for `a_type' in context `a_context_class'
		require
			a_type_attached: a_type /= Void
			a_context_class_attached: a_context_class /= Void
		do
			context := a_context_class
			a_type.process (Current)
			Result := last_type
		end

feature{NONE} -- Implementation

	context: CLASS_C
			-- Context in which type will be evaluated

	last_type: TYPE_A
			-- Last type created by Current visitor

feature {TYPE_A}

	process_boolean_a (a_type: BOOLEAN_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_character_a (a_type: CHARACTER_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_cl_type_a (a_type: CL_TYPE_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_formal_a (a_type: FORMAL_A)
			-- Process `a_type'.
		do
			last_type := context.constraints (a_type.position).first.type
		end

	process_gen_type_a (a_type: GEN_TYPE_A)
			-- Process `a_type'.
		local
			l_type: GEN_TYPE_A
			l_derived_generics: ARRAYED_LIST [TYPE_A]
		do
			l_type := a_type.duplicate
			create l_derived_generics.make (a_type.generics.count)

			across a_type.generics as l_generic loop
				l_generic.item.process (Current)
				l_derived_generics.extend (last_type)
			end
			l_type.set_generics (l_derived_generics)
			last_type := l_type
		end

	process_integer_a (a_type: INTEGER_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_like_argument (a_type: LIKE_ARGUMENT)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_like_current (a_type: LIKE_CURRENT)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_like_feature (a_type: LIKE_FEATURE)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_local (a_type: LOCAL_TYPE_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_manifest_integer_a (a_type: MANIFEST_INTEGER_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_manifest_natural_64_a (a_type: MANIFEST_NATURAL_64_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_manifest_real_a (a_type: MANIFEST_REAL_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_named_tuple_type_a (a_type: NAMED_TUPLE_TYPE_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_native_array_type_a (a_type: NATIVE_ARRAY_TYPE_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_natural_a (a_type: NATURAL_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_none_a (a_type: NONE_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_pointer_a (a_type: POINTER_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_qualified_anchored_type_a (a_type: QUALIFIED_ANCHORED_TYPE_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_real_a (a_type: REAL_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_tuple_type_a (a_type: TUPLE_TYPE_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_typed_pointer_a (a_type: TYPED_POINTER_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_unevaluated_like_type (a_type: UNEVALUATED_LIKE_TYPE)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_unevaluated_qualified_anchored_type (a_type: UNEVALUATED_QUALIFIED_ANCHORED_TYPE)
			-- Process `a_type'.
		do
			last_type := a_type
		end

	process_unknown (t: UNKNOWN_TYPE_A)
			-- <Precursor>
		do
			last_type := t
		end

	process_void_a (a_type: VOID_A)
			-- Process `a_type'.
		do
			last_type := a_type
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

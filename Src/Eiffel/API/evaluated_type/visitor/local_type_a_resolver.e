note
	description: "Evaluator of types of locals without explicit type declarations."

class
	LOCAL_TYPE_A_RESOLVER

inherit
	TYPE_A_VISITOR
		redefine
			process_multi_formal_a
		end

create
	make

feature {NONE} -- Creation

	make
			-- Initialize resolver object.
		do
			create stack.make (0)
		end

feature -- Basic operation

	resolve (l: LOCAL_TYPE_A)
			-- Try to resolve `l' in the current context and make it available in `last_type'.
		do
			stack.wipe_out
			last_type := Void
			l.process (Current)
		end

feature -- Access

	last_type: detachable TYPE_A

feature {TYPE_A} -- Visitor

	process_boolean_a (a_type: BOOLEAN_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_character_a (a_type: CHARACTER_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_cl_type_a (a_type: CL_TYPE_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_formal_a (a_type: FORMAL_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_gen_type_a (a_type: GEN_TYPE_A)
			-- <Precursor>
		local
			old_parameter: TYPE_A
			generic_type: detachable GEN_TYPE_A
		do
				-- Set result type to the currently visited type and reset it to Void on error.
			generic_type := a_type
			across
				a_type.generics as g
			until
				generic_type = Void
			loop
				old_parameter := g.item
				old_parameter.process (Current)
				if not attached last_type as new_parameter then
						-- There was a problem computing an actual generic paramater.
						-- Propagate this information.
					generic_type := Void
				elseif not new_parameter.same_as (old_parameter) then
						-- The actual generic parameter is changed, make it available in a copy of the current type.
					if generic_type = a_type then
						generic_type := a_type.duplicate
					end
					check
						from_loop_exit_condition: attached generic_type
					then
						generic_type.generics [g.target_index] := new_parameter
					end
				end
			end
			last_type := generic_type
		end

	process_integer_a (a_type: INTEGER_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_like_argument (a_type: LIKE_ARGUMENT)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_like_current (a_type: LIKE_CURRENT)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_like_feature (a_type: LIKE_FEATURE)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_local (a_type: LOCAL_TYPE_A)
			-- <Precursor>
		do
			if stack.has (a_type.position) then
					-- There is a circular dependency.
				last_type := Void
			elseif attached a_type.minimum as m then
					-- Mark `a_type' as being processed.
				stack.put (a_type.position)
					-- Resolved `m'.
				m.process (Current)
					-- Unmark `a_type' as being processed.
				stack.remove
			else
					-- The type cannot be computed yet.
				last_type := Void
			end
		end

	process_manifest_integer_a (a_type: MANIFEST_INTEGER_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_manifest_natural_64_a (a_type: MANIFEST_NATURAL_64_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_manifest_real_a (a_type: MANIFEST_REAL_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_multi_formal_a (a_type: MULTI_FORMAL_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_named_tuple_type_a (a_type: NAMED_TUPLE_TYPE_A)
			-- <Precursor>
		do
			process_gen_type_a (a_type)
		end

	process_native_array_type_a (a_type: NATIVE_ARRAY_TYPE_A)
			-- <Precursor>
		do
			process_gen_type_a (a_type)
		end

	process_natural_a (a_type: NATURAL_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_none_a (a_type: NONE_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_pointer_a (a_type: POINTER_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_qualified_anchored_type_a (a_type: QUALIFIED_ANCHORED_TYPE_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_real_a (a_type: REAL_A)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_tuple_type_a (a_type: TUPLE_TYPE_A)
			-- <Precursor>
		do
			process_gen_type_a (a_type)
		end

	process_typed_pointer_a (a_type: TYPED_POINTER_A)
			-- <Precursor>
		do
			process_gen_type_a (a_type)
		end

	process_unevaluated_like_type (a_type: UNEVALUATED_LIKE_TYPE)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_unevaluated_qualified_anchored_type (a_type: UNEVALUATED_QUALIFIED_ANCHORED_TYPE)
			-- <Precursor>
		do
			last_type := a_type
		end

	process_void_a (a_type: VOID_A)
			-- <Precursor>
		do
			last_type := a_type
		end

feature {NONE} -- Traversal

	stack: ARRAYED_STACK [like {LOCAL_TYPE_A}.position]
			-- Positions of {LOCAL_TYPE_A} that are being processed.

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

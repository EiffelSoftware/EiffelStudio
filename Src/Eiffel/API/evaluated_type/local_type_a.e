note
	description: "Unknown type of a local variable."

class
	LOCAL_TYPE_A

inherit
	UNKNOWN_TYPE_A
		redefine
			backward_conform_to,
			dump,
			ext_append_to,
			hash_code,
			internal_conform_to,
			is_computable,
			is_equivalent,
			same_as
		end

	SHARED_TYPES

create
	make

feature {NONE} -- Initialization

	make (p: like position)
			-- Initialize a type for a local at position `p'.
		do
			create lower_bound.make (0)
			create upper_bound.make (0)
			position := p
		ensure
			position_set: position = p
		end

feature -- Status report

	is_computable: BOOLEAN = True
			-- <Precursor>

feature -- Access

	hash_code: INTEGER
			-- <Precursor>
		do
				-- Avoid collisions with `{FORMAL_A}.hash_code'.
			Result := ({SHARED_HASH_CODE}.other_code - position).abs
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position
		end

	backward_conform_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
			-- <Precursor>
		do
				-- `Result = true', but type information may be recorded by this call.
			Precursor (a_context_class, other).do_nothing
				-- Collect type information.
			add_lower_bound (a_context_class, other, False)
				-- Assume that the code is correct.
			Result := True
		end

feature -- Access

	position: INTEGER
			-- Position in the local list.

feature -- Comparison

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		do
			Result := attached {LOCAL_TYPE_A} other as t and then is_equivalent (t)
		end

feature -- Type inference

	minimum: detachable TYPE_A
			-- Minimum type that can replace this type declaration.
		local
			t: like lower_bound.key_for_iteration
		do
			if lower_bound.count = 0 then
					-- No assignments to variables of this type.
					-- Check upper bound.
				if upper_bound.count = 1 then
						-- Use this type.
					t := upper_bound.key_for_iteration
					Result := t.type
					if not Result.is_computable then
							-- The type cannot be computed yet.
						Result := Void
					end
				else
						-- No assignments of this variable, use "NONE".
					Result := none_type
				end
			elseif lower_bound.count = 1 then
					-- All assignments to variables of this type use the same source type.
					-- Check that this type conforms to all types from `upper_bound'.
				lower_bound.start
				t := lower_bound.key_for_iteration
				Result := t.type
				if not Result.is_computable then
						-- The type cannot be computed yet.
					Result := Void
				elseif not across upper_bound as c all Result.conform_to (c.key.context, c.key.type) end then
						-- There are types to which found type does not conform.
					Result := none_type
				end
			else
					-- Complex case, leave it for future.
			end
		end

feature -- Output

	dump: STRING
			-- <Precursor>
		do
			Result := "like local#"
			Result.append_integer (position)
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C)
			-- <Precursor>
		do
			a_text_formatter.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_Like_keyword, Void)
			a_text_formatter.add_space
			a_text_formatter.add (once "local#")
			a_text_formatter.add_int (position)
		end

feature {TYPE_A} -- Helpers

	internal_conform_to (a_context_class: CLASS_C; other: TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
				-- Assume that the code is correct.
			Result := True
				-- Record information about conforming types.
			add_upper_bound (a_context_class, other, a_in_generic)
		end

feature {NONE} -- Type bounds

	lower_bound: HASH_TABLE [NONE, TUPLE [context: CLASS_C; type: TYPE_A; in_generic: BOOLEAN]]
			-- Lower bounds of the type.

	upper_bound: like lower_bound
			-- Upper bounds of the type.

feature {NONE} -- Modification

	add_lower_bound (context_class: CLASS_C; other: TYPE_A; in_generic: BOOLEAN)
			-- Add type `other' as a lower bound of the type in `context_class'.
			-- `in_generic' tells whether the type appears in a generic type.
		do
			add_bound (lower_bound, context_class, other, in_generic, conform_to_agent)
		end

	add_upper_bound (context_class: CLASS_C; other: TYPE_A; in_generic: BOOLEAN)
			-- Add type `other' as a upper bound of the type in `context_class'.
			-- `in_generic' tells whether the type appears in a generic type.
		do
			add_bound (upper_bound, context_class, other, in_generic, reverse_conform_to_agent)
		end

	add_bound (bound: like lower_bound;
		context_class: CLASS_C;
		other: TYPE_A;
		in_generic: BOOLEAN;
		is_conforming: like conform_to_agent)
			-- Add type `other' as a bound of the type in `context_class' to `bound'
			-- using `conformance_test' to check that one type conforms to another one.
			-- `in_generic' tells whether the type appears in a generic type.
		local
			t: like lower_bound.key_for_iteration
		do
				-- Check if the new lower bound is conforms to an existing one.
			if bound.is_empty or else other.is_computable and then across bound as i all not is_conforming (other, i.key.type, context_class) end then
					-- This is a new lower bound.
					-- Remove any existing bound that conform to it.
				from
					bound.start
					if not bound.is_empty and then not bound.key_for_iteration.type.is_computable then
							-- Remove uncomputable type.
						bound.remove (bound.key_for_iteration)
					end
				until
					bound.after
				loop
					if is_conforming (bound.key_for_iteration.type, other, context_class) then
							-- Existing lower bound can be replaced with a new one.
						bound.remove (bound.key_for_iteration)
					else
						bound.forth
					end
				end
					-- Record new information about conforming types.
				t := [context_class, other, in_generic]
				t.compare_objects
				bound.force (Void, t)
			end
		end

feature {NONE} -- Helper

	conform_to_agent: PREDICATE [ANY, TUPLE [s: TYPE_A; t: TYPE_A; c: CLASS_C]]
			-- A predicate to check that `s' conforms to `t' in class `c'?
		once
			Result :=
				agent (s, t: TYPE_A; c: CLASS_C): BOOLEAN
					do
						Result := s.conform_to (c, t)
					end
		end

	reverse_conform_to_agent: PREDICATE [ANY, TUPLE [s: TYPE_A; t: TYPE_A; c: CLASS_C]]
			-- A predicate to check that `t' conforms to `s' in class `c'?
		once
			Result :=
				agent (s, t: TYPE_A; c: CLASS_C): BOOLEAN
					do
						Result := t.conform_to (c, s)
					end
		end

note
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

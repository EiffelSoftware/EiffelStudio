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
			process,
			same_as
		end

	SHARED_TYPES

create
	make

feature {NONE} -- Initialization

	make (p: like position; any_type: TYPE_A; context_class: CLASS_C)
			-- Initialize a type for a local at position `p'.
		do
			create lower_bound.make (1)
			create upper_bound.make (1)
			position := p
			is_computable := True
			lower_bound.extend (Void, [context_class, none_type.as_attached_type, False])
			upper_bound.extend (Void, [context_class, any_type, False])
		ensure
			position_set: position = p
		end

feature -- Status report

	is_computable: BOOLEAN
			-- <Precursor>
			-- This is set to `False' when type computation depends on types that were not computed yet or when associated type set changes.

feature -- Status setting

	reset
			-- Prepare this object to a new cycle of type information collection.
		do
				-- Assume that the type information collected so far is stable.
			is_computable := True
		end

feature -- Access

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := combined_hash_code({SHARED_GEN_CONF_LEVEL}.max_dtype, position)
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

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- <Precursor>
		do
			v.process_local (Current)
		end

	process_lower (v: TYPE_A_VISITOR)
			-- Process all lower bounds with `v'.
		do
			across
				lower_bound as i
			loop
				i.key.type.process (v)
			end
		end

feature -- Type inference

	minimum: detachable TYPE_A
			-- Minimum type that can replace this type declaration.
		do
				-- Return non-void result only when the type is computable.
			if is_computable then
					-- If upper bound is expanded, it should be used.
				if attached upper_approximation as u and then u.is_expanded then
					Result := u
				else
					Result := lower_approximation
				end
			end
		end

	maximum: detachable TYPE_A
			-- Maximum type that can replace this type declaration.
		do
				-- Return non-void result only when the type is computable.
			if is_computable then
				Result := upper_approximation
			end
		end

	lower_approximation: detachable TYPE_A
			-- Approximate type that can replace this type declaration.
			-- Contrary to `minimum' does not take into account `is_computable' flag.
		do
			Result := approximation (lower_bound, upper_bound, conform_to_agent)
		end

	upper_approximation: detachable TYPE_A
			-- Approximate type that can replace this type declaration.
			-- Contrary to `maximum' does not take into account `is_computable' flag.
		do
			Result := approximation (upper_bound, lower_bound, reverse_conform_to_agent)
		end

	approximation (target_bound: like lower_bound; constraint_bound: like lower_bound; is_conforming: like conform_to_agent): detachable TYPE_A
			-- Approximate type that can replace this type declaration that is the closest one to `target_bound' and matches `constraint_bound'
			-- using `is_conforming' to check that the types conform.
		require
			not target_bound.is_empty
		do
			if target_bound.count = 1 then
					-- All assignments to variables of this type use the same source type.
					-- Check that this type conforms to all types from `upper_bound'.
				target_bound.start
				Result := target_bound.key_for_iteration.type
				if not across constraint_bound as c all is_conforming (Result, c.key.type, c.key.context) end then
						-- There are types to which found type does not conform.
					Result := unknown_type
				end
			else
					-- TODO: Find a target  bound to which all known target bounds conform.
					-- TODO: Check that all target bounds conform to all constraint bounds.
			end
		end

	feature_call (name_id: like {FEATURE_I}.feature_name_id; context_class: CLASS_C): detachable TUPLE [descriptor: FEATURE_I; site: CL_TYPE_A; target: TYPE_A]
			-- Information about a call to a feature with the name correponding to `name_id' called on the current type in `context_class':
			-- descriptor: feature descriptor
			-- site: class type with the  feature
			-- target: target type (may be different from "site" if it is a formal generic, acnhored type, etc.)
		do
			if attached lower_approximation as t then
				feature_finder.find (name_id, t, context_class)
				if attached feature_finder.found_feature as f then
					Result := [f, feature_finder.found_site, t]
				end
			end
		end

	operator_call (name_id: like {FEATURE_I}.alias_name_id; context_class: CLASS_C): detachable TUPLE [descriptor: FEATURE_I; site: TYPE_A; target: TYPE_A]
			-- Information about an operator call with the operator name correponding to `name_id' called on the current type in `context_class':
			-- descriptor: feature descriptor
			-- site: class type with the  feature
			-- target: target type (may be different from "site" if it is a formal generic, acnhored type, etc.)
		do
			if attached lower_approximation as t then
				feature_finder.find_by_alias (name_id, t, context_class)
				if attached feature_finder.found_feature as f then
					Result := [f, feature_finder.found_site, t]
				end
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

feature {LOCAL_TYPE_A} -- Type bounds

	lower_bound: HASH_TABLE [NONE, TUPLE [context: CLASS_C; type: TYPE_A; in_generic: BOOLEAN]]
			-- Lower bounds of the type.
		attribute
		ensure
			not Result.is_empty
		end

	upper_bound: like lower_bound
			-- Upper bounds of the type.
		attribute
		ensure
			not Result.is_empty
		end

feature {NONE} -- Modification

	add_lower_bound (context_class: CLASS_C; other: TYPE_A; in_generic: BOOLEAN)
			-- Add type `other' as a lower bound of the type in `context_class'.
			-- `in_generic' tells whether the type appears in a generic type.
		do
			add_bound (lower_bound, context_class, other, in_generic, conform_to_agent, agent (t: LOCAL_TYPE_A): like lower_bound do Result := t.lower_bound end)
		end

	add_upper_bound (context_class: CLASS_C; other: TYPE_A; in_generic: BOOLEAN)
			-- Add type `other' as a upper bound of the type in `context_class'.
			-- `in_generic' tells whether the type appears in a generic type.
		do
			add_bound (upper_bound, context_class, other, in_generic, reverse_conform_to_agent, agent (t: LOCAL_TYPE_A): like lower_bound do Result := t.upper_bound end)
		end

	add_bound (bound: like lower_bound;
		context_class: CLASS_C;
		other: TYPE_A;
		in_generic: BOOLEAN;
		is_conforming: like conform_to_agent;
		other_bound: FUNCTION [LOCAL_TYPE_A, like lower_bound])
			-- Add type `other' as a bound of the type in `context_class' to `bound'
			-- using `is_conforming' to check that one type conforms to another one
			-- and a function `other_bound' to access the corresponding bound of `other'
			-- if it appears to be of type `{LOCAL_TYPE_A}'.
			-- `in_generic' tells whether the type appears in a generic type.
		local
			new_bound: like lower_bound.key_for_iteration
			is_new_bound_inserted: BOOLEAN
			is_old_bound_removed: BOOLEAN
		do
			if same_as (other) then
					-- Nothing to do.
			elseif attached {LOCAL_TYPE_A} other as t then
					-- Add bounds from `other'.
				across
					other_bound (t) as b
				loop
					add_bound (bound, context_class, b.key.type, in_generic, is_conforming, other_bound)
				end
			elseif attached {UNKNOWN_TYPE_A} other then
					-- Record that the type is not computable.
				is_computable := False
			else
					-- Remove any existing bound that conforms to the new one.
				from
						-- Check from the beginning of the type list.
					bound.start
						-- Insert a new bound if there are none.
					is_new_bound_inserted := bound.after
				until
					bound.after
				loop
					if is_conforming (other, bound.key_for_iteration.type, context_class) then
							-- `other' conforms to one of the existing types, so no changes to the `bound' are required.
							-- But `other' may be more precise, so use it instead of existing same type (if any).
						is_old_bound_removed := other.same_as (bound.key_for_iteration.type)
					else
							-- This is a new known bound.
							-- Record that the type is not computable.
						is_computable := False
						is_old_bound_removed := is_conforming (bound.key_for_iteration.type, other, context_class)
					end
					if is_old_bound_removed then
							-- Existing lower bound is replaced with a new one.
						is_new_bound_inserted := True
							-- Remove old bound.
						bound.remove (bound.key_for_iteration)
					else
							-- Advance to next bound.
						bound.forth
					end
				end
					-- Add a new bound if required.
				if is_new_bound_inserted then
						-- Prepare a new dependency tuple.
					new_bound := [context_class, other, in_generic]
					new_bound.compare_objects
						-- Record new information about the conforming type.
					bound.force (Void, new_bound)
				end
			end
		end

feature {NONE} -- Helper

	conform_to_agent: PREDICATE [TUPLE [s: TYPE_A; t: TYPE_A; c: CLASS_C]]
			-- A predicate to check that `s' conforms to `t' in class `c'?
		once
			Result :=
				agent (s, t: TYPE_A; c: CLASS_C): BOOLEAN
					do
						Result := s.conform_to (c, t)
					end
		end

	reverse_conform_to_agent: PREDICATE [TUPLE [s: TYPE_A; t: TYPE_A; c: CLASS_C]]
			-- A predicate to check that `t' conforms to `s' in class `c'?
		once
			Result :=
				agent (s, t: TYPE_A; c: CLASS_C): BOOLEAN
					do
						Result := t.conform_to (c, s)
					end
		end

	feature_finder: TYPE_A_FEATURE_FINDER
			-- Facility to lookup for a feature in a given type.
		once
			create Result
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

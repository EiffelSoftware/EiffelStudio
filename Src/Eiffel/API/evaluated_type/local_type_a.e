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
			upper_lower_bound := any_type.as_normally_attached (context_class).as_non_separate
			lower_upper_bound := none_type.as_detachable_type.as_separate
			lower_bound.extend (Void, [context_class, none_type.as_normally_attached (context_class).as_non_separate, False])
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

	position: INTEGER
			-- Position in the local list.

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := combined_hash_code({SHARED_GEN_CONF_LEVEL}.max_dtype, position)
		end

feature {NONE} -- Access

	upper_lower_bound: TYPE_A
			-- The type to be used when lower bound could not be derived from the source code.

	lower_upper_bound: TYPE_A
			-- The type to be used when upper bound could not be derived from the source code.

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
				Result := lower_approximation
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
			Result := approximation (lower_bound, upper_bound, lower_agent, upper_lower_bound)
		end

	upper_approximation: detachable TYPE_A
			-- Approximate type that can replace this type declaration.
			-- Contrary to `maximum' does not take into account `is_computable' flag.
		do
			Result := approximation (upper_bound, lower_bound, upper_agent, lower_upper_bound)
		end

	approximation (target_bound: like lower_bound; constraint_bound: like lower_bound; common_bound: like upper_agent; extremum_bound: TYPE_A): detachable TYPE_A
			-- Approximate type that can replace this type declaration that is the closest one to `target_bound' and matches `constraint_bound'
			-- using `common_bound' to find a common bound.
		require
			not target_bound.is_empty
		do
				-- Check whether `target_bound` is compatible with `constraint_bound`.
			if
				across target_bound as t all
					across constraint_bound as c all
						attached common_bound (t.key.type, c.key.type, c.key.context) as b and then
						b.same_as (c.key.type)
					end
				end
			then
					-- The bounds are compatible.
					-- The result is either a common type for `target_bound` that is compatible with `constraint_bound`,
					-- or `unknown_type`.
				if target_bound.count = 1 then
						-- There is a single compatible type, use it.
					target_bound.start
					Result := target_bound.key_for_iteration.type
				else
						-- There are several incompatible types.
					if constraint_bound.count = 1 then
							-- Use `constraint_bound` to get one compatible to all others.
						constraint_bound.start
						Result := constraint_bound.key_for_iteration.type.to_other_attachment (extremum_bound).to_other_separateness (extremum_bound)
					else
							-- Use `extremum_bound` to get one compatible to all others.
						Result := extremum_bound
					end
					across
						target_bound as t
					until
						not attached Result
					loop
						Result := common_bound (Result, t.key.type, t.key.context)
					end
						-- Check that the found type is combatible with the other bound.
					if
						attached Result implies
						not across constraint_bound as c all
							attached common_bound (Result, c.key.type, c.key.context) as b and then b.same_as (c.key.type)
						end
					then
							-- There are types with which found type is incompatible.
						Result := unknown_type
					end
						-- Make implicit attachment status explicit.
						-- This is needed to generate attached types rather than ones with mark "detachable".
					if Result.is_implicitly_attached then
						target_bound.start
						Result := Result.as_normally_attached (target_bound.key_for_iteration.context)
					end
				end
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

	operator_call (name_id: INTEGER; context_class: CLASS_C): detachable TUPLE [descriptor: FEATURE_I; site: TYPE_A; target: TYPE_A]
			-- Information about an operator call with the operator name correponding to `name_id' called on the current type in `context_class':
			-- descriptor: feature descriptor
			-- site: class type with the  feature
			-- target: target type (may be different from "site" if it is a formal generic, acnhored type, etc.)
		require
			{OPERATOR_KIND}.is_alias_id (name_id)
			{OPERATOR_KIND}.is_fixed_alias_id (name_id)
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
			add_bound (lower_bound, context_class, other, in_generic, lower_agent, agent {LOCAL_TYPE_A}.lower_bound)
		end

	add_upper_bound (context_class: CLASS_C; other: TYPE_A; in_generic: BOOLEAN)
			-- Add type `other' as a upper bound of the type in `context_class'.
			-- `in_generic' tells whether the type appears in a generic type.
		do
			add_bound (upper_bound, context_class, other, in_generic, upper_agent, agent {LOCAL_TYPE_A}.upper_bound)
		end

	add_bound (bound: like lower_bound;
		context_class: CLASS_C;
		other: TYPE_A;
		in_generic: BOOLEAN;
		common_bound: like upper_agent;
		other_bound: FUNCTION [LOCAL_TYPE_A, like lower_bound])
			-- Add type `other' as a bound of the type in `context_class' to `bound'
			-- using `is_conforming' to check that one type conforms to another one
			-- and a function `other_bound' to access the corresponding bound of `other'
			-- if it appears to be of type `{LOCAL_TYPE_A}'.
			-- `in_generic' tells whether the type appears in a generic type.
		local
			current_bound: like lower_bound.key_for_iteration
			bound_type: TYPE_A
			removed_bounds: ARRAYED_LIST [like lower_bound.key_for_iteration]
			has_new_bound: BOOLEAN
		do
			if same_as (other) then
					-- Nothing to do.
			elseif attached {LOCAL_TYPE_A} other as t then
					-- Add bounds from `other'.
				across
					other_bound (t) as b
				loop
					add_bound (bound, context_class, b.key.type, in_generic, common_bound, other_bound)
				end
			elseif attached {UNKNOWN_TYPE_A} other then
					-- Record that the type is not computable.
				is_computable := False
			else
					-- Remove any existing bound that conforms to the new one.
				from
						-- Use `other` as a potential bound.
					bound_type := other
					has_new_bound := True
						-- Check from the beginning of the type list.
					bound.start
				until
					bound.after
				loop
					current_bound := bound.key_for_iteration
						-- Advance to the next bound (if any).
					bound.forth
					if not attached common_bound (bound_type, current_bound.type, context_class) as b then
							-- This is a new known bound.
					elseif b.same_as (current_bound.type) then
							-- There is already a bound matching the new one.
							-- There should be no removed bounds.
						check not attached removed_bounds end
							-- Skip the rest of the loop.
						from
							has_new_bound := False
						until
							bound.after
						loop
							bound.forth
						end
					else
							-- Existing bound is replaced with a new one.
						bound_type := b
							-- Check if the current bound was removed already.
						if not attached removed_bounds then
							create removed_bounds.make (1)
						end
						if not across removed_bounds as r some r.item.type.same_as (current_bound.type) end then
								-- This bound was not processed yet.
								-- Start processing from the beginning to ensure that
								-- there are no types that can be replaced with `b`.
							bound.start
						end
							-- Record that the current bound should be removed.
						removed_bounds.extend (current_bound)
					end
				end
					-- Add a new bound if required.
				if attached removed_bounds then
						-- Remove items that are superseded by `bound_type`.
					across
						removed_bounds as r
					loop
						check common_bound (bound_type, r.item.type, context_class).same_as (bound_type) end
						bound.remove (r.item)
					end
				end
				if has_new_bound then
						-- Prepare a new dependency tuple.
					current_bound := [context_class, bound_type, in_generic]
					current_bound.compare_objects
						-- Record new information about the conforming type.
					bound.force (Void, current_bound)
				end
			end
		end

feature {NONE} -- Comparison

	upper_type (x, y: TYPE_A; current_class: CLASS_C): detachable TYPE_A
			-- A type that is computed as a tripple for tripples <xc, xa, xs> and <yc, ya, ys> corresponding to `x` and `y` as follows:
			-- • xc, yc - marks free types, using only class conformance rules
			-- • xa, ya - attachment status
			-- • xs, ys - separateness status
			-- The resulting type is <zc, za, zs> where
			-- • zc = xc if yc -> xc, zc = yc if xc -> yc, zc = Void otherwise
			-- • za = attached, if xa and ya is attached, detachable otherwise
			-- • zs = separate, if xs or ys is separate, non-separate otherwise
		local
			rx, ry: TYPE_A
		do
			rx := x
			ry := y
			if y.is_attached then
				if not x.is_implicitly_attached then
						-- `x` is less attached, use its attachment status.
					ry := y.as_detachable_type
				end
			elseif x.is_attached then
				if not y.is_implicitly_attached then
						-- `y` is less attached, use its attachment status.
					rx := x.as_detachable_type
				end
			elseif y.is_implicitly_attached then
				if not x.is_implicitly_attached then
						-- `x` is less attached, use its attachment status.
					ry := y.as_implicitly_detachable
				end
			elseif x.is_implicitly_attached then
				if not y.is_implicitly_attached then
						-- `y` is less attached, use its attachment status.
					rx := x.as_implicitly_detachable
				end
			end
				-- Source types should conform to the computed ones.
			check
				x_conforms_to_rx: x.conform_to (current_class, rx)
				y_conforms_to_ry: y.conform_to (current_class, ry)
			end
			if rx.is_separate then
					-- Use `x` separateness status.
				ry := ry.to_other_separateness (rx)
			else
					-- Use `y` separateness status.
				rx := rx.to_other_separateness (ry)
			end
				-- Source types should conform to the computed ones.
			check
				x_conforms_to_rx: x.conform_to (current_class, rx)
				y_conforms_to_ry: y.conform_to (current_class, ry)
			end
				-- Use the type to which both `x` and `y` conform.
			if x.conform_to (current_class, ry) then
				Result := ry
			elseif y.conform_to (current_class, rx) then
				Result := rx
			end
		ensure
			class
			x_conforms_to_Result: attached Result implies x.conform_to (current_class, Result)
			y_conforms_to_Result: attached Result implies y.conform_to (current_class, Result)
		end

	lower_type (x, y: TYPE_A; current_class: CLASS_C): detachable TYPE_A
			-- A type that is computed as a tripple for tripples <xc, xa, xs> and <yc, ya, ys> corresponding to `x` and `y` as follows:
			-- • xc, yc - marks free types, using only class conformance rules
			-- • xa, ya - attachment status
			-- • xs, ys - separateness status
			-- The resulting type is <zc, za, zs> where
			-- • zc = xc if xc -> yc, zc = yc if yc -> xc, zc = Void otherwise
			-- • za = attached, if xa or ya are attached, detachable otherwise
			-- • zs = separate, if xs and ys is separate, non-separate otherwise
		local
			rx, ry: TYPE_A
		do
			rx := x
			ry := y
			if  x.is_attached then
					-- `x` is more attached, use its attachment status.
				ry := y.as_attached_type
			elseif y.is_attached then
					-- `y` is more attached, use its attachment status.
				rx := x.as_attached_type
			elseif x.is_implicitly_attached then
					-- `x` is more attached, use its attachment status.
				ry := y.as_implicitly_attached
			elseif y.is_implicitly_attached then
					-- `y` is more attached, use its attachment status.
				rx := x.as_implicitly_attached
			end
				-- Source types should conform to the computed ones.
			check
				rx_conforms_to_x: rx.conform_to (current_class, x)
				ry_conforms_to_y: ry.conform_to (current_class, y)
			end
			if not rx.is_separate then
					-- Use `x` separateness status.
				ry := ry.to_other_separateness (rx)
			else
					-- Use `y` separateness status.
				rx := rx.to_other_separateness (ry)
			end
				-- Source types should conform to the computed ones.
			check
				rx_conforms_to_x: rx.conform_to (current_class, x)
				ry_conforms_to_y: ry.conform_to (current_class, y)
			end
				-- Use the type which conform to both `x` and `y`.
			if rx.conform_to (current_class, y) then
				Result := rx
			elseif ry.conform_to (current_class, x) then
				Result := ry
			end
		ensure
			class
			Result_conforms_to_x: attached Result implies Result.conform_to (current_class, x)
			Result_conforms_to_y: attached Result implies Result.conform_to (current_class, y)
		end

feature {NONE} -- Helper

	upper_agent: FUNCTION [TUPLE [s: TYPE_A; t: TYPE_A; c: CLASS_C], detachable TYPE_A]
		once
			Result := agent lower_type
		end

	lower_agent: FUNCTION [TUPLE [s: TYPE_A; t: TYPE_A; c: CLASS_C], detachable TYPE_A]
		once
			Result := agent upper_type
		end

	feature_finder: TYPE_A_FEATURE_FINDER
			-- Facility to lookup for a feature in a given type.
		once
			create Result
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

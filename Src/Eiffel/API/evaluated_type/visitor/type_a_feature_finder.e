note
	description: "Feature lookup facility for {TYPE_A}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_A_FEATURE_FINDER

inherit
	TYPE_A_VISITOR
		redefine
			default_create,
			is_type_valid,
			is_valid,
			process_multi_formal_a
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
			{ANY} names_heap
		redefine
			default_create
		end

	SHARED_AST_CONTEXT
		export {NONE} all
		redefine
			default_create
		end

	SHARED_WORKBENCH
		export {NONE} all
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Creation

	default_create
		do
			create found_features.make (0)
		end

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
			-- `True' iff context class is set in {AST_CONTEXT}.
		do
			Result := attached context_class
		end

	is_type_valid (t: TYPE_A): BOOLEAN
			-- <Precursor>
			-- `True' iff `t' is valid for the context class.
		do
			Result := is_type_valid_for_class (t, context_class)
		end

	is_type_valid_for_class (t: TYPE_A; c: CLASS_C): BOOLEAN
			-- Is type `t' valid for context class `c'?
		require
			t_attached: attached t
			c_attached: attached c
		do
			if
				not t.is_like_argument and then
				not t.is_void and then
				not attached {UNEVALUATED_LIKE_TYPE} t and then
				not attached {UNEVALUATED_QUALIFIED_ANCHORED_TYPE} t and then
				(attached {UNKNOWN_TYPE_A} t implies attached {LOCAL_TYPE_A} t)
			then
				Result := t.is_valid_for_class (c)
			end
		end

feature -- Access

	found_feature: detachable FEATURE_I
			-- A feature found by `find' or `find_bye_routine_id' (if any) which is called on the class type identified by `found_site'.
		do
			if not found_features.is_empty then
				Result := found_features [1].descriptor
			end
		end

	found_site: detachable CL_TYPE_A
			-- A class type on which `found_feature' is called.
		do
			if not found_features.is_empty then
				Result := found_features [1].site
			end
		end

	found_features: ARRAYED_LIST [TUPLE [descriptor: FEATURE_I; site: CL_TYPE_A; context: TYPE_A]]
			-- Features ("descriptor") found by `find' or `find_bye_routine_id' (if any) at the associated class types ("site") when looking from.

	has_multiple: BOOLEAN
			-- Were multiple call sites found?
		do
			Result := found_features.count > 1
		end

feature {NONE} -- Context

	context_class: CLASS_C
			-- Class in which search is performed

	feature_in_class: FUNCTION [CLASS_C, detachable FEATURE_I]
			-- Lookup procedure for {CL_TYPE_A}

	find_in_renamed_type_a: PROCEDURE [RENAMED_TYPE_A]
			-- Lookup procedure for {RENAMED_TYPE_A}

	formal_generics: detachable ARRAYED_LIST [FORMAL_A]
			-- List of processed formal generics to avoid infinite recursion
			-- when formal generic constraints are recursive

feature {NONE} -- Search by name

	feature_in_class_by_name (n: like {FEATURE_I}.feature_name_id; c: CLASS_C): detachable FEATURE_I
			-- Feature of name `n' in class `c' if present.
		require
			valid_n: names_heap.has (n)
			c_attached: attached c
		do
			if c.has_feature_table then
				Result := c.feature_of_name_id (n)
			end
		end

	find_in_renamed_type_a_by_name (n: like {FEATURE_I}.feature_name_id; t: RENAMED_TYPE_A)
		require
			valid_n: names_heap.has (n)
			t_attached: attached t
		local
			name_id: like {FEATURE_I}.feature_name_id
			saved_feature_in_class: like feature_in_class
			saved_find_in_renamed_type_a: like find_in_renamed_type_a
		do
				-- Save search routines that use an old name before using the new one.
			saved_feature_in_class := feature_in_class
			saved_find_in_renamed_type_a := find_in_renamed_type_a
			name_id := n
			if attached t.renaming as renaming then
					-- Get an old name if a feature (if possible).
				name_id := renaming.renamed (n)
			end
				-- Skip processing if there is no feature corresponding to `n'.
			if name_id > 0 then
				if name_id /= n then
						-- Take renaming in formal generic constraints into account.
					feature_in_class := agent feature_in_class_by_name (name_id, ?)
					find_in_renamed_type_a := agent find_in_renamed_type_a_by_name (name_id, ?)
				end
					-- Search using the old name.
				t.type.process (Current)
			end
				-- Restore search routines that use an old name.
			find_in_renamed_type_a := saved_find_in_renamed_type_a
			feature_in_class := saved_feature_in_class
		end

feature -- Search

	find (n: like {FEATURE_I}.feature_name_id; t: TYPE_A; c: CLASS_C)
			-- Find feature of name ID `n' called on type `t' and make it available in `found_feature'
			-- assuming that the code is written in `c'.
		require
			valid_n: names_heap.has (n)
			attached_t: attached t
			attached_c: attached c
			valid_t: is_type_valid_for_class (t, c)
		do
			found_features.wipe_out
			context_class := c
			formal_generics := Void
			feature_in_class := agent feature_in_class_by_name (n, ?)
			find_in_renamed_type_a := agent find_in_renamed_type_a_by_name (n, ?)
			t.process (Current)
		ensure
			same_name:
				attached found_feature as f implies
				(f.feature_name_id = n or else True) -- Feature can be renamed in formal constraints
			valid_site:
				attached found_feature as f implies attached found_site
			feature_from_class:
				attached found_feature as f implies
				attached found_site as s and then
				(s.base_class.feature_of_name_id (n) ~ f or else True) -- Feature can be renamed in formal constraints
		end

	find_by_alias (n: INTEGER; t: TYPE_A; c: CLASS_C)
			-- Find feature of alias name ID `n' called on type `t' and make it available in `found_feature'
			-- assuming that the code is written in `c'.
		require
			{OPERATOR_KIND}.is_alias_id (n)
			{OPERATOR_KIND}.is_fixed_alias_id (n)
			attached_t: attached t
			attached_c: attached c
			valid_t: is_type_valid_for_class (t, c)
		do
			found_features.wipe_out
			context_class := c
			formal_generics := Void
			feature_in_class := agent (name: INTEGER; lookup: CLASS_C): detachable FEATURE_I
				do
					if lookup.has_feature_table then
						Result := lookup.feature_table.item_alias_id (name)
					end
				end (n, ?)
					-- TODO: add a feature to find by alias ID.
			find_in_renamed_type_a := agent find_in_renamed_type_a_by_name (n, ?)
			t.process (Current)
		ensure
			same_name:
				attached found_feature as f implies
				(f.has_alias_name_id (n) or else True) -- Feature can be renamed in formal constraints
			valid_site:
				attached found_feature as f implies attached found_site
			feature_from_class:
				attached found_feature as f implies
				attached found_site as s and then
				(s.base_class.feature_of_alias_id (n) ~ f or else True) -- Feature can be renamed in formal constraints
		end

	find_by_routine_id (r: INTEGER; t: TYPE_A; c: CLASS_C)
			-- Find feature of routine ID `r' called on type `t' and make it available in `found_feature'
			-- assuming that the code is written in `c'.
		require
			valid_r: r > 0 -- and then system.routine_id_counter.is_feature_routine_id (r)
			attached_t: attached t
			attached_c: attached c
			valid_t: is_type_valid_for_class (t, c)
		do
			found_features.wipe_out
			context_class := c
			formal_generics := Void
			feature_in_class := agent (f: INTEGER; s: CLASS_C): detachable FEATURE_I
				require
					valid_f: f > 0 -- and then system.routine_id_counter.is_feature_routine_id (f)
					s_attached: attached s
				do
					if s.has_feature_table then
						Result := s.feature_of_rout_id (f)
					end
				end
				(r, ?)
			find_in_renamed_type_a := agent (renamed_type: RENAMED_TYPE_A)
				require
					renamed_type_attached: attached renamed_type
				do
					renamed_type.type.process (Current)
				end
			t.process (Current)
		ensure
			same_name:
				attached found_feature as f implies
				f.rout_id_set.has (r)
			valid_site:
				attached found_feature as f implies attached found_site
			feature_from_class:
				attached found_feature as f implies
				attached found_site as s and then
				(s.base_class.feature_of_rout_id (r) ~ f)
		end

feature {TYPE_A} -- Visitor

	process_boolean_a (t: BOOLEAN_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_character_a (t: CHARACTER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_cl_type_a (t: CL_TYPE_A)
			-- <Precursor>
		do
			if
				attached t.base_class as c and then
				attached feature_in_class.item (c) as f and then
				(attached found_feature as h implies
					h.code_id /= f.code_id or else not h.rout_id_set.intersect (f.rout_id_set))
			then
					-- Found next feature.
					-- TODO: provide valid context.
				found_features.extend ([f, t, t])
			end
		end

	process_renamed_type_a (t: RENAMED_TYPE_A)
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_formal_a (t: FORMAL_A)
			-- <Precursor>
		local
			g: like formal_generics
		do
			g := formal_generics
			if not attached g then
				create g.make (1)
				g.compare_objects
				formal_generics := g
			end
			if not g.has (t) then
				g.extend (t)
				across
					context_class.constraints (t.position).constraining_types (context_class) as c
				loop
					find_in_renamed_type_a.call ([c.item])
				end
			end
		ensure then
			t_registered: attached formal_generics as f and then f.has (t)
			formal_generics_persistent: old attached formal_generics implies old formal_generics = formal_generics
		end

	process_gen_type_a (t: GEN_TYPE_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_integer_a (t: INTEGER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_like_argument (t: LIKE_ARGUMENT)
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_like_current (t: LIKE_CURRENT)
			-- <Precursor>
		do
			t.conformance_type.process (Current)
		end

	process_like_feature (t: LIKE_FEATURE)
			-- <Precursor>
		do
			t.conformance_type.process (Current)
		end

	process_local (t: LOCAL_TYPE_A)
			-- <Precursor>
		do
			t.process_lower (Current)
		end

	process_manifest_integer_a (t: MANIFEST_INTEGER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_manifest_natural_64_a (t: MANIFEST_NATURAL_64_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_manifest_real_a (t: MANIFEST_REAL_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_multi_formal_a (t: MULTI_FORMAL_A)
			-- <Precursor>
		do
			process_formal_a (t)
		end

	process_named_tuple_type_a (t: NAMED_TUPLE_TYPE_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_native_array_type_a (t: NATIVE_ARRAY_TYPE_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_natural_a (t: NATURAL_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_none_a (t: NONE_A)
			-- <Precursor>
		do
		end

	process_pointer_a (t: POINTER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_qualified_anchored_type_a (t: QUALIFIED_ANCHORED_TYPE_A)
			-- <Precursor>
		do
			t.conformance_type.process (Current)
		end

	process_real_a (t: REAL_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_tuple_type_a (t: TUPLE_TYPE_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_typed_pointer_a (t: TYPED_POINTER_A)
			-- <Precursor>
		do
			process_cl_type_a (t)
		end

	process_unevaluated_like_type (t: UNEVALUATED_LIKE_TYPE)
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_unevaluated_qualified_anchored_type (t: UNEVALUATED_QUALIFIED_ANCHORED_TYPE)
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_unknown (t: UNKNOWN_TYPE_A)
			-- <Precursor>
		do
			check valid_t: False end
		end

	process_void_a (t: VOID_A)
			-- <Precursor>
		do
			check valid_t: False end
		end

note
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

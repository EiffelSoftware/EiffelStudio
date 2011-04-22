note
	description: "Class for an staticed type on a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	QUALIFIED_ANCHORED_TYPE_A

inherit
	LIKE_TYPE_A
		redefine
			description, description_with_detachable_type,
			dispatch_anchors,
			error_generics,
			evaluated_type_in_descendant,
			good_generics, internal_is_valid_for_class,
			has_formal_generic,
			has_like,
			initialize_info,
			formal_instantiated_in,
			instantiated_in,
			instantiation_in,
			is_explicit,
			is_loose,
			is_syntactically_equal,
			skeleton_adapted_in,
			update_dependance
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization and reinitialization

	make (q: like qualifier; c: like chain; w: like class_id)
			-- Cr
		require
			q_attached: attached q
			c_attached: attached c
			c_not_empty: c.count > 0
			valid_w: system.classes.has (w)
		do
			qualifier := q
			chain := c
			class_id := w
		ensure
			qualifier_set: qualifier = q
			chain_set: chain = c
			class_id_set: class_id = w
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_qualified_anchored_type_a (Current)
		end

feature -- Properties

	qualifier: TYPE_A
			-- First part of the type, before the feature `chain'


	chain: SPECIAL [INTEGER_32]
			-- Feature name IDs of the second part of the type, after the `qualifier'

	class_id: INTEGER
			-- ID if a class where this type is written

feature {TYPE_A_CHECKER} -- Properties

	routine_id: SPECIAL [INTEGER_32]
			-- Routine IDs of the second part of the type, after the `qualifier'

feature -- Status Report

	is_loose: BOOLEAN
			-- <Precursor>
		do
				-- If qualifier type depends on the actual type of the object,
				-- qualified anchored type depends on the dynamic type,
				-- otherwise it is stand-alone.
			Result := qualifier.is_loose
		end

	is_explicit: BOOLEAN
			-- Is type fixed at compile time without anchors or formals?
		do
			if system.in_final_mode then
				initialize_info (shared_create_info)
				Result := shared_create_info.is_explicit
			else
				Result := False
			end
		end

	has_formal_generic: BOOLEAN
			-- <Precursor>
		do
			Result := qualifier.has_formal_generic
		end

	has_like: BOOLEAN
			-- <Precursor>
		do
			Result := qualifier.has_like
		end

feature -- Comparison

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		do
			if
				attached {QUALIFIED_ANCHORED_TYPE_A} other as o and then
				qualifier.same_as (o.qualifier) and then
				chain ~ o.chain and then
				has_same_marks (o)
			then
					-- Compare computed actual types as otherwise they may be left
					-- from the previous compilation in an invalid state.
				if attached actual_type as a then
					Result :=
						is_valid and then
						o.is_valid and then
						attached o.actual_type as oa and then
						a.same_as (oa)
				else
					Result := not attached o.actual_type
				end
			end
		end

feature -- Code generation

	description: ATTR_DESC
			-- Descritpion of type for skeletons.
		local
			gen_desc: GENERIC_DESC
		do
			if qualifier.is_loose then
				create gen_desc
				gen_desc.set_type_i (Current)
				Result := gen_desc
			else
				Result := Precursor
			end
		end

	description_with_detachable_type: ATTR_DESC
			-- Descritpion of type for skeletons.
		local
			gen_desc: GENERIC_DESC
		do
			if qualifier.is_loose then
				create gen_desc
				gen_desc.set_type_i (as_detachable_type)
				Result := gen_desc
			else
				Result := Precursor
			end
		end

	skeleton_adapted_in (class_type: CLASS_TYPE): QUALIFIED_ANCHORED_TYPE_A
			-- <Precursor>
		local
			q: TYPE_A
		do
			Result := Current
			q := qualifier.skeleton_adapted_in (class_type)
			if q /= qualifier then
				Result := duplicate
				Result.set_qualifier (q)
			end
		end

feature -- Type checking

	good_generics: BOOLEAN
			-- <Precursor>
		do
			Result := qualifier.good_generics and then Precursor
		end

	error_generics: VTUG
			-- <Precursor>
		do
			if qualifier.good_generics then
				Result := Precursor
			else
				Result := qualifier.error_generics
			end
		end

	update_dependance (feat_depend: FEATURE_DEPENDANCE)
			-- Update dependency for Dead Code Removal
		local
			c: CLASS_C
			f: FEATURE_I
			i: INTEGER
		do
			qualifier.update_dependance (feat_depend)
			from
				c := qualifier.associated_class
			until
				i >= chain.count
			loop
				if attached c then
					f := c.feature_table.item_id (chain [i])
					if attached f then
						feat_depend.extend_depend_unit_with_level (c.class_id, f, 0)
						c := f.type.associated_class
					end
				end
				i := i + 1
			end
		end

feature {TYPE_A} -- Helpers

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- Is current type valid?
		do
			Result := attached qualifier as l_qualifier and then l_qualifier.internal_is_valid_for_class (a_class) and then Precursor (a_class)
		end

feature -- Modification

	set_qualifier (q: like qualifier)
			-- Set `qualifier' to `q'.
		require
			q_attached: attached q
		do
			qualifier := q
		ensure
			qualifier_set: qualifier = q
		end

feature {TYPE_A_CHECKER} -- Modification

	set_chain (n: like chain; c: CLASS_C)
			-- Set `chain' to the value relative to class `c'.
		require
			n_attached: attached n
			n_same_count: n.count = chain.count
			c_attached: attached c
		do
			chain := n
			class_id := c.class_id
		ensure
			chain_set: chain = n
			class_id_set: class_id = c.class_id
		end

	set_routine_id (r: like routine_id)
			-- Set `routine_id' to `r'.
		require
			r_attached: attached r
			r_same_count: r.count = chain.count
		do
			routine_id := r
		ensure
			routine_id_set: routine_id = r
		end

feature -- Generic conformance

	initialize_info (an_info: like shared_create_info)
		do
			an_info.make (Current, system.class_of_id (class_id))
		end

	create_info: CREATE_QUALIFIED
		do
			initialize_info (shared_create_info)
			Result := shared_create_info.twin
		end

	shared_create_info: CREATE_QUALIFIED
		once
			create Result
		end

feature -- IL code generation

	dispatch_anchors (a_context_class: CLASS_C)
			-- <Precursor>
		local
			c: CLASS_C
			f: FEATURE_I
			i: INTEGER
		do
			qualifier.dispatch_anchors (a_context_class)
			from
				c := qualifier.associated_class
			until
				i >= chain.count
			loop
				if attached c then
					f := c.feature_table.item_id (chain [i])
					if attached f then
						c.extend_type_set (f.rout_id_set.first)
						c := f.type.associated_class
					end
				end
				i := i + 1
			end
		end

feature -- Output

	dump: STRING
			-- Dumped trace
		local
			s: STRING
			i, nb: INTEGER
		do
			s := actual_type.dump
			create Result.make (20 + s.count)
			Result.append_character ('[')
			dump_marks (Result)
			Result.append ("like {")
			Result.append (qualifier.dump)
			Result.append ("}")
			from
				i := 0
				nb := chain.count
			until
				i = nb
			loop
				Result.append_character ('.')
				Result.append_string (names_heap.item (chain.item (i)))
				i := i + 1
			end
			Result.append ("] ")
			Result.append (s)
		end

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C)
		local
			q: detachable CLASS_C
			i: INTEGER
			n: STRING
			f: detachable E_FEATURE
		do
			st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_l_bracket)
			ext_append_marks (st)
			st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_like_keyword, Void)
			st.add_space
			st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_l_curly)
			qualifier.ext_append_to (st, c)
			st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_r_curly)
			from
				q := qualifier.associated_class
			until
				i >= chain.count
			loop
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_dot)
				if attached q and then q.has_feature_table then
					f := q.feature_with_name_id (chain [i])
				else
					f := Void
				end
				n := names_heap.item (chain [i])
				if attached f then
					st.add_feature (f, n)
				elseif attached q then
					st.add_feature_name (n, q)
				else
					st.process_feature_name_text (n, Void)
				end
				i := i + 1
			end
			st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_r_bracket)
			st.add_space
			if is_valid then
				actual_type.ext_append_to (st, c)
			end
		end

feature -- Primitives

	formal_instantiated_in (class_type: TYPE_A): TYPE_A
			-- <Precursor>
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.formal_instantiated_in (class_type).actual_type)
			t.set_qualifier (qualifier.formal_instantiated_in (class_type))
			Result := t
		end

	instantiated_in (class_type: TYPE_A): TYPE_A
			-- <Precursor>
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.instantiated_in (class_type).actual_type)
			t.set_qualifier (qualifier.instantiated_in (class_type))
			Result := t
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A
			-- <Precursor>
		local
			t: like Current
		do
			t := twin
			t.set_actual_type (actual_type.instantiation_in (type, written_id))
			t.set_qualifier (qualifier.instantiation_in (type, written_id))
			Result := t
		end

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): QUALIFIED_ANCHORED_TYPE_A
			-- <Precursor>
		local
			i: INTEGER
			c: like chain
			q: TYPE_A
			d: TYPE_A
		do
			if a_ancestor /= a_descendant then
					-- Compute new feature names.
				create c.make_filled (0, chain.count)
				from
					q := qualifier
					d := q.evaluated_type_in_descendant (a_ancestor, a_descendant, a_feature)
					create Result.make (d, c, a_descendant.class_id)
				until
					i >= chain.count
				loop
						-- Find a corresponding feature in the current class and in the descendant.
					feature_finder.find (chain [i], q, a_ancestor)
					check
						is_ancestor_feature_found: attached feature_finder.found_feature as f
						is_descendant_feature_found: attached q.evaluated_type_in_descendant (a_ancestor, a_descendant, a_feature).associated_class.feature_of_rout_id (f.rout_id_set.first) as g
					then
						c [i] := g.feature_name_id
						q := f.type.instantiated_in (q)
						d := g.type.instantiated_in (d)
					end
					i := i + 1
				end
					-- `q' holds the type relative to `a_ancestor'.
					-- `d' holds the type relative to `a_descendant'.
				Result.set_actual_type (d)
				Result.set_marks_from (Current)
			else
				Result := Current
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result :=
				equivalent (qualifier, other.qualifier) and then
				chain ~ other.chain and then
				has_same_marks (other)
		end

	is_syntactically_equal (other: TYPE_A): BOOLEAN
			-- <Precursor>
		do
			if attached {like Current} other then
				Result := same_as (other)
			elseif attached {UNEVALUATED_QUALIFIED_ANCHORED_TYPE} other as o then
				Result :=
					qualifier.is_syntactically_equal (o.qualifier) and then
					chain ~ o.chain and then
					has_same_marks (o)
			end
		end

feature {NONE} -- Lookup

	feature_finder: TYPE_A_FEATURE_FINDER
			-- Lookup facility
		once
			create Result
		ensure
			feature_finder_attached: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

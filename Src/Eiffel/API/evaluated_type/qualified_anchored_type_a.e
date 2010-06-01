note
	description: "Class for an staticed type on a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	QUALIFIED_ANCHORED_TYPE_A

inherit
	LIKE_TYPE_A
		redefine
			dispatch_anchors,
			error_generics,
			evaluated_type_in_descendant,
			good_generics,
			initialize_info,
			is_explicit,
			is_syntactically_equal,
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

feature -- Status Report

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

feature -- Access

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		do
			if attached {QUALIFIED_ANCHORED_TYPE_A} other as o then
				Result :=
					qualifier.same_as (o.qualifier) and then
					chain ~ o.chain and then
					has_same_attachment_marks (o)
			end
		end

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
			if has_attached_mark then
				Result.append_character ('!')
			elseif has_detachable_mark then
				Result.append_character ('?')
			end
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
			if has_attached_mark then
				st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_attached_keyword, Void)
				st.add_space
			elseif has_detachable_mark then
				st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_detachable_keyword, Void)
				st.add_space
			end
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
				else
					st.add_feature_name (n, q)
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

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): QUALIFIED_ANCHORED_TYPE_A
			-- <Precursor>
		local
			i: INTEGER
			c: like chain
			q: TYPE_A
		do
			if a_ancestor /= a_descendant then
					-- Compute new feature names.
				create c.make_filled (0, chain.count)
				from
					q := qualifier
					create Result.make (q.evaluated_type_in_descendant (a_ancestor, a_descendant, a_feature), c, a_descendant.class_id)
				until
					i >= chain.count
				loop
						-- Find a corresponding feature in the current class and in the descendant.
					feature_finder.find (chain [i], q, context.written_class)
					check
						is_ancestor_feature_found: attached feature_finder.found_feature as f
						is_descendant_feature_found: attached q.evaluated_type_in_descendant (a_ancestor, a_descendant, a_feature).associated_class.feature_of_rout_id (f.rout_id_set.first) as g
					then
						c [i] := g.feature_name_id
						q := f.type.instantiated_in (q)
					end
					i := i + 1
				end
					-- `q' holds the type relative to `a_ancestor'.
				Result.set_actual_type (q.evaluated_type_in_descendant (a_ancestor, a_descendant, a_feature))
				if has_attached_mark then
					Result.set_attached_mark
				elseif has_detachable_mark then
					Result.set_detachable_mark
				end
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
				has_same_attachment_marks (other)
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
					has_same_attachment_marks (o)
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

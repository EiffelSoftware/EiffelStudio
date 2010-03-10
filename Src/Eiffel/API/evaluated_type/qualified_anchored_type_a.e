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
			evaluated_type_in_descendant,
			initialize_info,
			is_explicit,
			update_dependance
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature -- Initialization and reinitialization

	make (q: like qualifier; c: like chain)
			-- Creation
		require
			q_attached: attached q
			c_attached: attached c
			c_not_empty: c.count > 0
		do
			qualifier := q
			chain := c
		ensure
			qualifier_set: qualifier = q
			chain_set: chain = c
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

feature -- Generic conformance

	initialize_info (an_info: like shared_create_info)
		do
			-- TODO
		end

	create_info: CREATE_FEAT
		do
			initialize_info (shared_create_info)
			Result := shared_create_info.twin
		end

	shared_create_info: CREATE_FEAT
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
		local
			c: CLASS_C
			f: FEATURE_I
			i: INTEGER
			n: like chain
			q: TYPE_A
		do
			if a_ancestor /= a_descendant then
					-- Compute new feature names.
				create n.make_filled (0, chain.count)
				from
					c := qualifier.associated_class
					q := qualifier.evaluated_type_in_descendant (a_ancestor, a_descendant, a_feature)
				until
					i >= chain.count
				loop
					if attached c then
						f := c.feature_table.item_id (chain [i])
						if attached f then
							n [i] := q.associated_class.feature_of_rout_id (f.rout_id_set.first).feature_name_id
							c := f.type.associated_class
						end
					end
					i := i + 1
				end
				create Result.make (q, n)
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

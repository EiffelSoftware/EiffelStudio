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
			generate_cid,
			generate_cid_array,
			generate_cid_init,
			good_generics,
			has_formal_generic,
			has_like,
			initialize_info,
			internal_is_valid_for_class,
			formal_instantiated_in,
			instantiated_in,
			instantiation_in,
			is_explicit,
			is_loose,
			is_syntactically_equal,
			make_type_byte_code,
			recomputed_in,
			skeleton_adapted_in,
			update_dependance
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_TABLE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization and reinitialization

	make (q: like qualifier; c: like chain; w: like class_id)
			-- Create descriptor with qualifier `q' and feature names `c' written in class `w'.
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
			-- ID of a class where this type is written

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

	generate_cid (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; a_context_type: TYPE_A)
		do
			generate_cid_prefix (buffer, Void)
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_cid (buffer, final_mode)
			elseif attached buffer then
					-- Traverse the feature chain generate qualified anchored types, so that for
					--    {A}.b.c the generated code looks like
					--    QUALIFIED_FEATURE_TYPE 2 A b c
					-- Generate prefix.
				buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.qualified_feature_type)
				buffer.put_character (',')
				buffer.put_integer (chain.count)
				buffer.put_character (',')
					-- Generate qualifier.
				qualifier.generate_cid (buffer, final_mode, use_info, a_context_type)
					-- Generate routine IDs.
				across
					routine_id as r
				loop
					if system.in_final_mode then
							-- Side effect. This is not nice but unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used_for_type (r.item)
					end
					buffer.put_integer_for_type_array (r.item)
					buffer.put_character (',')
				end
			end
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A)
		do
			generate_cid_prefix (buffer, idx_cnt)
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_cid_array (buffer, final_mode, idx_cnt)
			else
					-- Traverse the feature chain generate qualified anchored types, so that for
					--    {A}.b.c the generated code looks like
					--    QUALIFIED_FEATURE_TYPE 2 A b c
					-- Generate prefix.
				buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.qualified_feature_type)
				buffer.put_character (',')
				buffer.put_integer (chain.count)
				buffer.put_character (',')
					-- Generate qualifier.
				qualifier.generate_cid_array (buffer, final_mode, use_info, idx_cnt, a_context_type)
					-- Generate routine IDs.
				across
					routine_id as r
				loop
					if system.in_final_mode then
							-- Side effect. This is not nice but unavoidable.
							-- Mark routine id used
						Eiffel_table.mark_used_for_type (r.item)
					end
					buffer.put_integer_for_type_array (r.item)
					buffer.put_character (',')
					idx_cnt.next.do_nothing
				end
			end
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A; a_level: NATURAL)
		do
			generate_cid_prefix (Void, idx_cnt)
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.generate_cid_init (buffer, final_mode, idx_cnt, a_level)
			else
					-- Traverse the feature chain generate qualified anchored types, so that for
					--    {A}.b.c the generated code looks like
					--    QUALIFIED_FEATURE_TYPE 2 A b c
					-- Generate prefix.
				idx_cnt.set_value (idx_cnt.value + 2)
					-- Generate qualifier.
				qualifier.generate_cid_init (buffer, final_mode, use_info, idx_cnt, a_context_type, a_level)
					-- Generate routine IDs.
				idx_cnt.set_value (idx_cnt.value + chain.count)
			end
		end

	make_type_byte_code (ba: BYTE_ARRAY; use_info: BOOLEAN; a_context_type: TYPE_A)
		do
			make_type_prefix_byte_code (ba)
			if use_info then
				initialize_info (shared_create_info)
				shared_create_info.make_type_byte_code (ba)
			else
					-- Traverse the feature chain generate qualified anchored types, so that for
					--    {A}.b.c the generated code looks like
					--    QUALIFIED_FEATURE_TYPE 2 A b c
					-- Generate prefix.
				ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.qualified_feature_type)
				ba.append_natural_16 (chain.count.to_natural_16)
					-- Generate qualifier.
				qualifier.make_type_byte_code (ba, False, a_context_type)
					-- Generate routine IDs.
				across
					routine_id as r
				loop
						-- Note that we do not encode the INEGER_32 value into NATURAL_16 encoding
						-- that type arrays are usually made of.
					ba.append_integer_for_type_array (r.item)
				end
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
				c := qualifier.base_class
			until
				i >= chain.count
			loop
				if attached c then
					f := c.feature_table.item_id (chain [i])
					if attached f then
						feat_depend.extend_depend_unit_with_level (c.class_id, f, 0)
						c := f.type.base_class
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

feature {TYPE_A_CHECKER, QUALIFIED_ANCHORED_TYPE_A} -- Modification

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

feature {TYPE_A_CHECKER, QUALIFIED_ANCHORED_TYPE_A} -- Modification

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

	shared_create_info, create_info: CREATE_QUALIFIED
			-- <Precursor>
		do
				--| Unlike its precursor, we cannot use a shared structure because unlike traditional
				--| anchors, qualified anchors can be nested, therefore we cannot reuse the same object
				--| as its value would be overridden while processing the nested definitions.
				--| See eweasel test#anchor042 and test#anchor051 for test cases.
			create Result.make (Current, system.class_of_id (class_id))
		end

feature -- IL code generation

	dispatch_anchors (a_context_class: CLASS_C)
			-- <Precursor>
		local
			c: detachable CLASS_C
			i: INTEGER
			l_rid: INTEGER
		do
			qualifier.dispatch_anchors (a_context_class)
			from
			until
				i >= routine_id.count
			loop
				l_rid := routine_id [i]
				c := system.class_of_id (system.rout_info_table.item (l_rid).origin)
				if c /= Void then
					c.extend_type_set (l_rid)
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

	ext_append_to (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C)
			-- <Precursor>
		local
			q: detachable CLASS_C
			i: INTEGER
			n: STRING
			f: detachable E_FEATURE
		do
			a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_l_bracket)
			ext_append_marks (a_text_formatter)
			a_text_formatter.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_like_keyword, Void)
			a_text_formatter.add_space
			a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_l_curly)
			qualifier.ext_append_to (a_text_formatter, a_context_class)
			a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_r_curly)
			from
				q := qualifier.base_class
			until
				i >= chain.count
			loop
				a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_dot)
				if attached q and then q.has_feature_table then
					f := q.feature_with_name_id (chain [i])
				else
					f := Void
				end
				n := names_heap.item (chain [i])
				if attached f then
					a_text_formatter.add_feature (f, n)
				elseif attached q then
					a_text_formatter.add_feature_name (n, q)
				else
					a_text_formatter.process_feature_name_text (n, Void)
				end
				i := i + 1
			end
			a_text_formatter.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_r_bracket)
			a_text_formatter.add_space
			if is_valid then
				actual_type.ext_append_to (a_text_formatter, a_context_class)
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

	recomputed_in (target_type: TYPE_A; context_id: INTEGER; constraint: TYPE_A; written_id: INTEGER): TYPE_A
			-- <Precursor>
		do
			Result := recompute (qualifier.recomputed_in (target_type, context_id, constraint, written_id), context_id)
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
		do
			if a_ancestor /= a_descendant then
				Result := recompute (qualifier.evaluated_type_in_descendant (a_ancestor, a_descendant, a_feature), a_descendant.class_id)
			else
				Result := Current
			end
		end

feature {NONE} -- Recomputation in a different context

	recompute (new_qualifier: TYPE_A; new_class_id: like class_id): QUALIFIED_ANCHORED_TYPE_A
			-- Recompute the complete type starting from a new qualifier `new_qualifier' in a new class with `new_class_id'.
		local
			c: like chain
			q: TYPE_A
			i, n: like chain.count
			w: CLASS_C
		do
			if new_qualifier.same_as (qualifier) and then new_class_id = class_id then
					-- Same context.
				Result := Current
			else
					-- Compute new feature names.
				from
					c := chain
					q := new_qualifier
						-- Make a copy of the original qualified anchored type with the new qualifier and class ID.
					create Result.make (q, c, new_class_id)
					Result.set_routine_id (routine_id)
						-- Then traverse the feature chain and update it in the `Result' if required.
					w := system.class_of_id (new_class_id)
					n := c.count
				until
					i >= n
				loop
						-- Find a corresponding feature in the written type.
					feature_finder.find_by_routine_id (routine_id [i], q, w)
					if
						attached feature_finder.found_feature as f and then
						attached feature_finder.found_site as l_site and then
						attached l_site.base_class as l_site_class
					then
						if f.feature_name_id /= c [i] then
								-- New feature name is used.
							if c = chain then
									-- Duplicate chain.
								c := chain.twin
								Result.set_chain (c, w)
							end
							c [i] := f.feature_name_id
						end
						f.nested_check_types (l_site.base_class)
						q := f.type.recomputed_in (q, new_class_id, l_site, l_site_class.class_id)
					else
							-- An internal compiler error occurred here.
						check feature_found: False end
					end
					i := i + 1
				end
					-- It's possible that `q' is an anchored type.
					-- Its actual type should be used to set the actual type of the result.
				Result.set_actual_type (q.actual_type)
				Result.set_marks_from (Current)
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

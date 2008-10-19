indexing
	description: "Class for an staticed type on a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	LIKE_FEATURE

inherit
	LIKE_TYPE_A
		redefine
			update_dependance, evaluated_type_in_descendant, is_explicit,
			initialize_info, dispatch_anchors
		end

	SHARED_TABLE
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature -- Initialization and reinitialization

	make (f: FEATURE_I; a_context_class_id: INTEGER) is
			-- Creation
		require
			valid_argument: f /= Void
			a_context_class_id_positive: a_context_class_id > 0
		do
			feature_id := f.feature_id
			routine_id := f.rout_id_set.first
			feature_name_id := f.feature_name_id
			class_id := a_context_class_id
		ensure
			feature_id_set: feature_id = f.feature_id
			routine_id_set: routine_id = f.rout_id_set.first
			feature_name_id_set: feature_name_id = f.feature_name_id
			class_id_set: class_id = a_context_class_id
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_like_feature (Current)
		end

feature -- Properties

	feature_name_id: INTEGER
			-- Feature name ID of anchor

	class_id: INTEGER;
			-- Class ID of the class where the anchor is referenced

	feature_name: STRING is
			-- Final name of anchor.
		require
			feature_name_id_set: feature_name_id >= 1
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature -- Status Report

	is_explicit: BOOLEAN is
			-- Is type fixed at compile time without anchors or formals?
		do
			if system.in_final_mode then
				initialize_info (shared_create_info)
				Result := shared_create_info.is_explicit
			else
				Result := False
			end
		end

feature {COMPILER_EXPORTER} -- Implementation: Access

	feature_id: INTEGER
			-- Feature ID of the anchor

	routine_id: INTEGER
			-- Routine ID of anchor in context of `class_id'.

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_like_feat: LIKE_FEATURE
		do
			other_like_feat ?= other
			if other_like_feat /= Void then
				Result :=
					other_like_feat.routine_id = routine_id and then
					other_like_feat.feature_id = feature_id and then
					has_same_attachment_marks (other_like_feat)
			end
		end

	update_dependance (feat_depend: FEATURE_DEPENDANCE) is
			-- Update dependency for Dead Code Removal
		local
			a_class: CLASS_C
			depend_unit: DEPEND_UNIT
			feature_i: FEATURE_I
		do
				-- we must had a dependance to the anchor feature
			a_class := System.class_of_id (class_id)
			feature_i := a_class.feature_table.item_id (feature_name_id)
			create depend_unit.make (class_id, feature_i)
			feat_depend.extend (depend_unit)
		end

feature -- Generic conformance

	initialize_info (an_info: like shared_create_info) is
		do
				-- FIXME: Should we use `make' or just `set_info'?
			an_info.make (feature_id, routine_id)
		end

	create_info: CREATE_FEAT is
		do
			create Result.make (feature_id, routine_id)
		end

	shared_create_info: CREATE_FEAT is
		once
			create Result
		end

feature -- IL code generation

	dispatch_anchors (a_context_class: CLASS_C) is
			-- <Precursor>
		do
			a_context_class.extend_type_set (routine_id)
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			s: STRING
		do
			s := actual_type.dump
			create Result.make (20 + s.count)
			Result.append_character ('[')
			if has_attached_mark then
				Result.append_character ('!')
			elseif has_detachable_mark then
				Result.append_character ('?')
			end
			Result.append ("like " + feature_name +"] ")
			Result.append (s)
		end

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C) is
		local
			ec: CLASS_C
			l_feat: E_FEATURE
		do
			ec := Eiffel_system.class_of_id (class_id)
			st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_l_bracket)
			if has_attached_mark then
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_exclamation)
			elseif has_detachable_mark then
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_question)
			end
			st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_like_keyword, Void)
			st.add_space
			if ec.has_feature_table then
				l_feat := ec.feature_with_name (feature_name)
			end
			if l_feat /= Void then
				st.add_feature (l_feat, feature_name)
			else
				st.add_feature_name (feature_name, ec)
			end
			st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_r_bracket)
			st.add_space
			if is_valid then
				actual_type.ext_append_to (st, c)
			end
		end

feature -- Primitives

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): LIKE_FEATURE is
		local
			l_anchor: FEATURE_I
		do
			if a_ancestor /= a_descendant then
				l_anchor := a_descendant.feature_of_rout_id (routine_id)
				check l_anchor_not_void: l_anchor /= Void end
				create Result.make (l_anchor, a_descendant.class_id)
				Result.set_actual_type (l_anchor.type.actual_type)
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

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := routine_id = other.routine_id and then
				class_id = other.class_id and then
				feature_id = other.feature_id and then
				equivalent (actual_type, other.actual_type) and then
				feature_name_id = other.feature_name_id and then
				other.has_attached_mark = has_attached_mark and then
				other.has_detachable_mark = has_detachable_mark
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

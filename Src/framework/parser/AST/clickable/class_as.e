indexing
	description: "Abstract description of an Eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_AS

inherit
	AST_EIFFEL

	CLICKABLE_AST
		redefine
			is_class, class_name
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like class_name;
			ext_name: STRING_AS;
			is_d, is_e, is_s, is_fc, is_ex, is_par: BOOLEAN;
			top_ind: like top_indexes;
			bottom_ind: like bottom_indexes;
			g: like generics;
			cp: like parents;
			ncp: like parents;
			c: like creators;
			co: like convertors;
			f: like features;
			inv: like invariant_part;
			s: like suppliers;
			o: like obsolete_message;
			ed: like end_keyword)
		is
			-- Create a new CLASS AST node.
		require
			n_not_void: n /= Void
			s_not_void: s /= Void
			co_valid: co /= Void implies not co.is_empty
			ed_not_void: ed /= Void
		do
			class_name := n
			external_class_name := ext_name
			is_deferred := is_d
			is_expanded := is_e
			is_separate := is_s
			is_frozen := is_fc
			is_external := is_ex
			is_partial := is_par
			internal_top_indexes := top_ind
			internal_bottom_indexes := bottom_ind
			internal_generics := g
			internal_conforming_parents := cp
			internal_non_conforming_parents := ncp
			creators := c
			convertors := co
			features := f
			invariant_part := inv
			internal_invariant := inv
			if
				invariant_part /= Void and then
				invariant_part.assertion_list = Void
			then
					-- The keyword `invariant' followed by no assertion
					-- at all is not significant.
				invariant_part := Void
				has_empty_invariant := True
			end
			suppliers := s
			obsolete_message := o

			end_keyword := ed
			date := -1
		ensure
			class_name_set: class_name = n
			external_class_name_set: external_class_name = ext_name
			is_deferred_set: is_deferred = is_d
			is_expanded_set: is_expanded = is_e
			is_separate_set: is_separate = is_s
			is_frozen_set: is_frozen = is_fc
			is_external_set: is_external = is_ex
			is_partial_set: is_partial = is_par
			internal_top_indexes_set: internal_top_indexes = top_ind
			internal_bottom_indexes_set: internal_bottom_indexes = bottom_ind
			internal_generics_set: internal_generics = g
			internal_parents_set: internal_conforming_parents = cp
			creators_set: creators = c
			convertors_set: convertors = co
			features_set: features = f
			empty_invariant_part: invariant_part = Void implies inv = Void or else inv.assertion_list = Void
			invariant_part_set: invariant_part /= Void implies invariant_part = inv
			suppliers_set: suppliers = s
			obsolete_message_set: obsolete_message = o
			end_keyword_not_void: end_keyword = ed
			internal_invariant_set: internal_invariant = inv
			date_set: date = -1
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_class_as (Current)
		end

feature -- Roundtrip

	alias_keyword_index: INTEGER
			-- Index of keyword "alias" associated with this class

	class_keyword_index: INTEGER
			-- Index of keyword "class" associated with this class

	obsolete_keyword_index: INTEGER
			-- Index of keyword "obsolete" associated with this class	

	frozen_keyword_index,
	expanded_keyword_index,
	deferred_keyword_index,
	separate_keyword_index,
	external_keyword_index: INTEGER
			-- Index of keywords that may appear in header mark

	alias_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- keyword "alias" associated with this class
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := alias_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	class_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- keyword "class" associated with this class
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := class_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	obsolete_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- keyword "obsolete" associated with this class	
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := obsolete_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	frozen_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keywords that may appear in header mark
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := frozen_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	expanded_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keywords that may appear in header mark
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := expanded_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	deferred_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keywords that may appear in header mark
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := deferred_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	separate_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keywords that may appear in header mark
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := separate_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	external_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keywords that may appear in header mark
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := external_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	set_header_mark (a_frozen_keyword, a_expanded_keyword, a_deferred_keyword, a_separate_keyword, a_external_keyword: KEYWORD_AS) is
			-- Set header marks of a class.
		do
			if a_frozen_keyword /= Void then
				frozen_keyword_index := a_frozen_keyword.index
			end
			if a_expanded_keyword /= Void then
				expanded_keyword_index := a_expanded_keyword.index
			end
			if a_deferred_keyword /= Void then
				deferred_keyword_index := a_deferred_keyword.index
			end
			if a_separate_keyword /= Void then
				separate_keyword_index := a_separate_keyword.index
			end
			if a_external_keyword /= Void then
				external_keyword_index := a_external_keyword.index
			end
		ensure
			frozen_keyword_set: a_frozen_keyword /= Void implies frozen_keyword_index = a_frozen_keyword.index
			expanded_keyword_set: a_expanded_keyword /= Void implies expanded_keyword_index = a_expanded_keyword.index
			deferred_keyword_set: a_deferred_keyword /= Void implies deferred_keyword_index = a_deferred_keyword.index
			separate_keyword_set: a_separate_keyword /= Void implies separate_keyword_index = a_separate_keyword.index
			external_keyword_set: a_external_keyword /= Void implies external_keyword_index = a_external_keyword.index
		end

	set_class_keyword (k_as: KEYWORD_AS) is
			-- Set `class_keyword' with `k_as'.
		do
			if k_as /= Void then
				class_keyword_index := k_as.index
			end
		ensure
			class_keyword_set: k_as /= Void implies class_keyword_index = k_as.index
		end

	set_alias_keyword (k_as: KEYWORD_AS) is
			-- Set `alias_keyword' with `k_as'.
		do
			if k_as /= Void then
				alias_keyword_index := k_as.index
			end
		ensure
			alias_keyword_set: k_as /= Void implies alias_keyword_index = k_as.index
		end

	set_obsolete_keyword (k_as: KEYWORD_AS) is
			-- Set `obsolete_keyword' with `k_as'.
		do
			if k_as /= Void then
				obsolete_keyword_index := k_as.index
			end
		ensure
			obsolete_keyword_set: k_as /= Void implies obsolete_keyword_index = k_as.index
		end

	first_header_mark (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- First header mark keyword,
			-- Void if no one appears.
		require
			a_list_not_void: a_list /= Void
		do
			if frozen_keyword_index /= 0 then
				Result := frozen_keyword (a_list)
			elseif deferred_keyword_index /= 0 then
				Result := deferred_keyword (a_list)
			elseif expanded_keyword_index /= 0 then
				Result := expanded_keyword (a_list)
			elseif separate_keyword_index /= 0 then
				Result := separate_keyword (a_list)
			elseif external_keyword_index /= 0 then
				Result := external_keyword (a_list)
			end
		end

feature -- Roundtrip

	internal_bottom_indexes: INDEXING_CLAUSE_AS
			-- Internal indexing clause at bottom of class.

	internal_top_indexes: INDEXING_CLAUSE_AS
			-- Internal indexing clause at top of class.

	internal_conforming_parents: PARENT_LIST_AS
			-- Internal conforming inheritance clause

	internal_non_conforming_parents: PARENT_LIST_AS
			-- Internal non-conforming inheritance clause

	internal_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			-- Internal formal generic parameter list

	internal_invariant: like invariant_part
			-- Invariant clause used by roundtrip, in which assertion without expression(such as "tag:") is stored.

feature -- Attributes

	class_name: ID_AS
			-- Class name

	external_class_name: STRING_AS
			-- External_name of class if `is_external'.

	obsolete_message: STRING_AS
			-- Obsolete message clause
			-- (Void if was not present)

	top_indexes: INDEXING_CLAUSE_AS is
			-- Indexing clause at top of class.
		do
			if internal_top_indexes = Void or else internal_top_indexes.is_empty then
				Result := Void
			else
				Result := internal_top_indexes
			end
		end

	bottom_indexes: INDEXING_CLAUSE_AS is
			-- Indexing clause at bottom of class.
		do
			if internal_bottom_indexes = Void or else internal_bottom_indexes.is_empty then
				Result := Void
			else
				Result := internal_bottom_indexes
			end
		end

	parents: PARENT_LIST_AS
			-- Parents from both conforming and non-conforming inheritance clauses.
		local
			l_conforming_parents, l_non_conforming_parents: like non_conforming_parents
		do
			l_conforming_parents := conforming_parents
			if l_conforming_parents /= Void then
				l_non_conforming_parents := non_conforming_parents
				if l_non_conforming_parents /= Void then
					create Result.make (l_conforming_parents.count + l_non_conforming_parents.count)
					Result.append (l_conforming_parents)
						-- We need to twin the result if appending to avoid side effect.
					Result.append (l_non_conforming_parents)
				else
					Result := l_conforming_parents
				end
			else
				Result := non_conforming_parents
			end
		end

	conforming_parents: PARENT_LIST_AS is
			-- Parents from conforming inheritance clause.
		do
			Result := internal_conforming_parents
				-- Return Void if list is empty
			if Result /= Void and then Result.is_empty then
				Result := Void
			end
		end

	non_conforming_parents: PARENT_LIST_AS is
			-- Parents from non-conforming inheritance clause.
		do
			Result := internal_non_conforming_parents
				-- Return Void if list is empty
			if Result /= Void and then Result.is_empty then
				Result := Void
			end
		end

	generics: EIFFEL_LIST [FORMAL_DEC_AS] is
			-- Formal generic parameter list
		do
			if internal_generics = Void or else internal_generics.is_empty then
				Result := Void
			else
				Result := internal_generics
			end
		end

	creators: EIFFEL_LIST [CREATE_AS]
			-- Creators

	convertors: CONVERT_FEAT_LIST_AS
			-- Convertors

	features: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			-- Feature list

	invariant_part: INVARIANT_AS
			-- Class invariant

	suppliers: SUPPLIERS_AS
			-- Supplier types

	is_deferred: BOOLEAN
			-- Is the class deferred ?

	is_expanded: BOOLEAN
			-- Is the class expanded ?

	is_separate: BOOLEAN
			-- Is the class separate ?

	is_frozen: BOOLEAN
			-- Is class frozen, ie we cannot inherit from it.

	is_external: BOOLEAN
			-- Is class just an encapsulation of an already generated class.

	is_partial: BOOLEAN
			-- Is class a partial? (that is the type definition is divided between multiple files)

	click_list: CLICK_LIST is
		local
			l_clicklist_visitor: AST_CLICKABLE_VISITOR
		do
			Result := internal_click_list
			if Result = Void then
				create l_clicklist_visitor
				Result := l_clicklist_visitor.click_list (Current)
				internal_click_list := Result
			end
		end

	internal_click_list: CLICK_LIST
			-- Clickable AST items for current class.

	end_keyword: KEYWORD_AS
			-- Position of last end keyword

	feature_clause_insert_position: INTEGER
			-- Position at end of features

	inherit_clause_insert_position: INTEGER
			-- Position at end of inherit clause.

	generics_start_position: INTEGER
			-- Position at start of formal generics.

	generics_end_position: INTEGER
			-- Position at end of formal generics.

	invariant_insertion_position: INTEGER is
			-- Position where new invariant can be inserted (at the end of an invariant
			-- clause if any, otherwise before the indexing or end keyword).
		do
			if invariant_part /= Void then
				Result := invariant_part.end_location.final_position + 1
			elseif bottom_indexes /= Void then
				Result := bottom_indexes.start_position
			else
				Result := end_keyword.position
			end
		end

	has_empty_invariant: BOOLEAN
			-- Does class have an empty invariant clause?

	date: INTEGER
			-- Date of file when last parsed.

feature -- Status report

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		local
			l_break: BREAK_AS
		do
			if a_list = Void then
				if top_indexes /= Void then
					Result := top_indexes.first_token (a_list)
				else
					Result := class_name.first_token (a_list)
				end
			else
				if not a_list.is_empty then
					l_break ?= a_list.first.first_token (a_list)
				else
					l_break := Void
				end
				if l_break /= Void then
					Result := l_break
				else
					if internal_top_indexes /= Void then
						Result := internal_top_indexes.first_token (a_list)
					else
						Result := first_header_mark (a_list)
						if Result = Void then
							Result := class_keyword (a_list)
						end
					end
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		local
			l_break: BREAK_AS
		do
			if a_list = Void then
				Result := end_keyword.last_token (a_list)
			else
				if not a_list.is_empty then
					l_break ?= a_list.last.last_token (a_list)
				else
					l_break := Void
				end
				if l_break /= Void then
					Result := l_break
				else
					Result := end_keyword.last_token (a_list)
				end
			end
		end

feature {EIFFEL_PARSER_SKELETON} -- Element change

	set_text_positions (ge, ip, fp: INTEGER) is
			-- Set positions in class text.
		require
			ge_positive_or_not_present: ge >= 0
			ip_positive: ip >= 0 and ip >= ge
			fp_positive: fp > 0 and fp >= ip
		do
			generics_end_position := ge
			inherit_clause_insert_position := ip
			feature_clause_insert_position := fp
		ensure
			generics_end_position: generics_end_position = ge
			inherit_clause_insert_position_set: inherit_clause_insert_position = ip
			feature_clause_insert_position_set: feature_clause_insert_position = fp
		end

feature -- Access

	feature_with_name (n: INTEGER): FEATURE_AS is
			-- Feature AST with internal name `n'.
		local
			l_features: like features
			i, l_count: INTEGER
			l_area: SPECIAL [FEATURE_CLAUSE_AS]
		do
			l_features := features
			if l_features /= Void then
				from
					l_area := l_features.area
					l_count := l_area.count
				until
					i = l_count or else Result /= Void
				loop
					Result := l_area [i].feature_with_name (n)
					i := i + 1
				end
			end
		end

	parent_with_name (n: STRING): PARENT_AS is
			-- Parent AST with class name `n'.
		require
			n_not_void: n /= Void
		local
			cur: INTEGER
			pn: STRING
		do
			if parents /= Void then
				cur := parents.index
				from
					parents.start
				until
					parents.after or else Result /= Void
				loop
					pn := parents.item.type.class_name.name
					if pn.is_equal (n) then
						Result := parents.item
					end
					parents.forth
				end
				parents.go_i_th (cur)
			end
		end

	clickable_item (a_clickable: CLICKABLE_AST): CLICK_AST is
			-- Corresponding click-item for `a_clickable'.
			-- `Void' if not in `click_list'.
		require
			a_clickable_not_void: a_clickable /= Void
		local
			l_click_list: CLICK_LIST
		do
			l_click_list := click_list
			if l_click_list /= Void then
				Result := l_click_list.item_by_node (a_clickable)
			end
		ensure
			correct_item: Result /= Void implies Result.node = a_clickable
		end

	click_ast: CLICK_AST is
			-- Position of class name.
		do
			Result := clickable_item (Current)
		ensure
			not_void: Result /= Void
			correct_item: Result.node = Current
		end

	generics_as_string: STRING is
			-- Output `formal_decs' as string to `generics'.
			-- `Void' if `generics' `Void'.
		local
			i: INTEGER
		do
			if generics /= Void then
				create Result.make (3)
				Result.extend ('[')
				from i := 1 until i > generics.count loop
					if i > 1 then
						Result.append (", ")
					end
					Result.append (generics.i_th (i).constraint_string)
					i := i + 1
				end
				Result.extend (']')
			end
		end

	custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributse of current class if any.
		do
			if top_indexes /= Void then
				Result := top_indexes.custom_attributes
			end
		end

	class_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributes of current class if any.
		do
			if top_indexes /= Void then
				Result := top_indexes.class_custom_attributes
			end
		end

	interface_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributes of current class if any.
		do
			if top_indexes /= Void then
				Result := top_indexes.interface_custom_attributes
			end
		end

	assembly_custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributes of current class if any.
		do
			if top_indexes /= Void then
				Result := top_indexes.assembly_custom_attributes
			end
		end

feature -- Query

	all_features: !BILINEAR [!FEATURE_AS]
			-- Retrieves a list of all features of the Current class.
		local
			l_fccursor, l_fcursor: INTEGER
			l_result: !ARRAYED_LIST [!FEATURE_AS]
		do
			create l_result.make (0)
			if {l_fclauses: !like features} features then
					-- Iterate the features clauses and feature all features
				l_fccursor := l_fclauses.index
				from l_fclauses.start until l_fclauses.after loop
					if {l_fclause: !FEATURE_CLAUSE_AS} l_fclauses.item and then {l_features: !EIFFEL_LIST [FEATURE_AS]} l_fclause.features then
							-- Iterate all features and extend the result list
						l_fcursor := l_features.index
						from l_features.start until l_features.after loop
							if {l_feature: !FEATURE_AS} l_features.item then
									-- Add feature
								l_result.extend (l_feature)
							end
							l_features.forth
						end
						l_features.go_i_th (l_fcursor)
					end
					l_fclauses.forth
				end
				l_fclauses.go_i_th (l_fccursor)
			end

			Result := ({!BILINEAR [!FEATURE_AS]}) #? l_result
		end

	feature_of_name (a_name: !STRING_GENERAL; a_reverse_lookup: BOOLEAN): FEATURE_AS
			-- Retrieves the first located feature using the supplied feature name.
			--
			-- `a_name': The feature name to retrieve a feature AS node for.
			-- `a_reverse_lookup': True to lookup a feature from the end to the beginning.
		local
			l_fccursor, l_fcursor: INTEGER
		do
			if {l_fclauses: !like features} features then
				l_fccursor := l_fclauses.index
				if a_reverse_lookup then
					l_fclauses.finish
				else
					l_fclauses.start
				end

					-- Iterate the features clauses and feature all features
				from until l_fclauses.after or Result /= Void loop
					if {l_fclause: !FEATURE_CLAUSE_AS} l_fclauses.item and then {l_features: !EIFFEL_LIST [FEATURE_AS]} l_fclause.features then
						l_fcursor := l_features.index
						if a_reverse_lookup then
							l_features.finish
						else
							l_features.start
						end

							-- Iterate all features and extend the result list
						from until l_features.after or Result /= Void loop
							if {l_feature2: !FEATURE_AS} l_features.item then --and then l_feature2.is_named (a_name) then
								if l_feature2.is_named (a_name) then
										-- Feature located
									Result := l_feature2
								end

							end
							if a_reverse_lookup then
								l_features.back
							else
								l_features.forth
							end
						end
						l_features.go_i_th (l_fcursor)
					end
					if a_reverse_lookup then
						l_fclauses.back
					else
						l_fclauses.forth
					end
				end
				l_fclauses.go_i_th (l_fccursor)
			end
		end

	feature_of_position (a_line: INTEGER;): FEATURE_AS
			-- Retrieves the feature located
			--
			-- `a_line': One-base line number index to start looking for a feature at.
			-- `a_reverse_lookup': True to lookup a feature from the end to the beginning.
			-- `Result': The feature node located at the corresponding line number or Void if the line
			--           number resides outside of a feature.
		local
			l_fccursor, l_fcursor: INTEGER
			l_helper: AST_HELPER
			l_stop: BOOLEAN
		do
			if {l_fclauses: !like features} features and then not l_fclauses.is_empty then
					-- Iterate the features clauses and feature all features
				create l_helper
				l_fccursor := l_fclauses.index
				from l_fclauses.start until l_stop or else l_fclauses.after loop
					if {l_fclause: !FEATURE_CLAUSE_AS} l_fclauses.item then
						if
							l_helper.is_valid_positional_node (l_fclause) and then
							l_helper.is_line_in (l_fclause, a_line)
						then
							if {l_features: !EIFFEL_LIST [FEATURE_AS]} l_fclause.features then
									-- Found a feature clauses
									-- Iterate all features and extend the result list
								l_fcursor := l_features.index
								from l_features.start until l_stop or l_features.after loop
									if
										{l_feature: !FEATURE_AS} l_features.item and then
										l_helper.is_valid_positional_node (l_feature) and then
										l_helper.is_line_in (l_feature, a_line)
									then
										Result := l_feature
										l_stop := True
									end
									l_features.forth
								end
								l_features.go_i_th (l_fcursor)
							end

								-- Ensure we go no further because if no feature is found then
								-- we are not going to find it.
							l_stop := True
						end
					end

					check
						stop_for_attached_result: Result /= Void implies l_stop
					end

					l_fclauses.forth
				end
				l_fclauses.go_i_th (l_fccursor)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (creators, other.creators) and then
				equivalent (generics, other.generics) and then
				equivalent (top_indexes, other.top_indexes) and then
				equivalent (bottom_indexes, other.bottom_indexes) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (obsolete_message, other.obsolete_message) and then
				equivalent (parents, other.parents) and then
				equivalent (features, other.features) and then
				is_deferred = other.is_deferred and then
				is_expanded = other.is_expanded and then
				is_separate = other.is_separate
		end

feature {ABSTRACT_CLASS_C} -- Update

	assign_unique_values (counter: COUNTER; values: HASH_TABLE [INTEGER, STRING]) is
			-- Assign values to Unique features defined in the current class
		require
			valid_args: counter /= Void and values /= Void
		do
			from
				features.start
			until
				features.after
			loop
				features.item.assign_unique_values (counter, values)
				features.forth
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_top_indexes (i: like top_indexes) is
		do
			internal_top_indexes := i
		end

	set_date (a_date: like date) is
			-- Set `date' with `a_date'.
		require
			a_date_valid: a_date >= -1
		do
			date := a_date
		ensure
			date_set: date = a_date
		end

invariant
	convertors_valid: convertors /= Void implies not convertors.is_empty
	date_valid: date >= -1

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class CLASS_AS
